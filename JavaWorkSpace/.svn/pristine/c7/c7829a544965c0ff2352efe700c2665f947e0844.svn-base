package com.dhchain.business.colddigitalworkshop.dao;

import com.dhchain.business.colddigitalworkshop.vo.Smaintenance;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SplitMaintenanceMapper {
    int deleteByPrimaryKey(Integer id);
    int deleteByFparentIdAndId(Integer id);

    int insert(Smaintenance record);

    int insertSelective(Smaintenance record);

    Smaintenance selectByPrimaryKey(Integer id);

    List<Smaintenance> selectByAll(Smaintenance record);

    List<Smaintenance> selectsplitByfparentid(Smaintenance record);
    List<Smaintenance> selectSplitMaoLiaoFno();
    List<Smaintenance> selectParentIsHave(Smaintenance record);
    List<Smaintenance> selectChildIsHave(Smaintenance record);

    int updateByPrimaryKeySelective(Smaintenance record);

    int updateByPrimaryKey(Smaintenance record);
}