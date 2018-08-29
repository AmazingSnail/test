package com.dhchain.business.user.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.user.service.IOrganizationService;
import com.dhchain.business.user.vo.Organization;
import com.dhchain.config.base.BaseController;
import com.dhchain.config.result.Tree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by zhenglb on 2017/8/25.
 */
@Controller
@RequestMapping("/organization")
public class OrganizationController extends BaseController {
    @Autowired
    private IOrganizationService organizationService;
    /**
     * 部门
     *
     * @return
     */
    @PostMapping(value = "/treeGrid")
    @ResponseBody
    public Object treeGrid() {
        List<Organization>  list = organizationService.selectTree();
        JSONArray jslst = new JSONArray();
        Organization organization;
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        if(list.size()>0){
            for(int i = 0;i<list.size();i++) {
                organization = list.get(i);
                Map re = new HashMap();
                re.put("id",organization.getId());
                re.put("name",organization.getName());
                re.put("address",organization.getAddress());
                re.put("code",organization.getCode());
                re.put("seq",organization.getSeq());
                re.put("iconCls",organization.getIcon());
                re.put("createTime",sdf.format(organization.getCreateTime()));
                re.put("pid",organization.getPid());
                jslst.add(re);
            }
        }
        return jslst;
    }

    /**
     * 部门资源数
     *
     * @return
     */
    @PostMapping(value = "/tree")
    @ResponseBody
    public Object tree() {
        List<Organization> organizationList = organizationService.selectTree();
                List<Tree> trees = new ArrayList<Tree>();
        if (organizationList != null) {
            for (Organization organization : organizationList) {
                Tree tree = new Tree();
                tree.setId(organization.getId());
                tree.setText(organization.getName());
                tree.setIconCls(organization.getIcon());
                tree.setPid(organization.getPid());
                trees.add(tree);
            }
        }
        return trees;
    }


    /**
     * 添加部门
     *
     * @param organization
     * @return
     */
    @RequestMapping("/add")
    @ResponseBody
    public Object add(@Valid Organization organization) {
        organization.setCreateTime(new Date());
        boolean flag = organizationService.insert(organization);
        if(flag){
            return renderSuccess("添加成功！");
        }else{
            return renderSuccess("添加失败！");
        }


    }


    /**
     * 删除部门
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        boolean flag = organizationService.deleteById(id);
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
        Organization organization = organizationService.selectById(id);
        return  organization;
    }


    /**
     * 编辑部门
     *
     * @param organization
     * @return
     */
    @RequestMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Organization organization) {
        boolean flag = organizationService.updateById(organization);
        if(flag){
            return renderSuccess("编辑成功！");
        }else{
            return renderSuccess("编辑失败！");
        }

    }
}
