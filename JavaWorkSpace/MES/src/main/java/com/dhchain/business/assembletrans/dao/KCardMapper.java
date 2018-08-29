package com.dhchain.business.assembletrans.dao;

import com.dhchain.business.assembletrans.vo.CZG;
import com.dhchain.business.assembletrans.vo.KCard;
import com.dhchain.business.equipmentlist.vo.PlanProBase;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by tongc on 2017-7-22.
 */
@Repository
public interface KCardMapper {
    List<KCard> getKCard(KCard kCard);
    List<KCard> getSeId(KCard kCard);
    List<KCard> getKCardCZRK(@Param("dhorderno") String dhorderno,
                             @Param("PartDrawing") String PartDrawing,
                             @Param("fname") String fname,
                             @Param("plant") String plant,
                             @Param("startTime") String startTime,
                             @Param("endTime") String endTime,
                             @Param("issure") String issure,
                             @Param("IsTake") String IsTake,
                             @Param("inputman") String inputman,
                             @Param("ReportMan") String ReportMan,
                             @Param("fno") String fno,
                             @Param("serialno") String serialno
    );
    List<KCard> getKCardCZRKQR(@Param("dhorderno") String dhorderno,
                               @Param("PartDrawing") String PartDrawing,
                               @Param("fname") String fname,
                               @Param("plant") String plant,
                               @Param("startTime") String startTime,
                               @Param("endTime") String endTime,
                               @Param("issure") String issure,
                               @Param("IsTake") String IsTake,
                               @Param("inputman") String inputman,
                               @Param("ReportMan") String ReportMan,
                               @Param("fno") String fno,
                               @Param("serialno") String serialno
    );
    List<KCard> getKCardCZRKRK(@Param("dhorderno") String dhorderno,
                               @Param("PartDrawing") String PartDrawing,
                               @Param("fname") String fname,
                               @Param("plant") String plant,
                               @Param("startTime") String startTime,
                               @Param("endTime") String endTime,
                               @Param("issure") String issure,
                               @Param("IsTake") String IsTake,
                               @Param("inputman") String inputman,
                               @Param("ReportMan") String ReportMan,
                               @Param("fno") String fno,
                               @Param("serialno") String serialno
    );
    List<KCard> getKCardSumCZRK(@Param("dhorderno") String dhorderno,
                                @Param("PartDrawing") String PartDrawing,
                                @Param("fname") String fname,
                                @Param("plant") String plant,
                                @Param("startTime") String startTime,
                                @Param("endTime") String endTime,
                                @Param("issure") String issure,
                                @Param("IsTake") String IsTake,
                                @Param("inputman") String inputman,
                                @Param("ReportMan") String ReportMan,
                                @Param("fno") String fno,
                                @Param("serialno") String serialno
    );
    List<KCard> getKCardSumCZRKQR(@Param("dhorderno") String dhorderno,
                                  @Param("PartDrawing") String PartDrawing,
                                  @Param("fname") String fname,
                                  @Param("plant") String plant,
                                  @Param("startTime") String startTime,
                                  @Param("endTime") String endTime,
                                  @Param("issure") String issure,
                                  @Param("IsTake") String IsTake,
                                  @Param("inputman") String inputman,
                                  @Param("ReportMan") String ReportMan,
                                  @Param("fno") String fno,
                                  @Param("serialno") String serialno
    );
    List<KCard> getKCardSumCZRKRK(@Param("dhorderno") String dhorderno,
                                  @Param("PartDrawing") String PartDrawing,
                                  @Param("fname") String fname,
                                  @Param("plant") String plant,
                                  @Param("startTime") String startTime,
                                  @Param("endTime") String endTime,
                                  @Param("issure") String issure,
                                  @Param("IsTake") String IsTake,
                                  @Param("inputman") String inputman,
                                  @Param("ReportMan") String ReportMan,
                                  @Param("fno") String fno,
                                  @Param("serialno") String serialno
    );
    int insertKCard(KCard kCard);
    int deleteKCard(KCard kCard);
    int updateKCard(KCard kCard);
    int updateKCard1(KCard kCard);
    int updateRK(KCard kCard);
    int updateRK1(KCard kCard);//扫描确认
    int updateCZRK(KCard kCard);
    int updateDY(KCard kCard);
    int updatePackageIn(KCard kCard);
    List<CZG> getCZG(CZG czg);
    List<KCard> getKCardById(KCard kCard);
    List<KCard> selectidInPackIn(KCard kCard);
    List<KCard> selectLastMonthTake(KCard kCard);
    List<PlanProBase> getSB(PlanProBase planProBase);
    List<KCard> getIssure(KCard kCard);//查看记录是否存在。
    List<KCard> queryScan(KCard kCard);
    List<KCard> queryTakeScan(KCard kCard);
}
