package com.dhchain.business.attr.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attr.service.FactoryService;
import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.attr.vo.Factory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhenglb on 2017-11-22.
 */
@Controller
@RequestMapping("/factory")
public class FactoryController    extends com.dhchain.config.base.BaseController{
    @Autowired
    private FactoryService factoryService;
    @ResponseBody
    @RequestMapping(value = "Query", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String attrname = request.getParameter("attrname");
        String attrno = request.getParameter("attrno");
        Factory factory = new Factory();
        factory.setAttrname(attrname);
        factory.setAttrno(attrno);
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Factory> jslist =  factoryService.query(factory);

        JSONArray jslst = new JSONArray();
        Factory attr1;
        if(jslist.size()>1) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                attr1 = jslist.get(i);
                re1.put("id",attr1.getId());
                re1.put("attrname",attr1.getAttrname());
                re1.put("attrno",attr1.getAttrno());
                re1.put("remark",attr1.getRemark());
                re1.put("iscode",attr1.getIscode()==0?"否":"是");
                re1.put("isrelate",attr1.getIsrelate()==0?"否":"是");
                re1.put("fid",attr1.getFid());
                re1.put("inputman",attr1.getInputman());
                re1.put("inputdate",attr1.getInputdate()==null?"":sdf.format(attr1.getInputdate()));
                re1.put("modifyman",attr1.getModifyman());
                re1.put("modifydate",attr1.getModifydate()==null?"":sdf.format(attr1.getModifydate()));
                if(attr1.getFid()!=0) {
                    re1.put("_parentId", attr1.getFid());
                }
                jslst.add(re1);
            }
            re.put("rows",jslst);
            re.put("total",jslst.size());
        }else if(jslist.size()==0){
            re.put("rows",jslst);
            re.put("total",0);
        }else{
            attr1 = jslist.get(0);
            String flag = attr1.getFlag();
            List<Factory> jslist2 = factoryService.selectByFlag(flag);
            Factory factory1;
            if(jslist2.size()>0) {
                for (int i=0;i<jslist2.size();i++){
                    JSONObject re1 = new JSONObject();
                    factory1 = jslist2.get(i);
                    re1.put("id",factory1.getId());
                    re1.put("attrname",factory1.getAttrname());
                    re1.put("attrno",factory1.getAttrno());
                    re1.put("remark",factory1.getRemark());
                    re1.put("iscode",factory1.getIscode()==0?"否":"是");
                    re1.put("isrelate",factory1.getIsrelate()==0?"否":"是");
                    re1.put("fid",factory1.getFid());
                    re1.put("inputman",factory1.getInputman());
                    re1.put("inputdate",factory1.getInputdate()==null?"":sdf.format(factory1.getInputdate()));
                    re1.put("modifyman",factory1.getModifyman());
                    re1.put("modifydate",factory1.getModifydate()==null?"":sdf.format(factory1.getModifydate()));
                    if(factory1.getId()!=attr1.getId()) {
                        re1.put("_parentId", factory1.getFid());
                    }
                    jslst.add(re1);
                }
                re.put("rows",jslst);
                re.put("total",jslst.size());
            }
        }

        return re;
    }
    /**
     * 查询所有的菜单
     */
    @RequestMapping("/Tree")
    @ResponseBody
    public Object allMenu(HttpServletRequest request) {

        return factoryService.selectTree();
    }


    @RequestMapping("/add")
    @ResponseBody
    public JSONObject add(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String attrno = request.getParameter("attrno");
        String attrname = request.getParameter("attrname");
        String iscode = request.getParameter("iscode");
        String isrelate = request.getParameter("isrelate");
        String fid = request.getParameter("fid");
        String inputman = request.getParameter("inputman");
        String remark = request.getParameter("remark");
        Date date = new Date();
        Factory factory = new Factory();
        Factory parent ;
        factory.setFid(Integer.parseInt(fid));
        factory.setAttrno(attrno);
        factory.setAttrname(attrname);
        factory.setIsrelate(Integer.parseInt(isrelate));
        factory.setIscode(Integer.parseInt(iscode));
        factory.setInputdate(date);
        factory.setInputman(inputman);
        factory.setRemark(remark);
        JSONObject re = new JSONObject();
        int n = factoryService.add(factory);
        int newid = factoryService.selectNewId();
        Factory factory1 = factoryService.selectById(newid);
        if(fid.equals("0")){
            factory1.setFlag(";"+factory1.getId()+"-"+1);

        }else {
            parent = factoryService.selectById(Integer.parseInt(fid));
            factory1.setFlag(parent.getFlag()+"-"+factory1.getId());

        }
        factoryService.updateById(factory1);
        re.put("num",1);
        return re;
    }


    @RequestMapping("/edit")
    @ResponseBody
    public JSONObject edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        Factory factory = factoryService.selectById(Integer.parseInt(id));
        boolean status = factoryService.selectChild(factory.getId());
        String attrno = request.getParameter("attrno");
        String attrname = request.getParameter("attrname");
        String iscode = request.getParameter("iscode");
        String isrelate = request.getParameter("isrelate");
        String fid = request.getParameter("fid");
        String modifyman = request.getParameter("modifyman");
        String remark = request.getParameter("remark");
        Date date = new Date();
        Factory parent ;
        String msg = "";
        int num;
        if(status){
            msg = "有子节点无法改变！";
            num = 0;
        }else{
            factory.setFid(Integer.parseInt(fid));
            factory.setAttrno(attrno);
            factory.setAttrname(attrname);
            factory.setIsrelate(Integer.parseInt(isrelate));
            factory.setIscode(Integer.parseInt(iscode));
            factory.setModifydate(date);
            factory.setModifyman(modifyman);
            factory.setRemark(remark);
            if(fid.equals("0")){
                factory.setFlag(";"+factory.getId()+"-"+1);

            }else {
                parent = factoryService.selectById(Integer.parseInt(fid));
                factory.setFlag(parent.getFlag()+"-"+factory.getId());

            }
            boolean flag = factoryService.updateById(factory);
            if(flag){
                msg = "编辑成功！";
                num = 1;
            }else{
                msg = "编辑失败！";
                num = 0;
            }
        }
        JSONObject re = new JSONObject();
        re.put("msg",msg);
        re.put("num",num);
        return re;
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public JSONObject delete(int id) {
        boolean status = factoryService.selectChild(id);
        JSONObject re = new JSONObject();
        if(status){
            re.put("success",false);

        }else{
            boolean flag = factoryService.deleteById(id);
            if(flag){
                re.put("success",true);
                re.put("message","删除成功！");
            }else{
                re.put("success",false);
                re.put("message","删除失败！");
            }
        }

        return  re;
    }


    /**
     * 根据id查
     *
     * @param id
     * @return
     */
    @RequestMapping("/selectById")
    @ResponseBody
    public JSONObject selectById(int id) {
        Factory factory =  factoryService.selectById(id);
        JSONObject re = new JSONObject();
        re.put("attrname",factory.getAttrname());
        re.put("attrno",factory.getAttrno());
        re.put("fid",factory.getFid());
        re.put("remark",factory.getRemark());
        re.put("iscode",factory.getIscode());
        re.put("isrelate",factory.getIsrelate());
        return  re;
    }

}
