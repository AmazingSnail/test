package com.dhchain.business.code.service.impl;

import com.dhchain.business.code.dao.CodeManageMapper;
import com.dhchain.business.code.service.CodeManageService;
import com.dhchain.business.code.vo.CodeManageType;
import com.dhchain.business.type.vo.TypeDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-06.
 */
@Service("CodeManageService")
public class CodeManageServiceImpl implements CodeManageService {
    @Autowired
    private CodeManageMapper codeManageMapper;
    @Override
    public List<CodeManageType> selectByTypeid(String typeid) {
        return codeManageMapper.selectByTypeid(typeid);
    }
    @Override
    public int codeManageAdd(CodeManageType CodeManageType) {
        int n = codeManageMapper.codeManageAdd(CodeManageType);
        return n;
    }
    @Override
    public int codeManageDelete(String[] ids)
    {
        int n = codeManageMapper.codeManageDelete(ids);
        return n;
    }

    @Override
    public CodeManageType selectById(int id) {
        return codeManageMapper.selectById(id);
    }

    @Override
    public List<TypeDetail> getTypeDetail(String typeno) {
        return codeManageMapper.getTypeDetail(typeno);
    }
    @Override
    public int codeManageEdit(CodeManageType CodeManageType) {
        return codeManageMapper.codeManageEdit(CodeManageType);
    }

    @Override
    public CodeManageType selectByTypeno(String typeno) {
        return codeManageMapper.selectByTypeno(typeno);
    }
}
