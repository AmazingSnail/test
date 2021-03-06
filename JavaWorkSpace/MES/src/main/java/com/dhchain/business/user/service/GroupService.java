package com.dhchain.business.user.service;

import com.dhchain.business.user.vo.Group;

import java.util.List;
import java.util.Map;

public interface GroupService {

	public List<Group> findByUserId(String id);
	/**
	 * ��ѯ���н�ɫ���������
	 * @return
	 */
	public List<Group> findGroup();

	/**
	 * ��ҳ��ѯ
	 * @param map
	 * @return
	 */
	public List<Group> groupPage(Map<String, Object> map);
	/**
	 * ͳ������
	 * @param map
	 * @return
	 */
	public int groupCount(Map<String, Object> map);
	
	/**
	 * �����h��
	 * @param list
	 * @return
	 */
	public int deleteGroup(List<String> list);
	
	/**
	 * �޸�
	 * @param group
	 * @return
	 */
	public int updateGroup(Group group);
	
	public int addGroup(Group group);
}
