package com.bsp.service;


import com.bsp.dto.QueryObject;
import com.bsp.entity.News;
import com.bsp.utils.Page;

public interface IMessageService {
	
	/**
	 * 根据获取一条消息
	 * @param id 消息id
	 */
	News getUnReadMsg(Integer id);
	
	/**
	 * 根据获取一条已读信息
	 * @param id 消息id
	 */
	News getReadMsg(Integer id);
	
	/**
	 * 根据用户ID获取新（未读）消息数
	 * @param uuid 用户ID
	 */
	Integer getNewMsgAmount(String uuid);
	
	/**
	 * 获取未读消息列表（分页）
	 * @param queryObject 查询对象
	 */
	Page getNewMsgList(QueryObject queryObject);
	
	/**
	 * 获取已读消息列表（分页）
	 * @param queryObject
	 */
	Page getHistoryMsgList(QueryObject queryObject);
	
}
