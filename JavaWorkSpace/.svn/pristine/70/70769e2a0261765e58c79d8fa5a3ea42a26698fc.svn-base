package com.dhchain.business.code.dao;

import com.dhchain.business.code.vo.CodeManageType;
import com.dhchain.business.type.vo.TypeDetail;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-06.
 */
@Repository
public interface CodeManageMapper {
    List<CodeManageType> selectByTypeid(@Param("typeid") String typeid);
    int codeManageAdd(CodeManageType CodeManageType);
    int codeManageDelete(String[] ids);
    CodeManageType selectById(@Param("id")int id);
    List<TypeDetail> getTypeDetail(@Param("typeno") String typeno);
    int codeManageEdit(CodeManageType CodeManageType);
    CodeManageType selectByTypeno(@Param("typeno") String typeno);
}
