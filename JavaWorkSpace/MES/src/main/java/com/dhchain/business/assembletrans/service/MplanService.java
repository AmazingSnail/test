package com.dhchain.business.assembletrans.service;

import com.dhchain.business.assembletrans.vo.Mplan;
import com.dhchain.business.assembletrans.vo.PlanDuty;

import java.util.List;

public interface MplanService {
	



//	List<User> queryAsList1(MenuQuery query, String Username);
//
//	List<User> queryAsList(MenuQuery query, String Username);

//	List<User> queryAsList(User query, String Username);

	List<Mplan> queryAsList(Mplan mplan);
	List<PlanDuty> getman(PlanDuty record);
	List<Mplan> queryNum(Mplan mplan);
	List<Mplan> queryYS(Mplan mplan);
	int update(Mplan mplan);
	int updateth(Mplan mplan);
	int updatecz(Mplan mplan);
	int updateczqx(Mplan mplan);
	int updateruku(Mplan mplan);
	int updaterukuqx(Mplan mplan);
	int updatetime(Mplan mplan);
	int updateCZRK(int id, double changenum);
	Mplan selectByPrimaryKey(Integer id);
}
