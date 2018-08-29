package com.dhchain.business.colddigitalworkshop.service;

import com.dhchain.business.colddigitalworkshop.vo.ColdOut;
import com.dhchain.business.colddigitalworkshop.vo.HaginstRecord;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;

public interface ColdOutService {
    int deleteByPrimaryKey(Integer id);

    int insert(ColdOut record);

    int insertSelective(ColdOut record);

    ColdOut selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ColdOut record);

    int updateByPrimaryKey(ColdOut record);
    int insertSapOutMess(HaginstRecord haginstRecord);
    int insertSapMessOutBack(HaginstRecord haginstRecord);
    List<ColdOut> selectColdOutToday(ColdOut record);

    List<ColdOut> getSeId(ColdOut record);
    List<ColdOut> selectColdOutBydate(ColdOut record);


    HSSFWorkbook Out_exportExcelInfo(ColdOut record);
}
