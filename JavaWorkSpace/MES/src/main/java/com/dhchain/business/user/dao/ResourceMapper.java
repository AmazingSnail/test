package com.dhchain.business.user.dao;


import com.dhchain.business.user.vo.Resource;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 *
 * Resource 表数据库控制层接口
 *
 */
@Repository
public interface ResourceMapper {
    List<Resource> selectList();
    List<Resource> selectListByType(Integer type);
    int insert(Resource resource);
    int deleteById(Long id);
    Resource selectById(Long id);
    int  update(Resource resource);
}