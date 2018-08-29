package com.dhchain.system.dao.base;


import com.dhchain.common.BaseDao;
import com.dhchain.system.entity.OutputValue;
import com.dhchain.system.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OutputValueDao extends BaseDao<OutputValue>{
	@Select("  EXEC  PlantczGridView @year=#{year}  ,@monat=#{monat} ,@nwx=#{nwx}")
	public List<OutputValue>getOutputValue(@Param("year") String year, @Param("monat") String monat, @Param("nwx") String nwx);
	@Select("  EXEC  PlantczDay @year=#{year}  ,@monat=#{monat} ,@nwx=#{nwx}")
	public List<OutputValue>getOutputValueDay(@Param("year") String year, @Param("monat") String monat, @Param("nwx") String nwx);
}
