package com.dhchain.business.attr.service;

import com.dhchain.business.attr.vo.Factory;
import com.dhchain.config.result.Tree;

import java.util.List;

/**
 * Created by zhenglb on 2017-11-22.
 */
public interface FactoryService {
    List<Factory> query(Factory factory);
    List<Factory> selectByFlag(String flag);
    List<Tree> selectTree();
    Factory selectById(int id);
    Factory selectByNo(String attrno);
    Factory selectByNoAndFid(String attrno,int fid);
    Factory selectByNameAndFid(String attrname,int fid);
    int selectNewId();
    int add(Factory factory);
    boolean updateById(Factory factory);
    boolean selectChild(int id);
    boolean  deleteById(int id);
    List<Factory> selectByFid(int fid);
}
