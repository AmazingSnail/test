package com.dhchain.business.attr.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attr.vo.Attr;
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
 * Created by zhenglb on 2017-10-10.
 */
@Controller
@RequestMapping("/attr")
public class AttrController extends com.dhchain.config.base.BaseController{
    @Autowired
    private AttrService attrService;
    /**
     * 查询所有的菜单
     */
    @RequestMapping("/Tree")
    @ResponseBody
    public Object allMenu(HttpServletRequest request)  {

        return attrService.selectTree();
    }
    @ResponseBody
    @RequestMapping(value = "Query", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String attrname = request.getParameter("attrname");
        String attrno = request.getParameter("attrno");
        Attr attr = new Attr();
        attr.setAttrname(attrname);
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Attr> jslist =  attrService.query(attr);

        JSONArray jslst = new JSONArray();
        Attr attr1;
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
                re1.put("islocked",attr1.getIslocked()==0?"否":"是");
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
            List<Attr> jslist2 = attrService.selectByFlag(flag);
            Attr attr2;
            if(jslist2.size()>0) {
                for (int i=0;i<jslist2.size();i++){
                    JSONObject re1 = new JSONObject();
                    attr2 = jslist2.get(i);
                    re1.put("id",attr2.getId());
                    re1.put("attrname",attr2.getAttrname());
                    re1.put("attrno",attr2.getAttrno());
                    re1.put("remark",attr2.getRemark());
                    re1.put("iscode",attr2.getIscode()==0?"否":"是");
                    re1.put("isrelate",attr2.getIsrelate()==0?"否":"是");
                    re1.put("fid",attr2.getFid());
                    re1.put("islocked",attr2.getIslocked()==0?"否":"是");
                    re1.put("inputman",attr2.getInputman());
                    re1.put("inputdate",attr2.getInputdate()==null?"":sdf.format(attr2.getInputdate()));
                    re1.put("modifyman",attr2.getModifyman());
                    re1.put("modifydate",attr2.getModifydate()==null?"":sdf.format(attr2.getModifydate()));
                    if(attr2.getId()!=attr1.getId()) {
                        re1.put("_parentId", attr2.getFid());
                    }
                    jslst.add(re1);
                }
                re.put("rows",jslst);
                re.put("total",jslst.size());
            }
        }

