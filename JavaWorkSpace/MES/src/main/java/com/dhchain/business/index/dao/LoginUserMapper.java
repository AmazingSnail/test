package com.dhchain.business.index.dao;

import com.dhchain.business.index.vo.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by xieyj on 2017-7-14.
 */
@Repository
public interface LoginUserMapper {
    /**
     * 查询多个Menu
     *
     * @param
     * @param    query 菜单Id
     * @return	Menu
     * */
//    List<User> getUser(User user, String query,String Username);

    List<User> getUser(User query, String username);
}
