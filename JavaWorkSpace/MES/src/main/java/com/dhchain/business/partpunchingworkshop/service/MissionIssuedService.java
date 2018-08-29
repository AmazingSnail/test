package com.dhchain.business.partpunchingworkshop.service;

import com.dhchain.business.partpunchingworkshop.vo.*;

import java.util.List;

public interface MissionIssuedService {
    List<PTProdTake> getTodaydate();//查询当天数据
    List<BaseEquip> getEquipID(BaseEquip record);//查询设备编号
    List<MoldStore> GetMouldID(MoldStore record);//查询模具编号
    List<BaseUser> GetproductMan(BaseUser record);//查询冲制工人
    List<BaseCapacity> GetCapacity(BaseCapacity record);//查询单日产能
    List<PTProdTake> getSerialno(PTProdTake record);//查询月度最大编号
    int   insertTake(PTProdTake record);//插入到PTProdTake表中
    int   deleteTake(PTProdTake record);//删除PTProdTake表
    int   updateByid(PTPlan record);//更新月度计划的剩余数量
    int   updateByfno(PTPlan record);//更新月度计划的剩余数量
    List<PTPlan> getByid(PTPlan record);//查询月度计划根据id
    List<PTPlan> getByfno(PTPlan record);//查询月度计划根据fno
}
