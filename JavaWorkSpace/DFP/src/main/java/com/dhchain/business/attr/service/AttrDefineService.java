package com.dhchain.business.attr.service;

import com.dhchain.business.attr.vo.AttrDefine;

import java.util.List;

/**
 * Created by zhenglb on 2017-11-02.
 */
public interface AttrDefineService {
    List<AttrDefine> select(AttrDefine attrDefine);
    AttrDefine selectById(String id);
    AttrDefine selectByNo(String attrDefineno);
    AttrDefine selectByBaseid(int baseid);
    int add(AttrDefine attrDefine);
    int edit(AttrDefine attrDefine);
    int delete(String[] ids);
    boolean isexistAttrdefineno(String attrdefineno );
    boolean isdistribute(int attrid);
}
