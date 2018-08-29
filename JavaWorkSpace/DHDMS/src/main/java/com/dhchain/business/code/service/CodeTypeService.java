package com.dhchain.business.code.service;

import com.dhchain.business.code.vo.CodeType;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-17.
 */
public interface CodeTypeService {
    boolean insert(CodeType codeType);
    List<CodeType> selectByCodeManageId(int codemanageid);
    CodeType selectById(int id);
    boolean update(CodeType codeType);
    int delete(String[] ids);
    List<CodeType> selectByTypeno(String typeno);
    CodeType selectSerialnumber(String typeno);
}
