package com.dhchain.business.base.service.impl;

import com.dhchain.business.base.dao.BaseMapper;
import com.dhchain.business.base.service.BaseService;
import com.dhchain.business.base.vo.Base;
import com.dhchain.config.result.Tree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhenglb on 2017-10-06.
 */
@Service("baseService")
public class BaseServiceImpl implements BaseService {
    @Autowired
    private BaseMapper baseMapper;

    @Override
    public Base selectSXGL() {
        String sxgl = "属性归类";
        return baseMapper.selectSXGL(sxgl);
    }

    @Override
    public List<Base> selectSXGLList(int sxglid) {
        return baseMapper.selectChildById(sxglid);
    }

    @Override
    public List<Base> query(Base base) {
        return baseMapper.select(base);
    }

    @Override
    public List<Base> selectAll() {
        return baseMapper.selectAll();
    }

    @Override
    public List<Base> selectByFid(int fid) {
        return baseMapper.selectChildById(fid);
    }

    @Override
    public List<Tree> selectAllMenu() {
        List<Tree> trees = new ArrayList<Tree>();
        // 查询所有菜单
        List<Base> bases = this.selectAll();
        if (bases == null) {
            return trees;
        }
        for (Base base : bases) {
            Tree tree = new Tree();
            tree.setId((long) base.getId());

            tree.setPid((long) base.getFid());

            tree.setText(base.getBasename());
//            tree.setIconCls(base.getIcon());
//            tree.setAttributes(base.getUrl());
            tree.setState("close");
            trees.add(tree);
        }
        return trees;
    }

    @Override
    public boolean insert(Base base) {
        try {
            int c=baseMapper.insert(base);
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
    public boolean deleteById(int id) {
        try {
            int c = baseMapper.deleteById(id);
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
    public Base selectById(int id) {
        return baseMapper.selectById(id);
    }

    @Override
    public boolean updateById(Base base) {
        try {
            int c = baseMapper.update(base);
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
        return baseMapper.selectNewId();
    }

    @Override
    public List<Base> selectByFlag(String flag) {
        return baseMapper.selectByFlag(flag);
    }

    @Override
    public List<Base> selectDatabse(Base base) {
        return baseMapper.selectDatabse(base);
    }

    @Override
    public List<Base> selectByNoAndFid(String baseno,int fid) {

            return baseMapper.selectByNoAndFid(baseno,fid);
    }

    @Override
    public Base selectByNameAndFid(String basename, int fid) {
        return baseMapper.selectByNameAndFid(basename,fid);
    }

    @Override
    public boolean selectChild(int id) {
        List<Base> list = baseMapper.selectChildById(id);
        boolean flag = false;
        if(list.size()>0){
            flag = true;
        }
        return flag;
    }

    @Override
    public List<Tree> selectAllTree() {
        // 获取所有的资源 tree形式，展示
        List<Tree> trees = new ArrayList<Tree>();
        List<Base> bases = baseMapper.selectAll();
        if (bases == null) {
            return trees;
        }
        for (Base base : bases) {
            Tree tree = new Tree();
            tree.setId((long) base.getId());
            tree.setPid((long) base.getFid());
            tree.setText(base.getBasename());

            tree.setState(0);
            trees.add(tree);
        }
        return trees;
    }

    @Override
    public String selectRebasesById(int id) {

            return baseMapper.selectRebasesById(id);

    }


}
