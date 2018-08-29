package com.dhchain.business.type.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.type.service.TypeKindService;
import com.dhchain.business.type.vo.Type;
import com.dhchain.business.type.vo.TypeKind;
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
 * Created by zhenglb on 2017-10-05.
 */
@Controller
@RequestMapping("/typekind")
public class TypeKindController {
    @Autowired
    private TypeKindService typeKindService;
    @ResponseBody
    @RequestMapping(value = "selectType", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON selectType(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        List<Type> jslist = typeKindService.selectType();
        JSONArray jslst = new JSONArray();

        Type material1;
        JSONObject re2 = new JSONObject();
        re2.put("typeid","");
        re2.put("typename","请选择主数据类型");
        jslst.add(re2);
        if(jslist.size()>0) {

            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                material1 = (Type)jslist.get(i);
                re1.put("typeid",material1.getId());
                re1.put("typename",material1.getTypename());

                jslst.add(re1);
            }
        }

        return jslst;
    }


    @ResponseBody
    @RequestMapping(value = "selectByTypeid", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectByTypeid(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typeid = request.getParameter("typeid");
        JSONObject re = new JSONObject();
        JSONArray jslst2 = new JSONArray();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(typeid.equals("")){
            re.put("rows",jslst2);
            re.put("total",0);
            return  re;
        }else{
            List<TypeKind> jslist =  typeKindService.selectByTypeid(Integer.parseInt(typeid));
            JSONArray jslst = new JSONArray();
            TypeKind typeKind;
            if(jslist.size()>0) {
                for (int i=0;i<jslist.size();i++){
                    JSONObject re1 = new JSONObject();
                    typeKind = (TypeKind)jslist.get(i);
                    re1.put("id",typeKind.getId());
                    re1.put("typeid",typeKind.getTypeid());
                    re1.put("kindno",typeKind.getKindno());
                    re1.put("kindnum",typeKind.getKindnum());
                    re1.put("remark",typeKind.getRemark());
//                re1.put("islocked",material1.getIslocked());
                    re1.put("inputman",typeKind.getInputman());
                    re1.put("inputdate",typeKind.getInputdate()==null?"":sdf.format(typeKind.getInputdate()));
                    re1.put("modifyman",typeKind.getModifyman());
                    re1.put("modifydate",typeKind.getModifydate()==null?"":sdf.format(typeKind.getModifydate()));
                    jslst.add(re1);
                }
                re.put("rows",jslst);
                re.put("total",jslst.size());
                return re;
            }else{
                re.put("rows",jslst2);
                re.put("total",0);
                return  re;
            }

        }

    }


    @ResponseBody
    @RequestMapping(value = "add", method = {RequestMethod.GET, RequestMethod.POST})
    public Map add(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Date date =new Date();
        String typeid = request.getParameter("typeid");
        String kindno = request.getParameter("kindno");
        String kindnum = request.getParameter("kindnum");
        String inputman = request.getParameter("inputman");
        String remark = request.getParameter("remark");
        TypeKind typeKind = new TypeKind();
        typeKind.setTypeid(Integer.parseInt(typeid));
        typeKind.setKindno(Integer.parseInt(kindno));
        typeKind.setKindnum(Integer.parseInt(kindnum));
        typeKind.setRemark(remark);
        typeKind.setInputdate(date);
        typeKind.setInputman(inputman);
        typeKind.setIsdelete(0);
        int n = typeKindService.add(typeKind);
        Map json = new HashMap();

        json.put("num",n);
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "edit", method = {RequestMethod.GET, RequestMethod.POST})
    public Map edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String kindno = request.getParameter("kindno");
        String kindnum = request.getParameter("kindnum");
        String remark = request.getParameter("remark");
        String modifyman = request.getParameter("modifyman");
        Date date =new Date();
        TypeKind typeKind = new TypeKind();
        typeKind.setId(Integer.parseInt(id));
        typeKind.setKindnum(Integer.parseInt(kindnum));
        typeKind.setKindno(Integer.parseInt(kindno));
        typeKind.setRemark(remark);
        typeKind.setModifyman(modifyman);
        typeKind.setModifydate(date);
        int n = typeKindService.edit(typeKind);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "delete", method = {RequestMethod.GET, RequestMethod.POST})
    public Map delete(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("ids");
        String[] idArr = ids.split(",");
        int n = typeKindService.deleteTypeKind(idArr);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "selectById", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectById(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        TypeKind typeKind = typeKindService.selectById(id);
        JSONObject re1 = new JSONObject();
        re1.put("id",typeKind.getId());
        re1.put("kindno",typeKind.getKindno());
        re1.put("kindnum",typeKind.getKindnum());
        re1.put("remark",typeKind.getRemark());
        return re1;
    }

    @ResponseBody
    @RequestMapping(value="/selectKind",method={RequestMethod.GET,RequestMethod.POST})
    public JSON selectKind(HttpServletRequest request) throws UnsupportedEncodingException {
        String typeid = request.getParameter("typeid");
        List jslist = typeKindService.selectByTypeid(Integer.parseInt(typeid));

        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        TypeKind typeKind;
        //System.out.println(plant);
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {

                Map re = new HashMap();
                typeKind = (TypeKind) jslist.get(i);

                re.put("id", typeKind.getId());
                re.put("kindno", typeKind.getKindno());

                jslst.add(re);

            }
        }

        return jslst;
    }
}
