package com.bsp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dto.CheckLoanableBookQueryObject;
import com.bsp.entity.CheckLoanableBook;
import com.bsp.exceptions.SystemErrorException;
import com.bsp.service.IShareApplyService;
import com.bsp.utils.Page;
import com.bsp.utils.Result;

@RestController
@Scope(value="prototype")
@RequestMapping("share")
public class ShareApplyController extends BaseController {
	
	@Autowired
	private IShareApplyService shareApplyService;
	
	/**
	 * 共享图书，生成待管理员审核的订单，图片上传还需定义接口
	 * @param param 封装图书信息
	 */
	@RequestMapping("apply")
	public Result apply(CheckLoanableBook param) {
		return Result.success();
	}
	
	/**
	 * 更新数据
	 * @param clbId 待审核的书的id
	 */
	@RequestMapping("update")
	public Result update(Integer clbId) {
		return Result.success();
	}
	
	/**
	 * 取消分享申请
	 * @param clbId 待审核图书的id
	 */
	@RequestMapping("cancel")
	public Result cancel(Integer clbId) {
		return Result.success();
	}
	
	@RequestMapping("page")
	public Result page(CheckLoanableBookQueryObject queryObject) {
		Page page;
		try {
			page = shareApplyService.pageOfApply(queryObject);
		} catch (SystemErrorException e) {
			e.printStackTrace();
			return Result.error(e.getMessage());
		} 
		catch (Exception e) {
			e.printStackTrace();
			return Result.error("由于未知错误，查询数据失败");
		}
		Result result = Result.success();
		result.put("page", page);
		return result;
	}

	public void setShareApplyService(IShareApplyService shareApplyService) {
		this.shareApplyService = shareApplyService;
	}
	
	
}
