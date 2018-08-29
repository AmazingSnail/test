package com.dhchain.business.partpunchingworkshop.dao;

import com.dhchain.business.partpunchingworkshop.vo.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MissionIssuedMapper  {
    List<PTProdTake> getTodaydate();
    List<PTProdTake>  getSerialno(PTProdTake record);
    List<BaseEquip> getEquipID(BaseEquip record);
    List<MoldStore> GetMouldID(MoldStore record);
    List<BaseUser> GetproductMan(BaseUser record);
    List<BaseCapacity> GetCapacity(BaseCapacity record);
    int   insertTake(PTProdTake record);//插入到PTProdTake表中
    int   updateByid(PTPlan record);////更新月度计划的剩余数量
    int   updateByfno(PTPlan record);//更新月度计划的剩余数量
    List<PTPlan> getByid(PTPlan record);//查询月度计划
    List<PTPlan> getByfno(PTPlan record);//查询月度计划根据fno
    int   deleteTake(PTProdTake record);//删除PTProdTake表
}
