package com.dhchain.business.partpunchingworkshop.dao;

import com.dhchain.business.partpunchingworkshop.vo.ColdDailyPlan;
import com.dhchain.business.partpunchingworkshop.vo.PTFinish;
import com.dhchain.business.partpunchingworkshop.vo.PTMaterial;
import com.dhchain.business.partpunchingworkshop.vo.PTProdTake;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductionTaskMapper {
    List<PTProdTake> select(PTProdTake record);//查询任务表
    List<PTMaterial> getMaterial(PTMaterial record);//查询原材料记录
    List<PTFinish> getFinish(PTFinish record);//查询使用记录
    List<PTFinish> selectbyfno(PTFinish record);//根据物料编码查询数据在PTFinish
    List<ColdDailyPlan> selectbyid(ColdDailyPlan record);//根据coldid查询数据在ColdDailyPlan
    int updatebyplanid(PTProdTake record);//更新PTProdTake表中的数据
    int updatebyplanid1(PTProdTake record);//更新PTProdTake表中的数据(取消确认)
}
