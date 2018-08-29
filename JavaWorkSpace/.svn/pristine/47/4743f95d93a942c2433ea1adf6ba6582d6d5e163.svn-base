package com.dhchain.business.colddigitalworkshop.service;

import com.dhchain.business.colddigitalworkshop.vo.Smaintenance;

import java.util.List;

public interface SplitMaintenanceService {
    int deleteByPrimaryKey(Integer id);
    int deleteByFparentIdAndId(Integer id);
    int insert(Smaintenance record);

    int insertSelective(Smaintenance record);
    List<Smaintenance> selectByAll(Smaintenance record);
    Smaintenance selectByPrimaryKey(Integer id);
    List<Smaintenance> selectsplitByfparentid(Smaintenance record);
    List<Smaintenance> selectParentIsHave(Smaintenance record);
    List<Smaintenance> selectChildIsHave(Smaintenance record);
    int updateByPrimaryKeySelective(Smaintenance record);
    List<Smaintenance> selectSplitMaoLiaoFno();
    int updateByPrimaryKey(Smaintenance record);
}
