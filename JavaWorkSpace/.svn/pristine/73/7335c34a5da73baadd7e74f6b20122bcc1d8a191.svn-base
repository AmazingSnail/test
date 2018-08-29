package com.dhchain.business.TradeWMS.service.impl;

import com.dhchain.business.TradeWMS.dao.OutputValueDao;
import com.dhchain.business.TradeWMS.service.OutputValueService;
import com.dhchain.business.TradeWMS.vo.TOutputvalue;
import com.dhchain.business.base.service.impl.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("outputValueService")
public class OutputValueServiceImpl extends BaseService<TOutputvalue> implements OutputValueService {
     @Autowired
     private OutputValueDao outputValueDao;

    @Override
    public List<TOutputvalue> getOutputValue(String year, String month, String nwx) {
        return outputValueDao.getOutputValue(year,month,nwx);
    }
    @Override
    public List<TOutputvalue> getOutputValueDay(String year, String month, String nwx) {
        return outputValueDao.getOutputValueDay(year,month,nwx);
    }
}
