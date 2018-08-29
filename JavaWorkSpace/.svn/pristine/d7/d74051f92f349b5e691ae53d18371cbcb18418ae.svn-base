package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.dao.EquipmentMaintenanceMapper;
import com.dhchain.business.partpunchingworkshop.service.EquipmentMaintenanceService;
import com.dhchain.business.partpunchingworkshop.vo.EQPFault;
import com.dhchain.business.partpunchingworkshop.vo.EQPFaultRed;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("EquipmentMaintenanceService")
public class EquipmentMaintenanceServiceImpl implements EquipmentMaintenanceService{
    @Autowired
    private EquipmentMaintenanceMapper equipmentMaintenanceMapper;
    @Override
    public List<EQPFault> getData(EQPFault record) {
        return equipmentMaintenanceMapper.getData(record);
    }

    @Override
    public List<EQPFaultRed> getRed(EQPFaultRed record) {
        return equipmentMaintenanceMapper.getRed(record);
    }

    @Override
    public List<EQPFaultRed> select(EQPFaultRed record) {
        return equipmentMaintenanceMapper.select(record);
    }

    @Override
    public int insert(EQPFaultRed record) {
        return equipmentMaintenanceMapper.insert(record);
    }

    @Override
    public int update(EQPFault record) {
        return equipmentMaintenanceMapper.update(record);
    }

    @Override
    public int updateRed(EQPFaultRed record) {
        return equipmentMaintenanceMapper.updateRed(record);
    }
}
