var loadIngOrder = function(app) {
    $.ajax({
        url: '/in_record/query',
        data: app.ingParams,
        success: function (data) {
            if (data.code==0) {
                app.ingPage=data.page.rows;
                app.newOrderNum=data.page.total;
                // 设置分页工具条,getPageIndex在common.js中
                var pageIndex = getPageIndex(app.ingPageBar.pageBarSize, data.page.currPage, data.page.totalPage);
                app.ingPageBar.startPageIndex=pageIndex.startPageIndex;
                app.ingPageBar.endPageIndex=pageIndex.endPageIndex;
                app.currPage = data.page.currPage;
                app.page = data.page.totalPage;

            } else if (data.code==401) { //未登录
                window.location.href='/login'
            } else {
                alert(data.msg);
            }
        }
    });
}

var init = function () {
	loadIngOrder(this);
}

var record_app = new Vue({
    el: "#record_app",
    data: {
        showPage: 0,//0-显示正在进行,1-显示已经结束,2-显示已经结束
        newOrderNum: 0,//
        currPage:{},//当前页码
        page:{},//总页数
        ingPage: {}, // 正在进行分页数据
        ingPageBar: { // 正在进行分页工具条参数
            pageBarSize: 3,// 正在进行分页工具条大小
            startPageIndex: 1, // 正在进行分页工具条开始页码
            endPageIndex: 1, // 正在进行分分页工具条结束页码
        },
        ingParams: {// 正在进行分页查询参数
            limit: 7, // 页大小
            pageNumber: 1, // 当前页
            status: 0
        },
        bugPage: {}, // 已经结束分页数据
        bugPageBar: { // 已经结束分页工具条参数
            pageBarSize: 3,// 分页工具条大小
            startPageIndex: 1, // 分页工具条开始页码
            endPageIndex: 1, // 分页工具条结束页码
        },
        bugPageParams: {// 已经结束分页查询参数
            limit: 3, // 页大小
            pageNumber: 1, // 当前页
            status: 1
        },
        edPage: {}, // 已经结束分页数据
        edPageBar: { // 已经结束分页工具条参数
            pageBarSize: 3,// 分页工具条大小
            startPageIndex: 1, // 分页工具条开始页码
            endPageIndex: 1, // 分页工具条结束页码
        },
        edPageParams: {// 已经结束分页查询参数
            limit: 3, // 页大小
            pageNumber: 1, // 当前页
            status: 2
        }
    },
    methods: {
        switchPage: function (page) {//切换页
            this.showPage = page;
        },
        loadIngOrder:loadIngOrder,
        //loadBugOrder:loadBugOrder,
        //loadEdgOrder:loadEdgOrder,
        goIngPage: function (currPage) {// 页面跳转
            this.ingParams.pageNumber = currPage;
            this.loadIngOrder(this);
        },
        millisecondsToDateTime: function (ms){
            return new Date(ms).toLocaleString();
        }
    },
    created: init
})