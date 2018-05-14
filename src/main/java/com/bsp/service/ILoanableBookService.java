package com.bsp.service;

import com.bsp.dto.QueryObject;
import com.bsp.entity.LoanableBook;
import com.bsp.utils.Page;

public interface ILoanableBookService {

	/**
	 * 根据id返回图书信息
	 * @param id 图书id
	 */
	LoanableBook getLoanableBookInforByid(Integer id);
	
	/**
	 * 返回分页查询的结果
	 * @param queryObject 封装分页请求中的参数
	 */
	Page getListBook(QueryObject queryObject);
	
}
