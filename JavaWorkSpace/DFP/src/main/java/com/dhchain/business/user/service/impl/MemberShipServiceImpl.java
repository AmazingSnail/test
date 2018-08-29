package com.dhchain.business.user.service.impl;

import com.dhchain.business.user.dao.MemberShipMapper;
import com.dhchain.business.user.vo.MemberShip;
import com.dhchain.business.user.service.MemberShipService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("memberShipService")
public class MemberShipServiceImpl implements MemberShipService{

	@Resource
	private MemberShipMapper menberShipDao;
	
	/**
	 * �û�����ķ���
	 * @return
	 */
	public MemberShip userLogin(Map<String, Object> map){
		return menberShipDao.userLogin(map);
	}
	
	public int deleteAllGroupsByUserId(String userId){
		return menberShipDao.deleteAllGroupsByUserId(userId);
	}
	
	public int addMemberShip(MemberShip memberShip){
		return menberShipDao.addMemberShip(memberShip);
	}
	public List<MemberShip> selectMemberShipByUserId(String userId) {
		return menberShipDao.selectMemberShipByUserId(userId);
	}
}
