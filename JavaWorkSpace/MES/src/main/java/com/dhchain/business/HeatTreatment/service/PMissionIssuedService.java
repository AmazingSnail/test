package com.dhchain.business.HeatTreatment.service;

import com.dhchain.business.HeatTreatment.vo.MPtheatprint;
import com.dhchain.business.HeatTreatment.vo.MPtheattake;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;

/**
 * Created by ASUS on 2018/7/5.
 */
public interface PMissionIssuedService extends IService<MPtheattake> {
    List<MPtheattake> getPlanid(MPtheattake record);//获取最大的planid
    List<MPtheatprint> getPrint(MPtheatprint record);//获取打印记录 更过planid
    HSSFWorkbook exportExce(String umouth,String uyear,String plant,String Status,String EquipID,String fno,String fname);//进度管理导出
    List<MPtheattake> GetEquip(MPtheattake rrecord);//获取设备编号
}
