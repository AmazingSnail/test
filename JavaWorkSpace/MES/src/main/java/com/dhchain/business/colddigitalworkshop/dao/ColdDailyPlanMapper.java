package com.dhchain.business.colddigitalworkshop.dao;

import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPlan;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColdDailyPlanMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ColdDailyPlan record);

    int insertSelective(ColdDailyPlan record);

    ColdDailyPlan selectByPrimaryKey(Integer id);

    List<ColdDailyPlan> getSeId(ColdDailyPlan record);
    List<ColdDailyPlan> getSelectFId(ColdDailyPlan record);
    List<ColdDailyPlan> selectDailyPlanToday(ColdDailyPlan record);
    List<ColdDailyPlan> selectColdDailyPlanByFid(ColdDailyPlan record);
    List<ColdDailyPlan> selectColdDailyPlanByid(ColdDailyPlan record);
    List<ColdDailyPlan> selectDailyPlanReportByTake(ColdDailyPlan record);
    List<ColdDailyPlan> selectDailyPlanReportByStart(ColdDailyPlan record);

    int updateByPrimaryKeySelective(ColdDailyPlan record);

    int updateByPrimaryKey(ColdDailyPlan record);
}