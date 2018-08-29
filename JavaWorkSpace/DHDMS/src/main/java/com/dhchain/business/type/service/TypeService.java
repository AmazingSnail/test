package com.dhchain.business.type.service;

import com.dhchain.business.type.vo.Type;

import java.util.List;

/**
 * Created by zhenglb on 2017-09-28.
 */
public interface TypeService {
//    List<Material>  select(Material material);
    List<Type>  select(String type, String name);
    int delete(String[] ids);
    Type selectById(String id);
    int add(Type material);
    int edit(Type material);
    int selectWLZSJidByName(String typename);
}
