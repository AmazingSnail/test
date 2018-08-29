package com.dhchain.business.index.service.impl;

import java.util.List;
import java.util.Map;

import com.dhchain.business.index.vo.User;
import com.dhchain.business.user.vo.LoginUser;
import com.dhchain.business.user.vo.Organization;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dhchain.business.index.dao.IndexMapper;
import com.dhchain.business.index.service.IndexService;
import com.dhchain.business.index.vo.Menu;
import com.dhchain.business.index.vo.MenuQuery;
import com.dhchain.config.annotation.DataSource;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.vo.BaseResult;
import com.dhchain.config.vo.PageResult;
import com.dhchain.util.PageHelperUtils;
import com.dhchain.util.StringUtil;

@Service("indexService")
public class IndexServiceImpl implements IndexService {
	
	/**
	 * 将dao注入到service中
	 * */
	@Autowired
	private IndexMapper indexMapper;

	@Override
	@DataSource(Type.SQL_MDM)//默认是读库，使用该注解强制该方法使用写库
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//当方法抛出异常用来回滚事务
	public BaseResult<Menu> saveMenu(Menu menu) {
		BaseResult<Menu> result = new BaseResult<Menu>();
		if(StringUtil.isEmpty(menu.getUrl())){
			return result.setStatus(201).setMessage("url不能为空！");
		}
		
		int rs = indexMapper.saveMenu(menu);
		if(rs==0){
			return result.setStatus(201).setMessage("保存失败，请稍后再试！");
		}
		
		return result.setResult(menu);
	}

	@Override
	@DataSource(Type.SQL_MDM)//默认是读库，使用该注解强制该方法使用写库
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//当方法抛出异常用来回滚事务
	public BaseResult<Object> deleteMenu(Long id) {
		BaseResult<Object> result = new BaseResult<Object>();
		if(id==null){
			return result.setStatus(201).setMessage("Id不能为空！");
		}
		
		int rs = indexMapper.deleteMenu(id);
		if(rs==0){
			return result.setStatus(201).setMessage("删除失败，请稍后再试！");
		}
		
		return result;
	}

	@Override
	@DataSource(Type.SQL_MDM)//默认是读库，使用该注解强制该方法使用写库
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//当方法抛出异常用来回滚事务
	public BaseResult<Object> updateMenu(Menu menu) {
		BaseResult<Object> result = new BaseResult<Object>();
		
		int rs = indexMapper.updateMenu(menu);
		if(rs==0){
			return result.setStatus(201).setMessage("更新失败，请稍后再试！");
		}
		return result;
	}

	@Override
	public BaseResult<Menu> getOneMenu(Long id) {
		BaseResult<Menu> result = new BaseResult<Menu>();
		result.setResult(indexMapper.getOneMenu(id));
		return result;
	}

	@Override
	public PageResult<List<Menu>> query(MenuQuery query) {
		PageHelperUtils.setPage(query.getPageNum(), query.getPageSize());//开启分页,使用这句就会开启分页，不使用就全部
		List<Menu> list = indexMapper.getListMenu1(query);
		return PageHelperUtils.getBaseResult(list);//获取分页数据
	}


	@Override
	public List<User> queryAsList1(User query, String Username) {
//		PageHelperUtils.setPage(query.getPageNum(), query.getPageSize());//开启分页,使用这句就会开启分页，不使用就全部
		List<User> list = indexMapper.getListUser(query,Username);
		return list;//获取分页数据
	}

	@Override
	public List<String> queryAllDepartment() {
		List<String> list = indexMapper.queryAllDepartment();
		return list;
	}

	@Override
	public List<User> queryByDepartment(String department) {

		List<User> list = indexMapper.queryByDepartment(department);
		return list;
	}

	@Override
	public List<LoginUser> selectByDepartment(String department) {
		Organization organization = indexMapper.selectByName(department);
		long organizationId = organization.getId();
		List<LoginUser> list = indexMapper.selectByOrganizationId(organizationId);
		return list;
	}

	@Override
	public LoginUser selectById(long id) {
		return indexMapper.selectById(id);
	}

	@Override
	public LoginUser selectApproveman() {
		return  indexMapper.selectApproveman();
	}

	@Override
	public LoginUser selectConfirmman() {
		return indexMapper.selectConfirmman();
	}

	@Override
	public void updatePwdByUserId(long id, String password) {
		indexMapper.updatePwdByUserId(id,password);
	}


}
