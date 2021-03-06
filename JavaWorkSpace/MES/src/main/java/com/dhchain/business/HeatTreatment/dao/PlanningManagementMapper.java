package com.dhchain.business.HeatTreatment.dao;

import com.dhchain.business.HeatTreatment.vo.MPtheatplan;
import com.dhchain.business.HeatTreatment.vo.MaterialCoding;
import com.dhchain.business.base.dao.BaseDao;

import java.util.List;

/**
 * Created by ASUS on 2018/7/5.
 */
public interface PlanningManagementMapper extends BaseDao<MPtheatplan> {
    List<MaterialCoding> getFno(MaterialCoding record);//获取43数据库物料信息。
    List<MaterialCoding> getInfo(MaterialCoding record);//获取43数据库物料信息。
    List<MaterialCoding> getFno1(MaterialCoding record);//获取43数据库物料信息。
}
