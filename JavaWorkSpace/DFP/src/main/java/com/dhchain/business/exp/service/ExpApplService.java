package com.dhchain.business.exp.service;

import com.dhchain.business.exp.vo.ExpAppl;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-25.
 */
public interface ExpApplService {
    String selectTodayMaxApplyno();
    int add(ExpAppl expAppl);
    int selectNewId();
    ExpAppl findByApplyno(String applyno);
    int update(ExpAppl expAppl);
    ExpAppl getExpApplByTaskId(String processInstanceId);
    List<ExpAppl> select(ExpAppl expAppl);
}
