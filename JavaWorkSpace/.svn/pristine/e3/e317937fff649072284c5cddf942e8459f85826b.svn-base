package com.dhchain.business.user.service;

import com.dhchain.business.user.vo.ActUser;

import java.util.List;
import java.util.Map;

public interface UserService {
	
	public ActUser findById(String userId);
	/**
	 * ����
	 * @return
	 */
	public ActUser userLogin(ActUser user);
	
	/**'
	 * ��ҳ��ѯ�û�
	 * @param map
	 * @return
	 */
	public List<ActUser> userPage(Map<String, Object> map);
	
	public int userCount(Map<String, Object> map);
	
	/**
	 * ����ɾ���û�
	 * @param id
	 * @return
	 */
	public int deleteUser(List<String> id);
	
	/**
	 * �޸��û�
	 * @param user
	 * @return
	 */
	public int updateUser(ActUser user);
	
	/**
	 * �����û�
	 * @param user
	 * @return
	 */
	public int addUser(ActUser user);


}
