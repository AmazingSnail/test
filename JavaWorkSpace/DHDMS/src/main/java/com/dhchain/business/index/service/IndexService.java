package com.dhchain.business.index.service;

import java.util.List;


import com.dhchain.business.index.vo.Menu;
import com.dhchain.business.index.vo.MenuQuery;
import com.dhchain.business.index.vo.User;
import com.dhchain.business.user.vo.LoginUser;
import com.dhchain.config.vo.BaseResult;
import com.dhchain.config.vo.PageResult;

public interface IndexService {
	
	/**
	 * 保存menu
	 * @param	menu	菜单实体
	 * @return	BaseResult<Menu>
	 * */
	BaseResult<Menu> saveMenu(Menu menu);
	
	/**
	 * 删除menu
	 * @param	id	菜单Id
	 * @return	BaseResult<Object>
	 * */
	BaseResult<Object> deleteMenu(Long id);
	
	/**
	 * 修改menu
	 * @param	menu	菜单实体
	 * @return	BaseResult<Object>
	 * */
	BaseResult<Object> updateMenu(Menu menu);
	
	/**
	 * 获取单个menu
	 * @param	id	菜单Id
	 * @return	BaseResult<Menu>
	 * */
	BaseResult<Menu> getOneMenu(Long id);
	
	/**
	 * 分页查询menu
	 * @param	query	查询条件
	 * @return	PageResult<Menu>
	 * */
	PageResult<List<Menu>> query(MenuQuery query);

//	List<User> queryAsList1(MenuQuery query, String Username);
//
//	List<User> queryAsList(MenuQuery query, String Username);

//	List<User> queryAsList(User query, String Username);

	List<User> queryAsList1(User query, String Username);

	List<String> queryAllDepartment();

	List<User> queryByDepartment(String department);

	List<LoginUser> selectByDepartment(String department);

	LoginUser selectById(long id);

	LoginUser selectApproveman();

	LoginUser selectConfirmman();

	void  updatePwdByUserId(long id,String password);
}
