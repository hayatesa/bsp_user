package com.bsp.service;

import com.bsp.entity.LoanableBook;
import com.bsp.utils.Page;

public interface ILoanableBookService {

	/**
	 * 根据id返回书本信息
	 * @param id 书本id
	 */
	LoanableBook getLoanableBookInforByid(Integer id);
	
}
