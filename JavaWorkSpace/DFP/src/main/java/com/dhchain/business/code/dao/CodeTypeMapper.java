package com.dhchain.business.code.dao;

import com.dhchain.business.code.vo.CodeType;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-17.
 */
@Repository
public interface CodeTypeMapper {
    int insert(CodeType codeType);
    List<CodeType> selectByCodeManageId(@Param("codemanageid") int codemanageid);
    CodeType selectById(@Param("id")int id);
    int update(CodeType codeType);
    int delete(String[] ids);
    List<CodeType> selectByTypeno(@Param("typeno") String typeno);
    CodeType selectSerialnumber(@Param("typeno") String typeno);
}
