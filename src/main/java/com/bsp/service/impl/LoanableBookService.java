package com.bsp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bsp.dao.LoanableBookMapper;
import com.bsp.dao.PrimaryClassificationMapper;
import com.bsp.dao.SecondaryClassificationMapper;
import com.bsp.dto.LoanableBookQueryObject;
import com.bsp.dto.QueryObject;
import com.bsp.entity.LoanableBook;
import com.bsp.entity.PrimaryClassification;
import com.bsp.entity.SecondaryClassification;
import com.bsp.service.ILoanableBookService;
import com.bsp.utils.Page;

@Service
@Transactional
public class LoanableBookService implements ILoanableBookService{
	@Autowired
	private LoanableBookMapper loanableBookMapper;
	@Autowired private SecondaryClassificationMapper secondaryClassificationMapper;
	@Autowired private PrimaryClassificationMapper primaryClassificationMapper;
	
	public void setLoanableBookMapper(LoanableBookMapper loanableBookMapper) {
		this.loanableBookMapper = loanableBookMapper;
	}

	@Override
	public LoanableBook getLoanableBookInforByid(Integer id) {
		return loanableBookMapper.selectByPrimaryKey(id);
	}

	@Override
	public Page getAllListBook(QueryObject queryObject) {
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

	@Override
	public List<PrimaryClassification> getAllPrimary() {
		return primaryClassificationMapper.selectAll();
	}

	@Override
	public List<SecondaryClassification> getAllSecondary() {
		return secondaryClassificationMapper.selectAll();
	}


	@Override
	public Page getPrimaryListBook(QueryObject queryObject, Integer pcId) {
		LoanableBookQueryObject bookQueryObject = new LoanableBookQueryObject();
		bookQueryObject.setLimit(queryObject.getLimit());
		bookQueryObject.setOrder(queryObject.getOrder());
		bookQueryObject.setPageNumber(queryObject.getPageNumber());
		bookQueryObject.setSort(queryObject.getSort());
		bookQueryObject.setPrimaryClassification(primaryClassificationMapper.selectByPrimaryKey(pcId));
		List<LoanableBook> list = loanableBookMapper.selectByQueryObject(bookQueryObject);
		int total = loanableBookMapper.getTotalCount(bookQueryObject);
		Page page = new Page(list,total,queryObject.getLimit(),queryObject.getPageNumber());
		return page;
	}

	@Override
	public Page getSecondaryListBook(QueryObject queryObject, Integer scId) {
		LoanableBookQueryObject bookQueryObject = new LoanableBookQueryObject();
		bookQueryObject.setLimit(queryObject.getLimit());
		bookQueryObject.setOrder(queryObject.getOrder());
		bookQueryObject.setPageNumber(queryObject.getPageNumber());
		bookQueryObject.setSort(queryObject.getSort());
		bookQueryObject.setSecondaryClassification(secondaryClassificationMapper.selectByPrimaryKey(scId));
		List<LoanableBook> list = loanableBookMapper.selectByQueryObject(bookQueryObject);
		int total = loanableBookMapper.getTotalCount(bookQueryObject);
		Page page = new Page(list,total,queryObject.getLimit(),queryObject.getPageNumber());
		return page;
	}

	@Override
	public Page getSearchListBook(QueryObject queryObject, String bookName) {
		LoanableBookQueryObject bookQueryObject = new LoanableBookQueryObject();
		bookQueryObject.setLimit(queryObject.getLimit());
		bookQueryObject.setOrder(queryObject.getOrder());
		bookQueryObject.setPageNumber(queryObject.getPageNumber());
		bookQueryObject.setSort(queryObject.getSort());
		bookQueryObject.setSearch(bookName);
		List<LoanableBook> list = loanableBookMapper.selectByQueryObject(bookQueryObject);
		int total = loanableBookMapper.getTotalCount(bookQueryObject);
		Page page = new Page(list,total,queryObject.getLimit(),queryObject.getPageNumber());
		return page;
	}



}
