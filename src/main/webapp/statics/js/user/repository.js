/**
 * 获取图书列表
 */
var d_limit;// 页大小
var d_pageNumber;// 页码
var d_order="asc";//排序顺序
var d_sort;//排序字段
var d_search;//搜索关键字

var repository_vue = new Vue({
	el: '#list_app',
	data: {
		total: [],//图书总数
		page:[],//图书总页数
		datas: [],// 书本列表数据
		pageNumber: [],//当前页码
		limit:[],//每页显示总数
		maxlength: 138,//最大描述字段长度
		},
		created: function () {
			d_limit = 3;
			d_pageNumber = 1;
　　　　　	pagination();
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

/**
 * 从后台获取分页数据
 */
function pagination(){
	$.ajax({
    type: "GET",//请求方式
    data: {"limit": d_limit, "pageNumber": d_pageNumber, "order": d_order, "sort": d_sort},
    url: "/loanble_book/query",//地址，就是json文件的请求路径
    dataType: "json",//数据类型可以为 text xml json  script  jsonp
　　 success: function(result){
		if(result.code == 0){
			repository_vue.datas = result.booklist.list;	
			repository_vue.total = result.booklist.totalCount;
			repository_vue.page = result.booklist.totalPage;
			repository_vue.pageNumber = d_pageNumber;
			repository_vue.limit = result.booklist.pageSize;
		}
		else{
			alert(result.msg);
		}
    }
	});
}

/**
 * 分页查询
 * @param pageNumber 页码
 */
function pageto(pageNumber){
	$("li.active").removeClass('active');
	document.getElementById("page"+pageNumber).className = "active";
	d_pageNumber = pageNumber;
	d_limit = 3;
	pagination();
}

/**
 * 初始化
 */
$(function (){
	document.getElementById("page1").className = "active";
})

/**
*获取一级分类和二级分类
*/
var classify = new Vue({
	el: '#classify_app',
	data:{
		primary_datas:[],
		secondary_datas:[]
	},
	created: function (){
		var self = this;
		$.ajax({
		    type: "GET",//请求方式
		    url: "/loanble_book/classify",//地址，就是json文件的请求路径
		    dataType: "json",//数据类型可以为 text xml json  script  jsonp
		　　 success: function(result){
				if(result.code == 0){
					self.primary_datas = result.primarylist;
					self.secondary_datas = result.secondarylist;
				}
				else{
					alert(result.msg);
				}
		    }
		});
	}
})