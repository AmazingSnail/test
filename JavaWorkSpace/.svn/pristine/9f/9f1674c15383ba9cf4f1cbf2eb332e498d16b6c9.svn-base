package com.dhchain.business.equipmentlist.service.impl;

import com.dhchain.business.equipmentlist.dao.PlanProBaseMapper;
import com.dhchain.business.equipmentlist.service.PlanProBaseService;
import com.dhchain.business.equipmentlist.vo.PlanProBase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by tongc on 2017-8-16.
 */
@Service("PlanProBaseService")
public class PlanProBaseServiceImpl implements PlanProBaseService {
    @Autowired
    private PlanProBaseMapper planProBaseMapper;

    @Override
    public List<PlanProBase> queryAsList(PlanProBase planProBase) {
        List<PlanProBase> list = planProBaseMapper.getPlanPB(planProBase);
        return list;
    }

    @Override
    public int update(PlanProBase planProBase) {
        int n = planProBaseMapper.updatePlanPB(planProBase);
        return n;
    }

    @Override
    public int delete(PlanProBase planProBase) {
        int n = planProBaseMapper.deletePlanPB(planProBase);
        return n;
    }

    @Override
    public int insert(PlanProBase planProBase) {
        int n = planProBaseMapper.insertPlanPB(planProBase);
        return n;
    }

}
