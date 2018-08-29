package com.dhchain.business.colddigitalworkshop.dao;

import com.dhchain.business.colddigitalworkshop.vo.ColdPlantLgort;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColdPlantLgortMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ColdPlantLgort record);

    int insertSelective(ColdPlantLgort record);

    ColdPlantLgort selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ColdPlantLgort record);

    int updateByPrimaryKey(ColdPlantLgort record);

    List<ColdPlantLgort> selectPlantLgortAll();
}