package com.dhchain.business.code.service.impl;

import com.dhchain.business.code.dao.CodeTypeMapper;
import com.dhchain.business.code.service.CodeTypeService;
import com.dhchain.business.code.vo.CodeType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-17.
 */
@Service("CodeTypeService")
public class CodeTypeServiceImpl implements CodeTypeService {
    @Autowired
    private CodeTypeMapper codeTypeMapper;
    @Override
    public boolean insert(CodeType codeType) {
        try {
            int c=codeTypeMapper.insert(codeType);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<CodeType> selectByCodeManageId(int codemanageid) {
        return codeTypeMapper.selectByCodeManageId(codemanageid);
    }

    @Override
    public CodeType selectById(int id) {
        return codeTypeMapper.selectById(id);
    }

    @Override
    public boolean update(CodeType codeType) {
        try {
            int c=codeTypeMapper.update(codeType);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int delete(String[] ids) {
        int n = codeTypeMapper.delete(ids);
        return n;
    }

    @Override
    public List<CodeType> selectByTypeno(String typeno) {
        return codeTypeMapper.selectByTypeno(typeno);
    }

    @Override
    public CodeType selectSerialnumber(String typeno) {
        return codeTypeMapper.selectSerialnumber(typeno);
    }
}
