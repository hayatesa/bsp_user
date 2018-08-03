package com.bsp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bsp.dao.LoanableBookMapper;
import com.bsp.dao.PrimaryClassificationMapper;
import com.bsp.dao.SecondaryClassificationMapper;
import com.bsp.dto.LoanableBookQueryObject;
import com.bsp.entity.LoanableBook;
import com.bsp.entity.PrimaryClassification;
import com.bsp.entity.SecondaryClassification;
import com.bsp.exceptions.SystemErrorException;
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
	public Page getAllListBook(LoanableBookQueryObject queryObject) {
		LoanableBookQueryObject bookQueryObject = new LoanableBookQueryObject();
		bookQueryObject.setLimit(queryObject.getLimit());
		bookQueryObject.setOrder(queryObject.getOrder());
		bookQueryObject.setPageNumber(queryObject.getPageNumber());
		bookQueryObject.setSort(queryObject.getSort());
		List<LoanableBook> list = null;
		Integer total = null;
		try {
			list = loanableBookMapper.selectByQueryObject(bookQueryObject);
			total = loanableBookMapper.getTotalCount(bookQueryObject);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("系统错误，获取图书列表失败");
		}
		return new Page(list,total,queryObject.getLimit(),queryObject.getPageNumber());
	}

	@Override
	public List<PrimaryClassification> getAllPrimary() {
		List<PrimaryClassification> list = null;
		try {
			list = primaryClassificationMapper.selectAll();
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("系统错误，获取图书分类列表失败");
		}
		return list;
	}

	@Override
	public List<SecondaryClassification> getAllSecondary() {
		List<SecondaryClassification> list = null;
		try {
			list = secondaryClassificationMapper.selectAll();
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("系统错误，获取图书分类列表失败");
		}
		return list;
	}


	@Override
	public Page getPrimaryListBook(LoanableBookQueryObject queryObject, Integer pcId) {
		LoanableBookQueryObject bookQueryObject = new LoanableBookQueryObject();
		bookQueryObject.setLimit(queryObject.getLimit());
		bookQueryObject.setOrder(queryObject.getOrder());
		bookQueryObject.setPageNumber(queryObject.getPageNumber());
		bookQueryObject.setSort(queryObject.getSort());
		bookQueryObject.setPrimaryClassification(primaryClassificationMapper.selectByPrimaryKey(pcId));
		List<LoanableBook> list = null;
		Integer total = null;
		try {
			list = loanableBookMapper.selectByQueryObject(bookQueryObject);
			total = loanableBookMapper.getTotalCount(bookQueryObject);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("系统错误，获取一级分类图书列表失败");
		}
		Page page = new Page(list,total,queryObject.getLimit(),queryObject.getPageNumber());
		return page;
	}

	@Override
	public Page getSecondaryListBook(LoanableBookQueryObject queryObject, Integer scId) {
		LoanableBookQueryObject bookQueryObject = new LoanableBookQueryObject();
		bookQueryObject.setLimit(queryObject.getLimit());
		bookQueryObject.setOrder(queryObject.getOrder());
		bookQueryObject.setPageNumber(queryObject.getPageNumber());
		bookQueryObject.setSort(queryObject.getSort());
		bookQueryObject.setSecondaryClassification(secondaryClassificationMapper.selectByPrimaryKey(scId));
		List<LoanableBook> list = null;
		Integer total = null;
		try {
			list = loanableBookMapper.selectByQueryObject(bookQueryObject);
			total = loanableBookMapper.getTotalCount(bookQueryObject);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("系统错误，获取二级分类图书列表失败");
		}
		Page page = new Page(list,total,queryObject.getLimit(),queryObject.getPageNumber());
		return page;
	}

	@Override
	public Page getSearchListBook(LoanableBookQueryObject queryObject, String bookName) {
		LoanableBookQueryObject bookQueryObject = new LoanableBookQueryObject();
		bookQueryObject.setLimit(queryObject.getLimit());
		bookQueryObject.setOrder(queryObject.getOrder());
		bookQueryObject.setPageNumber(queryObject.getPageNumber());
		bookQueryObject.setSort(queryObject.getSort());
		bookQueryObject.setSearch(bookName);
		List<LoanableBook> list = null;
		Integer total = null;
		try {
			list = loanableBookMapper.selectByQueryObject(bookQueryObject);
			total = loanableBookMapper.getTotalCount(bookQueryObject);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("系统错误，获取搜索列表失败");
		}
		Page page = new Page(list,total,queryObject.getLimit(),queryObject.getPageNumber());
		return page;
	}



}
