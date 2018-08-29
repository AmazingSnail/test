package com.dhchain.business.code.dao;

import com.dhchain.business.code.vo.CodeName;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-17.
 */
@Repository
public interface CodeNameMapper {
    int insert(CodeName codeName);
    List<CodeName> selectByCodeManageId(@Param("codemanageid") int codemanageid);
    List<CodeName> selectByTypeno(@Param("typeno") String typeno);
    int delete(String[] ids);
    CodeName selectById(@Param("id")int id);
    CodeName selectFLCX(@Param("typeno") String typeno);
    int update(CodeName codeName);
}
