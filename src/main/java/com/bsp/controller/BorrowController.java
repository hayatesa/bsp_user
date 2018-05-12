package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.utils.Result;

/**
 * 借书
 * @author hayate
 *
 */
@RestController
@Scope(value="prototype")
@RequestMapping("borrow")
public class BorrowController extends BaseController {
	
	/**
	 * 申请借书
	 * @param lbId 可借出的书的id
	 * @param mount 借书数量
	 */
	@RequestMapping("apply")
	public Result apply(@RequestParam("lbId") Integer lbId, @RequestParam("mount")  Integer mount) {
		return Result.success();
	}
	
	/**
	 * 取消尚未被同意的借书申请
	 * @param record 用于暂时封装参数
	 */
	@RequestMapping("cancel")
	public Result apply(@RequestParam("lbId") Integer lbId) {
		return Result.success();
	}
	
}
