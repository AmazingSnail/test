package com.dhchain.business.colddigitalworkshop.service;

import com.dhchain.business.colddigitalworkshop.vo.ColdLocation;

public interface ColdLocationService {
    int deleteByPrimaryKey(String location);

    int insert(ColdLocation record);

    int insertSelective(ColdLocation record);

    ColdLocation selectByPrimaryKey(String location);

    int updateByPrimaryKeySelective(ColdLocation record);

    int updateByPrimaryKey(ColdLocation record);
}
