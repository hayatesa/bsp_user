package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dto.PageParams;
import com.bsp.entity.LoanableBook;
import com.bsp.utils.Result;

/**
 * 用户已共享图书管理
 * @author hayate
 *
 */
@RestController
@Scope(value="prototype")
@RequestMapping("shared_book")
public class SharedBookController {
	
	/**
	 * 查询正在共享的书
	 * @param pageParams 分页参数
	 */
	@RequestMapping("query")
	public Result query(PageParams pageParams) {
		return Result.success();
	}
	
	/**
	 * 更新分享的图书信息，只能更新部分属性
	 * @param loanableBook 可借出的书
	 */
	@RequestMapping("update")
	public Result update(LoanableBook loanableBook) {
		return Result.success();
	}
	
	/**
	 * 取消共享
	 * @param lbId 正在共享的书的ID
	 */
	@RequestMapping("cancel")
	public Result cancel(@RequestParam("lbId") Integer lbId) {
		return Result.success();
	}
	
}
