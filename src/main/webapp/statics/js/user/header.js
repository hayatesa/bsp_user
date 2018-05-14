var init = function () {
    var app = this;
    $.ajax({
        type:"get",
        url: "/token",
        success: function(data){
            if(data.code === 0){
                if (data.code!=0) {//未登录
                    return;
                }
                app.token=data.token;
                app.login=true;//显示消息链接
                $.ajax({//加载消息数
                    url: '/msg/amount',
                    type:"get",
                    success: function (data) {
                        var msgNum = data.msgNum;
                        app.msgNum=msgNum<100?msgNum:'99+';
                    }
                })
            }

        }
    });
}

var header_app=new Vue({
    el: "#header-app",
    data: {
        token: {},
        msgNum: 0,
        login: false,
    },
    created: init
})