package com.dhchain.business.colddigitalworkshop.service.impl;

import com.dhchain.business.colddigitalworkshop.service.ColdLocationService;
import com.dhchain.business.colddigitalworkshop.vo.ColdLocation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("ColdLocationService")
public class ColdLocationServiceImpl implements ColdLocationService {
    @Autowired
    private ColdLocationService coldLocationService;
    @Override
    public int deleteByPrimaryKey(String location) {
        return coldLocationService.deleteByPrimaryKey(location);
    }

    @Override
    public int insert(ColdLocation record) {
        return coldLocationService.insert(record);
    }

    @Override
    public int insertSelective(ColdLocation record) {
        return coldLocationService.insertSelective(record);
    }

    @Override
    public ColdLocation selectByPrimaryKey(String location) {
        return coldLocationService.selectByPrimaryKey(location);
    }

    @Override
    public int updateByPrimaryKeySelective(ColdLocation record) {
        return coldLocationService.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(ColdLocation record) {
        return coldLocationService.updateByPrimaryKey(record);
    }
}
