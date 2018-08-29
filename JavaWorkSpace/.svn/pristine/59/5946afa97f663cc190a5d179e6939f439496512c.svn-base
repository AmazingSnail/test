package com.dhchain.business.colddigitalworkshop.service;

import com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn;
import com.dhchain.business.colddigitalworkshop.vo.HaginstRecord;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;

public interface MaterialtakeinService {
    List<ColdMaterialIn> selectColdmaterlin(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectColdmaterlinSap(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectColdmaterlinNeed(ColdMaterialIn coldmaterialin);
    String getPlantIn(String plant);
    String getLGORTIn(String plant, String UserName);
    int insertColdmsg(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> getSeId(ColdMaterialIn coldmaterialin);
    int deletecoldmsg(ColdMaterialIn coldmaterialin);
    int updatecoldmsg(ColdMaterialIn coldmaterialin);
    int updatecoldmsgFXZ(ColdMaterialIn coldmaterialin);
    int updatecoldmsgBack(ColdMaterialIn coldmaterialin);
    int insertPoAgainstRecord(ColdMaterialIn coldmaterialin);
    int updateCutting(ColdMaterialIn coldmaterialin);
    int updateUsed(ColdMaterialIn coldmaterialin);
    int updateColdTakenFail(ColdMaterialIn coldmaterialin);
    int updateColdTakenBack(ColdMaterialIn coldmaterialin);
    int updateColdTakenInSap(ColdMaterialIn coldmaterialin);
    int insertColdSapMess(HaginstRecord haginstRecord);
    int insertColdSapMessBack(HaginstRecord haginstRecord);
    int updateUsedforDailyplanBack(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectcoldMsgById(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectColdmaterlinBydate(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectcoldmaoliaolocation(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectcoldCutByReelnum(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectcoldMsgByBatchno(ColdMaterialIn coldmaterialin);
    HSSFWorkbook In_exportExcelInfo(ColdMaterialIn record);
    Double selectColdmaterlinLeaveNumber(ColdMaterialIn coldmaterialin);
    Double selectColdmaterlinInNumber(ColdMaterialIn coldmaterialin);
}
