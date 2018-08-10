$(function () {

})

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
                vue_app.primaryClassifications=data.list;
            }

        }
    })

}

var loadSecondaryClassifications=function () {
    var pcId = vue_app.pcId;
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
                    vue_app.secondaryClassifications=data.list;
                }

            }
        })
    } else {
        vue_app.secondaryClassifications=[];
    }
    vue_app.newApply.secondaryClassification.scId=0;

}

var applyCheck = function () {
    var obj = vue_app.newApply;

    return true;
}

var init = function () {
    loadSharingPage(this);
    loadPrimaryClassifications();
}

var vue_app = new Vue({
    el: '#vue_app',
    data: {
        showPage: 2, // 0-共享中 1-正在申请 2-添加申请
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
        newApplyStep:  0, // 步骤, 0-上传封面, 1-填写表单
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
            }
            this.showPage = page;
        },
        loadSharingPage: loadSharingPage,
        loadApplyingPage: loadApplyingPage,
        loadPrimaryClassifications: loadPrimaryClassifications,
        loadSecondaryClassifications: loadSecondaryClassifications,
        goSharingPage: function (currPage) {// 页面跳转
            this.sharingPageParams.pageNumber = currPage;
            this.loadSharingPage(this);
        },
        goApplyingPage: function (currPage) {// 页面跳转
            this.applyingPageParams.pageNumber = currPage;
            this.loadApplyingPage(this);
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