package com.bsp.service;

import com.bsp.entity.User;
import com.bsp.entity.UserInfor;
import com.bsp.exceptions.UserDefinedException;

public interface IUserService {

	void addUser(User user, UserInfor userInfor);
	
	/**
	 * 根据用户名（邮箱）获取用户
	 * @param user
	 * @throws UserDefinedException
	 */
	User getUserByMail(User user);
	
	/**
	 * 根据用户获取用户信息
	 * @param user 用户
	 */
	UserInfor getUserInforByUser(User user);
	
}
