package com.bsp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bsp.dao.LoanableBookMapper;
import com.bsp.dto.LoanableBookQueryObject;
import com.bsp.dto.QueryObject;
import com.bsp.entity.LoanableBook;
import com.bsp.service.ILoanableBookService;
import com.bsp.utils.Page;

@Service
@Transactional
public class LoanableBookService implements ILoanableBookService{
	@Autowired
	private LoanableBookMapper loanableBookMapper;
	
	public void setLoanableBookMapper(LoanableBookMapper loanableBookMapper) {
		this.loanableBookMapper = loanableBookMapper;
	}

	@Override
	public LoanableBook getLoanableBookInforByid(Integer id) {
		return loanableBookMapper.selectByPrimaryKey(id);
	}

	@Override
	public Page getListBook(QueryObject queryObject) {
		LoanableBookQueryObject bookQueryObject = new LoanableBookQueryObject();
		bookQueryObject.setLimit(queryObject.getLimit());
		bookQueryObject.setOrder(queryObject.getOrder());
		bookQueryObject.setPageNumber(queryObject.getPageNumber());
		bookQueryObject.setSort(queryObject.getSort());
		List<LoanableBook> list = loanableBookMapper.selectByQueryObject(bookQueryObject);
		int total = loanableBookMapper.getTotalCount(bookQueryObject);
		Page page = new Page(list,total,queryObject.getLimit(),queryObject.getPageNumber());
		return page;
	}


}
