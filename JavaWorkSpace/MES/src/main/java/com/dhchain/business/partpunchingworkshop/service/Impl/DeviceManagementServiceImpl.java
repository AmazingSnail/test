package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.HeatTreatment.vo.MEqpheatstatus;
import com.dhchain.business.partpunchingworkshop.dao.DeviceManagementMapper;
import com.dhchain.business.partpunchingworkshop.service.DeviceManagementService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("DeviceManagementService")
public class DeviceManagementServiceImpl implements DeviceManagementService {
@Autowired
 private DeviceManagementMapper deviceManagementMapper;
    @Override
    public List<BaseEquip> getplant() {
        return deviceManagementMapper.getplant();
    }

    @Override
    public List<BaseEquip> getdepartment(BaseEquip record) {
        return deviceManagementMapper.getdepartment(record);
    }

    @Override
    public List<BaseEquip> getInfo(BaseEquip record) {
        return deviceManagementMapper.getInfo(record);
    }

    @Override
    public List<EQPStatus> getbyEquipID(EQPStatus record) {
        return deviceManagementMapper.getbyEquipID(record);
    }

    @Override
    public List<EQPPower> getbyEquipIDD(EQPPower record) {
        return deviceManagementMapper.getbyEquipIDD(record);
    }

    @Override
    public List<PTFinish> getEquipIDnum(PTFinish record) {
        return deviceManagementMapper.getEquipIDnum(record);
    }

    @Override
    public List<MEqpheatstatus> getbyEquipIDH(MEqpheatstatus record) {
        return deviceManagementMapper.getbyEquipIDH(record);
    }

    @Override
    public List<EQPStatus> getSize(EQPStatus record) {
        return deviceManagementMapper.getSize(record);
    }
    @Override
    public List<MEqpheatstatus> getSizeH(MEqpheatstatus record) {
        return deviceManagementMapper.getSizeH(record);
    }

    @Override
    public int updateUser(BaseUser record) {
        return deviceManagementMapper.updateUser(record);
    }
}

