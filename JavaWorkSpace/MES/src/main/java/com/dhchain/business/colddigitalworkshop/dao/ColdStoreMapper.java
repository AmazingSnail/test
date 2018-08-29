package com.dhchain.business.colddigitalworkshop.dao;

import com.dhchain.business.colddigitalworkshop.vo.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColdStoreMapper {
    int deleteByPrimaryKey(ColdStoreKey key);

    int insert(ColdStore record);

    int insertSelective(ColdStore record);

    ColdStore selectByPrimaryKey(ColdStoreKey key);

    int updateByPrimaryKeySelective(ColdStore record);

    int updateByPrimaryKey(ColdStore record);

    int updateColdStoreIn(ColdMaterialIn record);

    int updateColdStoreOut(ColdOut record);
    int updateColdStoreOutBack(ColdOut record);

    int updateColdStoreBack(ColdMaterialIn record);

    List<ColdStore> selectColdStoreList(ColdStore record);

    List<ColdStore> selectColdStore(ColdStoreKey record);

    List<ColdLocationStore> selectColdStoreLocation(ColdLocationStore record);
    List<ColdLocationStore> selectColdStoreLocationExport(ColdStore record);
}