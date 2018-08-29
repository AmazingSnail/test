package com.dhchain.business.partpunchingworkshop.service;

import com.dhchain.business.partpunchingworkshop.vo.*;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;

public interface MouldManageService {
    List<MoldStore>  selectByDepartment();//查询部门
    List<BaseUser> getDepartment(BaseUser record);//获取默认部门
    List<BaseStatus>  selectByNwx();//查询生产状态
    List<MoldStore> selectAll(MoldStore record);//查询模具库存数据
    List<MoldReplace> selecttime(MoldReplace record);//查询使用时间
    List<MoldStore> selectbymouldid(MoldStore record);//查询模具库存数据通过mouldid
    List<MoldStore> querypartDrawing(String partDrawing);//查询图号是否存在
    List<MoldStore> querypartDrawing1(String partDrawing);//查询图号是否存在
    List<BaseCapacity> queryfno(String fno);//查询物料编码是否存在
    List<MoldStore> queryMouldID1(String MouldID1);//查询图号是否存在
    int updateStatus(MoldStore record);//更新使用状态。
    int out(MoldStore record);//模具发出
    int outMoldOutput(MoldOutput record);//模具发出记录表
    int delete(MoldStore record);//模具报废
    int insertMoldStore(MoldStore record);//插入数据到模具库存表中
    int insertMoldInput(MoldInput record);//插入数据到模具入库记录表中
    int updateMould(MoldStore record);//更新插入的信息
    HSSFWorkbook exportExce(String umouth, String department, String MouldID, String Tonnage,
                            String MouldName, String Location, String nwx
    );//模具库存导出
}
