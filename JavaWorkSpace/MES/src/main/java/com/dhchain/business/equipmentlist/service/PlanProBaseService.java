package com.dhchain.business.equipmentlist.service;

import com.dhchain.business.equipmentlist.vo.PlanProBase;

import java.util.List;

/**
 * Created by tongc on 2017-8-16.
 */
public interface PlanProBaseService {
    List<PlanProBase> queryAsList(PlanProBase planProBase);
    int update(PlanProBase planProBase);
    int delete(PlanProBase planProBase);
    int insert(PlanProBase planProBase);
}
