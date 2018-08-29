package com.dhchain.business.colddigitalworkshop.dao;

import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPrint;
import com.dhchain.business.colddigitalworkshop.vo.ColdMonthPlan;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColdMonthPlanMapper {
    int deleteByPrimaryKey(Integer id);
    int deleteByFparentIdAndId(Integer id);

    int insert(ColdMonthPlan record);

    int insertSelective(ColdMonthPlan record);
    int insertSelectiveList(List<ColdMonthPlan> list);

    ColdMonthPlan selectByPrimaryKey(Integer id);

    List<ColdMonthPlan> selectByAllKey(ColdMonthPlan record);
    List<ColdMonthPlan> selectOnlyParent(ColdMonthPlan record);
    List<ColdMonthPlan> selectOnlyChilds(ColdMonthPlan record);
    List<ColdMonthPlan> selectmonthplanByDaoRu(ColdMonthPlan record);

    int updateByPrimaryKeySelective(ColdMonthPlan record);
    int updateByFidChangeNum(ColdDailyPrint record);

    int updateByPrimaryKey(ColdMonthPlan record);
    int updateMonthPlanTakenumGo(ColdMonthPlan record);
    int updateMonthPlanTakenumBack(ColdMonthPlan record);
}