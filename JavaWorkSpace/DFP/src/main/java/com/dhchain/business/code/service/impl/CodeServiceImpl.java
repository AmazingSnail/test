package com.dhchain.business.code.service.impl;

import com.dhchain.business.code.dao.CodeMapper;
import com.dhchain.business.code.service.CodeService;
import com.dhchain.business.code.vo.Code;
import com.dhchain.business.exp.dao.ExpMapper;
import com.dhchain.business.exp.vo.Exp;
import com.dhchain.business.rout.dao.RoutMapper;
import com.dhchain.business.rout.vo.Rout;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by zhenglb on 2017-10-20.
 */
@Service("codeService")
public class CodeServiceImpl implements CodeService{
    @Autowired
    private CodeMapper codeMapper;
    @Autowired
    private ExpMapper expMapper;
    @Autowired
    private RoutMapper routMapper;
    @Override
    public List<Code> select(Code code) {
        return codeMapper.select(code);
    }

    @Override
    public List<Integer> selectTypes() {
        return codeMapper.selectTypes();
    }

    @Override
    public List<Code> select2(String ids, int typedetailid) {
        return codeMapper.select2(ids,typedetailid);
    }

    @Override
    public List<Code> getCodeData(Code code) {
        return codeMapper.select(code);
    }

    @Override
    public boolean iscontain(String codeno) {
        boolean flag = false;
        Exp exp = expMapper.iscontain(codeno);
        if(exp!=null){
            flag = true;
        }
        return flag;
    }

    @Override
    public boolean iscontainrout(String codeno) {
        boolean flag = false;
        Rout rout = routMapper.iscontain(codeno);
        if(rout!=null){
            flag = true;
        }
        return flag;
    }

    @Override
    public Code selectByCodeno(String codeno) {
        return codeMapper.selectByCodeno(codeno);
    }

    @Override
    public Code selectById(int id) {
        return codeMapper.selectById(id);
    }

    @Override
    public int add(Code code) {
        return codeMapper.insert(code);
    }

    @Override
    public List<Code> selectExistCode(Code code) {
        return codeMapper.selectExistCode(code);
    }

    @Override
    public List<Code> selectByTypeDetailid(int typedetailid) {
        return codeMapper.selectByTypeDetailid(typedetailid);
    }

    @Override
    public int selectNewId() {
        return codeMapper.selectNewId();
    }

    @Override
    public boolean update(Code code) {
        try {
            int c = codeMapper.updateByPrimaryKey(code);
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
    public List<Code> selectByApplyno(String applyno) {
        return codeMapper.selectByApplyno(applyno);
    }

    @Override
    public List<Map> selectDepartmentCodes() {
        return codeMapper.selectDepartmentCodes();
    }

    @Override
    public List<Map> completionRate() {
        return codeMapper.completionRate();
    }

    @Override
    public Map monthlyIncrement() {
        Map map = new HashMap();
        map.put("cpxp",codeMapper.selectCPXP());
        map.put("bcp",codeMapper.selectBCP());
        map.put("cpgd",codeMapper.selectCPGD());
        return map;
    }

    @Override
    public int delete(Code code) {
        return codeMapper.deleteByPrimaryKey(code.getId());
    }
}
