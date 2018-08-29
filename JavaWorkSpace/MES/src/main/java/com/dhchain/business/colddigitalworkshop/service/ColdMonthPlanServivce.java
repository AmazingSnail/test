package com.dhchain.business.colddigitalworkshop.service;

import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPrint;
import com.dhchain.business.colddigitalworkshop.vo.ColdMonthPlan;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;

public interface ColdMonthPlanServivce {
    int deleteByPrimaryKey(Integer id);
    int deleteByFparentIdAndId(Integer id);
    int insert(ColdMonthPlan record);

    int insertSelective(ColdMonthPlan record);
    ColdMonthPlan selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ColdMonthPlan record);
    String importExcelInfo(InputStream in, MultipartFile file, String User, String mpupinst, Integer month, Integer uyear)throws Exception;
    int updateByPrimaryKey(ColdMonthPlan record);
    HSSFWorkbook exportExcelInfo(ColdMonthPlan record);
    List<ColdMonthPlan> selectByAllKey(ColdMonthPlan record);
    List<ColdMonthPlan> selectOnlyParent(ColdMonthPlan record);
    List<ColdMonthPlan> selectOnlyChilds(ColdMonthPlan record);
    List<ColdMonthPlan> selectmonthplanByDaoRu(ColdMonthPlan record);
    int updateByFidChangeNum(ColdDailyPrint record);
    int updateMonthPlanTakenumGo(ColdMonthPlan record);
    int updateMonthPlanTakenumBack(ColdMonthPlan record);
}
