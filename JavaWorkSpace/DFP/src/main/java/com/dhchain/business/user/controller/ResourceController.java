package com.dhchain.business.user.controller;

import com.dhchain.business.user.service.IResourceService;

import com.dhchain.business.user.vo.Resource;
import com.dhchain.config.base.BaseController;
import com.dhchain.config.shiro.ShiroUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.Date;

/**
 * Created by zhenglb on 2017/8/26.
 */
@Controller
@RequestMapping("/resource")
public class ResourceController extends BaseController {
    @Autowired
    private IResourceService resourceService;
    /**
     * 菜单树
     *
     * @return
     */
    @PostMapping("/tree")
    @ResponseBody
    public Object tree() {
        ShiroUser shiroUser = getShiroUser();
        return resourceService.selectTree(shiroUser);
    }

    /**
     * 资源管理列表
     *
     * @return
     */
    @PostMapping("/treeGrid")
    @ResponseBody
    public Object treeGrid() {
        return resourceService.selectAll();
    }


    /**
     * 查询所有的菜单
     */
    @RequestMapping("/allTree")
    @ResponseBody
    public Object allMenu() {
        return resourceService.selectAllMenu();
    }


    /**
     * 查询所有的资源tree
     */
    @RequestMapping("/allTrees")
    @ResponseBody
    public Object allTree() {
        return resourceService.selectAllTree();
    }
    /**
     * 添加资源
     *
     * @param resource
     * @return
     */
    @RequestMapping("/add")
    @ResponseBody
    public Object add(@Valid Resource resource) {
        resource.setCreateTime(new Date());
        // 选择菜单时将openMode设置为null
        Integer type = resource.getResourceType();
        if (null != type && type == 0) {
            resource.setOpenMode(null);
        }
        boolean flag = resourceService.insert(resource);
        if(flag){
            return renderSuccess("添加成功！");
        }else{
            return renderSuccess("添加失败！");
        }

    }


    /**
     * 删除资源
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        boolean flag = resourceService.deleteById(id);
        if(flag){
            return renderSuccess("删除成功！");
        }else{
            return renderSuccess("删除失败！");
        }

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
        Resource resource = resourceService.selectById(id);
        return  resource;
    }


    /**
     * 编辑部门
     *
     * @param resource
     * @return
     */
    @RequestMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Resource resource) {
        boolean flag = resourceService.updateById(resource);
        if(flag){
            return renderSuccess("编辑成功！");
        }else{
            return renderSuccess("编辑失败！");
        }

    }
}
