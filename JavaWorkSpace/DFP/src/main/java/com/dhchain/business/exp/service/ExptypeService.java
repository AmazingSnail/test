package com.dhchain.business.exp.service;


import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.exp.vo.Exptype;
import com.dhchain.business.exp.vo.ExptypeView;
import com.dhchain.business.exp.vo.View;

import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2017-10-06.
 */
public interface ExptypeService {
    List<Exptype> selectByTypeid(int typeid);
    List<Exptype> select(Exptype exptype);
    int add(Exptype exptype);
    int edit(Exptype exptype);
    int savesequence(ExptypeView exptypeView);
    Exptype selectById(String id);
    Exptype selectByTypedetailid(int typedetailid);
    int deleteExpTypes(String[] ids);
    boolean iscontainView(int id);
    List<View> selectViews(int exptypeid);
    boolean distribute(int exptypeid,String ids);
    Map isRepeatAttr(String[] ids);
    ExptypeView selectExptypeView(int exptypeid,int viewid);
    int selectNewId();
    List<AttrDefine> selectParms(int exptypeid);
    boolean distributeparms(int exptypeid,String[] ids);
}
