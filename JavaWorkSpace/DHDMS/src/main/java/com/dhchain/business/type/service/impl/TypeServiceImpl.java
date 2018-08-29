package com.dhchain.business.type.service.impl;

import com.dhchain.business.type.dao.TypeMapper;
import com.dhchain.business.type.service.TypeService;
import com.dhchain.business.type.vo.Type;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-09-28.
 */
@Service("typeService")
public class TypeServiceImpl implements TypeService {
    @Autowired
    private TypeMapper typeMapper;
//    @Override
//    public List<Material> select(Material material) {
//        return materialMapper.select(material);
//    }

    @Override
    public List<Type> select(String type, String name) {
        List<Type> list = typeMapper.select(type,name);
        return list;
    }

    @Override
    public int delete(String[] ids) {
        int n = typeMapper.delete2(ids);
        return n;
    }

    @Override
    public Type selectById(String id) {
        Type material = typeMapper.selectById(Integer.parseInt(id));
        return material;
    }

    @Override
    public int add(Type material) {
        int n = typeMapper.insert(material);
        return n;
    }

    @Override
    public int edit(Type material) {
        int n = typeMapper.update(material);
        return n;
    }

    @Override
    public int selectWLZSJidByName(String typename) {
        int n = typeMapper.selectWLZSJidByName(typename);
        return n;
    }
}
