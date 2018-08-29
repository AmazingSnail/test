package com.dhchain.business.assembletrans.service;

import com.dhchain.business.assembletrans.vo.CZG;
import com.dhchain.business.assembletrans.vo.KCard;
import com.dhchain.business.equipmentlist.vo.PlanProBase;

import java.util.List;

/**
 * Created by tongc on 2017-7-22.
 */
public interface KCardService {

    List<KCard> queryAsList(KCard kCard);
    List<KCard> querySeId(KCard kCard);
    List<PlanProBase> getSB(PlanProBase planProBase);
    List<KCard> getIssure(KCard kCard);//查看记录是否存在。
    List<KCard> queryScan(KCard kCard);
    List<KCard> queryTakeScan(KCard kCard);
    List<KCard> queryCZRK(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno);
    List<KCard> queryCZRKQR(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno);
    List<KCard> queryCZRKRK(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno);
    List<KCard> querySumCZRK(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno);
    List<KCard> querySumCZRKQR(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno);
    List<KCard> querySumCZRKRK(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno);
    int insert(KCard kCard);
    int updatePackageIn(KCard kCard);
    int delete(KCard kCard);
    int update(KCard kCard);
    int update1(KCard kCard);
    int updateRK(KCard kCard);
    int updateRK1(KCard kCard);
    int updateCZRK(KCard kCard);
    int updateDY(KCard kCard);
    List<CZG> queryCZG(CZG czg);
    List<KCard> getKCardById(KCard kCard);
    List<KCard> selectidInPackIn(KCard kCard);
    List<KCard> selectLastMonthTake(KCard kCard);
}
