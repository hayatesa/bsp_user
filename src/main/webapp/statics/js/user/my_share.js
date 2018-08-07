var loadSharingPage = function (app) {
    $.ajax({
        url: '/loanble_book/pageOfUser',
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

var init = function () {
    loadSharingPage(this);
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

var vue_app = new Vue({
    el: '#vue_app',
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
        newApply: {
            clbName: '', // 书名
            clbAuthor: '', // 作者
            clbPublishing: '', // 出版社
            isbn: '', // isbn号
            clbDuration: 1, // 时长（天）
            clbNumber: '', // 数量（本）
            clbComment: '', // 评价
            phone: '', // 手机号
            scId: '', // 二级分类
        },
    },
    methods: {
        switchPage: function (page) {//切换页
            if (page==0){
                this.loadSharingPage(this);
            } else if (page==1) {
                this.loadApplyingPage(this);
            }
            this.showPage = page;
        },
        loadSharingPage: loadSharingPage,
        loadApplyingPage: loadApplyingPage,
        goSharingPage: function (currPage) {// 页面跳转
            this.applyingPageParams.pageNumber = currPage;
            this.loadUnreadMsg(this);
        },
        textCut: textCut
    },
    created: init
});