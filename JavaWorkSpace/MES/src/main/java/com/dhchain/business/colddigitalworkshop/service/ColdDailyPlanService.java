package com.dhchain.business.colddigitalworkshop.service;

import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPlan;

import java.util.List;

public interface ColdDailyPlanService {
    int deleteByPrimaryKey(Integer id);

    int insert(ColdDailyPlan record);

    int insertSelective(ColdDailyPlan record);

    ColdDailyPlan selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ColdDailyPlan record);

    int updateByPrimaryKey(ColdDailyPlan record);

    List<ColdDailyPlan> getSeId(ColdDailyPlan record);

    List<ColdDailyPlan> selectDailyPlanToday(ColdDailyPlan record);
    List<ColdDailyPlan> getSelectFId(ColdDailyPlan record);
    List<ColdDailyPlan> selectColdDailyPlanByFid(ColdDailyPlan record);
    List<ColdDailyPlan> selectColdDailyPlanByid(ColdDailyPlan record);
    List<ColdDailyPlan> selectDailyPlanReportByTake(ColdDailyPlan record);
    List<ColdDailyPlan> selectDailyPlanReportByStart(ColdDailyPlan record);
}
