package com.dhchain.business.partpunchingworkshop.service;

import com.dhchain.business.partpunchingworkshop.vo.*;

import java.util.List;

public interface PersonnelMaintenanceService {
    List<BaseEquip> getEquip(BaseEquip record);//查询设备BaseEquip
    List<BaseEquip> getEquipD(BaseEquip record);//查询设备BaseEquip根据事业部和部门
    List<PTFinish> getEquip1(PTFinish record);//查询设备PTFinish
    List<EQPFault> getEquipF(EQPFault record);//查询设备EQPFault
    List<EQPCheck> getAll(EQPCheck record);//设备点检项目;
    List<EQPCheck> getMan(EQPCheck record);// 获取设备的检测时间和检测人
    List<Num> getNum(Num record);//英文变成阿拉伯数字
    List<BaseStatus> queryplant();//根据从基础数据得到事业部。
    List<BaseUser> getUserName(BaseUser record);//查询检验人员
    List<PTProdTake> getPlanID(PTProdTake record);//查询计划编号
    List<BaseStatus> getDepartment();//查询部门
    List<BaseStatus> getStatus(BaseStatus record);//设备编号查询部门
    List<BaseEquip> getlist(BaseEquip record);//获取设备信息
    List<BaseUser> query(BaseUser record);//查询人员信息
    int insertprocess(BaseUser record);//保存生产人员信息
    int updateUser(BaseUser record);//更新人员信息
    int delete(BaseUser record);//删除人员:
    List<CHKResult> getCheck(CHKResult record);//获取检验记录是否存在
    List<CHKResult> getCheck1(CHKResult record);//获取检验记录是否存在
    List<BaseCapacity> getInfo(BaseCapacity record);//获取材料基础信息是否存在。
    List<BaseChkStd>getBaseData(BaseChkStd record);//获取材料基础信息
    List<CHKDetail> getDetail(CHKDetail record);//获取检测明细。
    List<CHKResult> getChechID(CHKResult record);//获取最大的故障id
   int  insertResult(CHKResult record);//插入记录
   int  insertDetail(CHKDetail record);//插入明细记录
}
