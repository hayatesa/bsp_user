package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dto.QueryObject;
import com.bsp.utils.Result;

/**
 * 借出订单的管理，包括申请,借出方为当前用户，查表lending_record、lending_history
 * @author hayate
 *
 */
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
	 * 获取申请详情，查表lending_record
	 * @param lrId 借书记录id
	 */
	@RequestMapping("detial/lending")
	public Result getLendingDetails(@RequestParam("lrId") Integer lrId) {
		return Result.success();
	}
	
	/**
	 * 获取申请详情
	 * @param lhId 借书记录id
	 */
	@RequestMapping("detial/history")
	public Result getHistortyDetails(@RequestParam("lhId") Integer lhId) {
		return Result.success();
	}
	
	/**
	 * 获取借出列表，包括申请中的话正在借出中的订单，查表lending_record（分页）
	 * @param queryObject 查询对象
	 */
	@RequestMapping("list/lending")
	public Result queryLending(QueryObject queryObject) {
		return Result.success();
	}
	
	/**
	 * 获取借出历史列表，查表lending_history（分页）
	 * @param queryObject 查询对象
	 */
	@RequestMapping("list/history")
	public Result queryHistory(QueryObject queryObject) {
		return Result.success();
	}

}
