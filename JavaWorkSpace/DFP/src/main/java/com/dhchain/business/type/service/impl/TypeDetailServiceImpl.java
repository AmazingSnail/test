package com.dhchain.business.type.service.impl;


import com.dhchain.business.type.dao.TypeDetailMapper;
import com.dhchain.business.type.service.TypeDetailService;
import com.dhchain.business.type.vo.TypeDetail;
import com.dhchain.config.result.Tree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhenglb on 2017-09-28.
 */
@Service("TypeDetailServiceImpl")
public class TypeDetailServiceImpl implements TypeDetailService {
    @Autowired
    private TypeDetailMapper typeDetailMapper;
//    @Override
//    public List<Material> select(Material material) {
//        return materialMapper.select(material);
//    }

    @Override
    public List<TypeDetail> query(TypeDetail typeDetail) {
        List<TypeDetail> list = typeDetailMapper.query(typeDetail);
        return list;
    }

    @Override
    public boolean selectChild(int id) {
        List<TypeDetail> list = typeDetailMapper.selectChildById(id);
        boolean flag = false;
        if(list.size()>0){
            flag = true;
        }
        return flag;
    }

    @Override
    public boolean deleteById(int id) {
        try {
            int c = typeDetailMapper.deleteById(id);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int selectNewId() {
        return typeDetailMapper.selectNewId();
    }

    @Override
    public boolean insert(TypeDetail typeDetail) {
        try {
            int c=typeDetailMapper.insert(typeDetail);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public TypeDetail selectById(int id) {
        return typeDetailMapper.selectById(id);
    }

    @Override
    public TypeDetail selectByNo(String typeno) {

            return typeDetailMapper.selectByNo(typeno);
    }

    @Override
    public boolean updateById(TypeDetail typeDetail) {
        try {
            int c = typeDetailMapper.update(typeDetail);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();

            return false;
        }
    }

    @Override
    public List<Tree> selectTree(int typeid) {
        List<Tree> trees = new ArrayList<Tree>();
        // 查询所有菜单
        List<TypeDetail> typeDetails = this.selectByTypeid(typeid);
        if (typeDetails == null) {
            return trees;
        }
        for (TypeDetail typeDetail : typeDetails) {
            Tree tree = new Tree();
            tree.setId((long) typeDetail.getId());

            tree.setPid((long) typeDetail.getFid());

            tree.setText(typeDetail.getTypename());
//            tree.setIconCls(base.getIcon());
//            tree.setAttributes(base.getUrl());
            tree.setState("open");
            trees.add(tree);
        }
        return trees;
    }

    @Override
    public List<TypeDetail> selectByTypeid(int typeid) {
        return typeDetailMapper.selectByTypeid(typeid);
    }

    @Override
    public List<TypeDetail> selectByKind(int kindid) {
        return typeDetailMapper.selectByKind(kindid);
    }

}
