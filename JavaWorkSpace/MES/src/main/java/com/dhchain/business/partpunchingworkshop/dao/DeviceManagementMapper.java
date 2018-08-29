package com.dhchain.business.partpunchingworkshop.dao;

import com.dhchain.business.HeatTreatment.vo.MEqpheatstatus;
import com.dhchain.business.partpunchingworkshop.vo.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DeviceManagementMapper {
    List<BaseEquip> getplant();//查询事业部
    List<BaseEquip> getdepartment(BaseEquip record);
    List<BaseEquip> getInfo(BaseEquip record);//查询设备信息
    List<EQPStatus> getbyEquipID(EQPStatus record);//关联查询其他数据信息
    List<EQPPower> getbyEquipIDD(EQPPower record);//关联查询其他数据信息
    List<PTFinish> getEquipIDnum(PTFinish record);//查询当月产量
    List<MEqpheatstatus> getbyEquipIDH(MEqpheatstatus record);//关联查询其他数据信息
    List<EQPStatus> getSize(EQPStatus record);//总台数
    List<MEqpheatstatus> getSizeH(MEqpheatstatus record);//总台数

    int updateUser(BaseUser record);//更新图片
}
