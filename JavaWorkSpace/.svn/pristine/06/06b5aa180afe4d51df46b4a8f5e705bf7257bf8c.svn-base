package com.dhchain.business.base.dao;

import com.dhchain.business.base.vo.Base;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-06.
 */
@Repository
public interface BaseMapper {
    Base selectSXGL(@Param("basename") String basename);
    List<Base> select(Base base);
    List<Base> selectAll();
    int insert(Base base);
    int  deleteById(int id);
    Base selectById(int id);
    List<Base> selectByNoAndFid(@Param("baseno")String baseno,@Param("fid") int fid);
    Base selectByNameAndFid(@Param("basename")String basename,@Param("fid") int fid);
    int  update(Base base);
    int selectNewId();
    List<Base> selectByFlag(@Param("flag") String flag);
    List<Base> selectChildById(@Param("fid") int id);
    List<Base> selectDatabse(Base base);
    String selectRebasesById(@Param("id") int id);
}
