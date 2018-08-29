package com.dhchain.business.user.dao;

import com.dhchain.business.user.UserVo;
import com.dhchain.business.user.vo.LoginUser;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 *
 * User 表数据库控制层接口
 *
 */
@Repository
public interface UserMapper  {

    UserVo selectUserVoById(@Param("id") Long id);
    List<LoginUser>  selectByLoginName(@Param("userName") String userName);
    List<LoginUser>  selectByLoginName2(@Param("userName") String userName, @Param("id") long id);
    List<Map> selectUserPage(Map<String, Object> params);
    int insert(LoginUser user);
    int deleteById(Long id);
    Object selectById(Long id);
    LoginUser selectByIUserd(long id);
    int  update(LoginUser user);
//    List<Map<String, Object>> selectUserPage(Pagination page, Map<String, Object> params);

}