package com.bsp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bsp.dao.LoanableBookMapper;
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


}
