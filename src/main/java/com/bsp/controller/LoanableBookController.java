package com.bsp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bsp.dto.QueryObject;
import com.bsp.entity.LoanableBook;
import com.bsp.service.ILoanableBookService;
import com.bsp.utils.Page;
import com.bsp.utils.Result;

/**
 * 可借图书数据调取
 * @author hayate
 *
 */
@RestController
@Scope(value="prototype")
@RequestMapping("/loanble_book")
public class LoanableBookController extends BaseController {
	
	@Autowired
	private ILoanableBookService loanableBookService;
	
	public void setLoanableBookService(ILoanableBookService loanableBookService) {
		this.loanableBookService = loanableBookService;
	}
	
	/**
	 * 分页查询
	 * @param queryObject
	 */
	@RequestMapping("query")
	public Result query(QueryObject queryObject) {
		Page page = null;
		try {
			page = loanableBookService.getListBook(queryObject);
		}catch (Exception e) {
			e.printStackTrace();
			return Result.error("系统错误，获取图书列表失败");
		}
		Result result = new Result();
		result.put("booklist", page);
		return result;
	}
	
	/**
	 * 获取一本书
	 * @param idInteger
	 * @return
	 */
	@RequestMapping("/detail")
	public Result detail(@RequestParam("lbId")Integer idInteger) {
		LoanableBook book = null;
		try {
			book = loanableBookService.getLoanableBookInforByid(idInteger);
		}catch (Exception e) {
			e.printStackTrace();
			return Result.error("系统错误，获取图书信息失败");
		}
		Result result = new Result();
		result.put("detail", book);
		return result;
	}
	
}
