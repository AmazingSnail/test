package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.dao.MissionIssuedMapper;
import com.dhchain.business.partpunchingworkshop.service.MissionIssuedService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("MissionIssuedService")
public class MissionIssuedServiceImpl implements MissionIssuedService {
     @Autowired
     private MissionIssuedMapper missionIssuedMapper;

    @Override
    public List<PTProdTake> getTodaydate() {
        return missionIssuedMapper.getTodaydate();
    }

    @Override
    public List<BaseEquip> getEquipID(BaseEquip record) {
        return missionIssuedMapper.getEquipID(record);
    }

    @Override
    public List<MoldStore> GetMouldID(MoldStore record) {
        return  missionIssuedMapper.GetMouldID(record);
    }

    @Override
    public List<BaseUser> GetproductMan(BaseUser record) {
        return missionIssuedMapper.GetproductMan(record);
    }

    @Override
    public List<BaseCapacity> GetCapacity(BaseCapacity record) {
        return missionIssuedMapper.GetCapacity(record);
    }

    @Override
    public List<PTProdTake> getSerialno(PTProdTake record) {
        return missionIssuedMapper.getSerialno(record);
    }

    @Override
    public int insertTake(PTProdTake record) {
        return missionIssuedMapper.insertTake(record);
    }

    @Override
    public int deleteTake(PTProdTake record) {
        return missionIssuedMapper.deleteTake(record);
    }

    @Override
    public int updateByid(PTPlan record) {
        return missionIssuedMapper.updateByid(record);
    }

    @Override
    public int updateByfno(PTPlan record) {
        return missionIssuedMapper.updateByfno(record);
    }

    @Override
    public List<PTPlan> getByid(PTPlan record) {
        return missionIssuedMapper.getByid(record);
    }

    @Override
    public List<PTPlan> getByfno(PTPlan record) {
        return missionIssuedMapper.getByfno(record);
    }
}
