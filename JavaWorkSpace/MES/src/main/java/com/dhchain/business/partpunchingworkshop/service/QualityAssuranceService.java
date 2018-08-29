package com.dhchain.business.partpunchingworkshop.service;

import com.dhchain.business.partpunchingworkshop.vo.*;

import java.util.List;

public interface QualityAssuranceService {
    List<CHKResult> search(CHKResult record);//根据条件查询
    List<CHKDetail> getbycheckID(CHKDetail record);//根据送检单号进行查询
    List<BaseEquip> getEquipID(BaseEquip record);//查询设备编号
    List<PTPlan> getAll(PTPlan record);//得到当月计划产量
    List<PTPlan> getMatial();//得到每天原材料
    List<PTFinish> getFinish();//得到每天产量
    List<PTFinish> getAll1(PTFinish record);//得到当月完成产量
    List<BaseUser> getUser();//得到生产人员
    List<EQPStatus> getStatus(EQPStatus record);//得到设备状态
    List<EQPFault> getFault(EQPFault record);//得到维修记录
}
