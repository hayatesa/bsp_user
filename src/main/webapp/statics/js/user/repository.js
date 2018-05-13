/**
 * 获取图书列表
 */
new Vue({
			el: '#app',
			data: {
				d_limit: [],// 页大小
				d_pageNumber: [],// 页码
				datas: [],// 书本列表数据
				d_order: [],//排序顺序
				d_sort: [],//排序字段
				d_search: [],//搜索关键字
				maxlength: 138//最大描述字段长度
			},
			created: function () {
	　　　　　　//为了在内部函数能使用外部函数的this对象，要给它赋值了一个名叫self的变量。
				var self = this;
				d_limit = 6;
				d_pageNumber = 1;
				d_order = "asc";
				d_sort = "lbId";
				$.ajax({
                type: "GET",//请求方式
                //data: {"limit": self.d_limit, "pageNumber": self.d_pageNumber, "order": self.d_order, "sort": self.d_sort},
                url: "../../statics/data/BookData.json",//地址，就是json文件的请求路径
                dataType: "json",//数据类型可以为 text xml json  script  jsonp
　　　　　　　　　 success: function(result){//返回的参数就是 action里面所有的有get和set方法的参数
                    self.datas = result.rows;
                    self.total = result.total;   
                    self.page = result.page;   
                }
				});
			},
			methods:{
				maxSlice(str){
					if(str.length>this.maxlength)
						return str.slice(0,this.maxlength) + "...";
					else
						return str;
				}
			}
		}) 