package com.dhchain.business.user.service.impl;

import com.dhchain.business.user.dao.GroupMapper;
import com.dhchain.business.user.vo.Group;
import com.dhchain.business.user.service.GroupService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("groupService")
public class GroupServiceImpl implements GroupService{

	@Resource
	private GroupMapper groupMapper;
	
	public List<Group> findByUserId(String id){
		return groupMapper.findByUserId(id);
	}
	/**
	 * ��ѯ���н�ɫ���������
	 * @return
	 */
	public List<Group> findGroup(){
		return groupMapper.findGroup();
	}
	

	/**
	 * ��ҳ��ѯ
	 * @param map
	 * @return
	 */
	public List<Group> groupPage(Map<String,Object> map){
		return groupMapper.groupPage(map);
	}
	/**
	 * ͳ������
	 * @param map
	 * @return
	 */
	public int groupCount(Map<String,Object> map){
		return groupMapper.groupCount(map);
	}
	
	/**
	 * �����h��
	 * @param list
	 * @return
	 */
	public int deleteGroup(List<String> list){
		return groupMapper.deleteGroup(list);
	}
	
	/**
	 * �޸�
	 * @param group
	 * @return
	 */
	public int updateGroup(Group group){
		return groupMapper.updateGroup(group);
	}
	
	public int addGroup(Group group){
		return groupMapper.addGroup(group);
	}
}
