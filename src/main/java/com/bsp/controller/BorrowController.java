package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.entity.LendingRecord;
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
	 * @param record 用于暂时封装参数
	 */
	@RequestMapping("apply")
	public Result apply(LendingRecord record) {
		return Result.success();
	}
	
}
