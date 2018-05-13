package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dto.QueryObject;
import com.bsp.utils.Result;

/**
 * 可借图书数据调取
 * @author hayate
 *
 */
@RestController
@Scope(value="prototype")
@RequestMapping("/loanble_book")
public class LoanableBookController extends BaseController {
	
	/**
	 * 分页查询
	 * @param queryObject
	 */
	@RequestMapping("query")
	public Result query(QueryObject queryObject) {
		return Result.success();
	}
	
	/**
	 * 获取一本书
	 * @param idInteger
	 * @return
	 */
	@RequestMapping("/detail")
	public Result detail(@RequestParam("lbId")Integer idInteger) {
		return Result.success();
	}
	
}
