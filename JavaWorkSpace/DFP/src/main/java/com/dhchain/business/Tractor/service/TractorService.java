package com.dhchain.business.Tractor.service;

import com.dhchain.business.Tractor.vo.TCerttractor;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public interface TractorService  extends  IService<TCerttractor>{
    HSSFWorkbook exportExcel(String ProductID, String serialID, String OrderID, String WERKS,
                             String starttime, String endtime );//拖拉机合格证数据导出
}
