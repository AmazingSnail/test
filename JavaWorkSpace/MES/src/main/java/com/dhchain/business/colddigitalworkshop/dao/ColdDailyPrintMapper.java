package com.dhchain.business.colddigitalworkshop.dao;

import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPrint;
import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPrintSum;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColdDailyPrintMapper {
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