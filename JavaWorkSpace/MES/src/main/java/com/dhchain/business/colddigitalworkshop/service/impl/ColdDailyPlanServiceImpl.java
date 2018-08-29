package com.dhchain.business.colddigitalworkshop.service.impl;

import com.dhchain.business.colddigitalworkshop.dao.ColdDailyPlanMapper;
import com.dhchain.business.colddigitalworkshop.service.ColdDailyPlanService;
import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPlan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ColdDailyPlanService")
public class ColdDailyPlanServiceImpl implements ColdDailyPlanService {
    @Autowired
    private ColdDailyPlanMapper coldDailyPlanMapper;
    @Override
    public int deleteByPrimaryKey(Integer id) {
        return coldDailyPlanMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(ColdDailyPlan record) {
        return coldDailyPlanMapper.insert(record);
    }

    @Override
    public int insertSelective(ColdDailyPlan record) {
        return coldDailyPlanMapper.insertSelective(record);
    }

    @Override
    public ColdDailyPlan selectByPrimaryKey(Integer id) {
        return coldDailyPlanMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ColdDailyPlan record) {
        return coldDailyPlanMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(ColdDailyPlan record) {
        return coldDailyPlanMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<ColdDailyPlan> getSeId(ColdDailyPlan record) {
        return coldDailyPlanMapper.getSeId(record);
    }

    @Override
    public List<ColdDailyPlan> selectDailyPlanToday(ColdDailyPlan record) {
        return coldDailyPlanMapper.selectDailyPlanToday(record);
    }

    @Override
    public List<ColdDailyPlan> getSelectFId(ColdDailyPlan record) {
        return coldDailyPlanMapper.getSelectFId(record);
    }

    @Override
    public List<ColdDailyPlan> selectColdDailyPlanByFid(ColdDailyPlan record) {
        return coldDailyPlanMapper.selectColdDailyPlanByFid(record);
    }

    @Override
    public List<ColdDailyPlan> selectColdDailyPlanByid(ColdDailyPlan record) {
        return coldDailyPlanMapper.selectColdDailyPlanByid(record);
    }

    @Override
    public List<ColdDailyPlan> selectDailyPlanReportByTake(ColdDailyPlan record) {
        return coldDailyPlanMapper.selectDailyPlanReportByTake(record);
    }

    @Override
    public List<ColdDailyPlan> selectDailyPlanReportByStart(ColdDailyPlan record) {
        return coldDailyPlanMapper.selectDailyPlanReportByStart(record);
    }
}
