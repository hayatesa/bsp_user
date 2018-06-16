package com.bsp.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bsp.dao.LendingRecordMapper;
import com.bsp.dao.LoanableBookMapper;
import com.bsp.dao.MappingMapper;
import com.bsp.dao.UserMapper;
import com.bsp.entity.LendingRecord;
import com.bsp.entity.LoanableBook;
import com.bsp.entity.Mapping;
import com.bsp.entity.User;
import com.bsp.exceptions.SystemErrorException;
import com.bsp.service.IOrderService;

@Service
@Transactional
public class OrderService implements IOrderService{

	@Autowired
	private MappingMapper mappingMapper;
	public void setMappingMapper(MappingMapper mappingMapper) {
		this.mappingMapper = mappingMapper;
	}
	
	@Autowired
	private LendingRecordMapper lendingRecordMapper;
	public void setLendingRecordMapper(LendingRecordMapper lendingRecordMapper) {
		this.lendingRecordMapper = lendingRecordMapper;
	}
	
	@Autowired
	private UserMapper userMapper;
	public void setUserMapper(UserMapper userMapper) {
		this.userMapper = userMapper;
	}
	
	@Autowired
	private LoanableBookMapper loanableBookMapper;
	public void setLoanableBookMapper(LoanableBookMapper loanableBookMapper) {
		this.loanableBookMapper = loanableBookMapper;
	}
	
	@Override
	public String getContact_phones() {
		String contact_phones = null;
		try {
			contact_phones = mappingMapper.selectByPrimaryKey("contact_phones").getmValue();
		} catch (Exception e) {			
			e.printStackTrace();
			throw new SystemErrorException("系统错误，获取管理员联系电话失败");
		}
		return contact_phones;
	}
	@Override
	public String getTransfer_station() {
		String transfer_station = null;
		try {
			transfer_station = mappingMapper.selectByPrimaryKey("transfer_station").getmValue();
		} catch (Exception e) {			
			e.printStackTrace();
			throw new SystemErrorException("系统错误，获取取书地点失败");
		}
		return transfer_station;
	}
	@Override
	public void addOrder(Integer lbId, String uid, LendingRecord lendingRecord) {
		LoanableBook book = loanableBookMapper.selectByPrimaryKey(lbId);
		User user = userMapper.selectByPrimaryKey(uid);
		lendingRecord.setUser(user);
		lendingRecord.setLoanableBook(book);
		lendingRecord.setCreateTime(new Date());
		lendingRecord.setLrStruts(new Byte("0"));
		try {
			lendingRecordMapper.insertSelective(lendingRecord);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("系统异常，插入数据失败");
		}
	}
	
	

}