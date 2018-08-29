package com.dhchain.business.HeatTreatment.service;

import com.dhchain.business.HeatTreatment.vo.MCraftmould;
import com.dhchain.business.HeatTreatment.vo.ProductionProcess;

import java.util.List;

/**
 * Created by ASUS on 2018/7/6.
 */
public interface ProductionProcessService extends IService<MCraftmould>{
    List<ProductionProcess> getData(ProductionProcess reocrd);//获取生产工艺记录
    List<MCraftmould> getTempletname (MCraftmould record);//获取模板名称.
    List<MCraftmould> getTempletnum (MCraftmould record);//获取模板编号
    List<MCraftmould> getMaxMBid ( MCraftmould reocrd);//获取最大的模板id
}
