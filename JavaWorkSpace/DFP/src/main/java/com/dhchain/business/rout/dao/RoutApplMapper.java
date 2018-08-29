package com.dhchain.business.rout.dao;

import com.dhchain.business.rout.vo.RoutAppl;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-31.
 */
@Repository
public interface RoutApplMapper {
    String selectTodayMaxApplyno(String a);
    int insert(RoutAppl routAppl);
    int selectNewId();
    int update(RoutAppl routAppl);
    RoutAppl findByApplyno(String applyno);
    RoutAppl getExpApplByTaskId(String processInstanceId);
    List<RoutAppl> select(RoutAppl routAppl);
}
