package com.dhchain.business.partpunchingworkshop.dao;

import com.dhchain.business.partpunchingworkshop.vo.EQPFault;
import com.dhchain.business.partpunchingworkshop.vo.EQPFaultRed;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EquipmentMaintenanceMapper {
    List<EQPFault> getData(EQPFault record);//查询数据
    List<EQPFaultRed> getRed(EQPFaultRed record);//查询数据
    List<EQPFaultRed> select(EQPFaultRed record);//查询记录是否存在
    int insert(EQPFaultRed record);//插入数据
    int update(EQPFault record);//更新EQPFault状态
    int updateRed(EQPFaultRed record);//更新EQPFaultRed状态
}
