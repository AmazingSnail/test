package com.dhchain.business.exp.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.attr.service.AttrDefineService;
import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.attr.vo.ViewAttr;
import com.dhchain.business.base.service.BaseService;
import com.dhchain.business.base.vo.Base;
import com.dhchain.business.exp.service.ViewService;
import com.dhchain.business.exp.vo.ExptypeView;
import com.dhchain.business.exp.vo.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by zhenglb on 2017-11-03.
 */
@Controller
@RequestMapping("/view")
public class ViewController {
    @Autowired
    private ViewService viewService;
    @Autowired
    private AttrDefineService attrDefineService;
    @Autowired
    private BaseService baseService;
    @Autowired
    private AttrService attrService;
    @ResponseBody
    @RequestMapping(value = "select", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String viewcode = request.getParameter("viewcode");
        String viewname = request.getParameter("viewname");
//        String exptypeid = request.getParameter("exptypeid");
        String typeid = request.getParameter("typeid");
        View view = new View();
        view.setViewcode(viewcode);
        view.setViewname(viewname);
//        view.setExptypeid(Integer.parseInt(exptypeid));
        view.setTypeid(Integer.parseInt(typeid));
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<View> jslist =  viewService.select(view);
        JSONArray jslst = new JSONArray();
        View view1;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                view1 = (View)jslist.get(i);
                re1.put("id",view1.getId());
                re1.put("viewcode",view1.getViewcode());
                re1.put("viewname",view1.getViewname());
                re1.put("islocked",view1.getIslocked()==0?"否":"是");
                re1.put("inputman",view1.getInputman());
                re1.put("inputdate",view1.getInputdate()==null?"":sdf.format(view1.getInputdate()));
                re1.put("modifyman",view1.getModifyman());
                re1.put("modifydate",view1.getModifydate()==null?"":sdf.format(view1.getModifydate()));
                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }

    @ResponseBody
    @RequestMapping(value = "viewattrdefaults", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject viewattrdefaults(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String viewid = request.getParameter("viewid");
        List<AttrDefine> viewAttrDefines = viewService.selectAttrDefines(Integer.parseInt(viewid));
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(viewAttrDefines.size()>0){
            for (AttrDefine attrDefine1:viewAttrDefines){
                JSONObject re1 = new JSONObject();
                re1.put("id",attrDefine1.getId());
                re1.put("attrdefineno",attrDefine1.getAttrdefineno());
                re1.put("attrdefinename",attrDefine1.getAttrdefinename());
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
                }else if(widgettypeid==8){
                    widgettype = "树";
                }
                re1.put("datelength",attrDefine1.getDatelength()==0?"":attrDefine1.getDatelength());
                re1.put("precision",attrDefine1.getPrecision()==0?"":attrDefine1.getPrecision());
                re1.put("widgettype",widgettype);
                re1.put("codelength",attrDefine1.getCodelength()==0?"":attrDefine1.getCodelength());
                re1.put("remark",attrDefine1.getRemark());
                re1.put("islocked",attrDefine1.getIslocked()==0?"否":"是");
                re1.put("iscode",attrDefine1.getIscode()==0?"否":"是");
                re1.put("inputman",attrDefine1.getInputman());
                re1.put("inputdate",attrDefine1.getInputdate()==null?"":sdf.format(attrDefine1.getInputdate()));
                re1.put("modifyman",attrDefine1.getModifyman());
                re1.put("modifydate",attrDefine1.getModifydate()==null?"":sdf.format(attrDefine1.getModifydate()));
                ViewAttr viewAttr = viewService.selectViewAttr(Integer.parseInt(viewid),attrDefine1.getId());
                re1.put("attrdefault",viewAttr.getAttrdefault());

                jslst.add(re1);

            }
        }


        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;


    }

