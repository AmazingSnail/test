package com.dhchain.system.dao.base;


import java.util.List;

import org.apache.ibatis.annotations.Select;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import com.dhchain.common.BaseDao;
import com.dhchain.system.entity.User;
@Repository
public interface SalesSingleDao extends BaseDao<User>{

	@Select("select * from user where state = #{state}")
	public List<User> selectByState(Integer state);

	@Select("  EXEC  SalesSingle @year=#{year}  ,@monat=#{monat} ,@nwx=#{nwx}")
	public List<User>getlist( @Param("year") String year,@Param("monat") String monat ,@Param("nwx") String nwx);

	@Select("  EXEC  SalesSingleDay @year=#{year}  , @day=#{day},@nwx=#{nwx}")
	public List<User>getlistDay(@Param("year") String year,@Param("day") String day, @Param("nwx") String nwx);
	@Select("  EXEC  SalesSingleYear @year=#{year}  ,@nwx=#{nwx}")
	public List<User>getlistYear(@Param("year") String year, @Param("nwx") String nwx);


}
