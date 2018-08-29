package com.dhchain.business.colddigitalworkshop.service.impl;

import com.dhchain.business.colddigitalworkshop.dao.ColdDailyPrintMapper;
import com.dhchain.business.colddigitalworkshop.service.ColdDailyPrintService;
import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPrint;
import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPrintSum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ColdDailyPrintService")
public class ColdDailyPrintServiceImpl implements ColdDailyPrintService {
    @Autowired
    private ColdDailyPrintMapper coldDailyPrintMapper;
    @Override
    public int deleteByPrimaryKey(Integer id) {
        return coldDailyPrintMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(ColdDailyPrint record) {
        return coldDailyPrintMapper.insert(record);
    }

    @Override
    public int insertSelective(ColdDailyPrint record) {
        return coldDailyPrintMapper.insertSelective(record);
    }

    @Override
    public ColdDailyPrint selectByPrimaryKey(Integer id) {
        return coldDailyPrintMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ColdDailyPrint record) {
        return coldDailyPrintMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(ColdDailyPrint record) {
        return coldDailyPrintMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<ColdDailyPrint> selectColdDailyPrint(ColdDailyPrint record) {
        return coldDailyPrintMapper.selectColdDailyPrint(record);
    }

    @Override
    public List<ColdDailyPrint> selectPrintMan(ColdDailyPrint record) {
        return coldDailyPrintMapper.selectPrintMan(record);
    }

    @Override
    public List<ColdDailyPrintSum> selectDailyPrintSum(ColdDailyPrint record) {
        return coldDailyPrintMapper.selectDailyPrintSum(record);
    }
}
