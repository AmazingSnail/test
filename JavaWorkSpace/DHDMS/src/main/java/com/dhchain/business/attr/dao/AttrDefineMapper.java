package com.dhchain.business.attr.dao;

import com.dhchain.business.attr.vo.AttrDefine;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-11-02.
 */
@Repository
public interface AttrDefineMapper {
    List<AttrDefine> select(AttrDefine attrDefine);
    AttrDefine selectById(@Param("id") int id);
    AttrDefine selectByNo(@Param("attrDefineno") String attrDefineno);
    AttrDefine selectByBaseid(@Param("databaseid")int databaseid);
    int insert(AttrDefine attrDefine);
    int update(AttrDefine attrDefine);
    int delete(String[] ids);
}
