package com.bsp.service;

import org.springframework.web.multipart.MultipartFile;

public interface IFileUploadService {
	
	/**
	 * 上传图书封面，生成uuid文件名，取uuid前两位字符决定存储路径
	 * @param multipartFile
	 */
	String uploadCover(MultipartFile multipartFile);
	
	/**
	 * 删除一次申请中由于重复上传产生的旧封面，避免存储过多无用文件
	 * @param fileName 
	 */
	void deleteOldCoverInApply(String fileName);
	
}
