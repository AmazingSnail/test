package com.dhchain.business.rout.dao;

import com.dhchain.business.rout.vo.Rout;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by zhenglb on 2017-10-30.
 */
@Repository
public interface RoutMapper {
    int insert(Rout rout);
    Rout iscontain(@Param("codeno")String codeno);
}
