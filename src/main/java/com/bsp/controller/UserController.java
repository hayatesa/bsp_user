package com.bsp.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bsp.exceptions.SystemErrorException;
import com.bsp.service.IUserService;
import com.bsp.shiro.ShiroUtils;
import com.bsp.utils.Result;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

	@Autowired
	private IUserService userService;
	
	public void setUserService(IUserService userService) {
		this.userService = userService;
	}
	
	/**
	 * 修改密码
	 * @param currentPassword 原密码
	 * @param newPassword 新密码
	 * @param confirmPassword 确认密码
	 */
	@RequestMapping(value="password", method=RequestMethod.POST)
	public Result changePassword(String currentPassword, String newPassword, String confirmPassword) {
		try {
			userService.changePassword(ShiroUtils.getToken(), currentPassword, newPassword, confirmPassword);
		} catch (SystemErrorException e) {
			e.printStackTrace();
			Result.error(e.getMessage());
		}
		return Result.success();
	}
	
}