package com.bsp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bsp.dao.NewsMapper;
import com.bsp.dto.QueryObject;
import com.bsp.entity.News;
import com.bsp.exceptions.SystemErrorException;
import com.bsp.service.IMessageService;
import com.bsp.utils.Page;

@Service
public class MessageService implements IMessageService {
	
	@Autowired
	private NewsMapper newsMapper;
	
	
	public void setNewsMapper(NewsMapper newsMapper) {
		this.newsMapper = newsMapper;
	}

	@Override
	public News getUnReadMsg(Integer id) {
		return null;
	}

	@Override
	public News getReadMsg(Integer id) {
		return null;
	}

	@Override
	public Integer getNewMsgAmount(String uuid) {
		Integer amount = null;
		try {
			amount = newsMapper.getNewMsgAmount(uuid);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("系统异常");
		}
		return amount;
	}

	@Override
	public Page getNewMsgList(QueryObject queryObject) {
		List<News> list = null;
		Integer totalCount;
		try {
			list = newsMapper.selectByQueryObject(queryObject);
			totalCount = newsMapper.getTotalCount(queryObject);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("系统异常");
		}
		return new Page(list, totalCount, queryObject.getLimit(), queryObject.getPageNumber());
	}

	@Override
	public Page getHistoryMsgList(QueryObject queryObject) {
		return null;
	}

}
