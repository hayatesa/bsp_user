package com.bsp.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bsp.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

	@Autowired
	private IUserService userService;
	
	public void setUserService(IUserService userService) {
		this.userService = userService;
	}
	
}