package com.dhchain.business.attr.service.impl;

import com.dhchain.business.attr.dao.AttrMapper;
import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attr.vo.Attr;
import com.dhchain.config.result.Tree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhenglb on 2017-10-10.
 */
@Service("attrService")
public class AttrServiceImpl implements AttrService {
    @Autowired
    private AttrMapper attrMapper;

    @Override
    public List<Attr> query(Attr attr) {
        return attrMapper.select(attr);
    }

    @Override
    public int add(Attr attr) {
        int n = attrMapper.insert(attr);
        return n;
    }

    @Override
    public int selectNewId() {
        return attrMapper.selectNewId();
    }

    @Override
    public Attr selectById(int id) {
        return attrMapper.selectById(id);
    }

    @Override
    public Attr selectByNo(String attrno) {
        return  attrMapper.selectByNo(attrno);
    }

    @Override
    public Attr selectByNoAndFid(String attrno, int fid) {
        return  attrMapper.selectByNoAndFid(attrno,fid);
    }

    @Override
    public Attr selectByNameAndFid(String attrname, int fid) {
        return  attrMapper.selectByNameAndFid(attrname,fid);
    }

    @Override
    public boolean updateById(Attr attr) {
        try {
            int c = attrMapper.update(attr);
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
    public List<Attr> selectByFlag(String flag) {
        return attrMapper.selectByFlag(flag);
    }

    @Override
    public List<Attr> selectType() {
        Attr attr =new Attr();
        return attrMapper.select(attr);
    }

    @Override
    public List<Attr> selectByFid(int fid) {
        return attrMapper.selectChildById(fid);
    }

    @Override
    public List<Tree> selectTree() {
        List<Tree> trees = new ArrayList<Tree>();
        Attr attr = new Attr();
        // 查询所有菜单
        List<Attr> attrs = this.query(attr);
        if (attrs == null) {
            return trees;
        }
        for (Attr attr1 : attrs) {
            Tree tree = new Tree();
            tree.setId((long) attr1.getId());

            tree.setPid((long) attr1.getFid());

            tree.setText(attr1.getAttrname());
//            tree.setIconCls(base.getIcon());
//            tree.setAttributes(base.getUrl());
            tree.setState("open");
            trees.add(tree);
        }
        return trees;
    }

    @Override
    public boolean selectChild(int id) {
        List<Attr> list = attrMapper.selectChildById(id);
        boolean flag = false;
        if(list.size()>0){
            flag = true;
        }
        return flag;
    }

    @Override
    public boolean deleteById(int id) {
        try {
            int c = attrMapper.deleteById(id);
            if (c > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
