package com.dhchain.business.colddigitalworkshop.service;

import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPrint;
import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPrintSum;

import java.util.List;

public interface ColdDailyPrintService {
    int deleteByPrimaryKey(Integer id);

    int insert(ColdDailyPrint record);

    int insertSelective(ColdDailyPrint record);

    ColdDailyPrint selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ColdDailyPrint record);

    int updateByPrimaryKey(ColdDailyPrint record);

    List<ColdDailyPrint> selectColdDailyPrint(ColdDailyPrint record);
    List<ColdDailyPrint> selectPrintMan(ColdDailyPrint record);
    List<ColdDailyPrintSum> selectDailyPrintSum(ColdDailyPrint record);
}
