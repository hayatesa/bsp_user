package com.bsp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bsp.dao.UserInforMapper;
import com.bsp.dao.UserMapper;
import com.bsp.entity.User;
import com.bsp.exceptions.SendEmailException;
import com.bsp.exceptions.SystemErrorException;
import com.bsp.service.IRegisterService;
import com.bsp.utils.mail.MailSendUtils;

@Service
public class RegisterService implements IRegisterService {
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	UserInforMapper userInforMapper;
	
	public void setUserInforMapper(UserInforMapper userInforMapper) {
		this.userInforMapper = userInforMapper;
	}

	public void setUserMapper(UserMapper userMapper) {
		this.userMapper = userMapper;
	}
	
	@Override
	public boolean isAvailableEmail(String mail) {
		List<User> users = null;
		try {
			users = userMapper.selectByMail(mail);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemErrorException("请求出错，系统异常");
		}
		if (users.size() == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public String sendEmailCode(String dest) {
		// 生成邮箱验证码
		String mailVcode = String.valueOf((int) ((Math.random() * 9 + 1) * 100000));
		// 生成邮件主题内容
		String subject = "注册验证码"; // 邮件主题
		String content = "您的的验证码为：" + mailVcode + "，有效期30分钟，请尽快完成验证。请不要向任何人泄露验证码。"; // 邮件主体内容
		MailSendUtils mailSendUtils = new MailSendUtils();
		try {
			mailSendUtils.sendMail(dest, subject, content);// 发送邮件
		} catch (Exception e) {
			e.printStackTrace();
			throw new  SendEmailException("发送验证码失败，系统异常");
		}
		return mailVcode;
	}
	
}
