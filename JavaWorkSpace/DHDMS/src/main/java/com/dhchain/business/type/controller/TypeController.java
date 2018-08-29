package com.dhchain.business.type.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.type.service.TypeService;
import com.dhchain.business.type.vo.Type;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2017-09-28.
 */
@Controller
@RequestMapping("/type")
public class TypeController {
    @Autowired
    private TypeService typeService;
    @Autowired
    private AttrService attrService;
    @ResponseBody
    @RequestMapping(value = "select", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String type = request.getParameter("typeno");
        String name = request.getParameter("typename");
        Type material = new Type();
        material.setTypeno(type);
        material.setTypename(name);
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Type> jslist =  typeService.select(type,name);
        JSONArray jslst = new JSONArray();
        Type material1;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                material1 = (Type)jslist.get(i);
                re1.put("id",material1.getId());
                re1.put("typeno",material1.getTypeno());
                re1.put("typename",material1.getTypename());
                re1.put("islocked",material1.getIslocked()==0?"否":"是");
//                re1.put("islocked",material1.getIslocked());
                re1.put("inputman",material1.getInputman());
                re1.put("inputdate",material1.getInputdate()==null?"":sdf.format(material1.getInputdate()));
                re1.put("modifyman",material1.getModifyman());
                re1.put("modifydate",material1.getModifydate()==null?"":sdf.format(material1.getModifydate()));
                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }


    @ResponseBody
    @RequestMapping(value = "query", method = {RequestMethod.GET, RequestMethod.POST})
    public Object query(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String type = request.getParameter("typeno");
        String name = request.getParameter("typename");
        Type material = new Type();
        material.setTypeno(type);
        material.setTypename(name);
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Type> jslist =  typeService.select(type,name);
        JSONArray jslst = new JSONArray();
        Type material1;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                material1 = (Type)jslist.get(i);
                re1.put("id",material1.getId());
                re1.put("typeno",material1.getTypeno());
                re1.put("typename",material1.getTypename());
                re1.put("islocked",material1.getIslocked()==0?"否":"是");
//                re1.put("islocked",material1.getIslocked());
                re1.put("inputman",material1.getInputman());
                re1.put("inputdate",material1.getInputdate()==null?"":sdf.format(material1.getInputdate()));
                re1.put("modifyman",material1.getModifyman());
                re1.put("modifydate",material1.getModifydate()==null?"":sdf.format(material1.getModifydate()));
                jslst.add(re1);
            }
        }

        return jslst;
    }

    @ResponseBody
    @RequestMapping(value = "selectById", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectById(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        Type material = typeService.selectById(id);
        JSONObject re1 = new JSONObject();
        re1.put("id",material.getId());
        re1.put("typeno",material.getTypeno());
        re1.put("typename",material.getTypename());
        re1.put("islocked",material.getIslocked());



        return re1;
    }

    @ResponseBody
    @RequestMapping(value = "delete", method = {RequestMethod.GET, RequestMethod.POST})
    public Map delete(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("ids");
        String[] idArr = ids.split(",");
        int n = typeService.delete(idArr);
        Map json = new HashMap();
        json.put("num",n);

        return json;
    }

    @ResponseBody
    @RequestMapping(value = "add", method = {RequestMethod.GET, RequestMethod.POST})
    public Map add(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Date date =new Date();
        String typeno = request.getParameter("typeno");
        String typename = request.getParameter("typename");
        String islocked = request.getParameter("islocked");
        String inputman = request.getParameter("inputman");
        Type material = new Type();
        material.setTypename(typename);
        material.setTypeno(typeno);
        material.setIslocked(islocked.equals("是")?1:0);
        material.setInputdate(date);
        material.setInputman(inputman);
        material.setIsdelete(0);
        int n = typeService.add(material);
        if(n>0){
            Attr attr = new Attr();
            attr.setAttrname(typename);
            attr.setAttrno(typeno);
            attr.setInputman(inputman);
            attr.setInputdate(date);
            attr.setFid(0);
            attr.setIscode(0);
            attr.setIsrelate(0);
            attr.setIslocked(0);
            int l = attrService.add(attr);
            if(l>0){
                int m = attrService.selectNewId();
                Attr attr1 = attrService.selectById(m);
                attr1.setFlag(";"+attr1.getId()+"-"+1);
                attrService.updateById(attr1);
            }
        }
        Map json = new HashMap();

        json.put("num",n);
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "edit", method = {RequestMethod.GET, RequestMethod.POST})
    public Map edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String typeno = request.getParameter("typeno");
        String typename = request.getParameter("typename");
        String islocked = request.getParameter("islocked");
        String modifyman = request.getParameter("modifyman");
        Date date =new Date();
        Type material = new Type();
        material.setId(Integer.parseInt(id));
        material.setTypename(typename);
        material.setTypeno(typeno);
        material.setModifydate(date);
        material.setModifyman(modifyman);
        material.setIslocked(islocked.equals("是")?1:0);
        int n = typeService.edit(material);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }


}
