package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dto.QueryObject;
import com.bsp.utils.Result;

/**
 * 用户已共享图书管理，查表loanable_book，图书所有者为当前用户
 * @author hayate
 *
 */
@RestController
@Scope(value="prototype")
@RequestMapping("shared_book")
public class SharedBookController extends BaseController {
	
	/**
	 * 查询正在共享的图书列表,图书拥有者为当前用户
	 * @param pageParams 分页参数
	 */
	@RequestMapping("list")
	public Result list(QueryObject pageParams) {
		return Result.success();
	}
	
	/**
	 * 更新分享的图书信息，只能修改部分字段，实现时请完成参数列表
	 * @param lbId 正在共享的书的ID
	 */
	@RequestMapping("update")
	public Result update(@RequestParam("lbId") Integer lbId) {
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
