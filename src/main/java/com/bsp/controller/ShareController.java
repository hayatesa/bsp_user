package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.entity.CheckLoanableBook;
import com.bsp.utils.Result;

@RestController
@Scope(value="prototype")
@RequestMapping("share")
public class ShareController {
	
	/**
	 * 共享图书，生成待管理员审核的订单，图片上传还需定义接口
	 * @param param 封装图书信息
	 */
	@RequestMapping("apply")
	public Result apply(CheckLoanableBook param) {
		return Result.success();
	}
	
	/**
	 * 更新数据
	 * @param clbId 待审核的书的id
	 */
	@RequestMapping("update")
	public Result update(Integer clbId) {
		return Result.success();
	}
	
	/**
	 * 取消分享申请
	 * @param clbId 待审核的书的id
	 */
	@RequestMapping("cancel")
	public Result cancel(Integer clbId) {
		return Result.success();
	}
}
