package com.dhchain.business.rout.service;


import com.dhchain.business.rout.vo.RoutAppl;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-31.
 */
public interface RoutApplService {
    String selectTodayMaxApplyno();
    int add(RoutAppl routAppl);
    int selectNewId();
    int update(RoutAppl routAppl);
    RoutAppl findByApplyno(String applyno);
    RoutAppl getExpApplByTaskId(String processInstanceId);
    List<RoutAppl> select(RoutAppl routAppl);
}
