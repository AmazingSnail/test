package com.dhchain.business.exp.dao;

import com.dhchain.business.exp.vo.Exp;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ExpMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Exp record);

    int insertSelective(Exp record);

    Exp selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Exp record);

    int updateByPrimaryKey(Exp record);

    Exp iscontain(@Param("codeno")String codeno);
}