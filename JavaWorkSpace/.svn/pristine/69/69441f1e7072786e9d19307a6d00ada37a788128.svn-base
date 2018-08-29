package com.dhchain.business.exp.dao;

import com.dhchain.business.exp.vo.ExpAppl;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-25.
 */
@Repository
public interface ExpApplMapper {
    String selectTodayMaxApplyno(String a);
    int insert(ExpAppl expAppl);
    int update(ExpAppl expAppl);
    int selectNewId();
    ExpAppl findByApplyno(String applyno);
    ExpAppl getExpApplByTaskId(String processInstanceId);
    List<ExpAppl> select(ExpAppl expAppl);
}
