package com.dhchain.business.assembletrans.service.impl;

import com.dhchain.business.assembletrans.dao.KCardMapper;
import com.dhchain.business.assembletrans.service.KCardService;
import com.dhchain.business.assembletrans.vo.CZG;
import com.dhchain.business.assembletrans.vo.KCard;
import com.dhchain.business.equipmentlist.vo.PlanProBase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by tongc on 2017-7-22.
 */
@Service("KCardService")
public class KCardServiceImpl implements KCardService {
    @Autowired
    private KCardMapper kCardMapper;

    @Override
    public List<KCard> queryAsList(KCard kCard) {
        List<KCard> list=  kCardMapper.getKCard(kCard);
        return list;
    }
    @Override
    public List<KCard> queryCZRK(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno) {
        List<KCard> list=  kCardMapper.getKCardCZRK(dhorderno,PartDrawing,fname,plant,startTime,endTime,issure,IsTake,inputman,ReportMan,fno,serialno);
        return list;
    }
    @Override
    public List<KCard> queryCZRKQR(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno) {
        List<KCard> list=  kCardMapper.getKCardCZRKQR(dhorderno,PartDrawing,fname,plant,startTime,endTime,issure,IsTake,inputman,ReportMan,fno,serialno);
        return list;
    }
    @Override
    public List<KCard> queryCZRKRK(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno) {
        List<KCard> list=  kCardMapper.getKCardCZRKRK(dhorderno,PartDrawing,fname,plant,startTime,endTime,issure,IsTake,inputman,ReportMan,fno,serialno);
        return list;
    }

    @Override
    public List<KCard> querySumCZRK(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno) {
        List<KCard> list=  kCardMapper.getKCardSumCZRK(dhorderno,PartDrawing,fname,plant,startTime,endTime,issure,IsTake,inputman,ReportMan,fno,serialno);
        return list;
    }

    @Override
    public List<KCard> querySumCZRKQR(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno) {
        List<KCard> list=  kCardMapper.getKCardSumCZRKQR(dhorderno,PartDrawing,fname,plant,startTime,endTime,issure,IsTake,inputman,ReportMan,fno,serialno);
        return list;
    }

    @Override
    public List<KCard> querySumCZRKRK(String dhorderno, String PartDrawing, String fname, String plant, String startTime, String endTime, String issure, String IsTake, String inputman, String ReportMan, String fno, String serialno) {
        List<KCard> list=  kCardMapper.getKCardSumCZRKRK(dhorderno,PartDrawing,fname,plant,startTime,endTime,issure,IsTake,inputman,ReportMan,fno,serialno);
        return list;
    }

    @Override
    public int insert(KCard kCard) {
        int n = kCardMapper.insertKCard(kCard);
        return n;
    }

    @Override
    public int updatePackageIn(KCard kCard) {
        return kCardMapper.updatePackageIn(kCard);
    }

    @Override
    public int delete(KCard kCard) {
        int n = kCardMapper.deleteKCard(kCard);
        return n;
    }

    @Override
    public int update(KCard kCard) {
        int n = kCardMapper.updateKCard(kCard);
        return n;
    }
    @Override
    public int update1(KCard kCard) {
        int n = kCardMapper.updateKCard1(kCard);
        return n;
    }
    @Override
    public int updateRK(KCard kCard) {
        int n = kCardMapper.updateRK(kCard);
        return n;
    }
    @Override
    public int updateRK1(KCard kCard) {
        int n = kCardMapper.updateRK1(kCard);
        return n;
    }
    @Override
    public int updateCZRK(KCard kCard) {
        int n = kCardMapper.updateCZRK(kCard);
        return n;
    }

    @Override
    public int updateDY(KCard kCard) {
        int n = kCardMapper.updateDY(kCard);
        return n;
    }

    @Override
    public List<CZG> queryCZG(CZG czg) {
        List<CZG> list=  kCardMapper.getCZG(czg);
        return list;
    }

    @Override
    public List<KCard> getKCardById(KCard kCard) {
        List<KCard> list = kCardMapper.getKCardById(kCard);
        return list;
    }

    @Override
    public List<KCard> selectidInPackIn(KCard kCard) {
        return kCardMapper.selectidInPackIn(kCard);
    }

    @Override
    public List<KCard> selectLastMonthTake(KCard kCard) {
        return kCardMapper.selectLastMonthTake(kCard);
    }

    @Override
    public List<KCard> querySeId(KCard kCard) {
        List<KCard> list=  kCardMapper.getSeId(kCard);
        return list;
    }

    @Override
    public List<PlanProBase> getSB(PlanProBase planProBase) {
        List<PlanProBase> list=  kCardMapper.getSB(planProBase);
        return list;
    }

    @Override
    public List<KCard> getIssure(KCard kCard) {
        return kCardMapper.getIssure(kCard);
    }

    @Override
    public List<KCard> queryScan(KCard kCard) {
        return kCardMapper.queryScan(kCard);
    }
    @Override
    public List<KCard> queryTakeScan(KCard kCard) {
        return kCardMapper.queryTakeScan(kCard);
    }

}
