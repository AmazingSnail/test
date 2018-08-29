package com.dhchain.business.user.service.impl;

import com.dhchain.business.user.dao.ActUserMapper;
import com.dhchain.business.user.vo.ActUser;
import com.dhchain.business.user.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("serService")
public class UserServiceImpl implements UserService{
	@Resource
	private ActUserMapper acuserMapper;
	
	public ActUser findById(String userId){
		return acuserMapper.findById(userId);
	}
	/**
	 * ����
	 * @return
	 */
	public ActUser userLogin(ActUser user){
		return acuserMapper.userLogin(user);
	}
	
	/**'
	 * ��ҳ��ѯ�û�
	 * @param map
	 * @return
	 */
	public List<ActUser> userPage(Map<String, Object> map){
		return acuserMapper.userPage(map);
	}
	
	public int userCount(Map<String, Object> map){
		return acuserMapper.userCount(map);
	}
	
	/**
	 * ����ɾ���û�
	 * @param id
	 * @return
	 */
	public int deleteUser(List<String> id){
		return acuserMapper.deleteUser(id);
	}
	
	/**
	 * �޸��û�
	 * @param user
	 * @return
	 */
	public int updateUser(ActUser user){
		return acuserMapper.updateUser(user);
	}
	
	/**
	 * �����û�
	 * @param user
	 * @return
	 */
	public int addUser(ActUser user){
		return acuserMapper.addUser(user);
	}
}
