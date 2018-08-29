package com.dhchain.system.service.impl;

import com.dhchain.system.dao.base.OutputValueDao;
import com.dhchain.system.entity.OutputValue;
import com.dhchain.system.service.OutputValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class OutputValueServiceImpl extends BaseService<OutputValue> implements OutputValueService {
     @Autowired
     private OutputValueDao outputValueDao;

    @Override
    public List<OutputValue> getOutputValue(String year, String month, String nwx) {
        return outputValueDao.getOutputValue(year,month,nwx);
    }
    @Override
    public List<OutputValue> getOutputValueDay(String year, String month, String nwx) {
        return outputValueDao.getOutputValueDay(year,month,nwx);
    }
}
