package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.utils.Result;

@RestController
@Scope(value="prototype")
@RequestMapping("/loanble_book")
public class LoanableBookDetialController extends BaseController {
	
	@RequestMapping("/detail")
	public Result detail(@RequestParam("lbId")Integer idInteger) {
		return Result.success();
	}
	
}
