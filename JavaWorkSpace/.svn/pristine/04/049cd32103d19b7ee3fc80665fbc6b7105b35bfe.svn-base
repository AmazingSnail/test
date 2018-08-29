package com.dhchain.business.attr.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.attr.service.AttrDefineService;
import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attr.service.FactoryService;
import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.attr.vo.Factory;
import com.dhchain.business.base.service.BaseService;
import com.dhchain.business.base.vo.Base;
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
 * Created by zhenglb on 2017-11-02.
 */
@Controller
@RequestMapping("/attrdefine")
public class AttrDefineController {
    @Autowired
    private AttrDefineService attrDefineService;
    @Autowired
    private BaseService baseService;
    @Autowired
    private AttrService attrService;
    @Autowired
    private FactoryService factoryService;
    @ResponseBody
    @RequestMapping(value = "select", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typeid = request.getParameter("typeid");
        String datatype2 = request.getParameter("datatype");
        String widgettype2 = request.getParameter("widgettype");
        String iscode = request.getParameter("iscode");
        String islocked = request.getParameter("islocked");
        String attrdefineno = request.getParameter("attrdefineno");
        String attrdefinename = request.getParameter("attrdefinename");
        AttrDefine attrDefine = new AttrDefine();
        attrDefine.setTypeid(Integer.parseInt(typeid));
        if(!datatype2.equals("")){
            attrDefine.setDatatype(Integer.parseInt(datatype2));
        }
        if(!widgettype2.equals("")){
            attrDefine.setWidgettype(Integer.parseInt(widgettype2));
        }
        if(!iscode.equals("")){
            attrDefine.setIscode(Integer.parseInt(iscode));
        }
        if(!islocked.equals("")){
            attrDefine.setIslocked(Integer.parseInt(islocked));
        }
        attrDefine.setAttrdefinename(attrdefinename);
        attrDefine.setAttrdefineno(attrdefineno);
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<AttrDefine> jslist =  attrDefineService.select(attrDefine);
        JSONArray jslst = new JSONArray();
        AttrDefine attrDefine1;
        if(jslist.size()>0 ){
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                attrDefine1 = jslist.get(i);
                re1.put("id",attrDefine1.getId());
                re1.put("attrdefineno",attrDefine1.getAttrdefineno());
                re1.put("attrdefinename",attrDefine1.getAttrdefinename());
                re1.put("databasetype",attrDefine1.getDatabasetype());
                int databaseid = attrDefine1.getDatabaseid();
                re1.put("databaseid",databaseid);
                Base base = baseService.selectById(databaseid);
                if(base!=null){
                    re1.put("database",base.getBasename());
                }else {
                    re1.put("database","");
                }
                int attrid = attrDefine1.getAttrid();
                re1.put("attrid",attrid);
                Attr attr = attrService.selectById(attrid);
                if(attr!=null){
                    re1.put("attr",attr.getAttrname());
                }else {
                    re1.put("attr","");
                }
                int factoryid = attrDefine1.getFactoryid();
                re1.put("factoryid",factoryid);
                Factory factory = factoryService.selectById(factoryid);
                if(factory!=null){
                    re1.put("factory",factory.getAttrname());
                }else{
                    re1.put("factory","");
                }
                String datatype = "";
                int datatypeid = attrDefine1.getDatatype();
                if(datatypeid==1){
                    datatype = "字符串";
                }else if(datatypeid==2){
                    datatype = "整形";
                }else if(datatypeid==3){
                    datatype = "浮点型";
                }else if(datatypeid==4){
                    datatype = "日期";
                }else if(datatypeid==5){
                    datatype = "日期时间";
                }
                re1.put("datatype",datatype);
                String widgettype = "";
                int widgettypeid = attrDefine1.getWidgettype();
                if(widgettypeid==1){
                    widgettype = "文本输入框";
                }else if(widgettypeid==2){
                    widgettype = "数字输入框";
                }else if(widgettypeid==5){
                    widgettype = "下拉选择框";
                }else if(widgettypeid==6){
                    widgettype = "复选框";
                }else if(widgettypeid==7){
                    widgettype = "勾选框";
                } else if(widgettypeid==8){
                    widgettype = "树";
                }
                re1.put("datelength",attrDefine1.getDatelength()==0?"":attrDefine1.getDatelength());
                re1.put("precision",attrDefine1.getPrecision()==0?"":attrDefine1.getPrecision());
                re1.put("widgettype",widgettype);
                re1.put("codelength",attrDefine1.getCodelength()==0?"":attrDefine1.getCodelength());
                re1.put("remark",attrDefine1.getRemark());
                re1.put("islocked",attrDefine1.getIslocked()==0?"否":"是");
                re1.put("iscode",attrDefine1.getIscode()==0?"否":"是");
                re1.put("isrequired",attrDefine1.getIsrequired()==0?"否":"是");
                re1.put("inputman",attrDefine1.getInputman());
                re1.put("inputdate",attrDefine1.getInputdate()==null?"":sdf.format(attrDefine1.getInputdate()));
                re1.put("modifyman",attrDefine1.getModifyman());
                re1.put("modifydate",attrDefine1.getModifydate()==null?"":sdf.format(attrDefine1.getModifydate()));
                jslst.add(re1);
            }
            re.put("rows",jslst);
            re.put("total",jslst.size());
        }else{
            re.put("rows","");
            re.put("total",0);
        }
        return re;
    }


    @ResponseBody
    @RequestMapping(value = "selectById", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectById(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        AttrDefine attrDefine1 = attrDefineService.selectById(id);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        JSONObject re1 = new JSONObject();
        re1.put("id",attrDefine1.getId());
        re1.put("attrdefineno",attrDefine1.getAttrdefineno());
        re1.put("attrdefinename",attrDefine1.getAttrdefinename());
        int databaseid = attrDefine1.getDatabaseid();
        re1.put("databaseid",databaseid);
        Base base = baseService.selectById(databaseid);
        if(base!=null){
            re1.put("database",base.getBasename());
        }else{
            re1.put("database","");
        }
        int factoryid = attrDefine1.getFactoryid();
        re1.put("factoryid",factoryid);
        Factory factory = factoryService.selectById(factoryid);
        if(factory!=null){
            re1.put("factory",factory.getAttrname());
        }else{
            re1.put("factory","");
        }
        re1.put("databasetype",attrDefine1.getDatabasetype());
        int attrid = attrDefine1.getAttrid();
        re1.put("attrid",attrid);
        Attr attr = attrService.selectById(attrid);
        if(attr!=null){
            re1.put("attr",attr.getAttrname());
        }else {
            re1.put("attr","");
        }


        re1.put("datatype",attrDefine1.getDatatype());

        re1.put("datelength",attrDefine1.getDatelength()==0?"":attrDefine1.getDatelength());
        re1.put("precision",attrDefine1.getPrecision()==0?"":attrDefine1.getPrecision());
        re1.put("widgettype",attrDefine1.getWidgettype());
        re1.put("codelength",attrDefine1.getCodelength());
        re1.put("remark",attrDefine1.getRemark());
        re1.put("islocked",attrDefine1.getIslocked()==0?"否":"是");
        re1.put("iscode",attrDefine1.getIscode()==0?"否":"是");
        re1.put("isrequired",attrDefine1.getIsrequired()==0?"否":"是");
        re1.put("inputman",attrDefine1.getInputman());
        re1.put("inputdate",attrDefine1.getInputdate()==null?"":sdf.format(attrDefine1.getInputdate()));
        re1.put("modifyman",attrDefine1.getModifyman());
        re1.put("modifydate",attrDefine1.getModifydate()==null?"":sdf.format(attrDefine1.getModifydate()));



        return re1;
    }
    @ResponseBody
    @RequestMapping(value = "checkno", method = {RequestMethod.GET, RequestMethod.POST})
    public Map checkno(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String attrdefineno = request.getParameter("attrdefineno");
        boolean flag = attrDefineService.isexistAttrdefineno(attrdefineno);
        Map json = new HashMap();

        json.put("exist",flag);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "add", method = {RequestMethod.GET, RequestMethod.POST})
    public Map add(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Date date =new Date();
        String typeid = request.getParameter("typeid");
        String attrdefineno = request.getParameter("attrdefineno");
        String attrdefinename = request.getParameter("attrdefinename");
        String databaseid = request.getParameter("databaseid");
        String attrid = request.getParameter("attrid");
        String datatype = request.getParameter("datatype");
        String datelength = request.getParameter("datelength");
        String precision = request.getParameter("precision");
        String widgettype = request.getParameter("widgettype");
        String iscode = request.getParameter("iscode");
        String codelength = request.getParameter("codelength");
        String isrequired = request.getParameter("isrequired");
        String islocked = request.getParameter("islocked");
        String remark = request.getParameter("remark");
        String inputman = request.getParameter("inputman");
        String databasetype = request.getParameter("databasetype");
        String factoryid = request.getParameter("factoryid");
        AttrDefine attrDefine = new AttrDefine();
        attrDefine.setTypeid(Integer.parseInt(typeid));
        attrDefine.setAttrdefineno(attrdefineno);
        attrDefine.setAttrdefinename(attrdefinename);
        if(databaseid!=null&&!databaseid.equals("")){
            attrDefine.setDatabaseid(Integer.parseInt(databaseid));
        }
        if(attrid!=null&&!attrid.equals("")){
            attrDefine.setAttrid(Integer.parseInt(attrid));
        }
        if(factoryid!=null&&!factoryid.equals("")){
            attrDefine.setFactoryid(Integer.parseInt(factoryid));
        }
        if(databasetype!=null&&!databasetype.equals("")){
            attrDefine.setDatabasetype(Integer.parseInt(databasetype));
        }
        if(!datatype.equals("")){
            attrDefine.setDatatype(Integer.parseInt(datatype));
        }
        if(!datelength.equals("")){
            attrDefine.setDatelength(Integer.parseInt(datelength));
        }
        if(!precision.equals("")){
            attrDefine.setPrecision(Integer.parseInt(precision));
        }
        if(!widgettype.equals("")){
            attrDefine.setWidgettype(Integer.parseInt(widgettype));
        }
        attrDefine.setIscode(iscode.equals("是")?1:0);
        if(!codelength.equals("")){
            attrDefine.setCodelength(Integer.parseInt(codelength));
        }

        attrDefine.setIslocked(islocked.equals("是")?1:0);
        attrDefine.setIsrequired(isrequired.equals("是")?1:0);
        attrDefine.setRemark(remark);
        attrDefine.setInputdate(date);
        attrDefine.setInputman(inputman);
        attrDefine.setIsdelete(0);
        int n = attrDefineService.add(attrDefine);
        Map json = new HashMap();

        json.put("num",n);
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "edit", method = {RequestMethod.GET, RequestMethod.POST})
    public Map edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String typeid = request.getParameter("typeid");
        String attrdefineno = request.getParameter("attrdefineno");
        String attrdefinename = request.getParameter("attrdefinename");
        String databaseid = request.getParameter("databaseid");
        String attrid = request.getParameter("attrid");
        String factoryid = request.getParameter("factoryid");
        String databasetype = request.getParameter("databasetype");
        String datatype = request.getParameter("datatype");
        String datelength = request.getParameter("datelength");
        String precision = request.getParameter("precision");
        String widgettype = request.getParameter("widgettype");
        String iscode = request.getParameter("iscode");
        String codelength = request.getParameter("codelength");
        String islocked = request.getParameter("islocked");
        String isrequired = request.getParameter("isrequired");
        String remark = request.getParameter("remark");
        String inputman = request.getParameter("inputman");
        Date date =new Date();
        AttrDefine attrDefine =attrDefineService.selectById(id);
        attrDefine.setTypeid(Integer.parseInt(typeid));
        attrDefine.setAttrdefineno(attrdefineno);
        attrDefine.setAttrdefinename(attrdefinename);
        attrDefine.setDatabaseid(Integer.parseInt(databaseid));
        attrDefine.setFactoryid(Integer.parseInt(factoryid));
        attrDefine.setDatabasetype(Integer.parseInt(databasetype));
        attrDefine.setIslocked(islocked.equals("是")?1:0);
        attrDefine.setIscode(iscode.equals("是")?1:0);
        attrDefine.setIsrequired(isrequired.equals("是")?1:0);
        attrDefine.setAttrid(Integer.parseInt(attrid));
        if(!datatype.equals("")){
            attrDefine.setDatatype(Integer.parseInt(datatype));
        }
        if(!datelength.equals("")){
            attrDefine.setDatelength(Integer.parseInt(datelength));
        }
        if(!precision.equals("")){
            attrDefine.setPrecision(Integer.parseInt(precision));
        }
        if(!widgettype.equals("")){
            attrDefine.setWidgettype(Integer.parseInt(widgettype));
        }
        if(!codelength.equals("")){
            attrDefine.setCodelength(Integer.parseInt(codelength));
        }
        attrDefine.setRemark(remark);
        attrDefine.setModifyman(inputman);
        attrDefine.setModifydate(date);
        int n = attrDefineService.edit(attrDefine);
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
        Map json = new HashMap();
        boolean flag = true;


        for (String id:idArr){
            if(!id.equals("")){
                AttrDefine attrDefine = attrDefineService.selectById(id);
                boolean flag2 = attrDefineService.isdistribute(attrDefine.getId());
                if(!flag2){
                    flag = false;
                }
            }

        }
        if(flag){
            int n = attrDefineService.delete(idArr);
            json.put("num",n);
            json.put("message","删除成功");
        }else{
            json.put("num",0);
            json.put("message","该属性已被分配，无法删除");
        }


        return json;
    }


}
