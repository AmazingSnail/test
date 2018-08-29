package com.dhchain.business.code.dao;

import com.dhchain.business.code.vo.Code;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface CodeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Code code);

    int insertSelective(Code record);

    Code selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Code record);

    int updateByPrimaryKey(Code record);

    List<Code> select(Code code);
    List<Code> select2(@Param("ids")String ids,@Param("typedetailid")int typedetailid);
    List<Code> getCodeData(Code code);
    List<Integer> selectTypes();
    Code selectByCodeno(@Param("codeno")String codeno);
    Code selectById(@Param("id")int id);
    List<Code> selectExistCode(Code code);
    List<Code> selectByTypeDetailid(@Param("typedetailid")int typedetailid);
    int selectNewId();

    int update(Code code);

    List<Code> selectByApplyno(@Param("applyno")String applyno);
    List<Map> selectDepartmentCodes();
    List<Map> completionRate();
    List<Map> selectCPXP();
    List<Map> selectBCP();
    List<Map> selectCPGD();
}