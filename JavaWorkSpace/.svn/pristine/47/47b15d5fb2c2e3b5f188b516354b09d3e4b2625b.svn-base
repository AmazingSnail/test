package com.dhchain.business.colddigitalworkshop.service.impl;

import com.dhchain.business.colddigitalworkshop.dao.ColdPlantLgortMapper;
import com.dhchain.business.colddigitalworkshop.service.ColdPlantLgortService;
import com.dhchain.business.colddigitalworkshop.vo.ColdPlantLgort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ColdPlantLgortService")
public class ColdPlantLgortServiceImpl implements ColdPlantLgortService {
    @Autowired
    private ColdPlantLgortMapper coldPlantLgortMapper;
    @Override
    public int deleteByPrimaryKey(Integer id) {
        return coldPlantLgortMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(ColdPlantLgort record) {
        return coldPlantLgortMapper.insert(record);
}

    @Override
    public int insertSelective(ColdPlantLgort record) {
        return coldPlantLgortMapper.insertSelective(record);
    }

    @Override
    public ColdPlantLgort selectByPrimaryKey(Integer id) {
        return coldPlantLgortMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ColdPlantLgort record) {
        return coldPlantLgortMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(ColdPlantLgort record) {
        return coldPlantLgortMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<ColdPlantLgort> selectPlantLgortAll() {
        return coldPlantLgortMapper.selectPlantLgortAll();
    }
}
