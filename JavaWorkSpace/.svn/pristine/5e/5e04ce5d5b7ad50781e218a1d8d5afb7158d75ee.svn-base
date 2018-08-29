package com.dhchain.business.attr.service;

import com.dhchain.business.attr.vo.Attr;
import com.dhchain.config.result.Tree;

import java.util.List;

/**
 * Created by zhenglb on 2017-10-10.
 */
public interface AttrService {
    List<Attr> query(Attr attr);
    int add(Attr attr);
    int selectNewId();
    Attr selectById(int id);
    Attr selectByNo(String attrno);
    Attr selectByNoAndFid(String attrno,int fid);
    Attr selectByNameAndFid(String attrname,int fid);
    boolean updateById(Attr attr);
    List<Attr> selectByFlag(String flag);
    List<Attr> selectType();
    List<Attr> selectByFid(int fid);
    List<Tree> selectTree();
    boolean selectChild(int id);
    boolean  deleteById(int id);

}
