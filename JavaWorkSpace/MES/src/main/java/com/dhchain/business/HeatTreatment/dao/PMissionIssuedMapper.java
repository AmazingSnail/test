package com.dhchain.business.HeatTreatment.dao;

import com.dhchain.business.HeatTreatment.vo.MPtheatplan;
import com.dhchain.business.HeatTreatment.vo.MPtheatprint;
import com.dhchain.business.HeatTreatment.vo.MPtheattake;
import com.dhchain.business.base.dao.BaseDao;

import java.util.List;

/**
 * Created by ASUS on 2018/7/5.
 */
public interface PMissionIssuedMapper extends BaseDao<MPtheattake> {
    List<MPtheattake> getPlanid(MPtheattake record);
    List<MPtheatprint> getPrint(MPtheatprint record);//获取打印记录 更过planid
    List<MPtheattake> GetEquip(MPtheattake rrecord);//获取设备编号
}
