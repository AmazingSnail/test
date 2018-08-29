package com.dhchain.util;

import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.dhchain.config.vo.PageResult;

/**
 * 分页工具类,使用该工具只需要写一个基本的查询，会自动进行分页
 * */
public abstract class PageHelperUtils {
	
	/**
	 * 设置分页信息
	 * @param	pageNum		当前页
	 * @param	pageSize	每页条数
	 * */
	public static void setPage(int pageNum,int pageSize){
		setPage(pageNum, pageSize,null,null);
	}
	
	/**
	 * 设置分页信息
	 * @param	pageNum		当前页
	 * @param	pageSize	每页条数
	 * @param   colum       排序字段
	 * @param	sort		排序方式
	 * */
	public static void setPage(int pageNum,int pageSize,String colum,String sort){
		if(StringUtil.isEmpty(colum)||StringUtil.isEmpty(sort)){
			PageHelper.startPage(pageNum, pageSize);
		}else{
			PageHelper.startPage(pageNum, pageSize, colum.concat(" ").concat(sort));
		}
	}
	
	/**
	 * 获取分页信息
	 * @param	list	已经调用setPage获得的查询结果
	 * @return	PageInfo 
	 * */
	public static <T> PageInfo<T> getPageResult(List<T> list){
		return new PageInfo<T>(list);
	}
	
	/**
	 * 获取分页信息
	 * @param <T>
	 * @param	list	已经调用setPage获得的查询结果
	 * @return	PageInfo 
	 * */
	public static <T> PageResult<List<T>> getBaseResult(List<T> list){
		PageInfo<T> page = new PageInfo<T>(list);
		PageResult<List<T>> result = new PageResult<>();
		result.setResult(list);
		
		result.setPage(page.getPageNum());
		result.setPageSize(page.getPageSize());
		result.setTotalPage(page.getPages());
		result.setCount(page.getTotal());
		
		return result;
	}
}
