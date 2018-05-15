/**
 * 获取图书列表
 */
var d_limit;// 页大小
var d_pageNumber;// 页码
var d_order="asc";//排序顺序
var d_sort;//排序字段
var d_search;//搜索关键字

/**
 * 首次加载页面时查询所有图书列表
 */
var repository_vue = new Vue({
	el: '#list_app',
	data: {
		total: [],//图书总数
		page:[],//图书总页数
		datas: [],// 书本列表数据
		pageNumber: [],//当前页码
		limit:[],//每页显示总数
		maxlength: 138,//最大描述字段长度
		primary:[],//一级分类id
		secondary:[],//二级分类id
		search:[],//搜索的书名
		ins: 1,//active页码的class标志
		test:[]
		},
		created: function () {
			d_limit = 3;
			d_pageNumber = 1;
　　　　　	pagination("/loanble_book/query");
	},
	methods:{
		maxSlice(str){
			if(str.length>this.maxlength)
				return str.slice(0,this.maxlength) + "...";
			else
				return str;
		},
		active(num) {
			this.ins=num
		}
	}
}) 

/**
 * 从后台获取所有商品分页数据
 */
function pagination(to_url){
	$.ajax({
    type: "GET",//请求方式
    data: {"limit": d_limit, "pageNumber": d_pageNumber, "order": d_order, "sort": d_sort},
    url: to_url,//地址，就是json文件的请求路径
    dataType: "json",//数据类型可以为 text xml json  script  jsonp
　　 success: function(result){
		if(result.code == 0){
			repository_vue.datas = result.booklist.list;	
			repository_vue.total = result.booklist.totalCount;
			repository_vue.page = result.booklist.totalPage;
			repository_vue.pageNumber = d_pageNumber;
			repository_vue.limit = result.booklist.pageSize;
			repository_vue.secondary = result.secondary;
			repository_vue.primary = result.primary;
			repository_vue.search = result.search;
		}
		else{
			alert(result.msg);
		}
    }
	});
}

/**
 * 所有图书的页面跳转
 * @param pageNumber 页码
 */
function pageto(pageNumber){
	d_pageNumber = pageNumber;
	d_limit = 3;
	pagination("/loanble_book/query");
}

/**
 * 一级分类图书的分页跳转
 * @param pageNumber 页码
 * @param pcId 一级分类Id
 */
function primary_pageto(pageNumber,pcId){
	d_pageNumber = pageNumber;
	d_limit = 3;
	pagination("/loanble_book/queryprimary?pcId="+pcId);
}

/**
 * 二级分类图书的分页跳转
 * @param pageNumber 页码
 * @param scId 二级分类Id
 */
function secondary_pageto(pageNumber,scId){
	d_pageNumber = pageNumber;
	d_limit = 3;
	pagination("/loanble_book/querySecondary?scId="+scId);
}
/**
 * 搜索图书的分页跳转
 * @param pageNumber 页码
 * @param scId 二级分类Id
 */
function search_pageto(pageNumber){
	d_pageNumber = pageNumber;
	d_limit = 3;
	pagination("/loanble_book/querySearch?bookName="+repository_vue.search);
}

/**
*获取左侧一级分类和二级分类
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
/**
 * 一级分类查询
 */
function findByPrimary(pcId){
	repository_vue.ins = 1;
	d_limit = 3;
	d_pageNumber = 1;
	pagination("/loanble_book/queryprimary?pcId="+pcId);
}
/**
 * 二级分类查询
 */
function findBySecondary(scId){
	repository_vue.ins = 1;
	d_limit = 3;
	d_pageNumber = 1;
	pagination("/loanble_book/querySecondary?scId="+scId);
}
/**
 * 图书名搜索
 */
function findByBookName(){
	repository_vue.ins = 1;
	var bookName = $("#bookName").val();
	d_limit = 3;
	d_pageNumber = 1;
	pagination("/loanble_book/querySearch?bookName="+bookName);
}
