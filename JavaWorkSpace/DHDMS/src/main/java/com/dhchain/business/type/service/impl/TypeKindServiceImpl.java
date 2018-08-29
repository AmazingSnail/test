package com.dhchain.business.type.service.impl;

import com.dhchain.business.type.dao.TypeKindMapper;
import com.dhchain.business.type.dao.TypeMapper;
import com.dhchain.business.type.service.TypeKindService;
import com.dhchain.business.type.vo.Type;
import com.dhchain.business.type.vo.TypeKind;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-05.
 */
@Service("typeKindServiceImpl")
public class TypeKindServiceImpl implements TypeKindService {
    @Autowired
    private TypeMapper typeMapper;
    @Autowired
    private TypeKindMapper typeKindMapper;
    @Override
    public List<Type> selectType() {
        return typeMapper.select("","");
    }

    @Override
    public List<TypeKind> selectByTypeid(int id) {
        List<TypeKind> list = typeKindMapper.selectByTypeid(id);
        return list;
    }

    @Override
    public int add(TypeKind typeKind) {
        int n = typeKindMapper.insert(typeKind);
        return n;
    }

    @Override
    public int edit(TypeKind typeKind) {
        int n = typeKindMapper.update(typeKind);
        return n;
    }

    @Override
    public int deleteTypeKind(String[] ids) {
        int n = typeKindMapper.delete(ids);
        return n;
    }

    @Override
    public TypeKind selectById(String id) {
        TypeKind typeKind = typeKindMapper.selectById(Integer.parseInt(id));
        return typeKind;
    }
    @Override
    public TypeKind selectByKindno(TypeKind typeKind) {
        return typeKindMapper.selectByKindno(typeKind);
    }
}
