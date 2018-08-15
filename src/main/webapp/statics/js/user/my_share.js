jQuery(function () {
    initWebUploader();
});

// 初始化上传图片组件
var initWebUploader = function() {
    var $ = jQuery,    // just in case. Make sure it's not an other libaray.

        $wrap = $('#uploader'),

        // 图片容器
        $queue = $('<ul class="filelist"></ul>')
            .appendTo( $wrap.find('.queueList') ),

        // 状态栏，包括进度和控制按钮
        $statusBar = $wrap.find('.statusBar'),

        // 文件总体选择信息。
        $info = $statusBar.find('.info'),

        // 上传按钮
        $upload = $wrap.find('.uploadBtn'),

        // 没选择文件之前的内容。
        $placeHolder = $wrap.find('.placeholder'),

        // 总体进度条
        $progress = $statusBar.find('.progress').hide(),

        // 添加的文件数量,初始值0
        fileCount = 0,

        // 添加的文件总大小,初始值0
        fileSize = 0,

        // 优化retina, 在retina下这个值是2
        ratio = window.devicePixelRatio || 1,

        // 缩略图大小
        thumbnailWidth = 110 * ratio,
        thumbnailHeight = 110 * ratio,

        // 可能有pedding, ready, uploading, confirm, done.
        state = 'pedding',

        // 所有文件的进度信息，key为file id
        percentages = {},

        supportTransition = (function(){
            var s = document.createElement('p').style,
                r = 'transition' in s ||
                    'WebkitTransition' in s ||
                    'MozTransition' in s ||
                    'msTransition' in s ||
                    'OTransition' in s;
            s = null;
            return r;
        })(),

        // WebUploader实例
        uploader;

    if ( !WebUploader.Uploader.support() ) {
        alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
        throw new Error( 'WebUploader does not support the browser you are using.' );
    }

    // 实例化
    uploader = WebUploader.create({
        pick: { // 指定选择文件的按钮容器，不指定则不创建按钮。
            id: '#filePicker',
            label: '选择封面',
            multiple: false
        },
        dnd: '#uploader .queueList', // 指定Drag And Drop拖拽的容器，如果不指定，则不启动。
        paste: document.body, // 指定监听paste事件的容器，如果不指定，不启用此功能。此功能为通过粘贴来添加截屏的图片。建议设置为document.body.
        resize: false, // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传
        accept: { // 指定接受哪些类型的文件。
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png,'
        },
        /*thumb: {
            width: 110,
            height: 110,

            // 图片质量，只有type为`image/jpeg`的时候才有效。
            quality: 100,

            // 是否允许放大，如果想要生成小图的时候不失真，此选项应该设置为false.
            allowMagnify: true,

            // 是否允许裁剪。
            crop: true,

            // 为空的话则保留原有图片格式。
            // 否则强制转换成指定的类型。
            type: 'image/jpg'
        },*/
        // swf文件路径
        swf: '/statics/js/plugins/webuploader-0.1.5/Uploader.swf',
        disableGlobalDnd: true,

        //分页上传
        chunked: true,
        //服务器地址
        server: '/share/cover',
        //上传文件名
        fileVal:'cover',
        fileNumLimit: 1,
        fileSizeLimit: 1024*1024,    // 1 M
        fileSingleSizeLimit: 1024*1024    // 1 M
    });

    // 添加“添加文件”的按钮，
    /*uploader.addButton({
        id: '#filePicker2',
        label: '继续添加'
    });*/

    // 当有文件添加进来时执行，负责view的创建
    function addFile( file ) {
        var $li = $( '<li id="' + file.id + '">' +
            '<p class="title">' + file.name + '</p>' +
            '<p class="imgWrap"></p>'+
            '<p class="progress"><span></span></p>' +
            '</li>' ),

            $btns = $('<div class="file-panel">' +
                '<span class="cancel">删除</span>' +
                '<span class="rotateRight">向右旋转</span>' +
                '<span class="rotateLeft">向左旋转</span></div>').appendTo( $li ),
            $prgress = $li.find('p.progress span'),
            $wrap = $li.find( 'p.imgWrap' ),
            $info = $('<p class="error"></p>'),

            showError = function( code ) {
                switch( code ) {
                    case 'exceed_size':
                        text = '文件大小超出';
                        break;
                    case 'interrupt':
                        text = '上传暂停';
                        break;

                    default:
                        text = '上传失败';
                        break;
                }

                $info.text( text ).appendTo( $li );
            };

        if ( file.getStatus() === 'invalid' ) {
            showError( file.statusText );
        } else {
            // @todo lazyload
            $wrap.text( '预览中' );
            uploader.makeThumb( file, function( error, src ) {
                if ( error ) {
                    $wrap.text( '不能预览' );
                    return;
                }

                var img = $('<img src="'+src+'">');
                $wrap.empty().append( img );
            }, thumbnailWidth, thumbnailHeight );

            percentages[ file.id ] = [ file.size, 0 ];
            file.rotation = 0;
        }

        file.on('statuschange', function( cur, prev ) {
            if ( prev === 'progress' ) {
                $prgress.hide().width(0);
            } else if ( prev === 'queued' ) {
                $li.off( 'mouseenter mouseleave' );
                $btns.remove();
            }

            // 成功
            if ( cur === 'error' || cur === 'invalid' ) {
                console.log( file.statusText );
                showError( file.statusText );
                percentages[ file.id ][ 1 ] = 1;
            } else if ( cur === 'interrupt' ) {
                showError( 'interrupt' );
            } else if ( cur === 'queued' ) {
                percentages[ file.id ][ 1 ] = 0;
            } else if ( cur === 'progress' ) {
                $info.remove();
                $prgress.css('display', 'block');
            } else if ( cur === 'complete' ) {
                $li.append( '<span class="success"></span>' );
            }

            $li.removeClass( 'state-' + prev ).addClass( 'state-' + cur );
        });

        $li.on( 'mouseenter', function() {
            $btns.stop().animate({height: 30});
        });

        $li.on( 'mouseleave', function() {
            $btns.stop().animate({height: 0});
        });

        $btns.on( 'click', 'span', function() {
            var index = $(this).index(),
                deg;

            switch ( index ) {
                case 0:
                    uploader.removeFile( file );
                    return;

                case 1:
                    file.rotation += 90;
                    break;

                case 2:
                    file.rotation -= 90;
                    break;
            }

            if ( supportTransition ) {
                deg = 'rotate(' + file.rotation + 'deg)';
                $wrap.css({
                    '-webkit-transform': deg,
                    '-mos-transform': deg,
                    '-o-transform': deg,
                    'transform': deg
                });
            } else {
                $wrap.css( 'filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
                // use jquery animate to rotation
                // $({
                //     rotation: rotation
                // }).animate({
                //     rotation: file.rotation
                // }, {
                //     easing: 'linear',
                //     step: function( now ) {
                //         now = now * Math.PI / 180;

                //         var cos = Math.cos( now ),
                //             sin = Math.sin( now );

                //         $wrap.css( 'filter', "progid:DXImageTransform.Microsoft.Matrix(M11=" + cos + ",M12=" + (-sin) + ",M21=" + sin + ",M22=" + cos + ",SizingMethod='auto expand')");
                //     }
                // });
            }


        });

        $li.appendTo( $queue );
    }

    // 负责view的销毁
    function removeFile( file ) {
        var $li = $('#'+file.id);

        delete percentages[ file.id ];
        updateTotalProgress();
        $li.off().find('.file-panel').off().end().remove();
    }

    function updateTotalProgress() {
        var loaded = 0,
            total = 0,
            spans = $progress.children(),
            percent;

        $.each( percentages, function( k, v ) {
            total += v[ 0 ];
            loaded += v[ 0 ] * v[ 1 ];
        } );

        percent = total ? loaded / total : 0;

        spans.eq( 0 ).text( Math.round( percent * 100 ) + '%' );
        spans.eq( 1 ).css( 'width', Math.round( percent * 100 ) + '%' );
        updateStatus();
    }

    function updateStatus() {
        var text = '', stats;

        if ( state === 'ready' ) {
            text = '选中' + fileCount + '张图片，共' +
                WebUploader.formatSize( fileSize ) + '。';
        } else if ( state === 'confirm' ) {
            stats = uploader.getStats();
            if ( stats.uploadFailNum ) {
                text = '已成功上传' + stats.successNum+ '张图片，'+
                    stats.uploadFailNum + '张照片上传失败，<a class="retry" href="#">重新上传'//+'</a>失败图片或<a class="ignore" href="#">忽略</a>'
            }

        } else {
            stats = uploader.getStats();
            text = '共' + fileCount + '张（' +
                WebUploader.formatSize( fileSize )  +
                '），已上传' + stats.successNum + '张';

            if ( stats.uploadFailNum ) {
                text += '，失败' + stats.uploadFailNum + '张';
            }
        }

        $info.html( text );
    }

    function setState( val ) {
        var file, stats;

        if ( val === state ) {
            return;
        }

        $upload.removeClass( 'state-' + state );
        $upload.addClass( 'state-' + val );
        state = val;

        switch ( state ) {
            case 'pedding':
                $placeHolder.removeClass( 'element-invisible' );
                $queue.parent().removeClass('filled');
                $queue.hide();
                $statusBar.addClass( 'element-invisible' );
                uploader.refresh();
                break;

            case 'ready':
                $placeHolder.addClass( 'element-invisible' );
                $( '#filePicker2' ).removeClass( 'element-invisible');
                $queue.parent().addClass('filled');
                $queue.show();
                $statusBar.removeClass('element-invisible');
                uploader.refresh();
                break;

            case 'uploading':
                $( '#filePicker2' ).addClass( 'element-invisible' );
                $progress.show();
                $upload.text( '暂停上传' );
                break;

            case 'paused':
                $progress.show();
                $upload.text( '继续上传' );
                break;

            case 'confirm':
                $progress.hide();
                //$upload.text( '开始上传' ).addClass( 'disabled' );

                stats = uploader.getStats();
                if ( stats.successNum && !stats.uploadFailNum ) {
                    setState( 'finish' );
                    return;
                }
                break;
            case 'finish':
                stats = uploader.getStats();
                if ( stats.successNum ) {
                    //$upload.text( '开始上传' ).removeClass( 'disabled' );
                    $( '#filePicker2' ).removeClass( 'element-invisible' );
                    //alert( '上传成功' );
                } else {
                    // 没有成功的图片，重设
                    state = 'done';
                    location.reload();
                }
                break;
        }

        updateStatus();
    }

    uploader.onUploadProgress = function( file, percentage ) {
        var $li = $('#'+file.id),
            $percent = $li.find('.progress span');

        $percent.css( 'width', percentage * 100 + '%' );
        percentages[ file.id ][ 1 ] = percentage;
        updateTotalProgress();
    };

    uploader.onFileQueued = function( file ) {
        fileCount++;
        fileSize += file.size;

        if ( fileCount === 1 ) {
            $placeHolder.addClass( 'element-invisible' );
            $statusBar.show();
        }

        addFile( file );
        setState( 'ready' );
        updateTotalProgress();
    };

    uploader.onFileDequeued = function( file ) {
        fileCount--;
        fileSize -= file.size;

        if ( !fileCount ) {
            setState( 'pedding' );
        }

        removeFile( file );
        updateTotalProgress();

    };

    uploader.on( 'all', function( type ) {
        var stats;
        switch( type ) {
            case 'uploadFinished':
                setState( 'confirm' );
                break;

            case 'startUpload':
                setState( 'uploading' );
                break;

            case 'stopUpload':
                setState( 'paused' );
                break;

        }
    });

    //上传成功回调函数
    uploader.on( 'uploadSuccess', function(files,response) {
        if(response.code===0) {
            alert('上传成功');
            $upload.text('重新上传');
            $upload.unbind("click");//移除click事件
            $upload.on('click', resetWebUploader);
        } else if (response.code==401) { //未登录
            window.location.href='/login'
        } else {
            alert(response.msg);
            resetWebUploader();
        }
    });

    //错误提示
    uploader.onError = function( code ) {
        if(code == "F_DUPLICATE"){
            alert("系统提示:请不要重复选择文件！");
        }else if(code == "Q_EXCEED_SIZE_LIMIT"){
            alert("系统提示:<span class='C6'>所选附件总大小</span>不可超过<span class='C6'>" + allMaxSize + "M</span>哦！<br>换个小点的文件吧！");
        }else{
            alert( 'Eroor: ' + code );

        }
    };

    $upload.on('click', function() {
        if ( $(this).hasClass( 'disabled' ) ) {
            return false;
        }

        if ( state === 'ready' ) {
            uploader.upload();
        } else if ( state === 'paused' ) {
            uploader.upload();
        } else if ( state === 'uploading' ) {
            uploader.stop();
        }
    });

    $info.on( 'click', '.retry', function() {
        uploader.retry();
    } );

    $info.on( 'click', '.ignore', function() {
        alert( 'todo' );
    } );

    $upload.addClass( 'state-' + state );
    updateTotalProgress();
}


var resetWebUploader = function () {
    var $ = jQuery;
    var template = '<div class="queueList">' +
        '<div id="dndArea" class="placeholder">' +
        '<div id="filePicker"></div>' +
        '<p>可将图片拽或截图粘贴，只允许上传1张且大小不超过1M的图片</p>' +
        '<p>支持图片类型：gif,jpg,jpeg,bmp,png</p>' +
        '</div>' +
        '</div>' +
        '<div class="statusBar" style="display:none;">' +
        '<div class="progress">' +
        '<span class="text">0%</span>' +
        '<span class="percentage"></span>' +
        '</div>' +
        '<div class="info"></div>' +
        '<div class="btns">' +
        '<div id="filePicker2"></div>' +
        '<div class="uploadBtn">开始上传</div>' +
        '</div>' +
        '</div>';
    var $wrap = $('#uploader');
    $wrap.html(template);
    initWebUploader();
}

var loadSharingPage = function (app) {
    $.ajax({
        url: '/shared_book/page',
        data: app.sharingPageParams,
        success: function (data) {
            if (data.code==0) {
                app.sharingPage=data.page;
                // 设置分页工具条,getPageIndex在common.js中
                var pageIndex = getPageIndex(app.sharingPageBar.pageBarSize, data.page.currPage, data.page.totalPage);
                app.sharingPageBar.startPageIndex=pageIndex.startPageIndex;
                app.sharingPageBar.endPageIndex=pageIndex.endPageIndex;

            } else if (data.code==401) { //未登录
                window.location.href='/login'
            } else {
                alert(data.msg);
            }
        }
    });
}

var loadApplyingPage = function (app) {
    $.ajax({
        url: '/share/page',
        data: app.applyingPageParams,
        success: function (data) {
            if (data.code==0) {
                app.applyingPage=data.page;
                // 设置分页工具条,getPageIndex在common.js中
                var pageIndex = getPageIndex(app.applyingPageBar.pageBarSize, data.page.currPage, data.page.totalPage);
                app.applyingPageBar.startPageIndex=pageIndex.startPageIndex;
                app.applyingPageBar.endPageIndex=pageIndex.endPageIndex;

            } else if (data.code==401) { //未登录
                window.location.href='/login'
            } else {
                alert(data.msg);
            }
        }
    });
}

/**
 * 裁剪文本，超过部分用 ‘......’代替
 * @param text 文本
 * @param length 目标长度
 */
var textCut = function (text, length) {
    if (text.length > length) {
        return text.substring(0, 99)+'......';
    } else {
        return text;
    }
}

var loadPrimaryClassifications=function () {
    $.ajax({
        url: '/pc/all',
        success: function (data) {
            if (data.code==401){
                window.location.href='/login';
                return;
            } else if (data.code!=0){
                alert(data.msg);
            } else {
                my_share_app.primaryClassifications=data.list;
            }

        }
    })

}

var loadSecondaryClassifications=function () {
    var pcId = my_share_app.pcId;
    if (pcId>0) {
        $.ajax({
            url: '/sc/findByPcId',
            data: {
                pcId: pcId
            },
            success: function (data) {
                if (data.code==401){
                    window.location.href='/login';
                    return;
                } else if (data.code!=0){
                    alert(data.msg);
                } else {
                    my_share_app.secondaryClassifications=data.list;
                }

            }
        })
    } else {
        my_share_app.secondaryClassifications=[];
    }
    my_share_app.newApply.secondaryClassification.scId=0;
    applyCheck();

}

var applyCheck = function () {
    var obj = my_share_app.newApply;
    var msg = my_share_app.newApplyMsg;
    var result = true;
    if (!obj.clbAuthor.trim()) {
        result = false;
        msg.author = '不能为空';
    } else {
        msg.author = '';
    }
    if (!obj.clbComment.trim()) {
        result = false;
        msg.comment = '不能为空';
    } else {
        msg.comment = '';
    }
    if (!obj.clbDuration.trim()  || obj.clbDuration < 7 || obj.clbDuration > 365) {
        result = false;
        msg.duration = '不能为空，且大于7小于365';
    } else {
        msg.duration = '';
    }
    if (!obj.clbName.trim()) {
        result = false;
        msg.name = '不能为空';
    } else {
        msg.name = '';
    }
    if (!obj.clbNumber.trim() || obj.clbNumber < 1 || obj.clbNumber > 2147483647) {
        result = false;
        msg.number = '不能为空，且大于0小于2147483647';
    } else {
        msg.number = '';
    }
    if (!obj.clbPublishing.trim()) {
        result = false;
        msg.publishing = '不能为空';
    } else {
        msg.publishing = '';
    }
    if (!obj.isbn.trim()) {
        result = false;
        msg.isbn = '不能为空';
    } else {
        msg.isbn = '';
    }
    var e = new RegExp("^[1][3,4,5,6,7,8,9][0-9]{9}$");
    if (!e.test(obj.phone)) {
        result = false;
        msg.phone = '请填写正确的手机号';
    } else {
        msg.phone = '';
    }
    if (my_share_app.pcId == 0) {
        result = false;
        msg.primaryClassification = '请选择一级分类';
    } else {
        msg.primaryClassification = '';
    }
    if (obj.secondaryClassification.scId == 0) {
        result = false;
        msg.secondaryClassification = '请选择二级分类';
    } else {
        msg.secondaryClassification = '';
    }
    return result;
}

var apply = function () {
    var completed = applyCheck();
    if (!completed) {
        return;
    }
    confirm("提交申请?", function () {
        $.ajax({
            url: '/share/apply',
            data: JSON.stringify(my_share_app.newApply),
            success: function (data) {
                if(data.code==0){
                    my_share_app.newApplyStep = 2;
                } else if (data.code==1003) { // 封面未上传
                    alert(data.msg);
                    my_share_app.newApplyStep = 0; // 返回封面上传
                } else if (data.code==401){
                    window.location.href='/login';
                    return;
                } else {
                    alert(data.msg);
                }
            }
        })
    })
}

var openShare = function (lbId) {
    confirm("开启共享?", function () {
        $.ajax({
            url: '/shared_book/open',
            data: {
                lbId: lbId
            },
            success: function (data) {
                if(data.code==0) {
                    loadSharingPage(my_share_app);
                }else if (data.code==401){
                    window.location.href='/login';
                    return;
                } else {
                    alert(data.msg);
                }
            }
        })
    })
}

var closeShare = function (lbId) {
    confirm("关闭共享?", function () {
        $.ajax({
            url: '/shared_book/close',
            data: {
                lbId: lbId
            },
            success: function (data) {
                if(data.code==0) {
                    loadSharingPage(my_share_app);
                }else if (data.code==401){
                    window.location.href='/login';
                    return;
                } else {
                    alert(data.msg);
                }
            }
        })
    })
}

var deleteShare = function (lbId) {
    confirm("删除共享?", function () {
        $.ajax({
            url: '/shared_book/delete',
            data: {
                lbId: lbId
            },
            success: function (data) {
                if(data.code==0) {
                    loadSharingPage(my_share_app);
                }else if (data.code==401){
                    window.location.href='/login';
                    return;
                } else {
                    alert(data.msg);
                }
            }
        })
    })
}

/**
 * 初始化添加共享页面
 */
var initNewApplyForm = function () {
    resetWebUploader();
    my_share_app.newApplyStep = 0;
    my_share_app.newApply= {
        clbName: '', // 书名
        clbAuthor: '', // 作者
        clbPublishing: '', // 出版社
        isbn: '', // isbn号
        clbDuration: '', // 时长（天）
        clbNumber: '', // 数量（本）
        clbComment: '', // 评价
        phone: '', // 手机号
        secondaryClassification: {scId: 0} // 二级分类
    };
    my_share_app.newApplyMsg= { // 错误提示文本
        name: '', // 书名
        author: '', // 作者
        publishing: '', // 出版社
        isbn: '', // isbn号
        duration: '', // 时长（天）
        number: '', // 数量（本）
        comment: '', // 评价
        phone: '', // 手机号
        primaryClassification: '', // 一级分类
        secondaryClassification: '' // 二级分类
    }
}

var init = function () {
    loadSharingPage(this);
    loadPrimaryClassifications();
}

var my_share_app = new Vue({
    el: '#my_share_app',
    data: {
        showPage: 0, // 0-共享中 1-正在申请 2-添加申请
        sharingPage: {}, // 页数据
        sharingPageParams: { // 正在共享页面参数
            limit: 3, // 页大小
            pageNumber: 1 // 当前页
        },
        sharingPageBar: { // 共享中分页工具条参数
            pageBarSize: 3,
            startPageIndex: 1,
            endPageIndex: 1,
        },
        applyingPage: {}, // 页数据
        applyingPageParams: { // 正在申请页面参数
            limit: 3, // 页大小
            pageNumber: 1 // 当前页
        },
        applyingPageBar: { // 共享中分页工具条参数
            pageBarSize: 3,
            startPageIndex: 1,
            endPageIndex: 1,
        },
        newApplyStep: 0, // 步骤, 0-上传封面, 1-填写表单, 3-提示成功
        newApply: {
            clbName: '', // 书名
            clbAuthor: '', // 作者
            clbPublishing: '', // 出版社
            isbn: '', // isbn号
            clbDuration: '', // 时长（天）
            clbNumber: '', // 数量（本）
            clbComment: '', // 评价
            phone: '', // 手机号
            secondaryClassification: {scId: 0} // 二级分类
        },
        newApplyMsg: { // 错误提示文本
            name: '', // 书名
            author: '', // 作者
            publishing: '', // 出版社
            isbn: '', // isbn号
            duration: '', // 时长（天）
            number: '', // 数量（本）
            comment: '', // 评价
            phone: '', // 手机号
            primaryClassification: '', // 一级分类
            secondaryClassification: '' // 二级分类
        },
        pcId: 0,
        primaryClassifications: [],
        secondaryClassifications: []
    },
    methods: {
        switchPage: function (page) {//切换页
            if (page==0){
                this.loadSharingPage(this);
            } else if (page==1) {
                this.loadApplyingPage(this);
            } else if (page==2) {
                initNewApplyForm();
            }
            this.showPage = page;
        },
        openShare: openShare,
        closeShare: closeShare,
        deleteShare: deleteShare,
        apply: apply,
        applyCheck: applyCheck,
        loadSharingPage: loadSharingPage,
        loadApplyingPage: loadApplyingPage,
        loadPrimaryClassifications: loadPrimaryClassifications,
        loadSecondaryClassifications: loadSecondaryClassifications,
        initNewApplyForm: initNewApplyForm,
        goSharingPage: function (currPage) {// 页面跳转
            this.sharingPageParams.pageNumber = currPage;
            this.loadSharingPage(this);
        },
        goApplyingPage: function (currPage) {// 页面跳转
            this.applyingPageParams.pageNumber = currPage;
            this.loadApplyingPage(my_share_app);
        },
        changeStepOfNewApply: function (step) {
            this.newApplyStep = step;
        },
        millisecondsToDateTime: function (ms){
            return new Date(ms).toLocaleString();
        },
        textCut: textCut
    },
    created: init
});