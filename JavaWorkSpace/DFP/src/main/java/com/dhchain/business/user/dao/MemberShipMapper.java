package com.dhchain.business.user.dao;

import com.dhchain.business.user.vo.Group;
import com.dhchain.business.user.vo.MemberShip;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface MemberShipMapper {
	/**
	 * �û�����ķ���
	 * @return
	 */
	public MemberShip userLogin(Map<String, Object> map);
	
	public int deleteAllGroupsByUserId(String userId);

	public int deleteAllGroupsByGroupId(String groupId);

	public int addMemberShip(MemberShip memberShip);

	public List<MemberShip> selectMemberShipByUserId(String userId);
}
