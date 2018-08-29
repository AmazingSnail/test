package com.dhchain.business.user.controller;

import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.user.UserVo;
import com.dhchain.business.user.service.IUserService;
import com.dhchain.business.user.vo.LoginUser;
import com.dhchain.config.base.BaseController;
import com.dhchain.config.result.PageInfo;
import com.dhchain.config.shiro.PasswordHash;
import com.dhchain.util.StringUtils;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2017/8/25.
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController{
    @Autowired
    private IUserService userService;
    @Autowired
    private PasswordHash passwordHash;

    /**
     * 用户管理列表
     *
     * @param userVo
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(UserVo userVo, Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(userVo.getName())) {
            condition.put("name", userVo.getName());
        }
        if (userVo.getOrganizationId() != null) {
            condition.put("organizationId", userVo.getOrganizationId());
        }
        if (userVo.getCreatedateStart() != null) {
            condition.put("startTime", userVo.getCreatedateStart());
        }
        if (userVo.getCreatedateEnd() != null) {
            condition.put("endTime", userVo.getCreatedateEnd());
        }
        pageInfo.setCondition(condition);
        List<Map> list = userService.selectDataGrid(pageInfo);
        JSONArray jslst = new JSONArray();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        Map loginUser;
        if(list.size()>0){
            for(int i = 0;i<list.size();i++) {
                loginUser = list.get(i);
                Map re = new HashMap();
                re.put("loginName",loginUser.get("loginName"));
                re.put("name",loginUser.get("name"));
                re.put("organizationId",loginUser.get("organizationId"));
                re.put("organizationName",loginUser.get("organizationName"));
                re.put("createTime",sdf.format(loginUser.get("createTime")));
                re.put("sex",loginUser.get("sex"));
                re.put("age",loginUser.get("age"));
                re.put("phone",loginUser.get("phone"));
                re.put("rolesList",loginUser.get("rolesList"));
                re.put("userType",loginUser.get("userType"));
                re.put("status",loginUser.get("status"));
                re.put("id",loginUser.get("id"));
                jslst.add(re);
            }

        }
        return jslst;
    }


    /**
     * 添加用户
     *
     * @param userVo
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid UserVo userVo) {
        List<LoginUser> list = userService.selectByLoginName(userVo);
        if (list != null && !list.isEmpty()) {
            return renderError("登录名已存在!");
        }
        String salt = StringUtils.getUUId();
        String pwd = passwordHash.toHex(userVo.getPassword(), salt);
        userVo.setSalt(salt);
        userVo.setPassword(pwd);
        userService.insertByVo(userVo);
        return renderSuccess("添加成功");
    }

    /**
     * 删除用户
     *
     * @param id
     * @return
     */
    @RequiresRoles("admin")
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        Long currentUserId = getUserId();
        if (id == currentUserId) {
            return renderError("不可以删除自己！");
        }
        userService.deleteUserById(id);
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
        Object user = userService.selectById(id);
        return  user;
    }



    /**
     * 编辑用户
     *
     * @param userVo
     * @return
     */
    @RequiresRoles("admin")
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid UserVo userVo) {
        List<LoginUser> list = userService.selectByLoginName2(userVo);
        if (list != null && !list.isEmpty()) {
            return renderError("登录名已存在!");
        }
        // 更新密码
        if (StringUtils.isNotBlank(userVo.getPassword())) {
            LoginUser user = userService.selectByIUserd(userVo.getId());
            String salt = user.getSalt();
            String pwd = passwordHash.toHex(userVo.getPassword(), salt);
            userVo.setPassword(pwd);
        }
        userService.updateByVo(userVo);
        return renderSuccess("修改成功！");
    }
}
