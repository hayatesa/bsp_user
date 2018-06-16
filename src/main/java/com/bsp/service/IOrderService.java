package com.bsp.service;

import java.util.List;

import com.bsp.entity.LendingRecord;
import com.bsp.entity.Mapping;

public interface IOrderService {
	
	/**
	 * 获取Mapping表里的管理员联系电话
	 * @return
	 */
	String getContact_phones();
	
	/**
	 * 获取Mapping表里的取书地点
	 * @return
	 */
	String getTransfer_station();
	
	/**
	 * 添加订单
	 * @param lbId 
	 * @param lbId2 
	 */
	void addOrder(Integer lbId, String uid, LendingRecord lendingRecord);
}
