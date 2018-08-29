package com.dhchain.business.user.controller;

import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.user.service.IRoleService;
import com.dhchain.business.user.vo.Role;
import com.dhchain.config.base.BaseController;
import com.dhchain.config.result.PageInfo;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2017/8/26.
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {
    @Autowired
    private IRoleService roleService;
    /**
     * 权限列表
     *
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        List<Role> list = roleService.selectDataGrid(pageInfo);
        JSONArray jslst = new JSONArray();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        Role role;
        if(list.size()>0){
            for(int i = 0;i<list.size();i++) {
                role = list.get(i);
                Map re = new HashMap();
                re.put("id",role.getId());
                re.put("name",role.getName());
                re.put("seq",role.getSeq());
                re.put("description",role.getDescription());
                re.put("status",role.getStatus());
                re.put("actGroupState",role.isActGroupState());
//                re.put("age",loginUser.get("age"));
//                re.put("phone",loginUser.get("phone"));
//                re.put("rolesList",loginUser.get("rolesList"));
//                re.put("userType",loginUser.get("userType"));
//                re.put("status",loginUser.get("status"));
//                re.put("id",loginUser.get("id"));
//                re.put("actstate",loginUser.get("actstate"));
                jslst.add(re);
            }

        }
        return jslst;

    }

    /**
     * 权限树
     *
     * @return
     */
    @PostMapping("/tree")
    @ResponseBody
    public Object tree() {
        Object tree = roleService.selectTree();
        return tree;
    }

    /**
     * 添加权限
     *
     * @param role
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Role role) {
        boolean flag = roleService.insert(role);
        if(flag){
            return renderSuccess("增加成功！");
        }else{
            return renderSuccess("增加失败！");
        }
    }

    /**
     * 删除权限
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        roleService.deleteById(id);
        return renderSuccess("删除成功！");
    }


    /**
     * 编辑部门页
     *
     * @param
     * @param id
     * @return
     */

    @PostMapping(value = "/editPage")
    @ResponseBody
    public Object editPage(Long id) {
        Role role = roleService.selectById(id);
        return  role;
    }
    /**
     * 编辑部门
     *
     * @param role
     *
     * @return
     */
    @RequestMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Role role) {
        boolean flag = roleService.updateById(role);
        if(flag){
            return renderSuccess("编辑成功！");
        }else{
            return renderSuccess("编辑失败！");
        }

    }


    /**
     * 授权页面页面根据角色查询资源
     *
     * @param id
     * @return
     */
    @RequestMapping("/findResourceIdListByRoleId")
    @ResponseBody
    public Object findResourceByRoleId(Long id) {
        List<Long> resources = roleService.selectResourceIdListByRoleId(id);
        return renderSuccess(resources);
    }


    /**
     * 根据用户id查角色
     *
     * @param id
     * @return
     */
    @RequestMapping("/findRoleIdListByUserId")
    @ResponseBody
    public Object findRoleIdListByUserId(Long id) {
        List<Long> roles = roleService.findRoleIdListByUserId(id);
        return renderSuccess(roles);
    }

    /**
     * 授权
     *
     * @param id
     * @param resourceIds
     * @return
     */
    @RequiresRoles("admin")
    @RequestMapping("/grant")
    @ResponseBody
    public Object grant(Long id, String resourceIds) {
        roleService.updateRoleResource(id, resourceIds);
        return renderSuccess("授权成功！");
    }

}
