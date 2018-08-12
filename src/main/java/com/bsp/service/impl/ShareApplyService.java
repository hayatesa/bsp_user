package com.bsp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bsp.dao.CheckLoanableBookMapper;
import com.bsp.dto.CheckLoanableBookQueryObject;
import com.bsp.entity.CheckLoanableBook;
import com.bsp.exceptions.SystemErrorException;
import com.bsp.service.IShareApplyService;
import com.bsp.utils.Page;

@Service
public class ShareApplyService implements IShareApplyService {
	
	@Autowired
	private CheckLoanableBookMapper checkLoanableBookMapper;
	
	@Override
	public void addShare(CheckLoanableBook checkLoanableBook) {
		checkLoanableBook.setClbStatus((byte)0);// 转台0，未审核
		try {
			checkLoanableBookMapper.insertSelective(checkLoanableBook);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("服务器异常，提交申请失败");
		}
	}
	
	@Override
	public Page pageOfApply(CheckLoanableBookQueryObject queryObject) {
		Integer totalCount = 0;
		List<CheckLoanableBook> list = null;
		try {
			totalCount = checkLoanableBookMapper.getTotalCount(queryObject);
			list = checkLoanableBookMapper.selectByQueryObject(queryObject);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("服务器异常，提交申请失败");
		}
		return new Page(list, totalCount, queryObject.getLimit(), queryObject.getPageNumber());
	}

	public CheckLoanableBookMapper getCheckLoanableBookMapper() {
		return checkLoanableBookMapper;
	}

	public void setCheckLoanableBookMapper(CheckLoanableBookMapper checkLoanableBookMapper) {
		this.checkLoanableBookMapper = checkLoanableBookMapper;
	}

}
