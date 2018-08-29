package com.dhchain.business.user.dao;

import com.dhchain.business.user.vo.Group;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface GroupMapper {
	
	/**
	 * ��ѯ���н�ɫ���������
	 * @return
	 */
	public List<Group> findGroupByID(String id);
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
	
	/**
	 * ����
	 * @param group
	 * @return
	 */
	public int addGroup(Group group);
	
	public List<Group> findByUserId(String id);
}
