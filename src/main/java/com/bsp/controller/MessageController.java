package com.bsp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dto.QueryObject;
import com.bsp.entity.User;
import com.bsp.service.IMessageService;
import com.bsp.shiro.ShiroUtils;
import com.bsp.utils.Page;
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
	
	@Autowired
	private IMessageService messageService;
	
	public void setMessageService(IMessageService messageService) {
		this.messageService = messageService;
	}

	/**
	 * 获取未读消息数
	 * @return
	 */
	@RequestMapping("amount")
	public Result getAmount() {
		User user = ShiroUtils.getToken();
		
		Result rs = Result.success();
		rs.put("msgNum", 0);
		return rs;
	}
	
	/**
	 * 获取未读消息列表
	 */
	@RequestMapping("unread_list")
	public Result getNewMsgList(QueryObject queryObject) {
		User user = ShiroUtils.getToken();
		queryObject.setSearch(user.getUuid());// 设置用户uuid
		Result rs = new Result();
		Page page = null;
		try {
			page = messageService.getNewMsgList(queryObject);
			rs.put("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error(e.getMessage());
		}
		return rs;
	}
	
	/**
	 * 获取已读消息列表
	 */
	@RequestMapping("read_list")
	public Result getHistoryMsgList(QueryObject queryObject) {
		return Result.success();
	}
	
	/**
	 * 获取所有消息列表
	 */
	@RequestMapping("all")
	public Result getAllyMsgList(QueryObject queryObject) {
		return Result.success();
	}
	
	/**
	 * 打开一条未读消息
	 * @param nId 消息id
	 */
	@RequestMapping("unread")
	public Result getUnReadMsg(@RequestParam("nId") Integer nId) {
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
