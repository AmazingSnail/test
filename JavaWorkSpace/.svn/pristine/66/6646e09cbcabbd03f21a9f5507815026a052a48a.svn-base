package com.dhchain.business.user.dao;


import com.dhchain.business.user.vo.UserRole;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 *
 * UserRole 表数据库控制层接口
 *
 */
@Repository
public interface UserRoleMapper  {

    List<UserRole> selectByUserId(@Param("userId") Long userId);

    @Select("select role_id AS roleId from u_user_role where user_id = #{userId}")
    @ResultType(Long.class)
    List<Long> selectRoleIdListByUserId(@Param("userId") Long userId);

    @Delete("DELETE FROM u_user_role WHERE user_id = #{userId}")
    int deleteByUserId(@Param("userId") Long userId);

    int insert(UserRole userRole);

    int deleteById(Long id);

}