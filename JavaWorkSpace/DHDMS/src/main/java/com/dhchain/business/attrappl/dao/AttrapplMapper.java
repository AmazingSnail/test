package com.dhchain.business.attrappl.dao;

import com.dhchain.business.attrappl.vo.AttrAppl;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-11.
 */
@Repository
public interface AttrapplMapper {
    int insert(AttrAppl attrAppl);
    AttrAppl selectByApplyno(@Param("applyno") String applyno);
    List<AttrAppl> select(AttrAppl attrAppl);
    String selectTodayMaxApplyno(String a);
    int update(AttrAppl attrAppl);
    AttrAppl getAttrApplByTaskId(String processInstanceId);
}
