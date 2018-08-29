package com.dhchain.business.code.dao;

import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.code.vo.Code;
import com.dhchain.business.code.vo.CodeAppl;
import com.dhchain.business.code.vo.CodeApplDetail;
import com.dhchain.business.code.vo.CodeType;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CodeApplMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Code record);

    int add(CodeAppl codeAppl);

    int update(CodeAppl codeAppl);

    int updateCodeApplDetail(CodeApplDetail codeApplDetail);

    int deletecodeappldetail(@Param("id")int id);

    int insertSelective(Code record);

    Code selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Code record);

    int updateByPrimaryKey(Code record);

    CodeAppl selectById(@Param("id")int id);

    List<CodeAppl> query(CodeAppl codeAppl);

    List<Code> select(Code code);

    List<Code> getCodeData(Code code);

    Code selectByCodeno(@Param("codeno") String codeno);

    List<CodeType> selectByTypeno(@Param("typeno") String typeno);

    List<Attr> getAttrList(@Param("fieldName") String fieldName);

    int codeApplDetailSave(CodeApplDetail codeApplDetail);

    int selectNewId();
    int selectNewDetailId();
    String selectTodayMaxApplyno(String a);
    int getMaxItemno(String applyno);
    CodeApplDetail selectByDetailId(@Param("id")int id);
    CodeAppl getCodeApplByTaskId(@Param("processInstanceId")String processInstanceId);
    CodeAppl selectByApplyno(@Param("applyno") String applyno);
    List<CodeApplDetail> selectDetailByApplyno(@Param("applyno") String applyno);
    String selectMaxserialNumber(@Param("typedetailno") String typedetailno);
    List<CodeApplDetail> selectExistDetail(CodeApplDetail codeApplDetail);
}