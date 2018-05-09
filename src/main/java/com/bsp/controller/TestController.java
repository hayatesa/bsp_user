package com.bsp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bsp.dao.PrimaryClassificationMapper;
import com.bsp.dao.SecondaryClassificationMapper;
import com.bsp.entity.PrimaryClassification;
import com.bsp.entity.SecondaryClassification;


@Controller
@RequestMapping("/test")
public class TestController {
	
	@Autowired private SecondaryClassificationMapper secondaryClassificationMapper;
	@Autowired private PrimaryClassificationMapper primaryClassificationMapper;
	
	public void setPrimaryClassificationMapper(PrimaryClassificationMapper primaryClassificationMapper) {
		this.primaryClassificationMapper = primaryClassificationMapper;
	}

	public void setSecondaryClassificationMapper(SecondaryClassificationMapper secondaryClassificationMapper) {
		this.secondaryClassificationMapper = secondaryClassificationMapper;
	}

	@RequestMapping("sc")
	@ResponseBody
	public SecondaryClassification testSecondaryClassificationMapper() {
		return secondaryClassificationMapper.selectByPrimaryKey(248);
	}
	
	@RequestMapping("pc")
	@ResponseBody
	public PrimaryClassification testPrimaryClassificationMapper() {
		return primaryClassificationMapper.selectByPrimaryKey(1);
	}
	
}
