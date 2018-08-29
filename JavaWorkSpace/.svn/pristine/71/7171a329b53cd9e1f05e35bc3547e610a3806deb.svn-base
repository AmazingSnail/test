package com.dhchain.business.exp.service;

import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.attr.vo.ViewAttr;
import com.dhchain.business.exp.vo.View;

import java.util.List;

/**
 * Created by zhenglb on 2017-11-03.
 */
public interface ViewService {
    List<View> select(View view);
    List<View> selectByExptypeid(int exptypeid);
    int add(View view);
    int edit(View view);
    int delete(String[] ids);
    int savedefault(ViewAttr viewAttr);
    boolean distribute(int viewid,String[] ids);
    boolean isdistribute(int viewid);
    ViewAttr selectViewAttr(int viewid,int attrid);
    View selectById(int id);
    List<AttrDefine> selectAttrDefines(int viewid);
}
