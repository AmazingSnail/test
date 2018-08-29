package com.dhchain.business.colddigitalworkshop.service.impl;

import com.dhchain.business.colddigitalworkshop.dao.SplitMaintenanceMapper;
import com.dhchain.business.colddigitalworkshop.service.SplitMaintenanceService;
import com.dhchain.business.colddigitalworkshop.vo.Smaintenance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("SplitMaintenanceService")
public class SplitMaintenanceServiceImpl implements SplitMaintenanceService {
    @Autowired
    private SplitMaintenanceMapper splitMaintenanceMapper;
    @Override
    public int deleteByPrimaryKey(Integer id) {
        return splitMaintenanceMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteByFparentIdAndId(Integer id) {
        return splitMaintenanceMapper.deleteByFparentIdAndId(id);
    }

    @Override
    public int insert(Smaintenance record) {
        return splitMaintenanceMapper.insert(record);
    }

    @Override
    public int insertSelective(Smaintenance record) {
        return splitMaintenanceMapper.insertSelective(record);
    }

    @Override
    public List<Smaintenance> selectByAll(Smaintenance record) {
        return splitMaintenanceMapper.selectByAll(record);
    }


    @Override
    public Smaintenance selectByPrimaryKey(Integer id) {
        return splitMaintenanceMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Smaintenance> selectsplitByfparentid(Smaintenance record) {
        return splitMaintenanceMapper.selectsplitByfparentid(record);
    }

    @Override
    public List<Smaintenance> selectParentIsHave(Smaintenance record) {
        return splitMaintenanceMapper.selectParentIsHave(record);
    }

    @Override
    public List<Smaintenance> selectChildIsHave(Smaintenance record) {
        return splitMaintenanceMapper.selectChildIsHave(record);
    }

    @Override
    public int updateByPrimaryKeySelective(Smaintenance record) {
        return splitMaintenanceMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Smaintenance> selectSplitMaoLiaoFno() {
        return splitMaintenanceMapper.selectSplitMaoLiaoFno();
    }

    @Override
    public int updateByPrimaryKey(Smaintenance record) {
        return splitMaintenanceMapper.updateByPrimaryKey(record);
    }
}
