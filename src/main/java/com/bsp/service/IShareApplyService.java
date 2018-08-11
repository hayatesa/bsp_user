package com.bsp.service;

import com.bsp.dto.CheckLoanableBookQueryObject;
import com.bsp.entity.CheckLoanableBook;
import com.bsp.utils.Page;

public interface IShareApplyService {
	
	/**
	 * 查找一页数据
	 * @param queryObject
	 */
	Page pageOfApply(CheckLoanableBookQueryObject queryObject);
	
	/**
	 * 添加共享申请
	 * @param checkLoanableBook 实体
	 */
	void addShare(CheckLoanableBook checkLoanableBook);
}
