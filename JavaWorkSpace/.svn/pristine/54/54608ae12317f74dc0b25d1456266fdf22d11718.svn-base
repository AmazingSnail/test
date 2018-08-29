package com.dhchain.business.partpunchingworkshop.service;

import com.dhchain.business.partpunchingworkshop.vo.ColdDailyPlan;
import com.dhchain.business.partpunchingworkshop.vo.PTFinish;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;

public interface ElementDetailService {
    int updatenum(PTFinish record);//更新数量
    List<PTFinish> selectbyall(PTFinish record);//查询PTfinish表
    List<PTFinish> selectbycoldid(PTFinish record);//查询PTfinish表通过coldid
    List<ColdDailyPlan> selectByReelnum(ColdDailyPlan record);//根据reelnum查询数据在ColdDailyPlan
    HSSFWorkbook exportExcel(String plant, String uyear, String umouth, String planID,
                             String fno, String reelnum, String equipID, String partDrawing, String productMan, String starttime,
                             String endtime, String state);//完成明细导出

}
