package com.dhchain.business.exp.dao;

import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.exp.vo.Exptype;
import com.dhchain.business.exp.vo.ExptypeParm;
import com.dhchain.business.exp.vo.ExptypeView;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-06.
 */
@Repository
public interface ExptypeMapper {
    List<Exptype> selectByTypeid(@Param("typeid") int typeid);
    List<Exptype> select(Exptype exptype);
    int insert(Exptype exptype);
    int update(Exptype exptype);
    int savesequence(ExptypeView exptypeView);
    Exptype selectById(@Param("id") int id);
    Exptype selectByTypedetailid(@Param("typedetailid") int typedetailid);
    int delete(String[] ids);
    List<ExptypeView> idcontainView(@Param("exptypeid") int exptypeid);
    List<ExptypeView> isdistribute(@Param("viewid") int viewid);
    ExptypeView selectExptypeView(@Param("exptypeid") int exptypeid,@Param("viewid") int viewid);
    List<Integer> selectViews(@Param("exptypeid")int exptypeid);
    int deleteExptypeView(@Param("exptypeid")int exptypeid );
    int distribute(ExptypeView exptypeView);
    int selectNewId();
    List<AttrDefine> selectParms(@Param("exptypeid")int exptypeid);
    int deleteParms(@Param("exptypeid")int exptypeid );
    int distributeparm(ExptypeParm exptypeParm);
}
