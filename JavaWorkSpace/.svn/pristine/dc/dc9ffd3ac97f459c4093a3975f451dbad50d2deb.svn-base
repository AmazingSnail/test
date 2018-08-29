package com.dhchain.business.code.service;

import com.dhchain.business.code.vo.Code;

import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2017-10-20.
 */
public interface CodeService {
    List<Code> select(Code code);
    List<Integer> selectTypes();
    List<Code> select2(String ids,int typedetailid);
    List<Code> getCodeData(Code code);
    boolean iscontain(String codeno);
    boolean iscontainrout(String codeno);
    Code selectByCodeno(String codeno);
    Code selectById(int id);
    int add(Code code);
    List<Code> selectExistCode(Code code);
    List<Code> selectByTypeDetailid(int typedetailid);
    int selectNewId();
    boolean update(Code code);
    List<Code> selectByApplyno(String applyno);
    List<Map> selectDepartmentCodes();
    List<Map> completionRate();
    Map monthlyIncrement();
    int delete(Code code);
}
