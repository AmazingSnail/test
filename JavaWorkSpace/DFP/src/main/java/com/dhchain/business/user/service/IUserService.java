package com.dhchain.business.user.service;

import com.dhchain.business.user.UserVo;
import com.dhchain.business.user.vo.LoginUser;
import com.dhchain.config.result.PageInfo;

import java.util.List;
import java.util.Map;


/**
 *
 * User 表数据服务层接口
 *
 */
public interface IUserService  {

    List<LoginUser> selectByLoginName(UserVo userVo);

    List<LoginUser> selectByLoginName2(UserVo userVo);

    void insertByVo(UserVo userVo);

    UserVo selectVoById(Long id);

    void updateByVo(UserVo userVo);

    void updatePwdByUserId(Long userId, String md5Hex);

    List<Map>  selectDataGrid(PageInfo pageInfo);

    void deleteUserById(Long id);

    Object selectById(Long id);

    LoginUser  selectByIUserd(long id);
}