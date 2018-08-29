package com.dhchain.business.HeatTreatment.service;

import com.dhchain.business.HeatTreatment.vo.MCraftfault;
import com.dhchain.business.HeatTreatment.vo.MPtheatfinish;

import java.util.List;

/**
 * Created by ASUS on 2018/7/5.
 */
public interface ProductionDetailService extends IService<MPtheatfinish> {
    List<MPtheatfinish> getEquid (MPtheatfinish record);//获取设备信息
    List<MCraftfault> getType (MCraftfault record);//获取故障类型
}
