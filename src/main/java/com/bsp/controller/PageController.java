package com.bsp.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 控制页面跳转
 * 
 * @author hayate
 *
 */
@Controller
public class PageController {
	/**
	 * 控制页面跳转
	 *
	 * @param request
	 * @param moduleName 模块名
	 * @param htmlName 页面
	 * @return
	 */
	@RequestMapping("/module/{moduleName}/{htmlName}")
	public String showPage(HttpServletRequest request, @PathVariable("moduleName") String moduleName,
			@PathVariable("htmlName") String htmlName) {
		return "/" + moduleName + "/" + htmlName;
	}
	
	/**
	 * 账号登陆页面
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String signIn() {
		return "/user/login";
	}
	
	/**
	 * 首页
	 */
	@RequestMapping({"/index","/"})
	public String index() {
		return "/user/index";
	}
}
