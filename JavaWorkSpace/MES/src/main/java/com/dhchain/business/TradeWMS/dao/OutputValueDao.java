package com.dhchain.business.TradeWMS.dao;

import com.dhchain.business.TradeWMS.vo.TOutputvalue;
import com.dhchain.business.base.dao.BaseDao;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface OutputValueDao extends BaseDao<TOutputvalue> {
    @Select("  EXEC  PlantczGridView @year=#{year}  ,@monat=#{monat} ,@nwx=#{nwx}")
    public List<TOutputvalue> getOutputValue(@Param("year") String year, @Param("monat") String monat, @Param("nwx") String nwx);
    @Select("  EXEC  PlantczDay @year=#{year}  ,@monat=#{monat} ,@nwx=#{nwx}")
    public List<TOutputvalue>getOutputValueDay(@Param("year") String year, @Param("monat") String monat, @Param("nwx") String nwx);
}