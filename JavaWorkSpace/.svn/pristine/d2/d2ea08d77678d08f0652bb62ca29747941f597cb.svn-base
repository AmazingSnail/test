package com.dhchain.business.attr.dao;

import com.dhchain.business.attr.vo.Factory;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-11-22.
 */
@Repository
public interface FactoryMapper {
    List<Factory> select(Factory factory);
    List<Factory> selectByFlag(@Param("flag") String flag);
    Factory selectById(@Param("id") int id);
    Factory selectByNo(@Param("attrno") String  attrno);
    Factory selectByNoAndFid(@Param("attrno") String  attrno,@Param("fid")int fid);
    Factory selectByNameAndFid(@Param("attrname") String  attrname,@Param("fid")int fid);
    int selectNewId();
    int insert(Factory factory);
    int  update(Factory factory);
    List<Factory> selectChildById(@Param("fid")int id);
    int  deleteById(int id);
}
