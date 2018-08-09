package com.bsp.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bsp.exceptions.SystemErrorException;
import com.bsp.service.IFileUploadService;
import com.bsp.shiro.ShiroUtils;
import com.bsp.utils.Result;

@RestController
@RequestMapping("file")
public class FileUploadController {
	
	@Autowired
	private IFileUploadService fileUploadService;

	@RequestMapping("/cover")
	public Result coverUpload(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {
		try {
			String fileName = fileUploadService.uploadCover(multipartFile);
			request.getSession().setAttribute("session_cover_"+ShiroUtils.getToken().getUuid(), fileName); // 包含二级目录的文件名到session
		} catch (SystemErrorException e) {
			e.printStackTrace();
			return Result.error(e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("由于未知错误，操作失败");
		}
		return Result.success();
	}
	
	@RequestMapping("apply")
	public Result apply() {
		return Result.success();
	}
	
	public void setFileUploadService(IFileUploadService fileUploadService) {
		this.fileUploadService = fileUploadService;
	}
	
}
