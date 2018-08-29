package com.dhchain.business.colddigitalworkshop.dao;

import com.dhchain.business.colddigitalworkshop.vo.Base;
import com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn;
import com.dhchain.business.colddigitalworkshop.vo.HaginstRecord;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MaterialtakeinMapper {
    List<ColdMaterialIn> selectColdmaterlin(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectColdmaterlinNeed(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectColdmaterlinSap(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectcoldMsgById(ColdMaterialIn coldmaterialin);
    List<Base> getPlantIn(@Param("plant") String plant);
    List<Base> getLGORTIn(@Param("plant") String plant,
                          @Param("UserName") String UserName);
    int insertColdmsg(ColdMaterialIn coldmaterialin);
    int deletecoldmsg(ColdMaterialIn coldmaterialin);
    int updatecoldmsg(ColdMaterialIn coldmaterialin);
    int updatecoldmsgFXZ(ColdMaterialIn coldmaterialin);
    int updatecoldmsgBack(ColdMaterialIn coldmaterialin);
    int insertPoAgainstRecord(ColdMaterialIn coldmaterialin);
    int updateCutting(ColdMaterialIn coldmaterialin);
    int updateUsed(ColdMaterialIn coldmaterialin);
    int updateColdTakenFail(ColdMaterialIn coldmaterialin);
    int updateColdTakenInSap(ColdMaterialIn coldmaterialin);
    int updateColdTakenBack(ColdMaterialIn coldmaterialin);
    int updateUsedforDailyplanBack(ColdMaterialIn coldmaterialin);
    int insertColdSapMess(HaginstRecord haginstRecord);
    int insertColdSapMessBack(HaginstRecord haginstRecord);
    List<ColdMaterialIn> getSeId(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectColdmaterlinBydate(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectcoldmaoliaolocation(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectcoldCutByReelnum(ColdMaterialIn coldmaterialin);
    List<ColdMaterialIn> selectcoldMsgByBatchno(ColdMaterialIn coldmaterialin);
    Double selectColdmaterlinLeaveNumber(ColdMaterialIn coldmaterialin);
    Double selectColdmaterlinInNumber(ColdMaterialIn coldmaterialin);
}
