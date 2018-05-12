package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dto.PageParams;
import com.bsp.utils.Result;

@RestController
@Scope(value="prototype")
@RequestMapping("lend")
public class LendOrderController extends BaseController {
	
	/**
	 * 同意借出
	 * @param lrId 借书记录id
	 */
	@RequestMapping("agree")
	public Result agree(@RequestParam("lrId") Integer lrId) {
		return Result.success();
	}
	
	/**
	 * 拒绝借出
	 * @param lrId 借书记录id
	 */
	@RequestMapping("deny")
	public Result deny(@RequestParam("lrId") Integer lrId) {
		return Result.success();
	}
	
	/**
	 * 获取申请详情
	 * @param lrId 借书记录id
	 */
	@RequestMapping("apply_detials")
	public Result getDetails(@RequestParam("lrId") Integer lrId) {
		return Result.success();
	}
	
	/**
	 * 获取未处理的借书申请列表（分页）
	 * @param pageParams 分页参数
	 */
	@RequestMapping("apply_list")
	public Result queryApply(PageParams pageParams) {
		return Result.success();
	}
	
	/**
	 * 获取借出历史（分页）
	 * @param pageParams 分页参数
	 */
	@RequestMapping("record_list")
	public Result queryRecord(PageParams pageParams) {
		return Result.success();
	}

}
