package com.bsp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dto.OrderQueryObject;
import com.bsp.exceptions.SystemErrorException;
import com.bsp.service.IOrderService;
import com.bsp.utils.Page;
import com.bsp.utils.Result;

@RestController
@Scope(value="prototype")
@RequestMapping("/in_record")
public class InRecordControl {
	
	@Autowired
	private IOrderService orderService;
	public void setOrderService(IOrderService orderService) {
		this.orderService = orderService;
	}
	
	/**
	 * 分页查询借阅记录
	 */
	@RequestMapping("query")
	public Result query(OrderQueryObject queryObject) {
		System.out.println("页大小："+queryObject.getLimit());
		System.out.println("当前页："+queryObject.getPageNumber());
		System.out.println("订单状态："+queryObject.getStatus());
		System.out.println("搜索字段："+queryObject.getSearch());
		queryObject.setUuid("d500618bd4e4473a8abbcd53b6f29ece");
		Page page = null;
		try {
			page = orderService.getAllListOrder(queryObject);
		} catch (SystemErrorException e) {
			e.printStackTrace();
			return Result.error(e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("由于未知错误，请求失败");
		}
		Result result = new Result();
		result.put("page", page);
		return result;
	}

}
