package com.dhchain.business.partpunchingworkshop.service;

import com.dhchain.business.partpunchingworkshop.vo.*;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;

public interface MonthPlanService {
    List<BaseStatus> FindFname();//获取Fname
    List<Syb> queryplant();
    List<BaseUser> getUsername();
    List<PTMaterial> getUsername1();
    List<PTPlan> selectByAllKey(PTPlan record);//查询月度计划
    List<PTPlan> getAll(PTPlan record);//查询月度计划
    List<PTOrderPlan> selectByfno(PTOrderPlan record);//查询合同计划根据月度计划--物料编号
    int updateALLfinish(PTOrderPlan record);//更新这个物料的isfinish
    List<PTOrderPlan> selectByid(PTOrderPlan record);//查询合同计划根据月度计划--id
    int updateFinsh(PTOrderPlan record);//更新完成情况字段
    int deleteid(PTOrderPlan record);//删除数据
    List<BaseCapacity> getFtemp2(BaseCapacity record);//查询图号
    List<BaseCapacity> getCapacity(BaseCapacity record);//查询产能
    List<CraftFile> getCraftFile(CraftFile record);//查询文档
    List<BaseChkStd> getBaseChkStd(BaseChkStd record);//查询检验标准是否存在
    List<PTOrderPlan> selectByFno1(PTOrderPlan record);//查询相同物料编码的合同计划
    int deleteid1(PTPlan record);//删除数据
    int updatePlan(PTPlan record);//更新数据
    List<PTOrderPlan> selectptOrderPlan(PTOrderPlan record);//查询合同计划
    String importExcelInfo(InputStream in, MultipartFile file, String User, Integer month, Integer uyear, String plant, String time)throws Exception;//导入
    String importExcelInfo1(InputStream in, MultipartFile file, String User, Integer month, Integer uyear, String plant, String time)throws Exception;//导入
    HSSFWorkbook exportExcel(String plant, String uyear, String umonth, String fname,
                             String WorkCentre, String OrderLine, String fno, String state);//合同计划导出
    HSSFWorkbook exportExce2(String plant, String uyear, String umouth, String fname,
                             String WorkProcedure, String Fno, String PartDrawing, String PartName, String state);//月度计划导出
}
