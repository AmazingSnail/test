package com.dhchain.business.code.service.impl;

import com.dhchain.business.code.dao.CodeNameMapper;
import com.dhchain.business.code.service.CodeNameService;
import com.dhchain.business.code.vo.CodeName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-17.
 */
@Service("CodeNameService")
public class CodeNameServiceImpl implements CodeNameService {
    @Autowired
    private CodeNameMapper codeNameMapper;
    @Override
    public boolean insert(CodeName codeName) {
        try {
            int c=codeNameMapper.insert(codeName);
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
    public List<CodeName> selectByCodeManageId(int codemanageid) {
        return codeNameMapper.selectByCodeManageId(codemanageid);
    }

    @Override
    public List<CodeName> selectByTypeno(String typeno) {
        return codeNameMapper.selectByTypeno(typeno);
    }

    @Override
    public int delete(String[] ids) {
        int n = codeNameMapper.delete(ids);
        return n;
    }

    @Override
    public CodeName selectById(int id) {
        return codeNameMapper.selectById(id);
    }

    @Override
    public CodeName selectFLCX(String typeno) {
        return  codeNameMapper.selectFLCX(typeno);
    }

    @Override
    public boolean update(CodeName codeName) {
        try {
            int c=codeNameMapper.update(codeName);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
