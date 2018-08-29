package com.dhchain.business.attrappl.service;

import com.dhchain.business.attrappl.vo.AttrApplDetail;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-11.
 */
public interface AttrApplDetailService {
    int add(List<AttrApplDetail> list);
    int insert(AttrApplDetail attrApplDetail);
    int selectNewId();
    int edit(AttrApplDetail attrApplDetail);
    AttrApplDetail selectById(int id);
    List<AttrApplDetail> selectByApplyno(String applyno);
}
