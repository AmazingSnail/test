package com.dhchain.business.code.service;

import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.code.vo.Code;
import com.dhchain.business.code.vo.CodeAppl;
import com.dhchain.business.code.vo.CodeApplDetail;
import com.dhchain.business.code.vo.CodeType;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2017-10-20.
 */
public interface CodeApplService {
    List<Code> select(Code code);
    List<Code> getCodeData(Code code);
    CodeAppl selectById(int id);
    List<CodeAppl> query(CodeAppl codeAppl);
    boolean iscontain(String codeno);
    Code selectByCodeno(String codeno);
    List<CodeType> selectByTypeno(String typeno);
    List<Attr> getAttrList(String fieldName);
    int codeApplDetailSave(CodeApplDetail codeApplDetail);
    String selectTodayMaxApplyno();
    int getMaxItemno(String applyno);
    int add(CodeAppl codeAppl);
    int update(CodeAppl codeAppl);
    int insertDetail(CodeApplDetail codeApplDetail);
    int selectNewId();
    int selectNewDetailId();
    int updateCodeApplDetail(CodeApplDetail codeApplDetail);
    int deletecodeappldetail(int id);
    CodeApplDetail selectByDetailId(int id);
    CodeAppl getCodeApplByTaskId(String processInstanceId);
    CodeAppl selectByApplyno(String applyno);
    List<CodeApplDetail> selectDetailByApplyno(String applyno);
    Map selectMaxserialNumber(String typedetailno, int begin, int end, int length);
    List<CodeApplDetail> selectExistDetail(CodeApplDetail codeApplDetail);
    HSSFWorkbook exportExcelInfo(Map map);

}
