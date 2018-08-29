package com.dhchain.business.attr.service.impl;

import com.dhchain.business.attr.dao.FactoryMapper;
import com.dhchain.business.attr.service.FactoryService;
import com.dhchain.business.attr.vo.Factory;
import com.dhchain.config.result.Tree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhenglb on 2017-11-22.
 */
@Service("factoryService")
public class FactoryServiceImpl implements FactoryService {
    @Autowired
    private FactoryMapper factoryMapper;
    @Override
    public List<Factory> query(Factory factory) {
        return factoryMapper.select(factory);
    }

    @Override
    public List<Factory> selectByFlag(String flag) {
        return factoryMapper.selectByFlag(flag);
    }

    @Override
    public List<Tree> selectTree() {
        List<Tree> trees = new ArrayList<Tree>();
        Factory factory = new Factory();
        // 查询所有菜单
        List<Factory> factories = this.query(factory);
        if (factories == null) {
            return trees;
        }
        for (Factory factory1 : factories) {
            Tree tree = new Tree();
            tree.setId((long) factory1.getId());

            tree.setPid((long) factory1.getFid());

            tree.setText(factory1.getAttrname());
//            tree.setIconCls(base.getIcon());
//            tree.setAttributes(base.getUrl());
            tree.setState("open");
            trees.add(tree);
        }
        return trees;
    }

    @Override
    public Factory selectById(int id) {
        return factoryMapper.selectById(id);
    }

    @Override
    public Factory selectByNo(String attrno) {
        return factoryMapper.selectByNo(attrno);
    }

    @Override
    public Factory selectByNoAndFid(String attrno, int fid) {
        return factoryMapper.selectByNoAndFid(attrno,fid);
    }

    @Override
    public Factory selectByNameAndFid(String attrname, int fid) {
        return factoryMapper.selectByNameAndFid(attrname,fid);
    }

    @Override
    public int selectNewId() {
        return factoryMapper.selectNewId();
    }

    @Override
    public int add(Factory factory) {
        int n = factoryMapper.insert(factory);
        return n;
    }

    @Override
    public boolean updateById(Factory factory) {
        try {
            int c = factoryMapper.update(factory);
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
    public boolean selectChild(int id) {
        List<Factory> list = factoryMapper.selectChildById(id);
        boolean flag = false;
        if(list.size()>0){
            flag = true;
        }
        return flag;
    }

    @Override
    public boolean deleteById(int id) {
        try {
            int c = factoryMapper.deleteById(id);
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
    public List<Factory> selectByFid(int fid) {
        return factoryMapper.selectChildById(fid);
    }
}
