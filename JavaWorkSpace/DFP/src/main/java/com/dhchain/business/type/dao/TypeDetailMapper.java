package com.dhchain.business.type.dao;

import com.dhchain.business.type.vo.TypeDetail;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface TypeDetailMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TypeDetail record);

    int insertSelective(TypeDetail record);

    TypeDetail selectByPrimaryKey(Integer id);

    int update(TypeDetail typeDetail);

    int updateByPrimaryKey(TypeDetail record);
    List<TypeDetail> query(TypeDetail typeDetail);

    List<TypeDetail> selectChildById(@Param("fid")int id);

    int  deleteById(int id);
    int selectNewId();
    TypeDetail selectById(@Param("id")int id);
    TypeDetail selectByNo(@Param("typeno")String typeno);
    List<TypeDetail> selectByTypeid(@Param("typeid")int typeid);

    List<TypeDetail> selectByKind(@Param("kindid")int kindid);
}