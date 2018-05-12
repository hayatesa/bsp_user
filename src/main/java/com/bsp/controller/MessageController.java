package com.bsp.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dto.PageParams;
import com.bsp.utils.Result;

/**
 * 消息相关
 * @author hayate
 *
 */
@RestController
@Scope(value="prototype")
@RequestMapping("msg")
public class MessageController extends BaseController {
	
	/**
	 * 获取未读消息列表
	 */
	@RequestMapping("unread_list")
	public Result getNewMsgList(PageParams pageParams) {
		return Result.success();
	}
	
	/**
	 * 获取已读消息列表
	 */
	@RequestMapping("read_list")
	public Result getHistoryMsgList(PageParams pageRequestParams) {
		return Result.success();
	}
	
	/**
	 * 获取所有消息列表
	 */
	@RequestMapping("all")
	public Result getAllyMsgList(PageParams pageRequestParams) {
		return Result.success();
	}
	
	/**
	 * 打开一条未读消息
	 * @param nId 消息id
	 */
	@RequestMapping("unread")
	public Result getUnreadMsg(@RequestParam("nId") Integer nId) {
		return Result.success();
	}
	
	/**
	 * 打开一条已读消息
	 * @param nId 消息id
	 */
	@RequestMapping("read")
	public Result getReadMsg(@RequestParam("nId") Integer nId) {
		return Result.success();
	}
	
}
