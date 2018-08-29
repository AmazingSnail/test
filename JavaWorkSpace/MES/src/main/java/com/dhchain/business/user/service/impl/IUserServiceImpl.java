package com.dhchain.business.user.service.impl;


import com.baomidou.mybatisplus.plugins.Page;
import com.dhchain.business.user.dao.*;
import com.dhchain.business.user.vo.*;
import com.dhchain.business.user.UserVo;
import com.dhchain.business.user.service.IUserService;
import com.dhchain.config.result.PageInfo;
import com.dhchain.util.BeanUtils;
import com.dhchain.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 *
 * User 表数据服务层接口实现类
 *
 */
@Service("IUserService")
public class IUserServiceImpl  implements IUserService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private ActUserMapper actUserMapper;
    @Autowired
    private GroupMapper groupMapper;
    @Autowired
    private MemberShipMapper memberShipMapper;

    @Override
    public List<LoginUser> selectByLoginName(UserVo userVo) {
//        LoginUser user = new LoginUser();
//        user.setLoginName(userVo.getLoginName());
        String userName = userVo.getLoginName();
//        long id = userVo.getId();
        List<LoginUser> list= userMapper.selectByLoginName(userName);
        return list;
    }

    @Override
    public List<LoginUser> selectByLoginName2(UserVo userVo) {
        long id =userVo.getId();
        String userName = userVo.getLoginName();

        List<LoginUser> list= userMapper.selectByLoginName2(userName,id);
        return list;
    }

    //
    @Override
    public void insertByVo(UserVo userVo) {
        LoginUser user = BeanUtils.copy(userVo, LoginUser.class);

        user.setCreateTime(new Date());
        userMapper.insert(user);

        Long id = user.getId();
        String[] roles = userVo.getRoleIds().split(",");
        UserRole userRole = new UserRole();
        for (String string : roles) {
            userRole.setUserId(id);
//            long roleId = roleMapper.selectIdByName(string);
            userRole.setRoleId(Long.parseLong(string));
            userRoleMapper.insert(userRole);
        }

    }

    @Override
    public UserVo selectVoById(Long id) {
        return userMapper.selectUserVoById(id);
    }

    @Override
    public void updateByVo(UserVo userVo) {
        LoginUser user = BeanUtils.copy(userVo, LoginUser.class);
        if (StringUtils.isBlank(user.getPassword())) {
            user.setPassword(null);
        }
        userMapper.update(user);
//        同步添加Activiti用户
        boolean actstate = user.isActstate();
        String id_ = user.getLoginName();
        String name = user.getName();
        String firstname = name.substring(0,1);
        String lastname = name.substring(1);
        ActUser actUser = new ActUser();
        actUser.setId(id_);
        actUser.setFirstName(firstname);
        actUser.setLastName(lastname);
        actUser.setPassword("11");
        actUser.setEmail("123@qq.com");
        ActUser RactUser = actUserMapper.findById(id_);
        if(actstate){

           if (RactUser == null) {
               actUserMapper.addUser(actUser);
           }else{
               actUserMapper.updateUser(actUser);
           }
        }else{
            if (RactUser != null) {

                List<String> list=new ArrayList();;
                list.add(id_);
                memberShipMapper.deleteAllGroupsByUserId(id_);
                actUserMapper.deleteUser(list);
            }
        }

        Long id = userVo.getId();
        String UserId = userVo.getLoginName();
        List<UserRole> userRoles = userRoleMapper.selectByUserId(id);
        if (userRoles != null && !userRoles.isEmpty()) {
            for (UserRole userRole : userRoles) {
                userRoleMapper.deleteById(userRole.getId());
            }
        }
        memberShipMapper.deleteAllGroupsByUserId(UserId);

        String[] roles = userVo.getRoleIds().split(",");
        UserRole userRole = new UserRole();
        MemberShip memberShip = new MemberShip();
        for (String string : roles) {
            userRole.setUserId(id);
            userRole.setRoleId(Long.valueOf(string));

            userRoleMapper.insert(userRole);
            Role Rrole = roleMapper.selectById(Long.parseLong(string));
            ActUser actUser1 = new ActUser();
            actUser1.setId(UserId);
            memberShip.setUser(actUser1);
            List shiplist = groupMapper.findGroupByID(Rrole.getName());
            if(shiplist.size()>0){
                Group group = new Group();
                group.setId(Rrole.getName());
                memberShip.setGroup(group);
                int n = memberShipMapper.addMemberShip(memberShip);
                System.out.println(n);
            }
        }

    }

    @Override
    public void updatePwdByUserId(Long userId, String md5Hex) {
//        LoginUser user = new LoginUser();
//        user.setId(userId);
//        user.setPassword(md5Hex);
//        this.updateById(user);
    }

    @Override
    public List<Map> selectDataGrid(PageInfo pageInfo) {
//        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
//        page.setOrderByField(pageInfo.getSort());
//        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
//        List<Map<String, Object>> list = userMapper.selectUserPage(page, pageInfo.getCondition());
        List<Map> list = userMapper.selectUserPage(pageInfo.getCondition());
        return  list;
//        pageInfo.setRows(list);
//        pageInfo.setTotal(page.getTotal());
    }

    @Override
    public void deleteUserById(Long id) {
        //this.deleteById(id);
        LoginUser loginUser = userMapper.selectByIUserd(id);
        String actUserId = loginUser.getLoginName();
        List<String> list = new ArrayList();
        list.add(actUserId);
        memberShipMapper.deleteAllGroupsByUserId(actUserId);
        actUserMapper.deleteUser(list);
        userRoleMapper.deleteByUserId(id);
        userMapper.deleteById(id);

    }

    @Override
    public Object selectById(Long id) {
        return userMapper.selectById(id);
    }

    @Override
    public LoginUser selectByIUserd(long id) {
        return userMapper.selectByIUserd(id);
    }

}