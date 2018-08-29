package com.dhchain.system.service.impl;

import com.dhchain.system.dao.base.SalesSingleDao;
import com.dhchain.system.service.SalesSingleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhchain.system.entity.User;

import java.util.List;


@Service
public class SalesSingleServiceImpl extends BaseService<User> implements SalesSingleService {
     @Autowired
     private SalesSingleDao salesSingleDao;

    @Override
    public List<User> getlist(String year, String month, String nwx) {
        return salesSingleDao.getlist(year,month,nwx);
    }
    @Override
    public List<User> getlistDay( String year,String day,String nwx) {
        return salesSingleDao.getlistDay(year,day, nwx);
    }

    @Override
    public List<User> getlistYear(String year, String nwx) {
        return salesSingleDao.getlistYear(year,nwx);
    }
}