    @ResponseBody
    @RequestMapping(value = "savedefault", method = {RequestMethod.GET, RequestMethod.POST})
    public Map savedefault(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String viewid = request.getParameter("viewid");
        String attrdefault = request.getParameter("attrdefault");
        String attrid = request.getParameter("attrid");
        ViewAttr viewAttr = viewService.selectViewAttr(Integer.parseInt(viewid),Integer.parseInt(attrid));
        viewAttr.setAttrdefault(attrdefault);
        int n = viewService.savedefault(viewAttr);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "viewattrs", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject viewattrs(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String viewid = request.getParameter("viewid");
        String typeid = request.getParameter("typeid");
        String attrdefineno = request.getParameter("attrdefineno");
        String attrdefinename = request.getParameter("attrdefinename");
        AttrDefine attrDefine = new AttrDefine();
        AttrDefine attrDefine2 = new AttrDefine();
        attrDefine.setTypeid(Integer.parseInt(typeid));
        attrDefine2.setTypeid(Integer.parseInt(typeid));
        attrDefine2.setAttrdefineno(attrdefineno);
        attrDefine2.setAttrdefinename(attrdefinename);
        List<AttrDefine> attrDefineList = attrDefineService.select(attrDefine);
        List<AttrDefine> attrDefineList2 =  attrDefineService.select(attrDefine2);
        if(attrDefineList2.size()!=attrDefineList.size()){
            for (int i = 0 ;i<attrDefineList2.size();i++){
                for (int j = 0 ; j<attrDefineList.size();j++){
                    if(attrDefineList2.get(i).getId()==attrDefineList.get(j).getId()){
                        attrDefineList.add(0,attrDefineList.remove(j));
                    }
                }

            }
        }

        List<AttrDefine> viewAttrDefines = viewService.selectAttrDefines(Integer.parseInt(viewid));
        for (int i = 0 ;i<viewAttrDefines.size();i++){
            AttrDefine viewAttr = viewAttrDefines.get(i);
            boolean flag = true;
            if(attrDefineList2.size()!=attrDefineList.size()){
                for (int j = 0 ; j<attrDefineList2.size();j++){
                    if(viewAttr.getId()==attrDefineList2.get(j).getId()){
                        flag = false;
                        break;
                    }
                }
                for (int j = 0 ; j<attrDefineList.size();j++){
                    if(flag&&viewAttr.getId()==attrDefineList.get(j).getId()){
                        attrDefineList.add(attrDefineList2.size(),attrDefineList.remove(j));
                    }
                }
            }else{
                for (int j = 0 ; j<attrDefineList.size();j++){
                    if(viewAttr.getId()==attrDefineList.get(j).getId()){
                        attrDefineList.add(0,attrDefineList.remove(j));
                    }
                }
            }



        }
        List<Integer> viewAttrDefineIds = new ArrayList<Integer>();
        for (AttrDefine attrDefine1:viewAttrDefines){
            viewAttrDefineIds.add(attrDefine1.getId());
        }

        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        if(attrDefineList.size()>0){
            for (AttrDefine attrDefine1:attrDefineList){
                JSONObject re1 = new JSONObject();
                if (viewAttrDefineIds.contains(attrDefine1.getId())){
                    re1.put("id",attrDefine1.getId());
                    re1.put("attrdefineno",attrDefine1.getAttrdefineno());
                    re1.put("attrdefinename",attrDefine1.getAttrdefinename());
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
                    } else if(widgettypeid==7){
                        widgettype = "勾选框";
                    }else if(widgettypeid==8){
                        widgettype = "树";
                    }
                    re1.put("datelength",attrDefine1.getDatelength()==0?"":attrDefine1.getDatelength());
                    re1.put("precision",attrDefine1.getPrecision()==0?"":attrDefine1.getPrecision());
                    re1.put("widgettype",widgettype);
                    re1.put("codelength",attrDefine1.getCodelength()==0?"":attrDefine1.getCodelength());
                    re1.put("remark",attrDefine1.getRemark());
                    re1.put("islocked",attrDefine1.getIslocked()==0?"否":"是");
                    re1.put("iscode",attrDefine1.getIscode()==0?"否":"是");
                    re1.put("inputman",attrDefine1.getInputman());
                    re1.put("inputdate",attrDefine1.getInputdate()==null?"":sdf.format(attrDefine1.getInputdate()));
                    re1.put("modifyman",attrDefine1.getModifyman());
                    re1.put("modifydate",attrDefine1.getModifydate()==null?"":sdf.format(attrDefine1.getModifydate()));
                    re1.put("checked",true);
                    jslst.add(re1);
                }else {
                    re1.put("checked",false);
                    re1.put("id",attrDefine1.getId());
                    re1.put("attrdefineno",attrDefine1.getAttrdefineno());
                    re1.put("attrdefinename",attrDefine1.getAttrdefinename());
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
                    }else if(widgettypeid==3){
                        widgettype = "日期选择框";
                    }else if(widgettypeid==4){
                        widgettype = "日期时间选择框";
                    }else if(widgettypeid==5){
                        widgettype = "下拉选择框";
                    } else if(widgettypeid==6){
                        widgettype = "复选框";
                    }else if(widgettypeid==7){
                        widgettype = "勾选框";
                    }else if(widgettypeid==8){
                        widgettype = "树";
                    }
                    re1.put("datelength",attrDefine1.getDatelength()==0?"":attrDefine1.getDatelength());
                    re1.put("precision",attrDefine1.getPrecision()==0?"":attrDefine1.getPrecision());
                    re1.put("widgettype",widgettype);
                    re1.put("codelength",attrDefine1.getCodelength()==0?"":attrDefine1.getCodelength());
                    re1.put("remark",attrDefine1.getRemark());


                    re1.put("islocked",attrDefine1.getIslocked()==0?"否":"是");
                    re1.put("iscode",attrDefine1.getIscode()==0?"否":"是");
                    re1.put("inputman",attrDefine1.getInputman());
                    re1.put("inputdate",attrDefine1.getInputdate()==null?"":sdf.format(attrDefine1.getInputdate()));
                    re1.put("modifyman",attrDefine1.getModifyman());
                    re1.put("modifydate",attrDefine1.getModifydate()==null?"":sdf.format(attrDefine1.getModifydate()));
                    jslst.add(re1);
                }
            }
        }


        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }



    @ResponseBody
    @RequestMapping(value = "add", method = {RequestMethod.GET, RequestMethod.POST})
    public Map add(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Date date =new Date();
        String viewno = request.getParameter("viewcode");
        String viewname = request.getParameter("viewname");
        String islocked = request.getParameter("islocked");
        String inputman = request.getParameter("inputman");
        String typeid = request.getParameter("typeid");
        View view = new View();
        view.setViewcode(viewno);
        view.setViewname(viewname);
        view.setTypeid(Integer.parseInt(typeid));
        view.setIslocked(islocked.equals("是")?1:0);
        view.setInputdate(date);
        view.setInputman(inputman);
        view.setIsdelete(0);
        int n = viewService.add(view);

        Map json = new HashMap();

        json.put("num",n);
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "edit", method = {RequestMethod.GET, RequestMethod.POST})
    public Map edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String viewno = request.getParameter("viewcode");
        String viewname = request.getParameter("viewname");
        String islocked = request.getParameter("islocked");
        String modifyman = request.getParameter("modifyman");
        Date date =new Date();
        View  view= viewService.selectById(Integer.parseInt(id));
        view.setViewname(viewname);
        view.setViewcode(viewno);
        view.setModifydate(date);
        view.setModifyman(modifyman);
        view.setIslocked(islocked.equals("是")?1:0);
        int n = viewService.edit(view);
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
                View view = viewService.selectById(Integer.parseInt(id));
                boolean flag2 = viewService.isdistribute(view.getId());
                if(!flag2){
                    flag = false;
                }
            }

        }
        if(flag){
            int n = viewService.delete(idArr);

            json.put("num",n);
            json.put("message","删除成功");

        }else {
            json.put("num",0);
            json.put("message","该视图已被分配，无法删除");
        }

        return json;
    }



    @ResponseBody
    @RequestMapping(value = "distribute", method = {RequestMethod.GET, RequestMethod.POST})
    public Map distribute(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String viewid = request.getParameter("viewid");
        String ids = request.getParameter("ids");
        String[] idArr = ids.split(",");
        boolean flag = viewService.distribute(Integer.parseInt(viewid),idArr);
        Map json = new HashMap();
        json.put("succsess",flag);

        return json;
    }

}
