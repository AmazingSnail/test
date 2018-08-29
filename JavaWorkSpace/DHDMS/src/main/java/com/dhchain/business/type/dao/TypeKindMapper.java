package com.dhchain.business.type.dao;

import com.dhchain.business.type.vo.TypeKind;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-05.
 */
@Repository
public interface TypeKindMapper {
    List<TypeKind> selectByTypeid(@Param("typeid") int typeid);
    int insert(TypeKind typeKind);
    int update(TypeKind typeKind);
    int delete(String[] ids);
    TypeKind selectById(@Param("id") int id);
    TypeKind selectByKindno(TypeKind typeKind);
}
