package com.dhchain.system.service.impl;

import com.dhchain.system.dao.base.PlantSalesSendDao;
import com.dhchain.system.service.PlantSalesSendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhchain.system.entity.User;

import java.util.List;


@Service
public class PlantSalesSendServiceImpl extends BaseService<User> implements PlantSalesSendService {
    @Autowired
    private PlantSalesSendDao plantSalesSendDao;

    @Override
    public List<User> getlist1(String year, String month, String nwx) {
        return plantSalesSendDao.getlist1(year, month, nwx);
    }

    @Override
    public List<User> getlistDay1(String year,String month, String day, String nwx){
        return plantSalesSendDao.getlistDay1(year, month, day,nwx);
    }

    @Override
    public List<User> getlistYear1(String year,String nwx){
        return plantSalesSendDao.getlistYear1(year, nwx);
    }
}
