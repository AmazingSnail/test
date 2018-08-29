package com.dhchain.system.dao.mdm;


import com.dhchain.common.BaseDao;
import com.dhchain.system.entity.OutputValue;
import com.dhchain.system.entity.ZWQ;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TestDao extends BaseDao<ZWQ>{
	@Select(" select fno from z_wq")
	public List<ZWQ>getOutputValue(@Param("year") String year, @Param("monat") String monat, @Param("nwx") String nwx);

}
