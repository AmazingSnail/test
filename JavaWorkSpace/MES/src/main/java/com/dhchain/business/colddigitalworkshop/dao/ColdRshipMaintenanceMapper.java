package com.dhchain.business.colddigitalworkshop.dao;

import com.dhchain.business.colddigitalworkshop.vo.ColdRshipMaintenance;
import com.dhchain.business.colddigitalworkshop.vo.ColdRshipMaintenanceKey;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColdRshipMaintenanceMapper {
    int deleteByPrimaryKey(ColdRshipMaintenanceKey key);

    int insert(ColdRshipMaintenance record);

    int insertSelective(ColdRshipMaintenance record);

    ColdRshipMaintenance selectByPrimaryKey(ColdRshipMaintenanceKey key);

    int updateByPrimaryKeySelective(ColdRshipMaintenance record);

    int updateByPrimaryKey(ColdRshipMaintenance record);
    List<ColdRshipMaintenance> selectALL(ColdRshipMaintenance record);
    List<ColdRshipMaintenance> selectColdRshipMaintenanceByReelnum(ColdRshipMaintenance record);
}