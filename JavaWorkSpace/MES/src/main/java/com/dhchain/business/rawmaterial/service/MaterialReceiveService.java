package com.dhchain.business.rawmaterial.service;

import com.dhchain.business.rawmaterial.vo.BaseSupplier;
import com.dhchain.business.rawmaterial.vo.MMaterialreceive;
import com.dhchain.business.rawmaterial.vo.Materialreceive;
import com.dhchain.business.rawmaterial.vo.Materialsend;

import java.util.List;

/**
 * 材料接受后台service接口
 *
 * @author ct
 * @date 2018-08-06
 */
public interface MaterialReceiveService extends IService<MMaterialreceive> {
    List<MMaterialreceive> getSerialno (MMaterialreceive record);//获取最大编号
    List<MMaterialreceive> getDay (MMaterialreceive record);//当天数据
    List<Materialreceive> getReceviceInAll (Materialreceive record);// 获取接收汇总数据
    List<Materialsend> getReceviceOutAll (Materialsend record);// 获取发出汇总数据
    List<BaseSupplier> getSupplier (BaseSupplier record);//获取供应商
    String getPlantIn(String plant);
    String getLGORTIn(String plant, String UserName);
}
