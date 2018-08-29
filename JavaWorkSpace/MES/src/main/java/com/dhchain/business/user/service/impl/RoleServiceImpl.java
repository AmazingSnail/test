package com.dhchain.business.user.service.impl;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.dhchain.business.user.dao.*;
import com.dhchain.business.user.service.IRoleService;
import com.dhchain.business.user.vo.Group;
import com.dhchain.business.user.vo.Role;
import com.dhchain.business.user.vo.RoleResource;
import com.dhchain.config.result.PageInfo;
import com.dhchain.config.result.Tree;
import com.dhchain.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 *
 * Role 表数据服务层接口实现类
 *
 */
@Service
public class RoleServiceImpl implements IRoleService {

    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;
    @Autowired
    private RoleResourceMapper roleResourceMapper;
    @Autowired
    private GroupMapper groupMapper;
    @Autowired
    private MemberShipMapper memberShipMapper;

    public List<Role> selectAll() {
//        EntityWrapper<Role> wrapper = new EntityWrapper<Role>();
//        wrapper.orderBy("seq");
        return roleMapper.selectList();

    }

    @Override
    public List<Role> selectDataGrid(PageInfo pageInfo) {
        Page<Role> page = new Page<Role>(pageInfo.getNowpage(), pageInfo.getSize());

//        EntityWrapper<Role> wrapper = new EntityWrapper<Role>();
//        wrapper.orderBy(pageInfo.getSort(), pageInfo.getOrder().equalsIgnoreCase("ASC"));
//        selectPage(page, wrapper);
//
//        pageInfo.setRows(page.getRecords());
        List<Role> list = roleMapper.selectPage();
        return list;
//        pageInfo.setRows(list);
//        pageInfo.setTotal(page.getTotal());
    }

    @Override
    public Object selectTree() {
        List<Tree> trees = new ArrayList<Tree>();
        List<Role> roles = this.selectAll();
        for (Role role : roles) {
            Tree tree = new Tree();
            tree.setId(role.getId());
            tree.setText(role.getName());


            trees.add(tree);
        }
        return trees;
    }

    @Override
    public void updateRoleResource(Long roleId, String resourceIds) {
//         先删除后添加,有点爆力
        RoleResource roleResource = new RoleResource();
        roleResource.setRoleId(roleId);
        roleResourceMapper.deleteByRoleId(roleId);

        String[] resourceIdArray = resourceIds.split(",");
        for (String resourceId : resourceIdArray) {
            roleResource = new RoleResource();
            roleResource.setRoleId(roleId);
            roleResource.setResourceId(Long.parseLong(resourceId));
            roleResourceMapper.insert(roleResource);
        }
    }

    @Override
    public List<Long> selectResourceIdListByRoleId(Long id) {
        return roleMapper.selectResourceIdListByRoleId(id);
    }

    @Override
    public List<Long> findRoleIdListByUserId(Long id) {
        return roleMapper.findRoleIdListByUserId(id);
    }

    @Override
    public Map<String, Set<String>> selectResourceMapByUserId(Long userId) {
        Map<String, Set<String>> resourceMap = new HashMap<String, Set<String>>();
        List<Long> roleIdList = userRoleMapper.selectRoleIdListByUserId(userId);
        Set<String> urlSet = new HashSet<String>();
        Set<String> roles = new HashSet<String>();
        for (Long roleId : roleIdList) {
            List<Map<Long, String>> resourceList = roleMapper.selectResourceListByRoleId(roleId);
            if (resourceList != null) {
                for (Map<Long, String> map : resourceList) {
                    if (StringUtils.isNotBlank(map.get("url"))) {
                        urlSet.add(map.get("url"));
                    }
                }
            }
            Role role = roleMapper.selectById(roleId);
            if (role != null) {
                roles.add(role.getName());
            }
        }
        resourceMap.put("urls", urlSet);
        resourceMap.put("roles", roles);
        return resourceMap;

   }

    @Override
    public boolean insert(Role role) {
        boolean flag = false;
        try {
            int c=roleMapper.insert(role);
            if (c > 0) {
                flag = true;
            }

        } catch (Exception e) {
            e.printStackTrace();

        }
        return  flag;
    }

    @Override
    public boolean deleteById(Long id) {
        boolean flag = false;
        Role role = roleMapper.selectById(id);
        String id_ = role.getName();
        memberShipMapper.deleteAllGroupsByGroupId(id_);
        List<String> list = new ArrayList<>();
        list.add(id_);
        groupMapper.deleteGroup(list);
        try {
            int c = roleMapper.deleteById(id);
            if (c > 0) {
                flag = true;
            }

        } catch (Exception e) {
            e.printStackTrace();

        }
        return  flag;
    }

    @Override
    public Role selectById(Long id) {
        return roleMapper.selectById(id);
    }

    @Override
    public boolean updateById(Role role) {
        boolean flag = false;
        boolean actGroupState = role.isActGroupState();
        String id_ = role.getName();
        String name = role.getDescription();
        Group group = new Group();
        group.setId(id_);
        group.setName(name);
        List list = groupMapper.findGroupByID(id_);
        if(actGroupState){
            if (list.size()==0) {
                groupMapper.addGroup(group);
            }else{
                groupMapper.updateGroup(group);
            }
        }else{
            if (list.size()>0) {

                List<String> alist=new ArrayList();
                alist.add(id_);
                memberShipMapper.deleteAllGroupsByGroupId(id_);
                groupMapper.deleteGroup(alist);
            }
        }
        try {
            int c = roleMapper.update(role);
            if (c > 0) {
              flag = true;
            }

        } catch (Exception e) {
           e.printStackTrace();
        }
        return  flag;
    }

}