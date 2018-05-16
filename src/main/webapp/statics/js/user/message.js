var loadUnreadMsg = function(app) {
    $.ajax({
        url: '/msg/unread_list',
        data: app.pageParams,
        success: function (data) {
            if (data.code==0) {
                app.page=data.page;
                // 设置分页工具条,getPageIndex在common.js中
                var pageIndex = getPageIndex(app.pageBar.pageBarSize, data.page.currPage, data.page.totalPage);
                app.pageBar.startPageIndex=pageIndex.startPageIndex;
                app.pageBar.endPageIndex=pageIndex.endPageIndex;

            } else if (data.code==401) { //未登录
                window.location.href='/login'
            } else {
                alert(data.msg);
            }
        }
    });
    $.ajax({//加载消息数
        url: '/msg/amount',
        type:"get",
        success: function (data) {
            var newMsgNum = data.msgNum;
            app.newMsgNum=newMsgNum<100?newMsgNum:'99+';
        }
    })
}

var init = function () {
    loadUnreadMsg(this);
}

var msg_app = new Vue({
    el: "#msg-app",
    data: {
        showPage: 0,//0-显示未读消息,1-显示已读消息
        newMsgNum: 0,//未读消息数
        page: {}, // 分页数据
        pageBar: { // 分页工具条参数
            pageBarSize: 3,// 分页工具条大小
            startPageIndex: 1, // 分页工具条开始页码
            endPageIndex: 1, // 分页工具条结束页码
        },
        pageParams: {// 分页查询参数
            limit: 12, // 页大小
            pageNumber: 1 // 当前页
        },
    },
    methods: {
        loadUnreadMsg: loadUnreadMsg,
        goPage: function (currPage) {// 页面跳转
            this.pageParams.pageNumber = currPage;
            this.loadUnreadMsg(this);
        },
        millisecondsToDateTime: function (ms){
            return new Date(ms).toLocaleString();
        }
    },
    created: init
})