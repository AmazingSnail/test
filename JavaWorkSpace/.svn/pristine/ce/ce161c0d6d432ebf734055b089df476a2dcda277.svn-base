package com.dhchain.business.colddigitalworkshop.service;

import com.dhchain.business.colddigitalworkshop.vo.*;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;

public interface ColdStoreService {
    int deleteByPrimaryKey(ColdStoreKey key);

    int insert(ColdStore record);

    int insertSelective(ColdStore record);

    ColdStore selectByPrimaryKey(ColdStoreKey key);

    int updateByPrimaryKeySelective(ColdStore record);

    int updateByPrimaryKey(ColdStore record);

    int updateColdStoreIn(ColdMaterialIn record);

    int updateColdStoreOut(ColdOut record);
    int updateColdStoreOutBack(ColdOut record);
    int updateColdStoreBack(ColdMaterialIn record);

    List<ColdStore> selectColdStore(ColdStoreKey record);

    List<ColdStore> selectColdStoreList(ColdStore record);

    List<ColdLocationStore> selectColdStoreLocationExport(ColdStore record);
    List<ColdLocationStore> selectColdStoreLocation(ColdLocationStore record);
    HSSFWorkbook Y_exportExcelInfo(ColdLocationStore coldLocationStore);
    HSSFWorkbook C_exportExcelInfo(ColdLocationStore coldLocationStore);
}
