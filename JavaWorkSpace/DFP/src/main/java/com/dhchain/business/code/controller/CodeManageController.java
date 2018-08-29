package com.dhchain.business.code.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.attr.service.AttrDefineService;
import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.base.service.BaseService;
import com.dhchain.business.base.vo.Base;
import com.dhchain.business.code.service.CodeManageService;
import com.dhchain.business.code.service.CodeNameService;
import com.dhchain.business.code.service.CodeTypeService;
import com.dhchain.business.code.vo.CodeManageType;
import com.dhchain.business.code.vo.CodeName;
import com.dhchain.business.code.vo.CodeType;
import com.dhchain.business.exp.service.ExptypeService;
import com.dhchain.business.exp.service.ViewService;
import com.dhchain.business.exp.vo.Exptype;
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
@RequestMapping("/codemanage")
public class CodeManageController extends com.dhchain.config.base.BaseController{
    @Autowired
    private CodeManageService codeManageService;
    @Autowired
    private CodeTypeService codeTypeService;
    @Autowired
    private AttrService attrService;
    @Autowired
    private CodeNameService codeNameService;
    @Autowired
    private TypeDetailService typeDetailService;
    @Autowired
    private ExptypeService exptypeService;
    @Autowired
    private ViewService viewService;
    @Autowired
    private BaseService baseService;
    @Autowired
    private AttrDefineService attrDefineService;
    @ResponseBody
    @RequestMapping(value = "query", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectByTypeid(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typeid = request.getParameter("typeno");
        JSONArray jslst2 = new JSONArray();
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(typeid.equals("")){
//            re.put("rows",jslst2);
//            re.put("total",0);
            return  re;
        }else{
            List<CodeManageType> jslist =  codeManageService.selectByTypeid(typeid);
            JSONArray jslst = new JSONArray();
            CodeManageType exptype;
            if(jslist.size()>0) {
                for (int i=0;i<jslist.size();i++){
                    JSONObject re1 = new JSONObject();
                    exptype = (CodeManageType)jslist.get(i);
                    re1.put("id",exptype.getId());
                    re1.put("ftypeno",exptype.getFtypeno());
                    re1.put("ftypename",exptype.getFtypename());
                    re1.put("typeno",exptype.getTypeno());
                    re1.put("typename",exptype.getTypename());
                    re1.put("length",exptype.getCodelength());
                    re1.put("codeway",exptype.getCodeway());
                    re1.put("codenameway",exptype.getCodenameway());
                    re1.put("codebegin",exptype.getCodebegin());
                    re1.put("codeend",exptype.getCodeend());
                    re1.put("isunique",exptype.getIsunique()==0?"否":"是");
                    re1.put("isdelete",exptype.getIsdelete());
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
    @RequestMapping(value = "codeManageAdd", method = {RequestMethod.GET, RequestMethod.POST})
    public Map CodeManageAdd(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ftypeno = request.getParameter("ftypeno");
        String ftypename = request.getParameter("ftypename");
        String typeno = request.getParameter("typeno");
        String typename = request.getParameter("typename");
        String length = request.getParameter("length");
        String codeway = request.getParameter("codeway");
        String codenameway = request.getParameter("codenameway");
        String codebegin = request.getParameter("codebegin");
        String codeend = request.getParameter("codeend");
        String isunique =  request.getParameter("isunique");
        CodeManageType codeManageType = new CodeManageType();
        codeManageType.setFtypeno(ftypeno);
        codeManageType.setFtypename(ftypename);
        codeManageType.setTypeno(typeno);
        codeManageType.setTypename(typename);
        codeManageType.setCodelength(Integer.parseInt(length));
        codeManageType.setCodeway(codeway);
        codeManageType.setCodenameway(codenameway);
        codeManageType.setCodebegin(codebegin);
        codeManageType.setCodeend(codeend);
        codeManageType.setIsunique(Integer.parseInt(isunique));
        int n=  codeManageService.codeManageAdd(codeManageType);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "codeManageDelete", method = {RequestMethod.GET, RequestMethod.POST})
    public Map codeManageDelete(HttpServletRequest request) throws UnsupportedEncodingException {
            request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("ids");
        String[] idArr = ids.split(",");
        int n = codeManageService.codeManageDelete(idArr);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "codeManageTypeNo", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject codeManageTypeNO(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ftypeno = request.getParameter("ftypeno");

        List jslist=  codeManageService.getTypeDetail(ftypeno);
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        TypeDetail typeDetail;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {

                JSONObject re1 = new JSONObject();
                typeDetail = (TypeDetail) jslist.get(i);
                int id = typeDetail.getId();
                String Typeno=typeDetail.getTypeno();
                String Typename=typeDetail.getTypename();
                String Fid= String.valueOf(typeDetail.getFid());
                String Kindnum= String.valueOf(typeDetail.getKindnum());
                if(!typeDetail.getFid().toString().equals("0")) {
                    re1.put("_parentId", typeDetail.getFid().toString());
                }
                re1.put("id", id);
                re1.put("typeno", Typeno);
                re1.put("typename", Typename);
                re1.put("fid", Fid);
                re1.put("kindnum", Kindnum);
                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }

    @ResponseBody
    @RequestMapping(value = "/codeManageedit", method = {RequestMethod.GET, RequestMethod.POST})
    public Map codeManageEdit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String ftypeno = request.getParameter("ftypeno");
        String ftypename = request.getParameter("ftypename");
        String typeno = request.getParameter("typeno");
        String typename = request.getParameter("typename");
        String length = request.getParameter("length");
        String codeway = request.getParameter("codeway");
        String codenameway = request.getParameter("codenameway");
        String codebegin = request.getParameter("codebegin");
        String codeend = request.getParameter("codeend");
        String isunique = request.getParameter("isunique");
        CodeManageType codeManageType = new CodeManageType();
        codeManageType.setId(Integer.parseInt(id));
        codeManageType.setFtypeno(ftypeno);
        codeManageType.setFtypename(ftypename);
        codeManageType.setTypeno(typeno);
        codeManageType.setTypename(typename);
        codeManageType.setCodelength(Integer.parseInt(length));
        codeManageType.setCodeway(codeway);
        codeManageType.setCodenameway(codenameway);
        codeManageType.setCodebegin(codebegin);
        codeManageType.setCodeend(codeend);
        codeManageType.setIsunique(Integer.parseInt(isunique));
        //this is mapperservice
        int n=  codeManageService.codeManageEdit(codeManageType);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/codemanageaddcolumn", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject codemanageaddcolumn(HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();

        JSONObject re1 = new JSONObject();
        re1.put("title", "ID");
        re1.put("field", "id");
        re1.put("width", "50px");
        re1.put("hidden", true);
        jslst.add(re1);
        JSONObject re2 = new JSONObject();
        re2.put("title", "分类代码");
        re2.put("field", "typeno");
        re2.put("width", "100px");
        re2.put("hidden", false);
        re2.put("editor", "'text'");
        jslst.add(re2);
        JSONObject re3 = new JSONObject();
        re3.put("title", "分类名称");
        re3.put("field", "typename");
        re3.put("width", "100px");
        re3.put("hidden", false);
        jslst.add(re3);
        JSONObject re4 = new JSONObject();
        re4.put("title", "编码位数");
        re4.put("field", "kindnum");
        re4.put("width", "100px");
        re4.put("hidden", false);
        jslst.add(re4);
        JSONObject re5 = new JSONObject();
        re5.put("title", "父节点ID");
        re5.put("field", "fid");
        re5.put("width", "100px");
        re5.put("hidden", true);
        jslst.add(re5);
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }

    @ResponseBody
    @RequestMapping(value = "selectById", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectById(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        CodeManageType codeManageType = codeManageService.selectById(Integer.parseInt(id));
        JSONObject re1 = new JSONObject();
        re1.put("id",codeManageType.getId());
        re1.put("ftypeno",codeManageType.getFtypeno());
        re1.put("ftypename",codeManageType.getFtypename());
        re1.put("typeno",codeManageType.getTypeno());
        re1.put("typename",codeManageType.getTypename());
        re1.put("codelength",codeManageType.getCodelength());
        re1.put("codeway",codeManageType.getCodeway());
        re1.put("codenameway",codeManageType.getCodenameway());
        re1.put("codebegin",codeManageType.getCodebegin());
        re1.put("codeend",codeManageType.getCodeend());
        re1.put("fcodeid",codeManageType.getFcodeid());
        re1.put("isdelete",codeManageType.getIsdelete());
        re1.put("isunique",codeManageType.getIsunique());
        return re1;
    }



    @RequestMapping("/add")
    @ResponseBody
    public Object add(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ftypeno =request.getParameter("ftypeno");
        String ftypename = request.getParameter("ftypename");
        String typeno = request.getParameter("typeno");
        String typename = request.getParameter("typename");
        String codelength = request.getParameter("codelength");
        String codemanegeid = request.getParameter("codemanegeid");
        String attrname = request.getParameter("attrname");
        String attrno = request.getParameter("attrno");
        String attrid = request.getParameter("attrid");
        String inputman = request.getParameter("inputman");
        String typenoele = request.getParameter("typenoele");
        String kindno = request.getParameter("kindno");
        String kindnum = request.getParameter("kindnum");
        String codebegin = request.getParameter("codebegin");
        String codeend = request.getParameter("codeend");
        CodeType codeType = new CodeType();
        if(attrid!=null&&!attrid.equals("")){
            codeType.setAttrid(Integer.parseInt(attrid));
        }
        codeType.setAttrname(attrname);
        codeType.setAttrno(attrno);
        if(codemanegeid!=null&&!codemanegeid.equals("")){
            codeType.setCodemanageid(Integer.parseInt(codemanegeid));
        }
        if(codelength!=null&&!codelength.equals("")){
            codeType.setCodelength(Integer.parseInt(codelength));
        }
        codeType.setFtypename(ftypename);
        codeType.setFtypeno(ftypeno);
        codeType.setTypeno(typeno);
        codeType.setTypename(typename);
        codeType.setTypenoele(typenoele);
        codeType.setInputman(inputman);
        codeType.setInputdate(new Date());
        if(kindno!=null&&!kindno.equals("")){
            codeType.setKindno(Integer.parseInt(kindno));
        }
        if(kindnum!=null&&!kindnum.equals("")){
            codeType.setKindnum(Integer.parseInt(kindnum));
        }
        codeType.setCodebegin(codebegin);
        codeType.setCodeend(codeend);
        codeType.setIsdelete(0);
        boolean flag = codeTypeService.insert(codeType);


        if(flag){
            return renderSuccess("添加成功！");

        }else{
            return renderSuccess("添加失败！");
        }


    }


    @RequestMapping("/addcodename")
    @ResponseBody
    public Object addcodename(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ftypeno =request.getParameter("ftypeno");
        String ftypename = request.getParameter("ftypename");
        String typeno = request.getParameter("typeno");
        String typename = request.getParameter("typename");
        String codelength = request.getParameter("codelength");
        String codemanegeid = request.getParameter("codemanegeid");
        String attrname = request.getParameter("attrname");
        String attrno = request.getParameter("attrno");
        String attrid = request.getParameter("attrid");
        String viewname = request.getParameter("viewname");
        String viewcode = request.getParameter("viewcode");
        String viewid = request.getParameter("viewid");
        String inputman = request.getParameter("inputman");
        String typenoele = request.getParameter("typenoele");
        String kindno = request.getParameter("kindno");
        String kindnum = request.getParameter("kindnum");
        String splitstr = request.getParameter("splitstr");
        CodeName codeName = new CodeName();
        if(attrid!=null&&!attrid.equals("")){
            codeName.setAttrid(Integer.parseInt(attrid));
        }
        codeName.setAttrname(attrname);
        codeName.setAttrno(attrno);
        if(viewid!=null&&!viewid.equals("")){
            codeName.setViewid(Integer.parseInt(viewid));
        }
        codeName.setViewname(viewname);
        codeName.setViewcode(viewcode);
        if(codemanegeid!=null&&!codemanegeid.equals("")){
            codeName.setCodemanageid(Integer.parseInt(codemanegeid));
        }
        if(codelength!=null&&!codelength.equals("")){
            codeName.setCodelength(Integer.parseInt(codelength));
        }
        codeName.setFtypename(ftypename);
        codeName.setFtypeno(ftypeno);
        codeName.setTypeno(typeno);
        codeName.setTypename(typename);
        codeName.setTypenoele(typenoele);
        codeName.setInputman(inputman);
        codeName.setInputdate(new Date());
        if(kindno!=null&&!kindno.equals("")){
            codeName.setKindno(Integer.parseInt(kindno));
        }
        if(kindnum!=null&&!kindnum.equals("")){
            codeName.setKindnum(Integer.parseInt(kindnum));
        }
        codeName.setSplitstr(splitstr);
        codeName.setIsdelete(0);
        boolean flag = codeNameService.insert(codeName);


        if(flag){
            return renderSuccess("添加成功！");

        }else{
            return renderSuccess("添加失败！");
        }


    }


    @ResponseBody
    @RequestMapping(value = "selectByCodeManageId", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectByCodeManageId(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String codemanageid = request.getParameter("codemanageid");
        JSONArray jslst2 = new JSONArray();
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        int codelengthtotal = 0;
        if(codemanageid.equals("")){
            re.put("rows",jslst2);
            re.put("total",0);
            return  re;
        }else{
            List<CodeType> jslist =  codeTypeService.selectByCodeManageId(Integer.parseInt(codemanageid));
            JSONArray jslst = new JSONArray();
            CodeType codeType;
            if(jslist.size()>0) {
                for (int i=0;i<jslist.size();i++){
                    JSONObject re1 = new JSONObject();
                    codeType = (CodeType)jslist.get(i);
                    re1.put("id",codeType.getId());
                    re1.put("attrid",codeType.getAttrid());
                    re1.put("attrno",codeType.getAttrno());
                    re1.put("attrname",codeType.getAttrname());
                    re1.put("codemanageid",codeType.getCodemanageid());
                    re1.put("ftypeno",codeType.getFtypeno());
                    re1.put("ftypename",codeType.getFtypename());
                    re1.put("typeno",codeType.getTypeno());
                    re1.put("typename",codeType.getTypename());
                    re1.put("codelength",codeType.getCodelength());
                    if(codeType.getTypenoele().equals("0")){
                        re1.put("typenoele","主数据属性");
                    }else{
                        re1.put("typenoele",codeType.getTypenoele());
                    }

                    re1.put("kindno",codeType.getKindno()==0?"":codeType.getKindno());
                    re1.put("kindnum",codeType.getKindnum());
                    re1.put("codebegin",codeType.getCodebegin());
                    re1.put("codeend",codeType.getCodeend());
                    re1.put("inputman",codeType.getInputman());
                    re1.put("inputdate",codeType.getInputdate()==null?"":sdf.format(codeType.getInputdate()));
                    re1.put("modifyman",codeType.getModifyman());
                    re1.put("modifydate",codeType.getModifydate()==null?"":sdf.format(codeType.getModifydate()));
                    jslst.add(re1);
                    codelengthtotal+=codeType.getKindnum();
                }
                re.put("rows",jslst);
                re.put("total",jslst.size());
                re.put("codelength",codelengthtotal);
                return re;
            }else{
                re.put("rows",jslst2);
                re.put("total",0);
                re.put("codelength",codelengthtotal);
                return  re;
            }
        }


    }



    @ResponseBody
    @RequestMapping(value = "selectByCodeeditid", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectByCodeeditid(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String codemanageid = request.getParameter("codemanageid");
        JSONArray jslst2 = new JSONArray();
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(codemanageid.equals("")){
            re.put("rows",jslst2);
            re.put("total",0);
            return  re;
        }else{
            List<CodeName> jslist =  codeNameService.selectByCodeManageId(Integer.parseInt(codemanageid));
            JSONArray jslst = new JSONArray();
            CodeName codeName;
            if(jslist.size()>0) {
                for (int i=0;i<jslist.size();i++){
                    JSONObject re1 = new JSONObject();
                    codeName = (CodeName)jslist.get(i);
                    re1.put("id",codeName.getId());
                    re1.put("attrid",codeName.getAttrid());
                    re1.put("viewid",codeName.getViewid());
                    re1.put("viewcode",codeName.getViewcode());
                    re1.put("viewname",codeName.getViewname());
                    re1.put("attrno",codeName.getAttrno());
                    re1.put("attrname",codeName.getAttrname());
                    re1.put("codemanageid",codeName.getCodemanageid());
                    re1.put("ftypeno",codeName.getFtypeno());
                    re1.put("ftypename",codeName.getFtypename());
                    re1.put("typeno",codeName.getTypeno());
                    re1.put("typename",codeName.getTypename());
                    re1.put("codelength",codeName.getCodelength());
                    if(codeName.getTypenoele().equals("0")){
                        re1.put("typenoele","主数据属性");
                    }else{
                        re1.put("typenoele",codeName.getTypenoele());
                    }
                    re1.put("kindno",codeName.getKindno()==0?"":codeName.getKindno());
                    re1.put("kindnum",codeName.getKindnum());
                    re1.put("splitstr",codeName.getSplitstr());
                    re1.put("inputman",codeName.getInputman());
                    re1.put("inputdate",codeName.getInputdate()==null?"":sdf.format(codeName.getInputdate()));
                    re1.put("modifyman",codeName.getModifyman());
                    re1.put("modifydate",codeName.getModifydate()==null?"":sdf.format(codeName.getModifydate()));
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
    @RequestMapping(value = "selectEditCodeType", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectEditCodeType(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        CodeType codeType = codeTypeService.selectById(Integer.parseInt(id));
        JSONObject re1 = new JSONObject();
        re1.put("id",codeType.getId());
        re1.put("attrid",codeType.getAttrid());
        re1.put("attrno",codeType.getAttrno());
        re1.put("attrname",codeType.getAttrname());
        re1.put("codemanageid",codeType.getCodemanageid());
        re1.put("ftypeno",codeType.getFtypeno());
        re1.put("ftypename",codeType.getFtypename());
        re1.put("typeno",codeType.getTypeno());
        re1.put("typename",codeType.getTypename());
        re1.put("codelength",codeType.getCodelength());
        re1.put("typenoele",codeType.getTypenoele());
        re1.put("kindno",codeType.getKindno()==0?"":codeType.getKindno());
        re1.put("kindnum",codeType.getKindnum());
        re1.put("codebegin",codeType.getCodebegin());
        re1.put("codeend",codeType.getCodeend());
        re1.put("inputman",codeType.getInputman());
        re1.put("inputdate",codeType.getInputdate());
        re1.put("modifyman",codeType.getModifyman());
        re1.put("modifydate",codeType.getModifydate());
        return re1;
    }



    @ResponseBody
    @RequestMapping(value = "selectEditCodeName", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectEditCodeName(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        CodeName codeName = codeNameService.selectById(Integer.parseInt(id));
        JSONObject re1 = new JSONObject();
        re1.put("id",codeName.getId());
        re1.put("attrid",codeName.getAttrid());
        re1.put("viewid",codeName.getViewid());
        re1.put("attrno",codeName.getAttrno());
        re1.put("attrname",codeName.getAttrname());
        re1.put("viewcode",codeName.getViewcode());
        re1.put("viewname",codeName.getViewname());
        re1.put("codemanageid",codeName.getCodemanageid());
        re1.put("ftypeno",codeName.getFtypeno());
        re1.put("ftypename",codeName.getFtypename());
        re1.put("typeno",codeName.getTypeno());
        re1.put("typename",codeName.getTypename());
        re1.put("codelength",codeName.getCodelength());
        re1.put("typenoele",codeName.getTypenoele());
        re1.put("kindno",codeName.getKindno());
        re1.put("kindnum",codeName.getKindnum());
        re1.put("splitstr",codeName.getSplitstr());
        re1.put("inputman",codeName.getInputman());
        re1.put("inputdate",codeName.getInputdate());
        re1.put("modifyman",codeName.getModifyman());
        re1.put("modifydate",codeName.getModifydate());
        return re1;
    }


    @RequestMapping("/editCodeType")
    @ResponseBody
    public Object editCodeType(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        CodeType codeType = codeTypeService.selectById(Integer.parseInt(id));
        String attrid = request.getParameter("attrid");
        String attrno = request.getParameter("attrno");
        String attrname = request.getParameter("attrname");
        String modifyman = request.getParameter("modifyman");
        String typenoele = request.getParameter("typenoele");
        String kindno = request.getParameter("kindno");
        String kindnum =request.getParameter("kindnum");
        String codebegin =request.getParameter("codebegin");
        String codeend = request.getParameter("codeend");
        codeType.setAttrid(Integer.parseInt(attrid));
        codeType.setAttrno(attrno);
        codeType.setAttrname(attrname);
        codeType.setModifyman(modifyman);
        codeType.setModifydate(new Date());
        codeType.setTypenoele(typenoele);
        if (!kindno.equals("")) {
            codeType.setKindno(Integer.parseInt(kindno));
        }//
        codeType.setKindnum(Integer.parseInt(kindnum));
        codeType.setCodebegin(codebegin);
        codeType.setCodeend(codeend);
        boolean flag = codeTypeService.update(codeType);
        if(flag){
            return renderSuccess("修改成功！");

        }else{
            return renderSuccess("修改失败！");
        }


    }

    @RequestMapping("/editCodeName")
    @ResponseBody
    public Object editCodeName(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        CodeName codeName = codeNameService.selectById(Integer.parseInt(id));
        String attrid = request.getParameter("attrid");
        String attrno = request.getParameter("attrno");
        String attrname = request.getParameter("attrname");
        String viewid = request.getParameter("viewid");
        String viewcode = request.getParameter("viewcode");
        String viewname = request.getParameter("viewname");
        String modifyman = request.getParameter("modifyman");
        String typenoele = request.getParameter("typenoele");
        String kindno = request.getParameter("kindno");
        String kindnum =request.getParameter("kindnum");
        String splitstr =request.getParameter("splitstr");
        if(attrid!=null&&!attrid.equals("")){
            codeName.setAttrid(Integer.parseInt(attrid));
        }
        codeName.setAttrno(attrno);
        codeName.setAttrname(attrname);
        if(viewid!=null&&!viewid.equals("")){
            codeName.setViewid(Integer.parseInt(viewid));
        }
        codeName.setViewcode(viewcode);
        codeName.setViewname(viewname);
        codeName.setModifyman(modifyman);
        codeName.setModifydate(new Date());
        codeName.setTypenoele(typenoele);
        if(kindno!=null&&!kindno.equals("")){
            codeName.setKindno(Integer.parseInt(kindno));
        }
        if(kindnum!=null&&!kindnum.equals("")){
            codeName.setKindnum(Integer.parseInt(kindnum));
        }

        codeName.setSplitstr(splitstr);

        boolean flag = codeNameService.update(codeName);


        if(flag){
            return renderSuccess("修改成功！");

        }else{
            return renderSuccess("修改失败！");
        }


    }

    @ResponseBody
    @RequestMapping(value = "delete", method = {RequestMethod.GET, RequestMethod.POST})
    public Map delete(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("ids");
        String[] idArr = ids.split(",");
        int n = codeTypeService.delete(idArr);
        Map json = new HashMap();
        json.put("num",n);

        return json;
    }

    @ResponseBody
    @RequestMapping(value = "deleteCodeName", method = {RequestMethod.GET, RequestMethod.POST})
    public Map deleteCodeName(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("ids");
        String[] idArr = ids.split(",");
        int n = codeNameService.delete(idArr);
        Map json = new HashMap();
        json.put("num",n);

        return json;
    }


    @ResponseBody
    @RequestMapping(value = "selectCodeView", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String codemanegeid = request.getParameter("codemanegeid");
        CodeManageType codeManageType = codeManageService.selectById(Integer.parseInt(codemanegeid));
        TypeDetail typeDetail = typeDetailService.selectByNo(codeManageType.getTypeno());
        Exptype exptype = exptypeService.selectById(typeDetail.getExptypeid()+"");
        List<View> jslist = exptypeService.selectViews(exptype.getId());
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
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
    @RequestMapping(value = "selectDefines", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectDefines(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String viewid = request.getParameter("viewid");
        String codemanegeid = request.getParameter("codemanegeid");
        List<CodeName> list = codeNameService.selectByCodeManageId(Integer.parseInt(codemanegeid));
        List<AttrDefine> jslist = viewService.selectAttrDefines(Integer.parseInt(viewid));

        for(CodeName codeName:list){
            if (codeName.getTypenoele().equals("主数据属性")){
                int attrid = codeName.getAttrid();
                AttrDefine attrDefine = attrDefineService.selectById(attrid+"");
                if(jslist.contains(attrDefine)){
                    jslist.remove(attrDefine);
                }


            }
        }


        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        List<AttrDefine> jslist = viewService.selectAttrDefines(view.getId());
        JSONArray jslst = new JSONArray();
        AttrDefine attrDefine1;
        if(jslist.size()>0 ){
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                attrDefine1 = jslist.get(i);
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
                    widgettype = "引用主数据";
                }else if(widgettypeid==7){
                    widgettype = "复选框";
                }else if(widgettypeid==8){
                    widgettype = "值数据";
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
        }
        return re;
    }

    @ResponseBody
    @RequestMapping(value = "selectCodeDefine", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectCodeDefine(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String codemanegeid = request.getParameter("codemanegeid");
        List<CodeName> list = codeNameService.selectByCodeManageId(Integer.parseInt(codemanegeid));
        List<AttrDefine> jslist = new ArrayList<AttrDefine>();
        AttrDefine attrDefine;
        for(CodeName codeName:list){
            if (codeName.getTypenoele().equals("主数据属性")){
                int attrid = codeName.getAttrid();
                attrDefine = attrDefineService.selectById(attrid+"");
                jslist.add(attrDefine);
            }
        }


        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        List<AttrDefine> jslist = viewService.selectAttrDefines(view.getId());
        JSONArray jslst = new JSONArray();
        AttrDefine attrDefine1;
        if(jslist.size()>0 ){
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                attrDefine1 = jslist.get(i);
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
                    widgettype = "引用主数据";
                }else if(widgettypeid==7){
                    widgettype = "复选框";
                }else if(widgettypeid==8){
                    widgettype = "值数据";
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
        }
        return re;
    }
    @ResponseBody
    @RequestMapping(value = "selectCodeAttr", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectCodeAttr(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String attrname = request.getParameter("attrname");
        String attrno = request.getParameter("attrno");
        String codemanegeid = request.getParameter("codemanegeid");
        List<Integer> listId = new ArrayList<Integer>();
        List<Integer> listId2 = new ArrayList<Integer>();
        List<Integer> listId3 = new ArrayList<Integer>();
        List<Integer> listId4 = new ArrayList<Integer>();
        Attr attr2 = new Attr();
        attr2.setAttrname(attrname);
        attr2.setAttrno(attrno);
        List<Attr> attrs = attrService.query(attr2);
        List<CodeType> codeTypes = codeTypeService.selectByCodeManageId(Integer.parseInt(codemanegeid));
        List<Attr> jslist = new ArrayList<Attr>();
        Attr attr;
        for(CodeType codeType:codeTypes){
            int attrid = codeType.getAttrid();
            listId2.add(attrid);

        }
        for(int i=0;i<attrs.size();i++){
            for(int j=0;j<listId2.size();j++){
                if(attrs.get(i).getId()==listId2.get(j)){
                    listId.add(listId2.get(j));
                    break;
                }


            }

        }
        List<CodeName> codeNames = codeNameService.selectByCodeManageId(Integer.parseInt(codemanegeid));
        for (CodeName codeName:codeNames){
            int attrid = codeName.getAttrid();
            listId3.add(attrid);

        }
        listId.removeAll(listId3);

        for(Integer i:listId){
            attr = attrService.selectById(i);
            jslist.add(attr);
        }
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        JSONArray jslst = new JSONArray();
        Attr attr1;
        if(jslist.size()>0) {
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
                jslst.add(re1);
            }
            re.put("rows",jslst);
            re.put("total",jslst.size());
        }else {
            re.put("rows", jslst);
            re.put("total", 0);

        }
        return re;
    }
}
