package com.dhchain.business.base.service;

import com.dhchain.business.base.vo.Base;
import com.dhchain.config.result.Tree;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-06.
 */

public interface BaseService {
    Base selectSXGL();
    List<Base> selectSXGLList(int sxglid);
    List<Base> query(Base base);
    List<Base> selectAll();
    List<Base> selectByFid(int fid);
    List<Tree> selectAllMenu();
    boolean insert(Base base);
    boolean  deleteById(int id);
    Base selectById(int id);
    boolean updateById(Base base);
    int selectNewId();
    List<Base> selectByFlag(String flag);
    List<Base> selectDatabse(Base base);
    List<Base> selectByNoAndFid(String baseno,int fid);
    Base selectByNameAndFid(String basename,int fid);
    boolean selectChild(int id);
    List<Tree> selectAllTree();
    String selectRebasesById(int id);

}
