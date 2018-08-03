package com.bsp.service;

import com.bsp.dto.CheckLoanableBookQueryObject;
import com.bsp.utils.Page;

public interface IShareApplyService {
	
	/**
	 * 查找一页数据
	 * @param queryObject
	 */
	Page pageOfApply(CheckLoanableBookQueryObject queryObject);
	
	/**
	 * 保存封面
	 * @param fileName 文件名
	 */
	void saveCoverImg(String fileName);
}
