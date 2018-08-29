package com.dhchain.business.exp.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.attr.service.AttrDefineService;
import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.base.service.BaseService;
import com.dhchain.business.base.vo.Base;
import com.dhchain.business.exp.service.ExptypeService;
import com.dhchain.business.exp.service.ViewService;
import com.dhchain.business.exp.vo.Exptype;
import com.dhchain.business.exp.vo.ExptypeView;
import com.dhchain.business.exp.vo.View;
import com.dhchain.business.type.service.TypeDetailService;
import com.dhchain.business.type.vo.TypeDetail;
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
 * Created by zhenglb on 2017-10-06.
 */
@Controller
@RequestMapping("/exptype")
public class ExptypeController  {
    @Autowired
    private ExptypeService exptypeService;
    @Autowired
    private ViewService viewService;
    @Autowired
    private TypeDetailService typeDetailService;
    @Autowired
    private AttrDefineService attrDefineService;
    @Autowired
    private BaseService baseService;
    @Autowired
    private AttrService attrService;

    @ResponseBody
    @RequestMapping(value = "selectByTypeid", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectByTypeid(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typeid = request.getParameter("typeid");

        JSONArray jslst2 = new JSONArray();
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(typeid.equals("")){
            re.put("rows",jslst2);
            re.put("total",0);
            return  re;
        }else{
            List<Exptype> jslist =  exptypeService.selectByTypeid(Integer.parseInt(typeid));
            JSONArray jslst = new JSONArray();
            Exptype exptype;
            if(jslist.size()>0) {
                for (int i=0;i<jslist.size();i++){
                    JSONObject re1 = new JSONObject();
                    exptype = (Exptype)jslist.get(i);
                    re1.put("id",exptype.getId());
                    re1.put("typeid",exptype.getTypeid());
                    re1.put("exptypeno",exptype.getExptypeno());
                    re1.put("exptypename",exptype.getExptypename());
                    String typedetailid = exptype.getTypedetailid();
                    String typedetailnames = "";
                    String typedetailidss = "";
                    if(!typedetailid.equals("")){
                        String[] typedetailids = typedetailid.split(",");
                        for (String id:typedetailids){
                            typedetailnames = typedetailnames + typeDetailService.selectById(Integer.parseInt(id)).getTypename()+",";
                            typedetailidss = typedetailidss + typeDetailService.selectById(Integer.parseInt(id)).getId()+",";
                        }

                    }

                    re1.put("typedetailid",typedetailidss);
                    re1.put("typedetailnames",typedetailnames);
                    re1.put("inputman",exptype.getInputman());
                    re1.put("inputdate",exptype.getInputdate()==null?"":sdf.format(exptype.getInputdate()));
                    re1.put("modifyman",exptype.getModifyman());
                    re1.put("modifydate",exptype.getModifydate()==null?"":sdf.format(exptype.getModifydate()));
                    re1.put("islocked",exptype.getIslocked()==0?"否":"是");
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
    @RequestMapping(value = "select", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String exptypeno = request.getParameter("exptypeno");
        String exptypename = request.getParameter("exptypename");
        String typeid = request.getParameter("typeid");
        JSONArray jslst2 = new JSONArray();
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Exptype exptype1 = new Exptype();
        exptype1.setExptypename(exptypename);
        exptype1.setExptypeno(exptypeno);
        exptype1.setTypeid(Integer.parseInt(typeid));
            List<Exptype> jslist =  exptypeService.select(exptype1);
            JSONArray jslst = new JSONArray();
            Exptype exptype;
            if(jslist.size()>0) {
                for (int i=0;i<jslist.size();i++){
                    JSONObject re1 = new JSONObject();
                    exptype = (Exptype)jslist.get(i);
                    String typedetailid = exptype.getTypedetailid();
                    String typedetailidss = "";
                    String typedetailnames = "";
                    if(!typedetailid.equals("")){
                        String[] typedetailids = typedetailid.split(",");
                        for (String id:typedetailids){
                            typedetailnames = typedetailnames + typeDetailService.selectById(Integer.parseInt(id)).getTypename()+",";
                            typedetailidss = typedetailidss + typeDetailService.selectById(Integer.parseInt(id)).getId()+",";
                        }

                    }

                    re1.put("id",exptype.getId());
                    re1.put("typeid",exptype.getTypeid());
                    re1.put("exptypeno",exptype.getExptypeno());
                    re1.put("exptypename",exptype.getExptypename());
                    re1.put("typedetailid",typedetailidss);
                    re1.put("typedetailnames",typedetailnames);
//                    re1.put("typedetailid",typeDetail.getTypename());
                    re1.put("inputman",exptype.getInputman());
                    re1.put("inputdate",exptype.getInputdate()==null?"":sdf.format(exptype.getInputdate()));
                    re1.put("modifyman",exptype.getModifyman());
                    re1.put("modifydate",exptype.getModifydate()==null?"":sdf.format(exptype.getModifydate()));
                    re1.put("islocked",exptype.getIslocked()==0?"否":"是");
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




    @ResponseBody
    @RequestMapping(value = "isexistExptype", method = {RequestMethod.GET, RequestMethod.POST})
    public Map isexistExptype(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typeid = request.getParameter("typeid");
        String exptypeno = request.getParameter("exptypeno");
        String typedetailid = request.getParameter("typedetailid");
        Exptype exptype = new Exptype();
        exptype.setTypeid(Integer.parseInt(typeid));
        exptype.setExptypeno(exptypeno);
        exptype.setIsdelete(0);
        List<Exptype> exptypeList = exptypeService.select(exptype);
        Exptype exptype1 = new Exptype();
        exptype1.setTypeid(Integer.parseInt(typeid));
        exptype1.setIsdelete(0);
        exptype1.setTypedetailid(typedetailid);
        List<Exptype> exptypes = exptypeService.select(exptype1);
        Map json = new HashMap();
        int isexist = 1;
        if(exptypeList!=null&&exptypeList.size()>0){
            isexist = 2;
            json.put("message","编码已存在");
        }

        if(exptypes!=null&&exptypes.size()>0){
            isexist = 3;
            json.put("message","该分类已有模板请重新选择分类");
        }
        json.put("isexist",isexist);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "add", method = {RequestMethod.GET, RequestMethod.POST})
    public Map add(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Date date =new Date();
        String typeid = request.getParameter("typeid");
        String exptypeno = request.getParameter("exptypeno");
        String exptypename = request.getParameter("exptypename");
        String islocked = request.getParameter("islocked");
        String inputman = request.getParameter("inputman");
        String typedetailid = request.getParameter("typedetailid");
        Exptype exptype = new Exptype();
        exptype.setTypeid(Integer.parseInt(typeid));
        exptype.setExptypename(exptypename);
        exptype.setExptypeno(exptypeno);
        exptype.setTypedetailid(typedetailid);
        exptype.setIslocked(islocked.equals("是")?1:0);
        exptype.setInputdate(date);
        exptype.setInputman(inputman);
        exptype.setIsdelete(0);
        int n = exptypeService.add(exptype);
        if(!typedetailid.equals("")){
            String[] typedetailids = typedetailid.split(",");
            for (String id:typedetailids){
                TypeDetail typeDetail = typeDetailService.selectById(Integer.parseInt(id));
                typeDetail.setExptypeid(exptypeService.selectNewId());
                typeDetailService.updateById(typeDetail);
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
        String exptypeno = request.getParameter("exptypeno");
        String exptypename = request.getParameter("exptypename");
        String islocked = request.getParameter("islocked");
        String modifyman = request.getParameter("modifyman");
        String typedetailid = request.getParameter("typedetailid");
        Date date =new Date();
        Exptype exptype = new Exptype();
        exptype.setId(Integer.parseInt(id));
        exptype.setExptypeno(exptypeno);
        exptype.setExptypename(exptypename);
        exptype.setModifydate(date);
        exptype.setModifyman(modifyman);
        exptype.setTypedetailid(typedetailid);
        exptype.setIslocked(islocked.equals("是")?1:0);
        int n = exptypeService.edit(exptype);
        Map json = new HashMap();
        json.put("num",n);
        if(!typedetailid.equals("")){
            String[] typedetailids = typedetailid.split(",");
            for (String tid:typedetailids){
                TypeDetail typeDetail = typeDetailService.selectById(Integer.parseInt(tid));
                typeDetail.setExptypeid(Integer.parseInt(id));
                typeDetailService.updateById(typeDetail);
            }
        }
        return json;
    }



    @ResponseBody
    @RequestMapping(value = "savesequence", method = {RequestMethod.GET, RequestMethod.POST})
    public Map savesequence(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String viewid = request.getParameter("viewid");
        String sequence = request.getParameter("sequence");
        String exptypeid = request.getParameter("exptypeid");
        ExptypeView exptypeView = exptypeService.selectExptypeView(Integer.parseInt(exptypeid),Integer.parseInt(viewid));
        exptypeView.setSequence(Integer.parseInt(sequence));
        int n = exptypeService.savesequence(exptypeView);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "selectById", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectById(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        Exptype exptype = exptypeService.selectById(id);
        JSONObject re1 = new JSONObject();
        re1.put("id",exptype.getId());
        re1.put("exptypeno",exptype.getExptypeno());
        re1.put("exptypename",exptype.getExptypename());
        re1.put("islocked",exptype.getIslocked());
        re1.put("typedetailid",exptype.getTypedetailid());

        return re1;
    }


    @ResponseBody
    @RequestMapping(value = "delete", method = {RequestMethod.GET, RequestMethod.POST})
    public Map delete(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("ids");
        String[] idArr = ids.split(",");
        int n = exptypeService.deleteExpTypes(idArr);
        Map json = new HashMap();
        json.put("num",n);

        return json;
    }


    @ResponseBody
    @RequestMapping(value = "delete2", method = {RequestMethod.GET, RequestMethod.POST})
    public Map delete2(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("ids");
        String[] idArr = ids.split(",");
        boolean flag = true;
        String message = "";
        String exptypename = "";
        for(int i = 0; i < idArr.length; i++){
            Exptype exptype = exptypeService.selectById(idArr[i]);
            boolean iscontainview = exptypeService.iscontainView(Integer.parseInt(idArr[i]));
            if(iscontainview){
                flag = false;
                exptypename = exptype.getExptypename();
                message += exptypename+"已分配视图，";
            }
        }
        if(flag){
            int n = exptypeService.deleteExpTypes(idArr);
            if(n>0){
                message += "删除成功";
            }

        }else {
            message +="若要删除该模板，请先初始化该模板配置视图。";
        }

        Map json = new HashMap();
        json.put("success",flag);
        json.put("message",message);
        return json;
    }




    @ResponseBody
    @RequestMapping(value = "exptypeviewsorts", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject exptypeviewsorts(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String exptypeid = request.getParameter("exptypeid");
        List<View> viewAttrDefines = exptypeService.selectViews(Integer.parseInt(exptypeid));
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(viewAttrDefines.size()>0){
            for (View view2:viewAttrDefines){
                JSONObject re1 = new JSONObject();

                    re1.put("id",view2.getId());
                    re1.put("viewcode",view2.getViewcode());
                    re1.put("viewname",view2.getViewname());
                    re1.put("typeid",view2.getTypeid());
                    re1.put("islocked",view2.getIslocked()==0?"否":"是");
                    re1.put("inputman",view2.getInputman());
                    re1.put("inputdate",view2.getInputdate()==null?"":sdf.format(view2.getInputdate()));
                    re1.put("modifyman",view2.getModifyman());
                    re1.put("modifydate",view2.getModifydate()==null?"":sdf.format(view2.getModifydate()));
                    re1.put("checked",true);
                    ExptypeView  exptypeView = exptypeService.selectExptypeView(Integer.parseInt(exptypeid),view2.getId());
                    re1.put("sequence",exptypeView.getSequence());
                    jslst.add(re1);

            }
        }


        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;


    }

    @ResponseBody
    @RequestMapping(value = "exptypeviews", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject exptypeviews(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String exptypeid = request.getParameter("exptypeid");
        String typeid = request.getParameter("typeid");
        String viewcode = request.getParameter("viewcode");
        String viewname = request.getParameter("viewname");
        View view = new View();
        View view3 = new View();
        view.setTypeid(Integer.parseInt(typeid));
        view3.setTypeid(Integer.parseInt(typeid));
        view3.setViewname(viewname);
        view3.setViewcode(viewcode);
        List<View> views = viewService.select(view);
        List<View> views2 = viewService.select(view3);
        List<View> viewAttrDefines = exptypeService.selectViews(Integer.parseInt(exptypeid));
        if(views2.size()!=views.size()){
            for (int i = 0 ;i<views2.size();i++){
                for (int j = 0 ; j<views.size();j++){
                    if(views2.get(i).getId()==views.get(j).getId()){
                        views.add(0,views.remove(j));
                    }
                }

            }
        }
        for (int i = 0 ;i<viewAttrDefines.size();i++){
            View viewAttr = viewAttrDefines.get(i);
            boolean flag = true;
            if(views2.size()!=views.size()){
                for (int j = 0 ; j<views2.size();j++){
                    if(viewAttr.getId()==views2.get(j).getId()){
                        flag = false;
                        break;
                    }
                }
                for (int j = 0 ; j<views.size();j++){
                    if(flag&&viewAttr.getId()==views.get(j).getId()){
                        views.add(views2.size(),views.remove(j));
                    }
                }
            }else{
                for (int j = 0 ; j<views.size();j++){
                    if(viewAttr.getId()==views.get(j).getId()){
                        views.add(0,views.remove(j));
                    }
                }
            }



        }
        List<Integer> exptypeViewIds = new ArrayList<Integer>();
        for (View view1:viewAttrDefines){
            exptypeViewIds.add(view1.getId());
        }
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        if(views.size()>0){
            for (View view2:views){
                JSONObject re1 = new JSONObject();
                if (exptypeViewIds.contains(view2.getId())){
                    re1.put("id",view2.getId());
                    re1.put("viewcode",view2.getViewcode());
                    re1.put("viewname",view2.getViewname());
                    re1.put("typeid",view2.getTypeid());
                    re1.put("islocked",view2.getIslocked()==0?"否":"是");
                    re1.put("inputman",view2.getInputman());
                    re1.put("inputdate",view2.getInputdate()==null?"":sdf.format(view2.getInputdate()));
                    re1.put("modifyman",view2.getModifyman());
                    re1.put("modifydate",view2.getModifydate()==null?"":sdf.format(view2.getModifydate()));
                    re1.put("checked",true);

                    jslst.add(re1);
                }else {
                    re1.put("checked",false);
                    re1.put("id",view2.getId());
                    re1.put("viewcode",view2.getViewcode());
                    re1.put("viewname",view2.getViewname());
                    re1.put("typeid",view2.getTypeid());
                    re1.put("islocked",view2.getIslocked()==0?"否":"是");
                    re1.put("inputman",view2.getInputman());
                    re1.put("inputdate",view2.getInputdate()==null?"":sdf.format(view2.getInputdate()));
                    re1.put("modifyman",view2.getModifyman());
                    re1.put("modifydate",view2.getModifydate()==null?"":sdf.format(view2.getModifydate()));
                    jslst.add(re1);
                }
            }
        }


        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }


    @ResponseBody
    @RequestMapping(value = "distribute", method = {RequestMethod.GET, RequestMethod.POST})
    public Map distribute(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String exptypeid = request.getParameter("exptypeid");
        Map json = new HashMap();
        String ids = request.getParameter("ids");
        if(!ids.equals("")){
            String[] idArr = ids.split(",");

            Map isRepeatAttr = exptypeService.isRepeatAttr(idArr);
            boolean flag2 = (boolean) isRepeatAttr.get("flag");

            if(!flag2){
                json.put("succsess",false);
                json.put("message", isRepeatAttr.get("message"));
            }else{
                boolean flag = exptypeService.distribute(Integer.parseInt(exptypeid),ids);
                json.put("succsess",flag);
                json.put("message","分配成功");

            }
        }else {
            String[] idArr = ids.split(",");
            boolean flag = exptypeService.distribute(Integer.parseInt(exptypeid), ids);
            json.put("succsess",flag);
            json.put("message","分配成功");

        }


        return json;
    }


    @ResponseBody
    @RequestMapping(value = "queryparms", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject queryparms(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String exptypeid = request.getParameter("exptypeid");
        List<View> views = exptypeService.selectViews(Integer.parseInt(exptypeid));
        String typeid = request.getParameter("typeid");

        AttrDefine attrDefine = new AttrDefine();

        attrDefine.setTypeid(Integer.parseInt(typeid));

        List<AttrDefine> attrDefineList = exptypeService.selectParms(Integer.parseInt(exptypeid));


        List<AttrDefine> viewAttrDefines = new ArrayList<AttrDefine>();
        for (View view:views){
            List<AttrDefine> viewattrs = viewService.selectAttrDefines(view.getId());
            for (AttrDefine attrDefine1:viewattrs){
                viewAttrDefines.add(attrDefine1);
            }
        }


        List<Integer> parmIds = new ArrayList<Integer>();
        for (AttrDefine attrDefine1:attrDefineList){
            parmIds.add(attrDefine1.getId());
        }

        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        for (int i = 0 ;i<viewAttrDefines.size();i++){
            for (AttrDefine attrDefine2:attrDefineList){
                if(attrDefine2.getId()==viewAttrDefines.get(i).getId()){
                    viewAttrDefines.add(0,viewAttrDefines.remove(i));
                }

            }

        }
        if(viewAttrDefines.size()>0){
            for (AttrDefine attrDefine1:viewAttrDefines){
                JSONObject re1 = new JSONObject();
                if (parmIds.contains(attrDefine1.getId())){
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
    @RequestMapping(value = "distributeparms", method = {RequestMethod.GET, RequestMethod.POST})
    public Map distributeparms(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String exptypeid = request.getParameter("exptypeid");
        String ids = request.getParameter("ids");
        String[] idArr = ids.split(",");
        Map json = new HashMap();
        if(idArr.length>10){
            json.put("message","最多设置10个查询条件");
            json.put("succsess",false);
        }else{
            boolean flag = exptypeService.distributeparms(Integer.parseInt(exptypeid),idArr);

            json.put("succsess",flag);
            if(!flag){
                json.put("message","分配失败");
            }

        }




        return json;
    }

}
