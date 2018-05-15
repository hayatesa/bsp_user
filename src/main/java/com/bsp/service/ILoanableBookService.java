package com.bsp.service;

import java.util.List;

import com.bsp.dto.QueryObject;
import com.bsp.entity.LoanableBook;
import com.bsp.entity.PrimaryClassification;
import com.bsp.entity.SecondaryClassification;
import com.bsp.utils.Page;

public interface ILoanableBookService {

	/**
	 * 根据id返回图书信息
	 * @param id 图书id
	 */
	LoanableBook getLoanableBookInforByid(Integer id);
	
	/**
	 * 返回所有图书分页查询的结果
	 * @param queryObject 封装分页请求中的参数
	 */
	Page getAllListBook(QueryObject queryObject);
	
	/**
	 * 返回一级分类的所有结果
	 */
	List<PrimaryClassification> getAllPrimary();
	
	/**
	 * 返回二级分类的所有结果
	 */
	List<SecondaryClassification> getAllSecondary();

	/**
	 * 返回一级分类图书分页查询的结果
	 * @param queryObject 封装分页请求中的参数
	 * @param pcId 一级分类id
	 */
	Page getPrimaryListBook(QueryObject queryObject, Integer pcId);

	/**
	 * 返回二级分类图书分页查询的结果
	 * @param queryObject 封装分页请求中的参数
	 * @param scId 二级分类id
	 */
	Page getSecondaryListBook(QueryObject queryObject, Integer scId);

	/**
	 * 返回二级分类图书分页查询的结果
	 * @param queryObject 封装分页请求中的参数
	 * @param bookName 搜索的书名
	 * @return
	 */
	Page getSearchListBook(QueryObject queryObject, String bookName);
	
}
