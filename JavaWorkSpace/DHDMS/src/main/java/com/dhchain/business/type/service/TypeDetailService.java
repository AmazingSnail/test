package com.dhchain.business.type.service;


import com.dhchain.business.type.vo.TypeDetail;
import com.dhchain.config.result.Tree;

import java.util.List;

/**
 * Created by zhenglb on 2017-09-28.
 */
public interface TypeDetailService {
    List<TypeDetail>  query(TypeDetail typeDetail);
    boolean selectChild(int id);
    boolean  deleteById(int id);
    int selectNewId();
    boolean insert(TypeDetail typeDetail);
    TypeDetail selectById(int id);
    TypeDetail selectByNo(String typeno);
    boolean updateById(TypeDetail typeDetail);
    List<Tree> selectTree(int typeid);
    List<TypeDetail> selectByTypeid(int typeid);
    List<TypeDetail> selectByKind(int kindid);

}