        return re;
    }

    @ResponseBody
    @RequestMapping(value = "selectAttr", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON selectAttr(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        List<Attr> jslist = attrService.selectType();
        JSONArray jslst = new JSONArray();

        Attr attr1;
        JSONObject re2 = new JSONObject();
        re2.put("attrid","");
        re2.put("attrname","请选择主数据类型");
        jslst.add(re2);
        if(jslist.size()>0) {

            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                attr1 = (Attr)jslist.get(i);
                re1.put("attrid",attr1.getId());
                re1.put("attrname",attr1.getAttrname());

                jslst.add(re1);
            }
        }

        return jslst;
    }



    @ResponseBody
    @RequestMapping(value = "selectNameAndNo", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectNameAndNo(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String attrname = request.getParameter("attrname");
        String attrno = request.getParameter("attrno");
        Attr attr = new Attr();
        attr.setAttrname(attrname);
        attr.setAttrno(attrno);
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Attr> jslist =  attrService.query(attr);

        JSONArray jslst = new JSONArray();
        Attr attr1;
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
                re1.put("islocked",attr1.getIslocked()==0?"否":"是");
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
            List<Attr> jslist2 = attrService.selectByFlag(flag);
            if(jslist2.size()>0) {
                for (int i=0;i<jslist2.size();i++){
                    JSONObject re1 = new JSONObject();
                    attr1 = jslist2.get(i);
                    re1.put("id",attr1.getId());
                    re1.put("attrname",attr1.getAttrname());
                    re1.put("attrno",attr1.getAttrno());
                    re1.put("remark",attr1.getRemark());
                    re1.put("iscode",attr1.getIscode()==0?"否":"是");
                    re1.put("isrelate",attr1.getIsrelate()==0?"否":"是");
                    if(jslist.get(0).getId()==attr1.getId()){
                        re1.put("fid",0);
                    }else{
                        re1.put("fid",attr1.getFid());
                    }

                    re1.put("islocked",attr1.getIslocked()==0?"否":"是");
                    re1.put("inputman",attr1.getInputman());
                    re1.put("inputdate",attr1.getInputdate()==null?"":sdf.format(attr1.getInputdate()));
                    re1.put("modifyman",attr1.getModifyman());
                    re1.put("modifydate",attr1.getModifydate()==null?"":sdf.format(attr1.getModifydate()));
//                    if(attr.getId()!=jslist.get(0).getId()) {
//                        re1.put("_parentId", attr1.getFid());
//                    }
                    jslst.add(re1);
                }
                re.put("rows",jslst);
                re.put("total",jslst.size());
            }
        }

        return re;
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
        Attr attr = new Attr();
        Attr parent ;
        attr.setFid(Integer.parseInt(fid));
        attr.setAttrno(attrno);
        attr.setAttrname(attrname);
        attr.setIsrelate(Integer.parseInt(isrelate));
        attr.setIscode(Integer.parseInt(iscode));
        attr.setInputdate(date);
        attr.setInputman(inputman);
        attr.setRemark(remark);
        JSONObject re = new JSONObject();
        int n = attrService.add(attr);
        int newid = attrService.selectNewId();
        Attr attr1 = attrService.selectById(newid);
        if(fid.equals("0")){
            attr1.setFlag(";"+attr1.getId()+"-"+1);

        }else {
            parent = attrService.selectById(Integer.parseInt(fid));
            attr1.setFlag(parent.getFlag()+"-"+attr1.getId());

        }
        attrService.updateById(attr1);
        re.put("num",1);
        return re;
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
        Attr attr =  attrService.selectById(id);
        JSONObject re = new JSONObject();
        re.put("attrname",attr.getAttrname());
        re.put("attrno",attr.getAttrno());
        re.put("fid",attr.getFid());
        re.put("remark",attr.getRemark());
        re.put("iscode",attr.getIscode());
        re.put("isrelate",attr.getIsrelate());
        return  re;
    }


    @RequestMapping("/edit")
    @ResponseBody
    public JSONObject edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        Attr attr = attrService.selectById(Integer.parseInt(id));
        boolean status = attrService.selectChild(attr.getId());
        String attrno = request.getParameter("attrno");
        String attrname = request.getParameter("attrname");
        String iscode = request.getParameter("iscode");
        String isrelate = request.getParameter("isrelate");
        String fid = request.getParameter("fid");
        String modifyman = request.getParameter("modifyman");
        String remark = request.getParameter("remark");
        Date date = new Date();
        Attr parent ;
        String msg = "";
        int num;
        if(status){
            msg = "有子节点无法改变！";
            num = 0;
        }else{
            attr.setFid(Integer.parseInt(fid));
            attr.setAttrno(attrno);
            attr.setAttrname(attrname);
            attr.setIsrelate(Integer.parseInt(isrelate));
            attr.setIscode(Integer.parseInt(iscode));
            attr.setModifydate(date);
            attr.setModifyman(modifyman);
            attr.setRemark(remark);
            if(fid.equals("0")){
                attr.setFlag(";"+attr.getId()+"-"+1);

            }else {
                parent = attrService.selectById(Integer.parseInt(fid));
                attr.setFlag(parent.getFlag()+"-"+attr.getId());

            }
            boolean flag = attrService.updateById(attr);
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
        boolean status = attrService.selectChild(id);
        JSONObject re = new JSONObject();
        if(status){
            re.put("success",false);

        }else{
            boolean flag = attrService.deleteById(id);
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



}
