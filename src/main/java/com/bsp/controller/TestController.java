package com.bsp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dao.LoanableBookMapper;
import com.bsp.dao.PrimaryClassificationMapper;
import com.bsp.dao.SecondaryClassificationMapper;
import com.bsp.dto.LoanableBookQueryObject;
import com.bsp.entity.LoanableBook;
import com.bsp.entity.PrimaryClassification;
import com.bsp.entity.SecondaryClassification;
import com.bsp.utils.Result;


@RestController
@RequestMapping("/test")
public class TestController {
	
	@Autowired private SecondaryClassificationMapper secondaryClassificationMapper;
	@Autowired private PrimaryClassificationMapper primaryClassificationMapper;
	@Autowired private LoanableBookMapper loanableBookMapper;
	
	public void setLoanableBookMapper(LoanableBookMapper loanableBookMapper) {
		this.loanableBookMapper = loanableBookMapper;
	}

	public void setPrimaryClassificationMapper(PrimaryClassificationMapper primaryClassificationMapper) {
		this.primaryClassificationMapper = primaryClassificationMapper;
	}

	public void setSecondaryClassificationMapper(SecondaryClassificationMapper secondaryClassificationMapper) {
		this.secondaryClassificationMapper = secondaryClassificationMapper;
	}

	@RequestMapping("sc")
	public SecondaryClassification testSecondaryClassificationMapper() {
		return secondaryClassificationMapper.selectByPrimaryKey(248);
	}
	
	@RequestMapping("pc")
	public PrimaryClassification testPrimaryClassificationMapper() {
		return primaryClassificationMapper.selectByPrimaryKey(1);
	}
	
	@RequestMapping("lb")
	public Result testLoanableBookMapper() {
		LoanableBookQueryObject queryObject = new LoanableBookQueryObject();
		/*PrimaryClassification pc = new PrimaryClassification();
		pc.setPcId(1);*/
		/*queryObject.setPrimaryClassification(pc);
		SecondaryClassification sc = new SecondaryClassification();
		sc.setScId(8);
		queryObject.setSecondaryClassification(sc);*/
		queryObject.setSearch("哲学");
		/*queryObject.setPageNumber(2);
		queryObject.setLimit(2);*/
		Integer count = loanableBookMapper.getTotalCount(queryObject);
		List<LoanableBook> list = loanableBookMapper.selectByQueryObject(queryObject);
		Result rs = Result.success();
		rs.put("count", count);
		rs.put("list",list);
		rs.put("size", list.size());
		return rs;
	}
	
}
