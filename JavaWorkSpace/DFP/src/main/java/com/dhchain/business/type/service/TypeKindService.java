package com.dhchain.business.type.service;

import com.dhchain.business.type.vo.Type;
import com.dhchain.business.type.vo.TypeKind;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-05.
 */
public interface TypeKindService {

    List<Type> selectType();
    List<TypeKind> selectByTypeid(int id);
    int add(TypeKind typeKind);
    int edit(TypeKind typeKind);
    int deleteTypeKind(String[] ids);
    TypeKind selectById(String id);
    TypeKind selectByKindno(TypeKind typeKind);

}
