package com.dhchain.business.code.service;


import com.dhchain.business.code.vo.CodeManageType;
import com.dhchain.business.type.vo.TypeDetail;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-06.
 */
public interface CodeManageService {
    List<CodeManageType> selectByTypeid(String typeid);
    int codeManageAdd(CodeManageType CodeManageType);
    int codeManageDelete(String[] ids);
    CodeManageType selectById(int id);
    List<TypeDetail> getTypeDetail(String typeno);
    int codeManageEdit(CodeManageType CodeManageType);
    CodeManageType selectByTypeno(String typeno);
}
