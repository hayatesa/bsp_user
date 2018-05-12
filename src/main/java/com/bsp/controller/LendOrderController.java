package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.utils.Result;

@RestController
@Scope(value="prototype")
@RequestMapping("lend")
public class LendOrderController extends BaseController {
	
	/**
	 * 同意借书
	 * @param lrId 借书记录id
	 */
	@RequestMapping("agree")
	public Result agree(Integer lrId) {
		return Result.success();
	}
	
}
