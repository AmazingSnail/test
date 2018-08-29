package com.dhchain.system.dao.base;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import com.dhchain.common.BaseDao;
import com.dhchain.system.entity.User;
/**
 * Created by ANT on 2018/5/30.
 */
@Repository
public interface PlantSalesSendDao {

    @Select("select * from user where state = #{state}")
    public List<User> selectByState(Integer state);

    @Select("  EXEC  TPlantSalesSingle @year=#{year}  ,@monat=#{monat} ,@nwx=#{nwx}")
    public List<User> getlist1(@Param("year") String year, @Param("monat") String monat, @Param("nwx") String nwx);

    @Select(" EXEC TPlantSalesSingleDay @year=#{year}  ,@monat=#{monat} ,@day=#{day} ,@nwx=#{nwx}")
    public List<User> getlistDay1(@Param("year") String year, @Param("monat") String monat, @Param("day") String day, @Param("nwx") String nwx);

    @Select(" EXEC TPlantSalesSingleYear @year=#{year}  ,@nwx=#{nwx}")
    public List<User> getlistYear1(@Param("year") String year, @Param("nwx") String nwx);
}
