package com.dhchain.business.user.dao;


import com.dhchain.business.user.vo.RoleResource;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.io.Serializable;

/**
 *
 * RoleResource 表数据库控制层接口
 *
 */
@Repository
public interface RoleResourceMapper  {

    @Select("SELECT e.id AS id FROM t_role r LEFT JOIN role_resource e ON r.id = e.role_id WHERE r.id = #{id}")
    Long selectIdListByRoleId(@Param("id") Long id);

    @Delete("DELETE FROM u_role_resource WHERE resource_id = #{resourceId}")
    int deleteByResourceId(@Param("resourceId") Serializable resourceId);
    @Delete("DELETE FROM u_role_resource WHERE role_id = #{roleId}")
    int deleteByRoleId(@Param("roleId") Serializable roleId);
    int insert(RoleResource roleResource);

}