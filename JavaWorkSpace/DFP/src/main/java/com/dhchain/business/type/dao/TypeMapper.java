package com.dhchain.business.type.dao;

import com.dhchain.business.type.vo.Type;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhenglb on 2017-09-28.
 */
@Repository
public interface TypeMapper {
//    List<Material> select(Material material);
        List<Type> select(@Param("typeno") String typeno, @Param("typename") String typename);
        int delete2(String[] ids);
        Type selectById(@Param("id") long id);
        int insert(Type material);
        int update(Type material);
        int selectWLZSJidByName(@Param("typename") String typename);

}

