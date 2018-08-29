package com.dhchain.business.index.dao;

import java.util.List;

import com.dhchain.business.index.vo.Menu;
import com.dhchain.business.index.vo.MenuQuery;
import com.dhchain.business.index.vo.User;
import com.dhchain.business.user.vo.LoginUser;
import com.dhchain.business.user.vo.Organization;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * IndexMapper:是index模块的dao接口，因为在magic-data.xml中配置的是*Mapper，所以最好以Mapper结尾
 * 
 * mybatis与spring集成后，日常的开发任务就在这里。
 * 一个IndexMapper.java应该对应一个IndexMapper.xml文档。
 * IndexMapper.java中的一个方法要与mapper.xml中的SQL ID对应
 * 
 * */
@Repository
public interface IndexMapper {
	/**
	 * 保存Menu
	 * @param	m	菜单实体
	 * @return	int
	 * */
	int saveMenu(Menu m);
	
	/**
	 * 删除Menu（演示物理删除）
	 * @param	id	菜单Id
	 * @return	int
	 * */
	int deleteMenu(Long id);
	
	/**
	 * 修改Menu
	 * @param	m	菜单实体
	 * @return	int
	 * */
	int updateMenu(Menu m);
	
	/**
	 * 查询单个Menu
	 * @param	id	菜单Id
	 * @return	Menu
	 * */
	Menu getOneMenu(Long id);
	
	/**
	 * 查询多个Menu
	 * @param	query 菜单Id
	 * @return	Menu
	 * */
	List<User> getListUser(User query,@Param("Username")String Username);

	List<Menu> getListMenu1(MenuQuery query);

	/**
	 * 根据部门查人
	 * @param department 部门
	 * @return List<User>
	 */
	List<User> queryByDepartment(String department);

	List<String> queryAllDepartment();

	Organization selectByName(String name);

	List<LoginUser> selectByOrganizationId(long organizationId);

	LoginUser selectById(long id);

	LoginUser selectApproveman();

	LoginUser selectConfirmman();

	void updatePwdByUserId(@Param("id")long id, @Param("password")String password);

}
