package com.bsp.dao;

import com.bsp.entity.News;
import com.bsp.entity.OutdatedNews;

public interface OutdatedNewsMapper extends GenericMapper<OutdatedNews, Integer> {
	
	/**
	 * 包含消息内容的更新
	 * @param  记录
	 * @return 受影响行数
	 */
	int updateByPrimaryKeyWithBLOBs(News record);
}