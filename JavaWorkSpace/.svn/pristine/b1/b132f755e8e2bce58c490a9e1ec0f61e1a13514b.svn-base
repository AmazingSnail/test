package com.dhchain.business.user.dao;


import com.dhchain.business.user.vo.Resource;
import com.dhchain.business.user.vo.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 *
 * Role 表数据库控制层接口
 *
 */
@Repository
public interface RoleMapper  {

    List<Long> selectResourceIdListByRoleId(@Param("id") Long id);

    List<Long> findRoleIdListByUserId(@Param("id") Long id);

    List<Resource> selectResourceListByRoleIdList(@Param("list") List<Long> list);

    List<Map<Long, String>> selectResourceListByRoleId(@Param("id") Long id);

    Role selectById(Long roleId);

    List<Role> selectPage();

    List<Role> selectList();

    int insert(Role role);

    int deleteById(Long id);

    long selectIdByName(String name);

    int  update(Role role);
}