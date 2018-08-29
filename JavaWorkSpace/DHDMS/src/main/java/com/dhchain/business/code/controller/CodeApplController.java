package com.dhchain.business.code.controller;



import com.dhchain.business.attr.vo.ViewAttr;
import com.dhchain.business.index.service.IndexService;
import com.dhchain.business.user.service.UserService;
import com.dhchain.business.user.vo.LoginUser;
import com.dhchain.config.result.Tree;
import com.dhchain.config.vo.ExcelUtil;
import com.sap.conn.jco.*;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.activiti.util.ResponseUtil;
import com.dhchain.business.attr.service.AttrDefineService;
import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attr.service.FactoryService;
import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.attr.vo.AttrDefine;
import com.dhchain.business.attr.vo.Factory;
import com.dhchain.business.base.service.BaseService;
import com.dhchain.business.base.vo.Base;
import com.dhchain.business.code.service.*;
import com.dhchain.business.code.vo.*;
import com.dhchain.business.exp.service.ExptypeService;
import com.dhchain.business.exp.service.ViewService;
import com.dhchain.business.exp.vo.Exptype;
import com.dhchain.business.exp.vo.View;
import com.dhchain.business.type.service.TypeDetailService;
import com.dhchain.business.type.vo.TypeDetail;
import com.dhchain.business.user.vo.ActUser;
import com.dhchain.business.user.vo.Group;
import com.dhchain.business.user.vo.MemberShip;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.IdentityLink;
import org.activiti.engine.task.Task;

import org.apache.poi.hssf.usermodel.*;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.codehaus.groovy.runtime.powerassert.SourceText;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.SchemaOutputResolver;
import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.*;


import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.dhchain.util.SAPUtil.connect;

/**
 * Created by zhenglb on 2017-10-20.
 */

@Controller
@RequestMapping("/codeappl")
public class CodeApplController {
    @Autowired
    private CodeApplService codeApplService;
    @Autowired
    private ExptypeService exptypeService;
    // lijq
    @Autowired
    private TypeDetailService typeDetailService;
    @Autowired
    private AttrService attrService;
    @Autowired
    private FactoryService factoryService;
    @Autowired
    private ViewService viewService;
    @Autowired
    private AttrDefineService attrDefineService;
    @Autowired
    private CodeNameService codeNameService;
    @Autowired
    private CodeManageService codeManageService;
    @Autowired
    private CodeTypeService codeTypeService;
    @Autowired
    private BaseService baseService;
    @Autowired
    private CodeService codeService;
    @Autowired
    private IndexService indexService;

    @Resource
    private RuntimeService runtimeService;
    @Resource
    private TaskService taskService;


    //wangq
    @ResponseBody
    @RequestMapping(value = "/codeApplycolumn", method = {RequestMethod.GET, RequestMethod.POST})
    public net.sf.json.JSONObject codeApplycolumn(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typedetailno = request.getParameter("typedetailno");
        List<CodeType> list = codeApplService.selectByTypeno(typedetailno);
        JSONArray jslst = new JSONArray();
        net.sf.json.JSONObject re = new net.sf.json.JSONObject();
        re.put("title", "行号");
        re.put("field", "itemno");
        re.put("width", "50px");
        re.put("hidden", false);
        jslst.add(re);
        net.sf.json.JSONObject re1 = new net.sf.json.JSONObject();
        re1.put("title", "ID");
        re1.put("field", "id");
        re1.put("width", "50px");
        re1.put("hidden", true);
        jslst.add(re1);
        net.sf.json.JSONObject re3 = new net.sf.json.JSONObject();
        re3.put("title", "主数据分类编码");
        re3.put("field", "typedetailno");
        re3.put("width", "100px");
        re3.put("hidden", true);
        jslst.add(re3);
        net.sf.json.JSONObject re4 = new net.sf.json.JSONObject();
        re4.put("title", "主数据分类名称");
        re4.put("field", "typedetailname");
        re4.put("width", "100px");
        re4.put("hidden", false);
//        re4.put("editor","text");
        jslst.add(re4);
        net.sf.json.JSONObject re5 = new net.sf.json.JSONObject();
        re5.put("title", "物料编码");
        re5.put("field", "codeno");
        re5.put("width", "100px");
        re5.put("hidden", false);
        jslst.add(re5);
        net.sf.json.JSONObject re6 = new net.sf.json.JSONObject();
        re6.put("title", "物料名称");
        re6.put("field", "codename");
        re6.put("width", "100px");
        re6.put("hidden", false);
        jslst.add(re6);
        CodeType codeType;
        if(list.size()>0){
            for (int i=0;i<list.size();i++){
                int j=0;
                net.sf.json.JSONObject re11 = new net.sf.json.JSONObject();
                codeType = (CodeType)list.get(i);
                re11.put("title",codeType.getAttrname());
                re11.put("field",codeType.getAttrno());
                re11.put("width","100px");
                re11.put("hidden",false);
                re11.put("editor","{ " +
                        "type: 'combobox'," +
                        "options: { " +
                        "valueField: 'id1', " +
                        "textField:  'id2'," +
                        "method:'get', " +
                        "required: false}}");
                jslst.add(re11);
            }
        }
        net.sf.json.JSONObject re7 = new net.sf.json.JSONObject();
        re7.put("title", "冻结");
        re7.put("field", "islocked");
        re7.put("width", "100px");
        re7.put("hidden", false);
        jslst.add(re7);
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }
    @ResponseBody
    @RequestMapping(value = "/codeattr", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON codeattr(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fieldname = request.getParameter("fieldname");
        List<Attr> list = codeApplService.getAttrList(fieldname);
        JSONArray jslst = new JSONArray();
        Map re = new HashMap();
        re.put("id1","");
        re.put("id2","");
        jslst.add(re);
        if(list.size()>0){
            for (int i=0;i<list.size();i++){
                Attr AttrList = (Attr)list.get(i);
                Map re1 = new HashMap();
                re1.put("id1",AttrList.getAttrname());
                re1.put("id2",AttrList.getAttrname());
                jslst.add(re1);
            }
        }
        return jslst;
    }
    /**
     * 查询所有的菜单
     */
    @RequestMapping("/attrdataselect3")
    @ResponseBody
    public Object attrdataselect3(HttpServletRequest request) {
        String fieldname = request.getParameter("attrDefineno");
        AttrDefine attrDefine = attrDefineService.selectByNo(fieldname);
        int typebase = attrDefine.getDatabasetype();
        List<Tree> trees = new ArrayList<Tree>();
        if(typebase==1){
            int baseid = attrDefine.getDatabaseid();
            Base base = baseService.selectById(baseid);
            String flag = base.getFlag();
            List<Base> jslist2 = baseService.selectByFlag(flag);
            for (Base base1 : jslist2) {
                Tree tree = new Tree();
                tree.setId((long) base1.getId());

                tree.setPid((long) base1.getFid());

                tree.setText(base1.getBasename()+"("+base1.getBaseno()+")");
                tree.setState("open");
                trees.add(tree);
            }
        }else if(typebase==2){
            int attrid = attrDefine.getAttrid();
            Attr attr = attrService.selectById(attrid);
            String flag = attr.getFlag();
            List<Attr> jslist2 = attrService.selectByFlag(flag);
            for (Attr attr1 : jslist2) {
                Tree tree = new Tree();
                tree.setId((long) attr1.getId());

                tree.setPid((long) attr1.getFid());

                tree.setText(attr1.getAttrname());
                tree.setState("open");
                trees.add(tree);
            }
        } else if(typebase==3){
            int factoryid = attrDefine.getFactoryid();
            Factory factory = factoryService.selectById(factoryid);
            String flag = factory.getFlag();
            List<Factory> jslist2 = factoryService.selectByFlag(flag);
            for (Factory factory1 : jslist2) {
                Tree tree = new Tree();
                tree.setId((long) factory1.getId());

                tree.setPid((long) factory1.getFid());

                tree.setText(factory1.getAttrname());
                tree.setState("open");
                trees.add(tree);
            }
        }
        return trees;
    }
    @ResponseBody
    @RequestMapping(value = "/attrdataselect2", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON attrdataselect2(HttpServletRequest request) throws UnsupportedEncodingException {
        String fieldname = request.getParameter("attrDefineno");
        AttrDefine attrDefine = attrDefineService.selectByNo(fieldname);
        int typebase = attrDefine.getDatabasetype();
        Map re = new HashMap();
        JSONArray jslst = new JSONArray();
        re.put("id1","");
        re.put("id2","");
        if(typebase==1){
            int baseid = attrDefine.getDatabaseid();
            //查找这个数据源的下拉框
            List<Base> list = baseService.selectByFid(baseid);
            jslst.add(re);
            if(list.size()>0){
                for (int i=0;i<list.size();i++){
                    Base base = (Base)list.get(i);
                    Map re1 = new HashMap();
                    re1.put("id1",base.getBaseno());
                    re1.put("id2",base.getBasename()+"("+base.getBaseno()+")");
                    jslst.add(re1);
                }
            }
        }else if(typebase==2){
            int attrid = attrDefine.getAttrid();
            List<Attr> list = attrService.selectByFid(attrid);
            jslst.add(re);
            if(list.size()>0){
                for (int i=0;i<list.size();i++){
                    Attr attr = (Attr) list.get(i);
                    Map re1 = new HashMap();
                    re1.put("id1",attr.getAttrno());
                    re1.put("id2",attr.getAttrname()+"("+attr.getAttrno()+")");
                    jslst.add(re1);
                }
            }
        } else if(typebase==3){
            int factoryid = attrDefine.getFactoryid();
            List<Factory> list = factoryService.selectByFid(factoryid);
            jslst.add(re);
            if(list.size()>0){
                for (int i=0;i<list.size();i++){
                    Factory factory = (Factory) list.get(i);
                    Map re1 = new HashMap();
                    re1.put("id1",factory.getAttrno());
                    re1.put("id2",factory.getAttrname()+"("+factory.getAttrno()+")");
                    jslst.add(re1);
                }
            }
        }
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/attrdataselect", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON attrdataselect(String fieldname) throws UnsupportedEncodingException {
        AttrDefine attrDefine = attrDefineService.selectByNo(fieldname);
        int databasetype = attrDefine.getDatabasetype();
        Map re = new HashMap();
        re.put("id1","");
        re.put("id2","");
        JSONArray jslst = new JSONArray();
        jslst.add(re);
        if(databasetype==1){
            int baseid = attrDefine.getDatabaseid();
            //查找这个数据源的下拉框
            List<Base> list = baseService.selectByFid(baseid);
            if(list.size()>0){
                for (int i=0;i<list.size();i++){
                    Base base = (Base)list.get(i);
                    Map re1 = new HashMap();
                    re1.put("id1",base.getBaseno());
                    re1.put("id2",base.getBasename()+"("+base.getBaseno()+")");
                    jslst.add(re1);
                }
            }
        }else if(databasetype==2){
            int attrid = attrDefine.getAttrid();
            List<Attr> list = attrService.selectByFid(attrid);
            if(list.size()>0){
                for (int i=0;i<list.size();i++){
                    Attr attr = (Attr)list.get(i);
                    Map re1 = new HashMap();
                    re1.put("id1",attr.getAttrno());
                    re1.put("id2",attr.getAttrname()+"("+attr.getAttrno()+")");
                    jslst.add(re1);
                }
            }
        }else if(databasetype==3){
            int factoryid = attrDefine.getFactoryid();
            List<Factory> list = factoryService.selectByFid(factoryid);
            if(list.size()>0){
                for (int i=0;i<list.size();i++){
                    Factory factory = (Factory)list.get(i);
                    Map re1 = new HashMap();
                    re1.put("id1",factory.getAttrno());
                    re1.put("id2",factory.getAttrname()+"("+factory.getAttrno()+")");
                    jslst.add(re1);
                }
            }
        }

        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/cascade", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON cascade(HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        String name = request.getParameter("name");
        String value = request.getParameter("value");
        int start = value.indexOf("(");
        int end = value.indexOf(")");
        value = value.substring(start+1,end);
        String typedetailid =  request.getParameter("typedetailid");
        List<String> attrs =  selectColumn(Integer.parseInt(typedetailid));
        List<String> attrs2 = new ArrayList<String>();
        int flag = name.indexOf("_");
        String attrno = name.substring(flag+1,name.length());
        AttrDefine attrDefine = attrDefineService.selectByNo(attrno);
        int baseid = attrDefine.getDatabaseid();
        List<Base> base1 = baseService.selectByNoAndFid(value,baseid);
        String rebaseids = base1.get(0).getRebaseids();
        String rebaseitems = base1.get(0).getRebaseitems();
        String[] rebaseidattr =  rebaseids.split(",");
        String[] rebaseitemattr =  rebaseitems.split(",");
        List<Base> bases = new ArrayList<Base>();
        for (String rebaseitemstr : rebaseitemattr){
            Base rebaseitem = baseService.selectById(Integer.parseInt(rebaseitemstr));
            bases.add(rebaseitem);
        }
        List<AttrDefine> attrDefineList = new ArrayList<AttrDefine>();
        for (String rebasestr : rebaseidattr){
            Base rebase = baseService.selectById(Integer.parseInt(rebasestr));
            AttrDefine attrDefine1 = attrDefineService.selectByBaseid(Integer.parseInt(rebasestr));
            attrDefineList.add(attrDefine1);

        }
        for (AttrDefine attrDefine1:attrDefineList){
            Map re = new HashMap();
            JSONArray jslst2 = new JSONArray();
            for (String attr:attrs){
                if(attr.indexOf(attrDefine1.getAttrdefineno())!=-1){
                    re.put("name",attr);
                }
            }
            for (Base rebaseitem : bases){
                if(rebaseitem.getFid()==attrDefine1.getDatabaseid()){
                    Map re1 = new HashMap();
                    re1.put("id1",rebaseitem.getBaseno());
                    re1.put("id2",rebaseitem.getBasename()+"("+rebaseitem.getBaseno()+")");
                    jslst2.add(re1);
                }
            }
            re.put("item",jslst2);
            jslst2 = null;
            jslst.add(re);
        }
        return jslst;
    }
    /**
     * 是否手动填写
     */
    public Map isSDTX(String typeno ){
        boolean bmflag = false;
        boolean msflag = false;
        CodeManageType codeManageType = codeManageService.selectByTypeno(typeno);
        if(codeManageType.getCodeway().equals("手动填写")){
            bmflag = true;
        }
        if(codeManageType.getCodenameway().equals("手动填写")){
            msflag = true;
        }
        Map map = new HashMap();
        map.put("bm",bmflag);
        map.put("ms",msflag);
        return  map;
    }

    @ResponseBody
    @RequestMapping(value = "/codeApplySTcolumn", method = {RequestMethod.GET, RequestMethod.POST})
    public  net.sf.json.JSONObject  codeApplySTcolumn(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typedetailid = request.getParameter("typedetailid");
        TypeDetail typeDetail = typeDetailService.selectById(Integer.parseInt(typedetailid));
        //是否手动填写
        Map map = isSDTX(typeDetail.getTypeno());
        String applystate = request.getParameter("applystate");
        String typeno = request.getParameter("typeno");
        String bjattrs = "";
        int flag = 0;
        List<CodeName> codeNames = codeNameService.selectByTypeno(typeno) ;
        int exptypeid = typeDetail.getExptypeid();
        Exptype exptype = exptypeService.selectById(exptypeid+"");
        List<View> views = viewService.selectByExptypeid(exptype.getId());
        JSONArray jslst = new JSONArray();
        JSONArray jslst2 = new JSONArray();
        JSONArray frozenBTColumn = new JSONArray();
        JSONArray frozenBTColumn2 = new JSONArray();
        View view;
        AttrDefine attrDefine;
        int werksflag =0;
        com.alibaba.fastjson.JSONObject re9 = new com.alibaba.fastjson.JSONObject();
        com.alibaba.fastjson.JSONObject re6 = new com.alibaba.fastjson.JSONObject();
        com.alibaba.fastjson.JSONObject re3 = new com.alibaba.fastjson.JSONObject();
        re9.put("colspan",1);
        re9.put("width",60);
        re9.put("align","center");
        re9.put("hidden",true);
        frozenBTColumn.add(re9);
        re6.put("colspan",1);
        re6.put("width",60);
        re6.put("align","center");
        frozenBTColumn.add(re6);
        re3.put("colspan",2);
        re3.put("width",300);
        re3.put("title","主数据信息");
        re3.put("align","center");
        frozenBTColumn.add(re3);
        com.alibaba.fastjson.JSONObject re8 = new com.alibaba.fastjson.JSONObject();
        re8.put("field","id");
        re8.put("title","id");
        re8.put("width","60");
        re8.put("hidden",true);
        frozenBTColumn2.add(re8);
        com.alibaba.fastjson.JSONObject re7 = new com.alibaba.fastjson.JSONObject();
        re7.put("field","itemno");
        re7.put("title","行号");
        re7.put("width","60");
        frozenBTColumn2.add(re7);
        com.alibaba.fastjson.JSONObject re4 = new com.alibaba.fastjson.JSONObject();
        com.alibaba.fastjson.JSONObject re5 = new com.alibaba.fastjson.JSONObject();
        re4.put("field","codeno");
        re4.put("title","主数据编码");
        re4.put("width","100");
        if((Boolean) map.get("bm")){
            com.alibaba.fastjson.JSONObject json1 = new com.alibaba.fastjson.JSONObject();
            json1.put("required",true);
            com.alibaba.fastjson.JSONObject json2 = new com.alibaba.fastjson.JSONObject();
            json2.put("type","validatebox");
            json2.put("options",json1);
            re4.put("editor",json2);
        }
        re5.put("field","codename");
        re5.put("title","主数据描述");
        re5.put("width","200");
        if((Boolean) map.get("ms")){
            com.alibaba.fastjson.JSONObject json1 = new com.alibaba.fastjson.JSONObject();
            json1.put("required",true);
            com.alibaba.fastjson.JSONObject json2 = new com.alibaba.fastjson.JSONObject();
            json2.put("type","validatebox");
            json2.put("options",json1);
            re5.put("editor",json2);
        }
        frozenBTColumn2.add(re4);
        frozenBTColumn2.add(re5);
        if(views.size()>0){
            for (int i=0;i<views.size();i++){
                view = views.get(i);
                com.alibaba.fastjson.JSONObject re1 = new com.alibaba.fastjson.JSONObject();
                List<AttrDefine> attrDefines = viewService.selectAttrDefines(view.getId());
                re1.put("colspan",attrDefines.size());
                re1.put("title",view.getViewname());
                re1.put("width",100*attrDefines.size());
                re1.put("align","center");
                jslst.add(re1);
                if(attrDefines.size()>0){
                    for (int j=0;j<attrDefines.size();j++){
                        flag+=1;
                        attrDefine = attrDefines.get(j);
                            for (CodeName codeName:codeNames){
                                if ( codeName.getAttrname().equals(attrDefine.getAttrdefinename())&& (codeName.getViewid()==view.getId())){
                                    String bjattr = "t" + flag;
                                    bjattrs =  bjattrs + bjattr+",";
                                }
                            }
                        com.alibaba.fastjson.JSONObject re2 = new com.alibaba.fastjson.JSONObject();
                        re2.put("field",view.getViewcode()+"_"+attrDefine.getAttrdefineno());
                        re2.put("title",attrDefine.getAttrdefinename());
                        re2.put("width","150");
                        if(applystate==null||!applystate.equals("主数据申请审核")){
                            if(attrDefine.getWidgettype()==1||attrDefine.getWidgettype()==8){
                                com.alibaba.fastjson.JSONObject json1 = new com.alibaba.fastjson.JSONObject();
                                if(attrDefine.getIsrequired()==1){
                                    json1.put("required",true);
                                }else {
                                    json1.put("required",false);
                                }
                                com.alibaba.fastjson.JSONObject json2 = new com.alibaba.fastjson.JSONObject();
                                json2.put("type","validatebox");
                                json2.put("options",json1);
                                re2.put("editor",json2);
                            }else if(attrDefine.getWidgettype()==5){
                                JSON json = attrdataselect(attrDefine.getAttrdefineno());
                                com.alibaba.fastjson.JSONObject json1 = new com.alibaba.fastjson.JSONObject();
                                json1.put("valueField","id1");
                                json1.put("textField","id2");
                                json1.put("data",json);
                                if(attrDefine.getIsrequired()==1){
                                    json1.put("required",true);
                                }else {
                                    json1.put("required",false);
                                }
                                com.alibaba.fastjson.JSONObject json2 = new com.alibaba.fastjson.JSONObject();
                                json2.put("type","combobox");
                                json2.put("options",json1);
                                re2.put("editor",json2);
                            }else if(attrDefine.getWidgettype()==6){
                                JSON json = attrdataselect(attrDefine.getAttrdefineno());
                                com.alibaba.fastjson.JSONObject json1 = new com.alibaba.fastjson.JSONObject();
                                json1.put("valueField","id1");
                                json1.put("textField","id2");
                                json1.put("multiple",true);
                                json1.put("data",json);
                                if(attrDefine.getIsrequired()==1){
                                    json1.put("required",true);
                                }else {
                                    json1.put("required",false);
                                }
                                com.alibaba.fastjson.JSONObject json2 = new com.alibaba.fastjson.JSONObject();
                                json2.put("type","combobox");
                                json2.put("options",json1);
                                re2.put("editor",json2);
                            } else if(attrDefine.getWidgettype()==7){
                                com.alibaba.fastjson.JSONObject json1 = new com.alibaba.fastjson.JSONObject();
                                json1.put("on","√");
                                json1.put("off","");
                                if(attrDefine.getIsrequired()==1){
                                    json1.put("required",true);
                                }else {
                                    json1.put("required",false);
                                }
                                com.alibaba.fastjson.JSONObject json2 = new com.alibaba.fastjson.JSONObject();
                                json2.put("type","checkbox");
                                json2.put("options",json1);
                                re2.put("editor",json2);
                            }
                            else if(attrDefine.getWidgettype()==2){
                                com.alibaba.fastjson.JSONObject json1 = new com.alibaba.fastjson.JSONObject();
                                if(attrDefine.getIsrequired()==1){
                                    json1.put("required",true);
                                }else {
                                    json1.put("required",false);
                                }
//                                json1.put("value",0);
                                json1.put("type","numberbox");

                                re2.put("editor",json1);
                            }


                        }
                        if(attrDefine.getAttrdefineno().indexOf("MARC-WERKS")!=-1){
                            werksflag = flag;
                        }

                        jslst2.add(re2);
                    }
                }
            }
        }
        net.sf.json.JSONObject re = new net.sf.json.JSONObject();
        re.put("views",jslst);
        re.put("attrDefines",jslst2);
        re.put("werksflag",werksflag);
        re.put("FirstFrozenColumns",frozenBTColumn);
        re.put("SecondFrozenColumns",frozenBTColumn2);
        re.put("bjattrs",bjattrs);
        return re;
    }


    public List<String> selectColumn(int typedetailid){
        TypeDetail typeDetail = typeDetailService.selectById(typedetailid);
        Exptype exptype = exptypeService.selectById(typeDetail.getExptypeid()+"");
        List<View> views = viewService.selectByExptypeid(exptype.getId());
        List<String> list = new ArrayList<String>();
        if(views.size()>0){
            for (int i=0;i<views.size();i++){
                View view = views.get(i);
                List<AttrDefine> attrDefines = viewService.selectAttrDefines(view.getId());
                if(attrDefines.size()>0){
                    for (int j=0;j<attrDefines.size();j++){
                        AttrDefine attrDefine = attrDefines.get(j);
                        list.add(view.getViewcode()+"_"+attrDefine.getAttrdefineno());
                    }
                }

            }
        }

        return list;
    }

    @ResponseBody
    @RequestMapping(value = "Apply", method = {RequestMethod.GET, RequestMethod.POST})
    public String Apply(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String rows = request.getParameter("entities");
        CodeAppl codeAppl =new CodeAppl();
        String user = request.getParameter("nowuser");
        Date date = new Date();
        String applyreasons = request.getParameter("applyreasons");
        String bjattrs =  request.getParameter("bjattrs");
        String typeno = request.getParameter("typeno");
        String rank = request.getParameter("rank");
        codeAppl.setRank(Integer.parseInt(rank));
        codeAppl.setInputdate(date);
        codeAppl.setInputman(user);
        codeAppl.setApplyreasons(applyreasons);
        String type = request.getParameter("type");
        codeAppl.setApplystate("创建");
        codeAppl.setApplytype("创建");
        boolean flag = true;
        String typedetailid = request.getParameter("typedetailid");
        TypeDetail typeDetail = typeDetailService.selectById(Integer.parseInt(typedetailid));
        codeAppl.setTypedetailid(Integer.parseInt(typedetailid));
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");

        String applyno = codeApplService.selectTodayMaxApplyno();
        codeAppl.setApplyno(applyno);

//        int newid = codeApplService.selectNewId();
//        CodeAppl codeAppl1 = codeApplService.selectById(newid);
        Map map = selectByTypeDetailId(Integer.parseInt(typedetailid));
        List<String> attrDefines = (List<String>) map.get("attrDefineList");
        List<AttrDefine> attrDefineList = (List<AttrDefine>) map.get("attrs");
        int werkindex = (int) map.get("werkindex");
        String[] codeApplRows = rows.split("、");
        CodeApplDetail codeApplDetail =new CodeApplDetail();
        JSONArray jslst = new JSONArray();
        JSONObject re =  codeapplcheck2(codeApplRows,typeno,bjattrs);
        boolean exsit = (boolean) re.get("success");
        if(!exsit&&type.equals("申请")){
            ResponseUtil.write(response, re);
            return null;
        }else {
            int m = 0;
            List<CodeApplDetail> list = new ArrayList<CodeApplDetail>();

            Class<?> clazz = CodeApplDetail.class;
            Class<?> codeclazz = Code.class;
            for(String codeApplRow:codeApplRows){
                String codea = codeApplRow.substring(1,codeApplRow.length()-1);
                String[] codeasx = codea.split(",");
                if(type.equals("申请")){
                    codeAppl.setIsexpand(0);
                    codeApplDetail.setIsexpand(0);
                    for (String codeString:codeasx){
                        if(codeString.split(":")[0].replaceAll("\"","").equals("itemno")){
                            codeApplDetail.setItemno(codeString.split(":")[1].replaceAll("\"",""));
                        }else if(codeString.split(":")[0].replaceAll("\"","").equals("codeno")){
                            codeApplDetail.setCodeno(codeString.split(":")[1].replaceAll("\"",""));
                        }else if(codeString.split(":")[0].replaceAll("\"","").equals("codename")){
                            codeApplDetail.setCodename(codeString.split(":")[1].replaceAll("\"",""));
                        } else{
                            for (int j=1;j<=attrDefines.size();j++) {
                                if (attrDefines.get(j-1).equals(codeString.split(":")[0].replaceAll("\"", ""))) {
                                    PropertyDescriptor pd = new PropertyDescriptor("t"+(j), clazz);
                                    Method wM = pd.getWriteMethod();
                                    //下拉框显示值
                                    String xlk = codeString.split(":")[1].replaceAll("\"","");
                                    AttrDefine attrDefine = attrDefineList.get(j-1);
                                    if(attrDefine.getWidgettype()==5){
                                        int start = xlk.lastIndexOf("(");
                                        if(xlk.equals("")||start==-1){
                                            wM.invoke(codeApplDetail, xlk);
                                        }else{
                                            wM.invoke(codeApplDetail, xlk.substring(start+1,xlk.length()-1));
                                        }
                                    }
                                    else if(attrDefine.getWidgettype()==6){
                                        String[] xlks = xlk.split(",");
                                        String xlkz = "";
                                        for (String xlkxx:xlks){
                                            int start = xlkxx.lastIndexOf("(");
                                            if(xlkxx.equals("")||start==-1){
                                                xlkz = xlkz+xlkxx+",";

                                            }else{
                                                xlkz = xlkz +  xlkxx.substring(start+1,xlkxx.length()-1)+",";

                                            }
                                        }
                                        wM.invoke(codeApplDetail, xlkz);

                                    }
                                    else if(attrDefine.getWidgettype()==8){
                                        int start = xlk.lastIndexOf("(");
                                        if(xlk.equals("")||start==-1){
                                            wM.invoke(codeApplDetail, xlk);
                                        }else{
                                            wM.invoke(codeApplDetail, xlk.substring(start+1,xlk.length()-1));
                                        }

                                    }
                                    else {
                                        wM.invoke(codeApplDetail, xlk);
                                    }

                                }
                            }
                        }
                    }

                }else{
                    codeAppl.setIsexpand(1);
//                    codeApplDetail.setIsexpand(1);
                    String codeno = "";

                    for (String codeString:codeasx){
                        if(codeString.split(":")[0].replaceAll("\"","").equals("itemno")){
                            codeApplDetail.setItemno(codeString.split(":")[1].replaceAll("\"",""));
                        }else if(codeString.split(":")[0].replaceAll("\"","").equals("codeno")){
                            codeApplDetail.setCodeno(codeString.split(":")[1].replaceAll("\"",""));
                        }else if(codeString.split(":")[0].replaceAll("\"","").equals("codename")){
                            codeApplDetail.setCodename(codeString.split(":")[1].replaceAll("\"",""));
                        } else{
                            for (int j=1;j<=attrDefines.size();j++) {
                                if (attrDefines.get(j-1).equals(codeString.split(":")[0].replaceAll("\"", ""))) {
                                    PropertyDescriptor pd = new PropertyDescriptor("t"+(j), clazz);
                                    Method wM = pd.getWriteMethod();
                                    //下拉框显示值
                                    String xlk = codeString.split(":")[1].replaceAll("\"","");
                                    AttrDefine attrDefine = attrDefineList.get(j-1);
                                    if(attrDefine.getWidgettype()==5){
                                        int start = xlk.lastIndexOf("(");
                                        if(xlk.equals("")||start==-1){
                                            wM.invoke(codeApplDetail, xlk);
                                        }else{
                                            wM.invoke(codeApplDetail, xlk.substring(start+1,xlk.length()-1));
                                        }
                                    }
                                    else if(attrDefine.getWidgettype()==6){
                                        String[] xlks = xlk.split(",");
                                        String xlkz = "";
                                        for (String xlkxx:xlks){
                                            int start = xlkxx.lastIndexOf("(");
                                            if(xlkxx.equals("")||start==-1){
                                                xlkz = xlkz+xlkxx+",";

                                            }else{
                                                xlkz = xlkz +  xlkxx.substring(start+1,xlkxx.length()-1)+",";

                                            }
                                        }
                                        wM.invoke(codeApplDetail, xlkz);

                                    }
                                    else if(attrDefine.getWidgettype()==8){
                                        int start = xlk.lastIndexOf("(");
                                        if(xlk.equals("")||start==-1){
                                            wM.invoke(codeApplDetail, xlk);
                                        }else{
                                            wM.invoke(codeApplDetail, xlk.substring(start+1,xlk.length()-1));
                                        }

                                    }
                                    else {
                                        wM.invoke(codeApplDetail, xlk);
                                    }

                                }


                            }
                        }
                    }

                }

                codeApplDetail.setApplyno(applyno);
                codeApplDetail.setTypedetailid(Integer.parseInt(typedetailid));
                codeApplDetail.setTypedetailno(typeDetail.getTypeno());
                codeApplDetail.setTypedetailname(typeDetail.getTypename());
                codeApplDetail.setInputdate(date);
                codeApplDetail.setInputman(user);
                if(type.equals("申请")){
                    int i = codeApplService.insertDetail(codeApplDetail);
                    int newid2 = codeApplService.selectNewDetailId();
                    list.add(codeApplService.selectByDetailId(newid2));

                    m+=i;
                }else{
                    Code code = new Code();
                    code.setCodeno(codeApplDetail.getCodeno());
                    PropertyDescriptor pd = new PropertyDescriptor("t"+werkindex, codeclazz);
                    Method wM = pd.getWriteMethod();
                    PropertyDescriptor pd2 = new PropertyDescriptor("t"+werkindex, clazz);
                    Method rM = pd2.getReadMethod();
                    wM.invoke(code, rM.invoke(codeApplDetail));
                    Code code2 = new Code();
                    code2.setCodeno(codeApplDetail.getCodeno());
                    //相同物料号相同物料工厂
                    List<Code> codes = codeService.select(code);
                    //相同物料号相同物料
                    List<Code> codes1 = codeService.select(code2);
                    if(codes1==null||codes1.size()==0){
                        flag = false;
                        com.alibaba.fastjson.JSONObject re2 = new com.alibaba.fastjson.JSONObject();
                        re2.put("itemno",codeApplDetail.getItemno());
                        re2.put("codeno",codeApplDetail.getCodeno());
                        re2.put("reason","主数据中无该物料号，请先创建该物料");
                        jslst.add(re2);
                    }else{
                        //有相同工厂，有相同物料号 走修改
                        if(codes!=null&&codes.size()!=0){
                            codeApplDetail.setCodeid(codes.get(0).getId());
                            int i = codeApplService.insertDetail(codeApplDetail);
                            int newid2 = codeApplService.selectNewDetailId();
                            list.add(codeApplService.selectByDetailId(newid2));
                            codeAppl.setIsexpand(2);
                            m+=i;
                        }else{
                            //有相同物料号，无相同工厂 走扩充
                            int i = codeApplService.insertDetail(codeApplDetail);
                            int newid2 = codeApplService.selectNewDetailId();
                            list.add(codeApplService.selectByDetailId(newid2));
                            codeApplDetail.setIsexpand(1);
                            m+=i;
                        }
                    }

                }




            }
            Map<String,Object> variables=new HashMap<String,Object>();
            variables.put("applyno", applyno);
            variables.put("userID", user);
            LoginUser approveman = indexService.selectApproveman();
            variables.put("approveId", approveman.getLoginName());
            LoginUser confirmman = indexService.selectConfirmman();
            variables.put("confirmId", confirmman.getLoginName());
            // 启动流程
            if(flag){
                ProcessInstance pi= runtimeService.startProcessInstanceByKey("vacationRequest6",variables);
                codeAppl.setProcessInstanceId(pi.getProcessInstanceId());
            }

            int n = codeApplService.add(codeAppl);
            net.sf.json.JSONObject result=new net.sf.json.JSONObject();
            result.put("success", flag);
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            result.put("inputdate",sdf.format(codeAppl.getInputdate()));
            result.put("applyno", applyno);
            result.put("applytype", codeAppl.getApplytype());
            result.put("inputman", codeAppl.getInputman());
            result.put("grid",jslst);
            ResponseUtil.write(response, result);

            return null;

        }


    }

    public Map selectByTypeDetailId(int typedetailid){
        TypeDetail typeDetail = typeDetailService.selectById(typedetailid);
        Exptype exptype = exptypeService.selectById(typeDetail.getExptypeid()+"");
        List<View> views = viewService.selectByExptypeid(exptype.getId());
        List<String> attrDefineList = new ArrayList<String>();
        List<String> viewList = new ArrayList<String>();
        List<AttrDefine> attrs = new ArrayList<AttrDefine>();
        int i = 0 ;
        int werkindex = 0;
        for (View view:views){
            viewList.add(view.getViewcode());
            List<AttrDefine> attrDefines = viewService.selectAttrDefines(view.getId());
            for (AttrDefine attrDefine:attrDefines){
                i+=1;
                attrDefineList.add(view.getViewcode()+"_"+attrDefine.getAttrdefineno());
                attrs.add(attrDefine);
                if(attrDefine.getAttrdefineno().indexOf("MARC-WERKS")!=-1){
                    werkindex = i;
                }
            }
        }
        Map map = new HashMap();
        map.put("attrDefineList",attrDefineList);
        map.put("viewList",viewList);
        map.put("attrs",attrs);
        map.put("werkindex",werkindex);
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/selectCXTJ", method = {RequestMethod.GET, RequestMethod.POST})
    public net.sf.json.JSONObject  selectCXTJ(HttpServletRequest request){
        String typedetailid = request.getParameter("typedetailid");
        TypeDetail typeDetail = typeDetailService.selectById(Integer.parseInt(typedetailid));
        Exptype exptype = exptypeService.selectById(typeDetail.getExptypeid()+"");
        int exptypeid = exptype.getId();
        List<AttrDefine> exptypeparms = exptypeService.selectParms(exptypeid);
        List<View> views = viewService.selectByExptypeid(exptype.getId());
        List<AttrDefine> attrDefineList = new ArrayList<AttrDefine>();
        JSONArray jslst = new JSONArray();
        net.sf.json.JSONObject re = new net.sf.json.JSONObject();
        List<Integer> parmIds = new ArrayList<Integer>();
        int index = 0;
        for (AttrDefine attrDefine1:exptypeparms){
            parmIds.add(attrDefine1.getId());
        }

        for (View view:views){
            List<AttrDefine> attrDefines = viewService.selectAttrDefines(view.getId());
            for (AttrDefine attrDefine:attrDefines){
                attrDefineList.add(attrDefine);
            }
        }

        for (AttrDefine attrDefine:attrDefineList){
            index+=1;
            if(parmIds.contains(attrDefine.getId())){
                net.sf.json.JSONObject re1 = new net.sf.json.JSONObject();
                re1.put("widgettype",attrDefine.getWidgettype());
                re1.put("attrdefinename",attrDefine.getAttrdefinename());
                re1.put("attrdefino",attrDefine.getAttrdefineno());
                re1.put("database",attrDefine.getDatabaseid());
                re1.put("datatype",attrDefine.getDatatype());
                re1.put("precision",attrDefine.getPrecision());
                re1.put("t","t"+index);
                jslst.add(re1);
            }

        }
        re.put("attrDefines",jslst);
        re.put("total",jslst.size());
        return  re;
    }

    @ResponseBody
    @RequestMapping(value = "ApplyAndPass", method = {RequestMethod.GET, RequestMethod.POST})
    public String ApplyAndPass(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String rows = request.getParameter("entities");
        CodeAppl codeAppl =new CodeAppl();
        String user = request.getParameter("nowuser");
        Date date = new Date();
        boolean flag = true;
        JSONArray jslst = new JSONArray();
        String applyreasons = request.getParameter("applyreasons");
        String bjattrs =  request.getParameter("bjattrs");
        String typeno = request.getParameter("typeno");
        String type = request.getParameter("type");
        String rank = request.getParameter("rank");
        codeAppl.setInputdate(date);
        codeAppl.setInputman(user);
        codeAppl.setRank(Integer.parseInt(rank));
        codeAppl.setApplyreasons(applyreasons);
        codeAppl.setApplystate("开始审核");
        codeAppl.setApplytype("创建并发送");
        String typedetailid = request.getParameter("typedetailid");
        TypeDetail typeDetail = typeDetailService.selectById(Integer.parseInt(typedetailid));
        codeAppl.setTypedetailid(Integer.parseInt(typedetailid));
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");
        String applyno = codeApplService.selectTodayMaxApplyno();
        codeAppl.setApplyno(applyno);
        String[] codeApplRows = rows.split("、");
        JSONObject re =  codeapplcheck2(codeApplRows,typeno,bjattrs);
        boolean exsit = (boolean) re.get("success");
        if(!exsit&&type.equals("申请")){
            ResponseUtil.write(response, re);
            return null;
        }else {
            CodeApplDetail codeApplDetail =new CodeApplDetail();
            int m = 0;
            List<CodeApplDetail> list = new ArrayList<CodeApplDetail>();
            Class<?> clazz = CodeApplDetail.class;
            Class<?> codeclazz = Code.class;
            Map map = selectByTypeDetailId(Integer.parseInt(typedetailid));
            List<String> attrDefines = (List<String>) map.get("attrDefineList");
            List<AttrDefine> attrDefineList = (List<AttrDefine>) map.get("attrs");
            int werkindex = (int) map.get("werkindex");
            for(String codeApplRow:codeApplRows){
                String codea = codeApplRow.substring(1,codeApplRow.length()-1);
                String[] codeasx = codea.split("\",\"");
                if(type.equals("申请")){
                    codeAppl.setIsexpand(0);
                    codeApplDetail.setIsexpand(0);
                    for (String codeString:codeasx){
                        if(codeString.split(":")[0].replaceAll("\"","").equals("itemno")){
                            codeApplDetail.setItemno(codeString.split(":")[1].replaceAll("\"",""));
                        }else if(codeString.split(":")[0].replaceAll("\"","").equals("codeno")){
                            codeApplDetail.setCodeno(codeString.split(":")[1].replaceAll("\"",""));
                        }else if(codeString.split(":")[0].replaceAll("\"","").equals("codename")){
                            codeApplDetail.setCodename(codeString.split(":")[1].replaceAll("\"",""));
                        } else{
                            for (int j=1;j<=attrDefines.size();j++) {
                                if (attrDefines.get(j-1).equals(codeString.split(":")[0].replaceAll("\"", ""))) {
                                    PropertyDescriptor pd = new PropertyDescriptor("t"+(j), clazz);
                                    Method wM = pd.getWriteMethod();
                                    //下拉框显示值
                                    String xlk = codeString.split(":")[1].replaceAll("\"","");
                                    AttrDefine attrDefine = attrDefineList.get(j-1);
                                    if(attrDefine.getWidgettype()==5){
                                        int start = xlk.lastIndexOf("(");
                                        if(xlk.equals("")||start==-1){
                                            wM.invoke(codeApplDetail, xlk);
                                        }else{
                                            wM.invoke(codeApplDetail, xlk.substring(start+1,xlk.length()-1));
                                        }
                                    }
                                    else if(attrDefine.getWidgettype()==6){
                                        String[] xlks = xlk.split(",");
                                        String xlkz = "";
                                        for (String xlkxx:xlks){
                                            int start = xlkxx.lastIndexOf("(");
                                            if(xlkxx.equals("")||start==-1){
                                                xlkz = xlkz+xlkxx+",";

                                            }else{
                                                xlkz = xlkz +  xlkxx.substring(start+1,xlkxx.length()-1)+",";

                                            }
                                        }
                                        wM.invoke(codeApplDetail, xlkz);

                                    }
                                    else if(attrDefine.getWidgettype()==8){
                                        int start = xlk.lastIndexOf("(");
                                        if(xlk.equals("")||start==-1){
                                            wM.invoke(codeApplDetail, xlk);
                                        }else{
                                            wM.invoke(codeApplDetail, xlk.substring(start+1,xlk.length()-1));
                                        }

                                    }
                                    else {
                                        wM.invoke(codeApplDetail, xlk);
                                    }

                                }
                            }
                        }
                    }

                }else{
                    codeAppl.setIsexpand(1);
//                    codeApplDetail.setIsexpand(1);
                    for(int i = 0;i<codeasx.length;i++){
                        if(codeasx[i].split(":")[0].replaceAll("\"","").equals("itemno")){
                            codeApplDetail.setItemno(codeasx[i].split(":")[1].replaceAll("\"",""));
                        }else if(codeasx[i].split(":")[0].replaceAll("\"","").equals("codeno")){
                            codeApplDetail.setCodeno(codeasx[i].split(":")[1].replaceAll("\"",""));
                        }else if(codeasx[i].split(":")[0].replaceAll("\"","").equals("codename")){
                            codeApplDetail.setCodename(codeasx[i].split(":")[1].replaceAll("\"",""));
                        }else {

                            for (int j=1;j<=attrDefines.size();j++){
                                if(codeasx[i].split(":")[0].replaceAll("\"","").equals(attrDefines.get(j-1))){
                                    PropertyDescriptor pd = new PropertyDescriptor("t"+(j), clazz);
                                    Method wM = pd.getWriteMethod();
                                    //下拉框显示值
                                    String xlk = codeasx[i].split(":")[1].replaceAll("\"","");
                                    AttrDefine attrDefine = attrDefineList.get(j-1);
                                    if(attrDefine.getWidgettype()==5){
                                        int start = xlk.lastIndexOf("(");
                                        if(xlk.equals("")||start==-1){
                                            wM.invoke(codeApplDetail, xlk);
                                        }else{
                                            wM.invoke(codeApplDetail, xlk.substring(start+1,xlk.length()-1));
                                        }
                                    }else {
                                        wM.invoke(codeApplDetail, xlk);
                                    }


                                }
                            }
                        }


                    }
                }

                codeApplDetail.setApplyno(applyno);
                codeApplDetail.setTypedetailid(Integer.parseInt(typedetailid));
                codeApplDetail.setInputdate(date);
                codeApplDetail.setInputman(user);
                codeApplDetail.setTypedetailno(typeDetail.getTypeno());
                codeApplDetail.setTypedetailname(typeDetail.getTypename());
                if(type.equals("申请")){
                    int i = codeApplService.insertDetail(codeApplDetail);
                    int newid2 = codeApplService.selectNewDetailId();
                    list.add(codeApplService.selectByDetailId(newid2));

                    m+=i;
                }else{
                    Code code = new Code();
                    code.setCodeno(codeApplDetail.getCodeno());
                    PropertyDescriptor pd = new PropertyDescriptor("t"+werkindex, codeclazz);
                    Method wM = pd.getWriteMethod();
                    PropertyDescriptor pd2 = new PropertyDescriptor("t"+werkindex, clazz);
                    Method rM = pd2.getReadMethod();
                    wM.invoke(code, rM.invoke(codeApplDetail));
                    Code code2 = new Code();
                    code2.setCodeno(codeApplDetail.getCodeno());
                    //相同物料号相同物料工厂
                    List<Code> codes = codeService.select(code);
                    //相同物料号相同物料
                    List<Code> codes1 = codeService.select(code2);
                    if(codes1==null||codes1.size()==0){
                        flag = false;
                        com.alibaba.fastjson.JSONObject re2 = new com.alibaba.fastjson.JSONObject();
                        re2.put("itemno",codeApplDetail.getItemno());
                        re2.put("codeno",codeApplDetail.getCodeno());
                        re2.put("reason","主数据中无该物料号，请先创建该物料");
                        jslst.add(re2);
                    }else{
                        //有相同工厂，有相同物料号 走修改
                        if(codes!=null&&codes.size()!=0){
                            codeApplDetail.setCodeid(codes.get(0).getId());
                            int i = codeApplService.insertDetail(codeApplDetail);
                            int newid2 = codeApplService.selectNewDetailId();
                            list.add(codeApplService.selectByDetailId(newid2));
                            codeAppl.setIsexpand(2);
                            m+=i;
                        }else{
                            //有相同物料号，无相同工厂 走扩充
                            codeApplDetail.setIsexpand(1);
                            int i = codeApplService.insertDetail(codeApplDetail);
                            int newid2 = codeApplService.selectNewDetailId();
                            list.add(codeApplService.selectByDetailId(newid2));
                            m+=i;
                        }
                    }

                }

//                int i = codeApplService.insertDetail(codeApplDetail);
//                int newid2 = codeApplService.selectNewDetailId();
//                m+=i;
//                list.add(codeApplService.selectByDetailId(newid2));
            }
            Map<String,Object> variables=new HashMap<String,Object>();
            variables.put("applyno", applyno);
            variables.put("userID", user);
            LoginUser approveman = indexService.selectApproveman();
            variables.put("approveId", approveman.getLoginName());
            LoginUser confirmman = indexService.selectConfirmman();
            variables.put("confirmId", confirmman.getLoginName());
            // 启动流程
            if(flag){
                ProcessInstance pi= runtimeService.startProcessInstanceByKey("vacationRequest6",variables);
                codeAppl.setProcessInstanceId(pi.getProcessInstanceId());
                Task task=taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
                taskService.complete(task.getId());
                codeAppl.setApplystate("主数据申请审核");
                codeAppl.setProcessInstanceId(pi.getProcessInstanceId());
            }

            int n = codeApplService.add(codeAppl);
            JSONObject result=new JSONObject();
            result.put("success", flag);
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            result.put("inputdate",sdf.format(date));
            result.put("applyno", applyno);
            result.put("applytype", codeAppl.getApplytype());
            result.put("inputman", codeAppl.getInputman());
            result.put("grid",jslst);
            ResponseUtil.write(response, result);
//        Save(list);
            return null;

        }


    }


    @ResponseBody
    @RequestMapping("/export")
    public void export(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
            request.setCharacterEncoding("UTF-8");
            String typedetailid = request.getParameter("typedetailid");
            response.reset(); //清除buffer缓存
            Map<String,Object> map=new HashMap<String,Object>();
            // 指定下载的文件名
            String fileName="";
            try {
                fileName = URLEncoder.encode("月度计划", "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            HSSFWorkbook workbook=null;
            //导出Excel对象
            Map map2 = selectByTypeDetailId(Integer.parseInt(typedetailid));
            workbook = codeApplService.exportExcelInfo(map2);
            OutputStream output;
            try {
                output = response.getOutputStream();
                BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
                bufferedOutPut.flush();
                workbook.write(bufferedOutPut);
                bufferedOutPut.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

    }

    @ResponseBody
    @RequestMapping(value = "/selectkj", method = {RequestMethod.GET, RequestMethod.POST})
    public net.sf.json.JSONObject selectkj(HttpServletRequest request) throws UnsupportedEncodingException {
        String typedetailid = request.getParameter("typedetailid");
        TypeDetail typeDetail = typeDetailService.selectById(Integer.parseInt(typedetailid));
        Exptype exptype = exptypeService.selectById(typeDetail.getExptypeid()+"");
        List<View> views = viewService.selectByExptypeid(exptype.getId());


        net.sf.json.JSONObject re3 = new net.sf.json.JSONObject();
        JSONArray jslst2 = new JSONArray();
        for (View view:views){
            net.sf.json.JSONObject re2 = new net.sf.json.JSONObject();
            JSONArray jslst = new JSONArray();
            List<AttrDefine> attrDefines = viewService.selectAttrDefines(view.getId());
            for (AttrDefine attrDefine:attrDefines){
                net.sf.json.JSONObject re1 = new net.sf.json.JSONObject();
                re1.put("widgettype",attrDefine.getWidgettype());
                re1.put("attrdefinename",attrDefine.getAttrdefinename());
                re1.put("attrdefino",attrDefine.getAttrdefineno());
                re1.put("database",attrDefine.getDatabaseid());
                re1.put("datatype",attrDefine.getDatatype());
                re1.put("precision",attrDefine.getPrecision());
                re1.put("required",attrDefine.getIsrequired());
                ViewAttr viewAttr = viewService.selectViewAttr(view.getId(),attrDefine.getId());
                if(viewAttr==null){
                    re1.put("attrdefault","");
                }else{
                    if(viewAttr.getAttrdefault()==null){
                        re1.put("attrdefault","");
                    }else{
                        re1.put("attrdefault",viewAttr.getAttrdefault());
                    }

                }

                jslst.add(re1);
            }
            re2.put("attrdefines",jslst);
            re2.put("viewname",view.getViewname());
            re2.put("viewcode",view.getViewcode());
            re2.put("size",attrDefines.size());
            jslst2.add(re2);
        }
        re3.put("exptypename",exptype.getExptypename());
        re3.put("exptypeno",exptype.getExptypeno());
        re3.put("views",jslst2);
        re3.put("total",views.size());
        return re3;

    }


    /**
     * 查询流程信息
     * @param response
     * @param taskId  流程实例ID
     * @return
     * @throws Exception
     */
    @RequestMapping("/getCodeApplByTaskId")
    public Map getCodeApplByTaskId(HttpServletResponse response,String taskId) throws Exception{
        //先根据流程ID查询
        Task task=taskService.createTaskQuery().taskId(taskId).singleResult();
        CodeAppl codeAppl=codeApplService.getCodeApplByTaskId(task.getProcessInstanceId());
        net.sf.json.JSONObject result=new net.sf.json.JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        result.put("id", codeAppl.getId());
        TypeDetail typeDetail = typeDetailService.selectById(codeAppl.getTypedetailid());
        result.put("typedetail", typeDetail.getTypename());
        result.put("typeno", typeDetail.getTypeno());
        result.put("typedetailid", codeAppl.getTypedetailid());
        result.put("applytype", codeAppl.getApplytype());
        result.put("applyreasons", codeAppl.getApplytype());
        result.put("applystate", codeAppl.getApplystate());
        result.put("inputman", codeAppl.getInputman());
        result.put("inputdate", sdf.format(codeAppl.getInputdate()));
        result.put("applyno", codeAppl.getApplyno());
        result.put("processInstanceId", codeAppl.getProcessInstanceId());
        ResponseUtil.write(response, result);
        return null;
    }


    @ResponseBody
    @RequestMapping(value = "select", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        request.setCharacterEncoding("utf-8");
        String applyno = request.getParameter("applyno");
       CodeAppl codeAppl = codeApplService.selectByApplyno(applyno);
        Map map2 = selectByTypeDetailId(codeAppl.getTypedetailid());
        List<AttrDefine> attrDefineList = (List<AttrDefine>) map2.get("attrs");
//       int codeApplid = codeAppl.getId();
       List<CodeApplDetail> codeApplDetails = codeApplService.selectDetailByApplyno(applyno);
        CodeApplDetail codeApplDetail;
       List<String> column =selectColumn(codeAppl.getTypedetailid());
        Class<?> herosClass = CodeApplDetail.class;
        JSONObject re = new JSONObject();
        JSONArray jslst = new JSONArray();
        String rebaseids = "";
        String rebaseitems = "";
        List<Integer> rebaseistemlist = new ArrayList<Integer>();
        if(codeApplDetails.size()>0) {
            for (int i=0;i<codeApplDetails.size();i++){
                JSONObject re1 = new JSONObject();
                codeApplDetail = (CodeApplDetail)codeApplDetails.get(i);
                for (int j=0;j<column.size();j++){
                    String meth="getT" + (j+1);
                    Method m2 = herosClass.getMethod(meth);
                    String a = column.get(j);
                    String b = (String) m2.invoke(codeApplDetail);
                    AttrDefine attrDefine = attrDefineList.get(j);
                    if(a.indexOf("MARC-WERKS")!=-1){
                        AttrDefine werks = attrDefineService.selectByNo("MARC-WERKS");
                        int werkbaseid = werks.getDatabaseid();
                        List<Base> werkbase = baseService.selectByNoAndFid(b,werkbaseid);
                        rebaseids =","+werkbase.get(0).getRebaseids()+",";
                        rebaseitems =  werkbase.get(0).getRebaseitems()+",";
                        String [] rebaseistemarr = rebaseitems.split(",");
                        for (String rebaseitem :rebaseistemarr){
                            rebaseistemlist.add(Integer.parseInt(rebaseitem));
                        }
                    }
                    if(attrDefine.getWidgettype()==5){
                        int datebasetype = attrDefine.getDatabasetype();
                        if(datebasetype==1){
                            int basefid = attrDefine.getDatabaseid();
                            String basefidstr = ","+basefid+",";
                            Base base = null;
                            if(rebaseids.indexOf(basefidstr)!=-1){
                              for (Integer item:rebaseistemlist){
                                  Base baseitem = baseService.selectById(item);
                                  if(baseitem.getFid()==basefid&&baseitem.getBaseno().equals(b)){
                                      base = baseitem;
                                      break;

                                  }
                              }
                            }else{
                                List<Base> baseList = baseService.selectByNoAndFid(b,basefid);
                                if(baseList!=null&&baseList.size()!=0){
                                    base = baseList.get(0);
                                }

                            }
                            if(base!=null){
                                re1.put(a,base.getBasename()+"("+base.getBaseno()+")");
                            }
                        }
                        if(datebasetype==2){
                            int attrfid = attrDefine.getAttrid();
                            Attr attr = attrService.selectByNoAndFid(b,attrfid);
                            if(attr!=null){
                                re1.put(a,attr.getAttrname()+"("+attr.getAttrno()+")");
                            }
                        }
                        if(datebasetype==3){
                            int factoryfid = attrDefine.getFactoryid();
                            Factory factory = factoryService.selectByNoAndFid(b,factoryfid);
                            if(factory!=null){
                                re1.put(a,factory.getAttrname()+"("+factory.getAttrno()+")");
                            }
                        }
                    }else{
                        re1.put(a,b);
                    }

                }
                re1.put("itemno",codeApplDetail.getItemno());
                re1.put("codeno",codeApplDetail.getCodeno());
                re1.put("codename",codeApplDetail.getCodename());
                re1.put("id",codeApplDetail.getId());

                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }

    /**
     * 编码定义唯一性
     * @param typeno
     * @return
     */
    public Boolean isunique(String typeno){
        boolean flag;
        CodeManageType codeManageType = codeManageService.selectByTypeno(typeno);
        if(codeManageType.getIsunique()==1){
            flag = true;
        }else {
            flag = false;
        }
        return flag;
    }

    /**
     *
     * 生成编码确定唯一性的字段list
     * @param typeno
     * @return
     */
    public List<AttrDefine> selectUniqueAttrs(String typeno){
        List<CodeName> codeNames = codeNameService.selectByTypeno(typeno);
        List<AttrDefine> list = new ArrayList<AttrDefine>();
        for (CodeName codeName:codeNames){
            if(codeName.getTypenoele().equals("主数据属性")){
                int attrid = codeName.getAttrid();
                AttrDefine attrDefine = attrDefineService.selectById(attrid+"");
                list.add(attrDefine);
            }
        }
        return list;
    }
    @ResponseBody
    @RequestMapping(value = "codeapplcheck", method = {RequestMethod.GET, RequestMethod.POST})
    public String codeapplcheck(HttpServletRequest request, HttpServletResponse response,HttpSession session)throws Exception{
        String rows = request.getParameter("entities");
        String typeno = request.getParameter("typeno");
        String bjattrs = request.getParameter("bjattrs");
        TypeDetail typeDetail = typeDetailService.selectByNo(typeno);
        Map map2 = selectByTypeDetailId(typeDetail.getId());
        List<String> attrDefines = (List<String>) map2.get("attrDefineList");
        List<AttrDefine> attrDefineList = (List<AttrDefine>) map2.get("attrs");
        String[] codeApplRows = rows.split("、");
        Class<?> clazz = CodeApplDetail.class;
        Class<?> clazz2 = Code.class;
        JSONArray jslst = new JSONArray();
        int size = 0;
        List<CodeApplDetail> codeApplDetails = new ArrayList<CodeApplDetail>();
        for(String codeApplRow:codeApplRows){
            String codea = codeApplRow.substring(1,codeApplRow.length()-1);
            String[] codeasx = codea.split(",");

                CodeApplDetail codeApplDetail = new CodeApplDetail();
//                codeApplDetail.setItemno(codeasx[1].split(":")[1]);
                for(int i = 0;i<codeasx.length;i++){
                    if(codeasx[i].split(":")[0].replaceAll("\"","").equals("itemno")){
                        codeApplDetail.setItemno(codeasx[i].split(":")[1].replaceAll("\"",""));
                    }else if(codeasx[i].split(":")[0].replaceAll("\"","").equals("codeno")){
                        codeApplDetail.setCodeno(codeasx[i].split(":")[1].replaceAll("\"",""));
                    }else if(codeasx[i].split(":")[0].replaceAll("\"","").equals("codename")){
                        codeApplDetail.setCodename(codeasx[i].split(":")[1].replaceAll("\"",""));
                    }else {
                        for (int j=1;j<=attrDefines.size();j++){
                            if(codeasx[i].split(":")[0].replaceAll("\"","").equals(attrDefines.get(j-1))){
                                PropertyDescriptor pd = new PropertyDescriptor("t"+(j), clazz);
                                Method wM = pd.getWriteMethod();
                                AttrDefine attrDefine = attrDefineList.get(j-1);
                                if(attrDefine.getWidgettype()==5){
                                    String name = codeasx[i].split(":")[1].replaceAll("\"","");
                                    int index = name.lastIndexOf("(");
                                    if(index!=-1){
                                        name = name.substring(0,index);
                                    }
                                    if(attrDefine.getDatabasetype()==1){
                                        int basefid = attrDefine.getDatabaseid();
                                        Base base = baseService.selectByNameAndFid(name,basefid);
                                        if(base!=null){
                                            wM.invoke(codeApplDetail,base.getBaseno());
                                        }

                                    }
                                    if(attrDefine.getDatabasetype()==2){
                                        int attrfid = attrDefine.getAttrid();
                                        Attr attr = attrService.selectByNameAndFid(name,attrfid);
                                        if(attr!=null){
                                            wM.invoke(codeApplDetail,attr.getAttrno());
                                        }

                                    }
                                    if(attrDefine.getDatabasetype()==3){
                                        int factoryfid = attrDefine.getFactoryid();
                                        Factory factory = factoryService.selectByNameAndFid(name,factoryfid);
                                        if(factory!=null){
                                            wM.invoke(codeApplDetail,factory.getAttrno());
                                        }

                                    }

                                }else{
                                    wM.invoke(codeApplDetail, codeasx[i].split(":")[1].replaceAll("\"",""));
                                }

                            }
                        }
                    }


                }
                codeApplDetails.add(codeApplDetail);
        }
        net.sf.json.JSONObject result=new net.sf.json.JSONObject();
        //自定义编码类型为流水码的类型
        CodeType codeType = codeTypeService.selectSerialnumber(typeno);
        boolean flag = isunique(typeno);
        Map map = isSDTX(typeno);
        boolean bmflag = (boolean) map.get("bm");
        boolean msflag = (boolean) map.get("ms");
        boolean exsit = false;
//        String exsititems = "";
        if(!flag){
            //不是唯一性的，不校验编码有没有重复
            if((!bmflag)&&(!msflag)){
                if(codeType==null){
                    result.put("success", false);
                    result.put("message","自定义编码规则不对，缺少流水码类型");
                    result.put("size",0);
                    ResponseUtil.write(response, result);
                    return null;
                }
                //都是自动生成
//                Save(codeApplDetails,codeType,bjattrs);
            }else if((!bmflag)||(!msflag)){
                if(codeType==null){
                    result.put("success", false);
                    result.put("message","自定义编码规则不对");
                    result.put("size",0);
                    ResponseUtil.write(response, result);
                    return null;
                }else{
                    for (CodeApplDetail codeApplDetail:codeApplDetails){
                        if(!codeApplDetail.getCodeno().equals("")){
                            Code code = codeService.selectByCodeno(codeApplDetail.getCodeno());
                            if(code!=null){
                                exsit = true;
                                JSONObject re1 = new JSONObject();
                                re1.put("itemno",codeApplDetail.getItemno());
                                re1.put("codeno",codeApplDetail.getCodeno());
                                re1.put("reason","该行生成的自定义编码已存在，若要修改请走扩充流程");
                                size+=1;
                                jslst.add(re1);
//                                exsititems+=codeApplDetail.getItemno()+",";
                            }
                        }
                    }
                }
                //有一样是自动生成
//                Save3(codeApplDetails,codeType,bjattrs,bmflag,msflag);

            }

        }else{
            String codename = "";
            CodeName flcc = codeNameService.selectFLCX(typeno);
            List<CodeName> codeNames = codeNameService.selectByTypeno(typeno);
            String flccname = "";
            if(flcc!=null){
                flccname = flcc.getTypename()+flcc.getSplitstr();
            }
            String bjattr[] = bjattrs.split(",");
            int length = codeType.getKindnum();
            int begin = Integer.parseInt(codeType.getCodebegin());
            int end = Integer.parseInt(codeType.getCodeend());
            //唯一性 校验编码有没有重复
            if((!bmflag)&&(!msflag)){
                if(codeType==null){
                    result.put("success", false);
                    result.put("message","自定义编码规则不对");
                    result.put("size",0);
                    ResponseUtil.write(response, result);
                    return null;
                }else{
                    for(CodeApplDetail codeApplDetail:codeApplDetails){
                        Map maxserialnumber = codeApplService.selectMaxserialNumber(typeno,begin,end,length);

                        codename = flccname;
                        Code code = new Code();
                        TypeDetail typeDetail1 = typeDetailService.selectByNo(typeno);
                        code.setTypedetailid(typeDetail1.getId());
                        for (int i =0 ;i<bjattr.length;i++){
                            String attr = bjattr[i];
                            String meth="get"+attr.substring(0, 1).toUpperCase() + attr.substring(1);

                            Method m2 = clazz.getMethod(meth);
                            String bjflag = (String) m2.invoke(codeApplDetail);
                            codename = codename + bjflag + codeNames.get(i).getSplitstr();

                            PropertyDescriptor pd = new PropertyDescriptor(attr, clazz2);
                            Method wM = pd.getWriteMethod();
                            wM.invoke(code, bjflag.replaceAll("\"",""));
//                wM.invoke(code, bjflag.replaceAll("\"",""));
                        }
                        List<Code> codes = codeService.selectExistCode(code);
                        if(codes!=null&&codes.size()!=0){
                            exsit = true;
                            JSONObject re1 = new JSONObject();
                            re1.put("itemno",codeApplDetail.getItemno());
                            re1.put("codeno",codes.get(codes.size()-1).getCodeno());
                            re1.put("reason","该行生成的自定义编码已存在，若要修改请走扩充流程");
                            size+=1;
                            jslst.add(re1);
//                            exsititems+="行号为"+codeApplDetail.getItemno()+",生成的编码为"+codes.get(codes.size()-1).getCodeno()+"，";
                        }
                    }

                }
                //都是自动生成
//                Save2(codeApplDetails,codeType,bjattrs);
            }else if((!bmflag)||(!msflag)){
                if(codeType==null){
                    result.put("success", false);
                    result.put("message","自定义编码规则不对");
                    result.put("size",0);
                    ResponseUtil.write(response, result);
                    return null;
                }else {
                    if(!bmflag){
                        for(CodeApplDetail codeApplDetail:codeApplDetails){
                            Map maxserialnumber = codeApplService.selectMaxserialNumber(typeno,begin,end,length);

                            codename = flccname;
                            Code code = new Code();
                            TypeDetail typeDetail1 = typeDetailService.selectByNo(typeno);
                            code.setTypedetailid(typeDetail1.getId());
                            for (int i =0 ;i<bjattr.length;i++){
                                String attr = bjattr[i];
                                String meth="get"+attr.substring(0, 1).toUpperCase() + attr.substring(1);

                                Method m2 = clazz.getMethod(meth);
                                String bjflag = (String) m2.invoke(codeApplDetail);
                                codename = codename + bjflag + codeNames.get(i).getSplitstr();

                                PropertyDescriptor pd = new PropertyDescriptor(attr, clazz2);
                                Method wM = pd.getWriteMethod();
                                wM.invoke(code, bjflag.replaceAll("\"",""));
//                wM.invoke(code, bjflag.replaceAll("\"",""));
                            }
                            List<Code> codes = codeService.selectExistCode(code);
                            if(codes!=null&&codes.size()!=0){
                                exsit = true;
                                JSONObject re1 = new JSONObject();
                                re1.put("itemno",codeApplDetail.getItemno());
                                re1.put("codeno",codes.get(codes.size()-1).getCodeno());
                                re1.put("reason","该行生成的自定义编码已存在，若要修改请走扩充流程");
                                size+=1;
                                jslst.add(re1);
//                                exsititems+="行号为"+codeApplDetail.getItemno()+",生成的编码为"+codes.get(codes.size()-1).getCodeno()+"，";
                            }

                        }
                    }else{
                        for (CodeApplDetail codeApplDetail:codeApplDetails){
                            if(!codeApplDetail.getCodeno().equals("")){
                                Code code = codeService.selectByCodeno(codeApplDetail.getCodeno());
                                if(code!=null){
                                    exsit = true;
                                    JSONObject re1 = new JSONObject();
                                    re1.put("itemno",codeApplDetail.getItemno());
                                    re1.put("codeno",codeApplDetail.getCodeno());
                                    re1.put("reason","该行生成的自定义编码已存在，若要修改请走扩充流程");
                                    size+=1;
                                    jslst.add(re1);
//                                    exsititems+="行号为"+codeApplDetail.getItemno()+",生成的编码为"+codeApplDetail.getCodeno()+"，";
                                }
                            }
                        }
                    }
                }
                //有一样是自动生成
//                Save4(codeApplDetails,codeType,bjattrs,bmflag,msflag);
            }

        }
        if(exsit){
//            exsititems = exsititems.substring(0,exsititems.length()-1);
            JSONObject re = new JSONObject();
            re.put("rows",jslst);
            re.put("total",jslst.size());
            result.put("success", false);
            result.put("grid",re);
            result.put("size",size);
        }else{
            result.put("success", true);
            result.put("message","校验通过");
        }
        ResponseUtil.write(response, result);
        return null;
    }


    public JSONObject codeapplcheck2( String[] codeApplRows, String typeno,String bjattrs)throws Exception{
        JSONObject re = new JSONObject();
        int size = 0;
        TypeDetail typeDetail = typeDetailService.selectByNo(typeno);
        Map map2 = selectByTypeDetailId(typeDetail.getId());
        List<String> attrDefines = (List<String>) map2.get("attrDefineList");
        List<AttrDefine> attrDefineList = (List<AttrDefine>) map2.get("attrs");
        Class<?> clazz = CodeApplDetail.class;
        Class<?> clazz2 = Code.class;
        JSONArray jslst = new JSONArray();
        List<CodeApplDetail> codeApplDetails = new ArrayList<CodeApplDetail>();
        for(String codeApplRow:codeApplRows){
            String codea = codeApplRow.substring(1,codeApplRow.length()-1);
            String[] codeasx = codea.split(",");
            CodeApplDetail codeApplDetail = new CodeApplDetail();
//                codeApplDetail.setItemno(codeasx[1].split(":")[1]);
            for(int i = 0;i<codeasx.length;i++){
                if(codeasx[i].split(":")[0].replaceAll("\"","").equals("itemno")){
                    codeApplDetail.setItemno(codeasx[i].split(":")[1].replaceAll("\"",""));
                }else if(codeasx[i].split(":")[0].replaceAll("\"","").equals("codeno")){
                    codeApplDetail.setCodeno(codeasx[i].split(":")[1].replaceAll("\"",""));
                }else if(codeasx[i].split(":")[0].replaceAll("\"","").equals("codename")){
                    codeApplDetail.setCodename(codeasx[i].split(":")[1].replaceAll("\"",""));
                }else {
                    for (int j=1;j<=attrDefines.size();j++){
                        if(codeasx[i].split(":")[0].replaceAll("\"","").equals(attrDefines.get(j-1))){
                            PropertyDescriptor pd = new PropertyDescriptor("t"+(j), clazz);
                            Method wM = pd.getWriteMethod();
                            AttrDefine attrDefine = attrDefineList.get(j-1);
                            if(attrDefine.getWidgettype()==5){
                                String name = codeasx[i].split(":")[1].replaceAll("\"","");
                                int index = name.lastIndexOf("(");
                                if(index!=-1){
                                    name = name.substring(0,index);
                                }
                                if(attrDefine.getDatabasetype()==1){
                                    int basefid = attrDefine.getDatabaseid();
                                    Base base = baseService.selectByNameAndFid(name,basefid);
                                    if(base!=null){
                                        wM.invoke(codeApplDetail,base.getBaseno());
                                    }
                                }
                                if(attrDefine.getDatabasetype()==2){
                                    int attrfid = attrDefine.getAttrid();
                                    Attr attr = attrService.selectByNameAndFid(name,attrfid);
                                    if(attr!=null){
                                        wM.invoke(codeApplDetail,attr.getAttrno());
                                    }

                                }
                                if(attrDefine.getDatabasetype()==3){
                                    int factoryfid = attrDefine.getFactoryid();
                                    Factory factory = factoryService.selectByNameAndFid(name,factoryfid);
                                    if(factory!=null){
                                        wM.invoke(codeApplDetail,factory.getAttrno());
                                    }

                                }

                            }else{
                                wM.invoke(codeApplDetail, codeasx[i].split(":")[1].replaceAll("\"",""));
                            }

                        }
                    }
                }


            }
            codeApplDetails.add(codeApplDetail);



        }
        //自定义编码类型为流水码的类型
        CodeType codeType = codeTypeService.selectSerialnumber(typeno);
        boolean flag = isunique(typeno);
        Map map = isSDTX(typeno);
        boolean bmflag = (boolean) map.get("bm");
        boolean msflag = (boolean) map.get("ms");
        boolean exsit = false;
        String exsititems = "";
        if(!flag){
            //不是唯一性的，不校验编码有没有重复
            if((!bmflag)&&(!msflag)){
                if(codeType==null){
                    re.put("success", false);
                    re.put("message","自定义编码规则不对，缺少流水码类型");
                    re.put("size",0);

                    return re;
                }
                //都是自动生成
//                Save(codeApplDetails,codeType,bjattrs);
            }else if((!bmflag)||(!msflag)){
                if(codeType==null){
                    re.put("success", false);
                    re.put("message","自定义编码规则不对");
                    re.put("size",0);
                    return re;
                }else{
                    for (CodeApplDetail codeApplDetail:codeApplDetails){
                        if(!codeApplDetail.getCodeno().equals("")){
                            Code code = codeService.selectByCodeno(codeApplDetail.getCodeno());
                            if(code!=null){
                                exsit = true;
                                JSONObject re2 = new JSONObject();
                                re2.put("itemno",codeApplDetail.getItemno());
                                re2.put("codeno",codeApplDetail.getCodeno());
                                re2.put("reason","该行生成的自定义编码已存在，若要修改请走扩充流程");
                                size+=1;
                                jslst.add(re2);
//                                exsititems+=codeApplDetail.getItemno()+",";
                            }
                        }
                    }
                }
                //有一样是自动生成
//                Save3(codeApplDetails,codeType,bjattrs,bmflag,msflag);

            }

        }else{
            String codename = "";
            CodeName flcc = codeNameService.selectFLCX(typeno);
            List<CodeName> codeNames = codeNameService.selectByTypeno(typeno);
            String flccname = "";
            if(flcc!=null){
                flccname = flcc.getTypename()+flcc.getSplitstr();
            }
            String bjattr[] = bjattrs.split(",");
            int length = codeType.getKindnum();
            int begin = Integer.parseInt(codeType.getCodebegin());
            int end = Integer.parseInt(codeType.getCodeend());
            //唯一性 校验编码有没有重复
            if((!bmflag)&&(!msflag)){
                if(codeType==null){
                    re.put("success", false);
                    re.put("message","自定义编码规则不对");
                    re.put("size",0);
                    return re;
                }else{
                    for(CodeApplDetail codeApplDetail:codeApplDetails){
                        Map maxserialnumber = codeApplService.selectMaxserialNumber(typeno,begin,end,length);

                        codename = flccname;
                        Code code = new Code();
                        TypeDetail typeDetail1 = typeDetailService.selectByNo(typeno);
                        code.setTypedetailid(typeDetail1.getId());
                        for (int i =0 ;i<bjattr.length;i++){
                            String attr = bjattr[i];
                            String meth="get"+attr.substring(0, 1).toUpperCase() + attr.substring(1);

                            Method m2 = clazz.getMethod(meth);
                            String bjflag = (String) m2.invoke(codeApplDetail);
                            codename = codename + bjflag + codeNames.get(i).getSplitstr();

                            PropertyDescriptor pd = new PropertyDescriptor(attr, clazz2);
                            Method wM = pd.getWriteMethod();
                            wM.invoke(code, bjflag.replaceAll("\"",""));
//                wM.invoke(code, bjflag.replaceAll("\"",""));
                        }
                        List<Code> codes = codeService.selectExistCode(code);
                        if(codes!=null&&codes.size()!=0){
                            exsit = true;
                            JSONObject re2 = new JSONObject();
                            re2.put("itemno",codeApplDetail.getItemno());
                            re2.put("codeno",codes.get(codes.size()-1).getCodeno());
                            re2.put("reason","该行生成的自定义编码已存在，若要修改请走扩充流程");
                            size+=1;
                            jslst.add(re2);
//                            exsititems+="行号为"+codeApplDetail.getItemno()+",生成的编码为"+codes.get(codes.size()-1).getCodeno()+"，";
                        }
                    }

                }
                //都是自动生成
//                Save2(codeApplDetails,codeType,bjattrs);
            }else if((!bmflag)||(!msflag)){
                if(codeType==null){
                    re.put("success", false);
                    re.put("message","自定义编码规则不对");
                    re.put("size",0);
                    return re;
                }else {
                    if(!bmflag){
                        for(CodeApplDetail codeApplDetail:codeApplDetails){
                            Map maxserialnumber = codeApplService.selectMaxserialNumber(typeno,begin,end,length);

                            codename = flccname;
                            Code code = new Code();
                            TypeDetail typeDetail1 = typeDetailService.selectByNo(typeno);
                            code.setTypedetailid(typeDetail1.getId());
                            for (int i =0 ;i<bjattr.length;i++){
                                String attr = bjattr[i];
                                String meth="get"+attr.substring(0, 1).toUpperCase() + attr.substring(1);

                                Method m2 = clazz.getMethod(meth);
                                String bjflag = (String) m2.invoke(codeApplDetail);
                                codename = codename + bjflag + codeNames.get(i).getSplitstr();

                                PropertyDescriptor pd = new PropertyDescriptor(attr, clazz2);
                                Method wM = pd.getWriteMethod();
                                wM.invoke(code, bjflag.replaceAll("\"",""));
//                wM.invoke(code, bjflag.replaceAll("\"",""));
                            }
                            List<Code> codes = codeService.selectExistCode(code);
                            if(codes!=null&&codes.size()!=0){
                                exsit = true;
                                JSONObject re2 = new JSONObject();
                                re2.put("itemno",codeApplDetail.getItemno());
                                re2.put("codeno",codes.get(codes.size()-1).getCodeno());
                                re2.put("reason","该行生成的自定义编码已存在，若要修改请走扩充流程");
                                size+=1;
                                jslst.add(re2);
//                                exsititems+="行号为"+codeApplDetail.getItemno()+",生成的编码为"+codes.get(codes.size()-1).getCodeno()+"，";
                            }
                        }
                    }else{
                        for (CodeApplDetail codeApplDetail:codeApplDetails){
                            if(!codeApplDetail.getCodeno().equals("")){
                                Code code = codeService.selectByCodeno(codeApplDetail.getCodeno());
                                if(code!=null){
                                    exsit = true;
                                    JSONObject re2 = new JSONObject();
                                    re2.put("itemno",codeApplDetail.getItemno());
                                    re2.put("codeno",codeApplDetail.getCodeno());
                                    re2.put("reason","该行生成的自定义编码已存在，若要修改请走扩充流程");
                                    size+=1;
                                    jslst.add(re2);
//                                    exsititems+="行号为"+codeApplDetail.getItemno()+",生成的编码为"+codeApplDetail.getCodeno()+"，";
                                }
                            }
                        }
                    }
                }
                //有一样是自动生成
//                Save4(codeApplDetails,codeType,bjattrs,bmflag,msflag);
            }

        }
        if(exsit){
//            exsititems = exsititems.substring(0,exsititems.length()-1);
            JSONObject re1 = new JSONObject();
            re1.put("rows",jslst);
            re1.put("total",jslst.size());
            re.put("success", false);
            re.put("grid",re1);
            re.put("size",size);
//            re.put("success", false);
//            re.put("message",exsititems+"已存在，若要修改请进行扩充流程");
        }else{
            re.put("success", true);

        }

        return re;
    }
    /**
     * 审批
     * @param response
     * @param session
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "pass", method = {RequestMethod.GET, RequestMethod.POST})
    public String pass(HttpServletRequest request, HttpServletResponse response,HttpSession session)throws Exception{
        String rows = request.getParameter("entities");
        rows = rows.replaceAll("null","\"\"");
        String applyno2 = request.getParameter("applyno");
        String typeno = request.getParameter("typeno");
        String bjattrs = request.getParameter("bjattrs");
        CodeAppl codeAppl2 = codeApplService.selectByApplyno(applyno2);
        Class<?> clazz = CodeApplDetail.class;
        String id = "";
        String[] codeApplRows = rows.split("、");
        TypeDetail typeDetail = typeDetailService.selectByNo(typeno);
        Map map2 = selectByTypeDetailId(typeDetail.getId());
        List<String> attrDefines = (List<String>) map2.get("attrDefineList");
        List<AttrDefine> attrDefineList = (List<AttrDefine>) map2.get("attrs");
        net.sf.json.JSONObject result=new net.sf.json.JSONObject();
        boolean ispass = true;
        Map map3 = null;
        String taskId = request.getParameter("taskId");
        String GroupId = request.getParameter("GroupId");
        String UserId = request.getParameter("UserId");
        int state = Integer.parseInt(request.getParameter("state"));
        String comment = request.getParameter("comment");
        //首先根据ID查询任务
        Task task=taskService.createTaskQuery() // 创建任务查询
                .taskId(taskId) // 根据任务id查询
                .singleResult();
        Map<String,Object> variables=new HashMap<String,Object>();
        //取得角色用户登入的session对象
        MemberShip currentMemberShip=(MemberShip) session.getAttribute("currentMemberShip");
        //取出用户，角色信息
//		User currentUser=currentMemberShip.getUser();
//		Group currentGroup=currentMemberShip.getGroup();
        ActUser currentUser = new ActUser();
        Group currentGroup = new Group();
        currentGroup.setName(GroupId);
        String firstname = UserId.substring(0,1);
        currentUser.setFirstName(firstname);
        String lastname = UserId.substring(1);
        currentUser.setLastName(lastname);
        String taskname = task.getName();
        CodeType codeType = codeTypeService.selectSerialnumber(typeno);
        if(taskname.equals("主数据申请创建")){

            for(String codeApplRow:codeApplRows){
                int idindex = codeApplRow.indexOf("\"id\"");
                int idspide = codeApplRow.indexOf(",",idindex);
                codeApplRow = codeApplRow.substring(0,idindex+4)+"\""+codeApplRow.substring(idindex+4,idspide)+"\""+codeApplRow.substring(idspide,codeApplRow.length());
                String codea = codeApplRow.substring(1,codeApplRow.length()-1);
                String[] codeasx = codea.split("\",\"");
//            id = codeasx[0].split(":")[1].replace("\"","");
                for(int i = 0;i<codeasx.length;i++){
                    if(codeasx[i].split(":")[0].replaceAll("\"","").equals("id")){
                        id = codeasx[i].split(":")[1].replaceAll("\"","");
                    }


                }

                if(id.equals("")||id.equals("undefined")){
                    CodeApplDetail codeApplDetail = new CodeApplDetail();
                    for (String codeString:codeasx){
                        if(codeString.split(":")[0].replaceAll("\"","").equals("itemno")){
                            codeApplDetail.setItemno(codeString.split(":")[1].replaceAll("\"",""));
                        }else if(codeString.split(":")[0].replaceAll("\"","").equals("codeno")){
                            codeApplDetail.setCodeno(codeString.split(":")[1].replaceAll("\"",""));
                        }else if(codeString.split(":")[0].replaceAll("\"","").equals("codename")){
                            codeApplDetail.setCodename(codeString.split(":")[1].replaceAll("\"",""));
                        } else{
                            for (int j=1;j<=attrDefines.size();j++) {
                                if (attrDefines.get(j-1).equals(codeString.split(":")[0].replaceAll("\"", ""))) {
                                    PropertyDescriptor pd = new PropertyDescriptor("t"+(j), clazz);
                                    Method wM = pd.getWriteMethod();
                                    //下拉框显示值
                                    String xlk = codeString.split(":")[1].replaceAll("\"","");
                                    AttrDefine attrDefine = attrDefineList.get(j-1);
                                    if(attrDefine.getWidgettype()==5){
                                        int start = xlk.lastIndexOf("(");
                                        if(xlk.equals("")||start==-1){
                                            wM.invoke(codeApplDetail, xlk);
                                        }else{
                                            wM.invoke(codeApplDetail, xlk.substring(start+1,xlk.length()-1));
                                        }
                                    }
                                    else if(attrDefine.getWidgettype()==6){
                                        String[] xlks = xlk.split(",");
                                        String xlkz = "";
                                        for (String xlkxx:xlks){
                                            int start = xlkxx.lastIndexOf("(");
                                            if(xlkxx.equals("")||start==-1){
                                                xlkz = xlkz+xlkxx+",";

                                            }else{
                                                xlkz = xlkz +  xlkxx.substring(start+1,xlkxx.length()-1)+",";

                                            }
                                        }
                                        wM.invoke(codeApplDetail, xlkz);

                                    }
                                    else if(attrDefine.getWidgettype()==8){
                                        int start = xlk.lastIndexOf("(");
                                        if(xlk.equals("")||start==-1){
                                            wM.invoke(codeApplDetail, xlk);
                                        }else{
                                            wM.invoke(codeApplDetail, xlk.substring(start+1,xlk.length()-1));
                                        }

                                    }
                                    else {
                                        wM.invoke(codeApplDetail, xlk);
                                    }

                                }
                            }
                        }
                    }


                    codeApplDetail.setApplyno(applyno2);
                    codeApplDetail.setTypedetailid(codeAppl2.getTypedetailid());
//                TypeDetail typeDetail = typeDetailService.selectById(codeAppl2.getTypedetailid());
                    codeApplDetail.setTypedetailno(typeDetail.getTypeno());
                    codeApplDetail.setTypedetailname(typeDetail.getTypename());
                    int i = codeApplService.insertDetail(codeApplDetail);
                    int newid2 = codeApplService.selectNewDetailId();
                }else{
                    CodeApplDetail codeApplDetail = codeApplService.selectByDetailId(Integer.parseInt(id));
                    for(int i = 0;i<codeasx.length;i++){
                        if(codeasx[i].split(":")[0].replaceAll("\"","").equals("itemno")){
                            codeApplDetail.setItemno(codeasx[i].split(":")[1].replaceAll("\"",""));
                        }else if(codeasx[i].split(":")[0].replaceAll("\"","").equals("codeno")){
                            codeApplDetail.setCodeno(codeasx[i].split(":")[1].replaceAll("\"",""));
                        }else if(codeasx[i].split(":")[0].replaceAll("\"","").equals("codename")){
                            codeApplDetail.setCodename(codeasx[i].split(":")[1].replaceAll("\"",""));
                        }else {
                            for (int j=1;j<=attrDefines.size();j++){
                                if(codeasx[i].split(":")[0].replaceAll("\"","").equals(attrDefines.get(j-1))){
                                    PropertyDescriptor pd = new PropertyDescriptor("t"+(j), clazz);
                                    Method wM = pd.getWriteMethod();
                                    AttrDefine attrDefine = attrDefineList.get(j-1);
                                    if(attrDefine.getWidgettype()==5){
                                        String name = codeasx[i].split(":")[1].replaceAll("\"","");
                                        if(attrDefine.getDatabasetype()==1){
                                            int basefid = attrDefine.getDatabaseid();
                                            Base base = baseService.selectByNameAndFid(name,basefid);
                                            if(base!=null){
                                                wM.invoke(codeApplDetail,base.getBaseno());
                                            }

                                        }
                                        if(attrDefine.getDatabasetype()==2){
                                            int attrfid = attrDefine.getAttrid();
                                            Attr attr = attrService.selectByNameAndFid(name,attrfid);
                                            if(attr!=null){
                                                wM.invoke(codeApplDetail,attr.getAttrno());
                                            }

                                        }
                                        if(attrDefine.getDatabasetype()==3){
                                            int factoryfid = attrDefine.getFactoryid();
                                            Factory factory = factoryService.selectByNameAndFid(name,factoryfid);
                                            if(factory!=null){
                                                wM.invoke(codeApplDetail,factory.getAttrno());
                                            }

                                        }

                                    }else{
                                        wM.invoke(codeApplDetail, codeasx[i].split(":")[1].replaceAll("\"",""));
                                    }

                                }
                            }
                        }


                    }

                    int i = codeApplService.updateCodeApplDetail(codeApplDetail);

                }

            }
        }
//        if(currentGroup.getName().contains("admin")){
        if(taskname.equals("主数据申请审核")){
            if(state==1){
//                String maxserialnumber = codeApplService.selectMaxserialNumber(typeno,1,99999,5);
                boolean flag = isunique(typeno);
                String applyno=(String) taskService.getVariable(taskId, "applyno");
                CodeAppl codeAppl=codeApplService.selectByApplyno(applyno);
                codeAppl.setApplystate("审核通过");
                // 更新审核信息
                codeApplService.update(codeAppl);
                variables.put("statu", 1);
                List<CodeApplDetail> list = codeApplService.selectDetailByApplyno(applyno);
                //创建
                if(codeAppl.getIsexpand()==0){
                    Map map = isSDTX(typeno);
                    boolean bmflag = (boolean) map.get("bm");
                    boolean msflag = (boolean) map.get("ms");
                    if(!flag){
                        //不是唯一性的，不校验编码有没有重复
                        if((!bmflag)&&(!msflag)){
                            if(codeType==null){
                                ispass = false;
                                result.put("success", false);
                                result.put("message","自定义编码规则不对");
                                ResponseUtil.write(response, result);
                                return null;
                            }
                            //都是自动生成
                            Save(list,codeType,bjattrs);
                        }else if((!bmflag)||(!msflag)){
                            if(codeType==null){
                                ispass = false;
                                result.put("success", false);
                                result.put("message","自定义编码规则不对");
                                ResponseUtil.write(response, result);
                                return null;
                            }
                            //有一样是自动生成
                            Save3(list,codeType,bjattrs,bmflag,msflag);

                        }

                    }else{
                        //唯一性 校验编码有没有重复
                        if((!bmflag)&&(!msflag)){
                            if(codeType==null){
                                ispass = false;
                                result.put("success", false);
                                result.put("message","自定义编码规则不对");
                                ResponseUtil.write(response, result);
                                return null;
                            }
                            //都是自动生成
                            Save2(list,codeType,bjattrs);
                        }else if((!bmflag)||(!msflag)){
                            if(codeType==null){
                                ispass = false;
                                result.put("success", false);
                                result.put("message","自定义编码规则不对");
                                ResponseUtil.write(response, result);
                                return null;
                            }
                            //有一样是自动生成
                            Save4(list,codeType,bjattrs,bmflag,msflag);
                        }

                    }
                }
                int isexpand = codeAppl.getIsexpand();
                map3 =  Save3(list,applyno2,isexpand);
//                List<Integer> codes = (List<Integer>) map3.get("codes");
//                for (Integer codeid:codes){
//                    Code code = codeService.selectById(codeid);
//                    code.setApplyno(applyno2);
//                    codeService.update(code);
//                }

            }else{
                String applyno=(String) taskService.getVariable(taskId, "applyno");
                CodeAppl codeAppl=codeApplService.selectByApplyno(applyno);
                codeAppl.setApplystate("主数据申请创建");
                // 更新审核信息
                codeApplService.update(codeAppl);
                variables.put("statu", 2);
                variables.put("userID",codeAppl.getInputman());
            }
        }
        if(taskname.equals("主数据申请确认")){
            if(state==1){

                String applyno=(String) taskService.getVariable(taskId, "applyno");
                CodeAppl codeAppl=codeApplService.selectByApplyno(applyno);
                codeAppl.setApplystate("主数据申请完成");
                // 更新审核信息
                codeApplService.update(codeAppl);
                variables.put("flag", 1);
                List<CodeApplDetail> list = codeApplService.selectDetailByApplyno(applyno);
                JSONObject mess = sap(map2,list,typeDetail.getId());
                boolean messflag = (boolean) mess.get("flag");
                result.put("mess", mess.get("message"));
                if(!messflag){
                    ispass = false;
                }
                if(messflag){
                    List<Code> codes = codeService.selectByApplyno(applyno2);
                    for (Code codeitem:codes){
                        codeitem.setIssuccess(1);
                        codeService.update(codeitem);
                    }
                }
            }else{
                String applyno=(String) taskService.getVariable(taskId, "applyno");
                CodeAppl codeAppl=codeApplService.selectByApplyno(applyno);
                codeAppl.setApplystate("主数据申请创建");
                if(codeAppl.getIsexpand()==0){
                    List<Code> codes = codeService.selectByApplyno(applyno);
                    for (Code code:codes){
                        codeService.delete(code);
                    }
                    List<CodeApplDetail> list = codeApplService.selectDetailByApplyno(applyno);
                    for (CodeApplDetail codeApplDetail:list){
                        codeApplDetail.setCodeno("");
                        codeApplDetail.setCodename("");
                        codeApplService.updateCodeApplDetail(codeApplDetail);
                    }
                    // 更新审核信息
                    codeApplService.update(codeAppl);
                }else{
                    List<Code> codes = codeService.selectByApplyno(applyno);
                    for (Code code:codes){
                        if(code.getIsexpand()!=2)
                        codeService.delete(code);
                    }
                }

                variables.put("flag", 2);
                variables.put("userID",codeAppl.getInputman());
            }
        }


        String processInstanceId=task.getProcessInstanceId();
        // 设置用户id
        List list = taskService.getIdentityLinksForTask(taskId);
        IdentityLink li = (IdentityLink)list.get(0);
        Authentication.setAuthenticatedUserId(currentUser.getFirstName()+currentUser.getLastName()+"["+li.getGroupId()+"]");
        // 添加批注信息
        taskService.addComment(taskId, processInstanceId, comment);
        // 完成任务
        if(ispass){
             taskService.complete(taskId, variables);
            result.put("success", true);
        }else {
            result.put("success", false);
        }



        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 根据模板名称用来判断传入sap的类型
     * @param exptypename 模板名称
     * @return sap类型
     */
    public int saptype(String exptypename){
        int saptype = 0 ;
        if(exptypename.indexOf("选配成品模板")!=-1){
            saptype = 1;
        }else if(exptypename.indexOf("选配半成品模板")!=-1){
            saptype = 2;
        }else if(exptypename.indexOf("生产主材模板")!=-1){
            saptype = 3;
        }else if(exptypename.indexOf("生产辅材模板")!=-1){
            saptype = 4;
        }else if(exptypename.indexOf("包材模板")!=-1){
            saptype = 5;
        }else if(exptypename.indexOf("非生产性物资模板")!=-1){
            saptype = 6;
        }
        return saptype;
    }

    public    JSONObject  sap(Map map,List<CodeApplDetail> list,int typedetailid) throws JCoException, NoSuchMethodException, InvocationTargetException, IllegalAccessException, JCoException, IntrospectionException {
        List<String> views = (List<String>) map.get("attrDefineList");
        List<String> attrs = (List<String>) map.get("viewList");
        TypeDetail typeDetail1 = typeDetailService.selectById(typedetailid);
        Exptype exptype = exptypeService.selectById(typeDetail1.getExptypeid()+"");
        String exptypename = exptype.getExptypename();
        int saptype = saptype(exptypename);
        List<String> column =selectColumn(typedetailid);
        TypeDetail typeDetail = typeDetailService.selectById(typedetailid);
        List<CodeName> codeNames = codeNameService.selectByTypeno(typeDetail.getTypeno());
        //用来生成自定义描述的字段
        List<String> msattrs = new ArrayList<String>();
        for (CodeName codeName:codeNames){
            if(codeName.getTypenoele().equals("主数据属性")){
                msattrs.add(codeName.getViewcode()+"_"+codeName.getAttrno());
            }
        }
        Class<?> herosClass = CodeApplDetail.class;
        Class<?> codeclass = Code.class;
        JSONArray jslst = new JSONArray();
        CodeApplDetail codeApplDetail;
        if(list.size()>0) {
            for (int i=0;i<list.size();i++){
                JSONObject re1 = new JSONObject();
                codeApplDetail = (CodeApplDetail)list.get(i);
                for (int j=0;j<column.size();j++){
                    String meth="getT" + (j+1);
                    Method m2 = herosClass.getMethod(meth);
                    String a = column.get(j);
                    String b = (String) m2.invoke(codeApplDetail);
                    re1.put(a,b);
                }
                re1.put("itemno",codeApplDetail.getItemno());
                re1.put("codeno",codeApplDetail.getCodeno());
                re1.put("codename",codeApplDetail.getCodename());
                re1.put("id",codeApplDetail.getId());
                re1.put("isexpand",codeApplDetail.getIsexpand());

                jslst.add(re1);
            }
        }


        JCoFunction function = null;
        JCoDestination destination = connect();
        JCoTable result=null;//调用接口返回状态
        String message="";//调用接口返回信息
        //            //调用ZEP_O_019函数
        function = destination.getRepository().getFunction("ZHMDM_IMAT");
        JCoParameterList input = function.getImportParameterList();
        //发出扫码仓库
        input.setValue("Z_MODE", "1");
        //发出扫码库位
        input.setValue("Z_TASKID", "testtrans");
        //采购凭证号
        input.setValue("ZUSER", "lijiaqi");

//            //获取传入表参数SN_ITEM
        JCoTable GDSMT_ITEM = function.getTableParameterList().getTable("ZPDM_MATNR");
        for (int i =0;i<jslst.size();i++){
            JSONObject re1 = (JSONObject) jslst.get(i);

            GDSMT_ITEM.appendRow();//增加一行
            if((Integer)re1.get("isexpand")==1){
                GDSMT_ITEM.setValue("Z_MODE", "2");
            }else{
                GDSMT_ITEM.setValue("Z_MODE", "1");
            }
            GDSMT_ITEM.setValue("BASIC_VIEW", "X");//基本
            GDSMT_ITEM.setValue("STORAGE_VIEW", "X");//仓储
            GDSMT_ITEM.setValue("COST_VIEW", "X");//成本
            GDSMT_ITEM.setValue("ACCOUNT_VIEW", "X");//会计
            GDSMT_ITEM.setValue("PURCHASE_VIEW", "X");//采购
            if(saptype == 1 ){
                GDSMT_ITEM.setValue("SALES_VIEW", "X");//销售
                GDSMT_ITEM.setValue("PLAN_VIEW", "X");//计划
                GDSMT_ITEM.setValue("MRP_VIEW", "X");//生产
            }else if( saptype == 2 || saptype == 3){
                GDSMT_ITEM.setValue("SALES_VIEW", "X");//销售
                GDSMT_ITEM.setValue("PLAN_VIEW", "X");//计划
                GDSMT_ITEM.setValue("MRP_VIEW", "X");//生产
                GDSMT_ITEM.setValue("QUALITY_VIEW", "X");//质量
            }
            GDSMT_ITEM.setValue("MATNR", re1.get("codeno"));
            //Hmdm测试物料
            GDSMT_ITEM.setValue("MAKTX", re1.get("codename"));
            for (String in : re1.keySet()) {
                if(!(in.equals("itemno")||in.equals("id")||in.equals("codeno")||in.equals("codename")||in.equals("isexpand"))){
                    //用来判断是否是特性值 东风不需要
//                    boolean flag = true ;
//                    for(String msattr:msattrs){
//                        if(msattr.equals(in)){
//                            flag = false;
//                            break;
//                        }
//                    }
//                    if(flag){
                        String[] ins =  in.split("-");
                        String key = "";
                        if(ins.length>0){
                            key = ins[ins.length-1];
                            String val = (String) re1.get(in);
                            if(val!=null&&!val.equals("")){
                                //用来判断是不是联动带出的属性 传入数据库的格式为*（*）,括弧中为实际传入sap的值
                                int valstart = val.indexOf("(");
                                int valend =  val.indexOf(")");
                                if(valstart!=-1&&valend!=-1){
                                    GDSMT_ITEM.setValue(key,val.substring(valstart+1,valend));
                                }else {
                                    GDSMT_ITEM.setValue(key,val);
                                }

                            }
                        }else {
                            key = ins[0];
                            String val = (String) re1.get(in);
                            if(!val.equals("")){
                                int valstart = val.indexOf("(");
                                int valend =  val.indexOf(")");
                                if(valstart!=-1&&valend!=-1){
                                    GDSMT_ITEM.setValue(key,val.substring(valstart+1,valend));
                                }else {
                                    GDSMT_ITEM.setValue(key,val);
                                }
                            }

                        }
//                    }

                }



            }

        }
        JSONObject re = new JSONObject();
        function.execute(destination);
        List<String> mess = new ArrayList<String>();
        JSONArray resultmess = new JSONArray();
        result = function.getTableParameterList().getTable("Z_RETURN");//调用接口返回参数
        boolean flag = true;
        for (int i = 0; i < result.getNumRows(); i++) {
            result.setRow(i);
            mess.add(result.getString("ZMESS"));
            JSONObject re1 = new JSONObject();
            re1.put("ZOBJE",result.getString("ZOBJE"));
            if(result.getString("ZISOK").equals("N")){
                flag = false;
            }
            re1.put("ZISOK",result.getString("ZISOK"));
            re1.put("ZMESS",result.getString("ZMESS"));
            resultmess.add(re1);
        }
        re.put("flag",flag);
        if(flag){
            for (CodeApplDetail codeApplDetail1:list){
                if(codeApplDetail1.getIsexpand()==2){
                    int codeid = codeApplDetail1.getCodeid();
                    Code code = codeService.selectById(codeid);
                    for (int j=0;j<column.size();j++){
                        String meth="getT" + (j+1);
                        Method m2 = herosClass.getMethod(meth);
                        String a = column.get(j);
                        String b = (String) m2.invoke(codeApplDetail1);
                        PropertyDescriptor pd = new PropertyDescriptor("t"+(j+1), codeclass);
                        Method wM = pd.getWriteMethod();
                        wM.invoke(code, b);
                    }
                    codeService.update(code);
                }
            }
        }
        re.put("message",resultmess);
        message = function.getExportParameterList().getString("E_MESSAGE");//调用接口返回信息
        GDSMT_ITEM.clear();//清空本次条件，如果要继续传入值去或者还要循环，那得将之前的条件清空
        return re;
    }

    public Map Save(List<CodeApplDetail> list,CodeType codeType,String bjattrs) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        Map json = new HashMap();
        String typeno = codeType.getTypeno();
        String codename = "";
        CodeName flcc = codeNameService.selectFLCX(typeno);
        List<CodeName> codeNames = codeNameService.selectByTypeno(typeno);
        String flccname = "";
        if(flcc!=null){
            flccname = flcc.getTypename()+flcc.getSplitstr();
        }
        String bjattr[] = bjattrs.split(",");
        int length = codeType.getKindnum();
        int begin = Integer.parseInt(codeType.getCodebegin());
        int end = Integer.parseInt(codeType.getCodeend());
        int n = 0;
        Class<?> herosClass = CodeApplDetail.class;
        for(CodeApplDetail codeApplDetail:list){
            Map maxserialnumber = codeApplService.selectMaxserialNumber(typeno,begin,end,length);
            String codeno = typeno + maxserialnumber.get("returnNo");
            codeApplDetail.setCodeno(codeno);
            codename = flccname;
            for (int i =0 ;i<bjattr.length;i++){
                String meth = bjattr[i];
                meth="get"+meth.substring(0, 1).toUpperCase() + meth.substring(1);
                Method m2 = herosClass.getMethod(meth);
                String bjflag = (String) m2.invoke(codeApplDetail);
                codename = codename + bjflag + codeNames.get(i).getSplitstr();
            }
            codeApplDetail.setCodename(codename.substring(0,codename.length()-1));
            codeApplDetail.setSerialnumber((Integer) maxserialnumber.get("serialnumber"));
            codeApplService.updateCodeApplDetail(codeApplDetail);
            n = n+1;
        }
        json.put("num",n);
        return json;
    }


    public Map Save3(List<CodeApplDetail> list,CodeType codeType,String bjattrs,boolean bmflag,boolean msflag) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        Map json = new HashMap();
        String typeno = codeType.getTypeno();
        String codename = "";
        CodeName flcc = codeNameService.selectFLCX(typeno);
        List<CodeName> codeNames = codeNameService.selectByTypeno(typeno);
        String flccname = "";
        if(flcc!=null){
            flccname = flcc.getTypename()+flcc.getSplitstr();
        }
        String bjattr[] = bjattrs.split(",");
        int length = codeType.getKindnum();
        int begin = Integer.parseInt(codeType.getCodebegin());
        int end = Integer.parseInt(codeType.getCodeend());
        int n = 0;
        Class<?> herosClass = CodeApplDetail.class;
        for(CodeApplDetail codeApplDetail:list){
            if(!bmflag){
                Map maxserialnumber = codeApplService.selectMaxserialNumber(typeno,begin,end,length);
                String codeno = typeno + maxserialnumber.get("returnNo");
                codeApplDetail.setCodeno(codeno);
                codeApplDetail.setSerialnumber((Integer) maxserialnumber.get("serialnumber"));
            }

            if(!msflag){
                codename = flccname;
                for (int i =0 ;i<bjattr.length;i++){
                    String meth = bjattr[i];
                    meth="get"+meth.substring(0, 1).toUpperCase() + meth.substring(1);
                    Method m2 = herosClass.getMethod(meth);
                    String bjflag = (String) m2.invoke(codeApplDetail);
                    codename = codename + bjflag + codeNames.get(i).getSplitstr();
                }
                codeApplDetail.setCodename(codename.substring(0,codename.length()-1));
            }


            codeApplService.updateCodeApplDetail(codeApplDetail);
            n = n+1;
        }
        json.put("num",n);
        return json;
    }

    public Map Save2(List<CodeApplDetail> list,CodeType codeType,String bjattrs) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException, IntrospectionException {
        Map json = new HashMap();
        String typeno = codeType.getTypeno();
        TypeDetail typeDetail = typeDetailService.selectByNo(typeno);
        String codename = "";
        CodeName flcc = codeNameService.selectFLCX(typeno);
        List<CodeName> codeNames = codeNameService.selectByTypeno(typeno);
        String flccname = "";
        if(flcc!=null){
            flccname = flcc.getTypename()+flcc.getSplitstr();
        }
        String bjattr[] = bjattrs.split(",");
        int length = codeType.getKindnum();
        int begin = Integer.parseInt(codeType.getCodebegin());
        int end = Integer.parseInt(codeType.getCodeend());
        int n = 0;
        Class<?> herosClass = CodeApplDetail.class;
//        Class<?> codeClass = Code.class;
        for(CodeApplDetail codeApplDetail:list){
            Map maxserialnumber = codeApplService.selectMaxserialNumber(typeno,begin,end,length);

            codename = flccname;
            CodeApplDetail codeApplDetail1 = new CodeApplDetail();
            codeApplDetail1.setTypedetailno(typeno);
//            Code code = new Code();
//            code.setTypedetailid(typeDetail.getId());
            for (int i =0 ;i<bjattr.length;i++){
                String attr = bjattr[i];
                String meth="get"+attr.substring(0, 1).toUpperCase() + attr.substring(1);

                Method m2 = herosClass.getMethod(meth);
                String bjflag = (String) m2.invoke(codeApplDetail);
                codename = codename + bjflag + codeNames.get(i).getSplitstr();

                PropertyDescriptor pd = new PropertyDescriptor(attr, herosClass);
                Method wM = pd.getWriteMethod();
                wM.invoke(codeApplDetail1, bjflag.replaceAll("\"",""));
//                wM.invoke(code, bjflag.replaceAll("\"",""));
            }
            List<CodeApplDetail> codeApplDetailExist = codeApplService.selectExistDetail(codeApplDetail1);
//            List<Code> codes = codeService.select(code);
            if(codeApplDetailExist == null||codeApplDetailExist.size()==0){
                String codeno = typeno + maxserialnumber.get("returnNo");
                codeApplDetail.setCodeno(codeno);
                codeApplDetail.setSerialnumber((Integer) maxserialnumber.get("serialnumber"));
            }else{
                codeApplDetail.setCodeno(codeApplDetailExist.get(codeApplDetailExist.size()-1).getCodeno());
            }
            codeApplDetail.setCodename(codename.substring(0,codename.length()-1));

            codeApplService.updateCodeApplDetail(codeApplDetail);
            n = n+1;
        }
        json.put("num",n);
        return json;
    }

    public Map Save4(List<CodeApplDetail> list,CodeType codeType,String bjattrs,boolean bmflag,boolean msflag) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException, IntrospectionException {
        Map json = new HashMap();
        String typeno = codeType.getTypeno();
        TypeDetail typeDetail = typeDetailService.selectByNo(typeno);
        String codename = "";
        CodeName flcc = codeNameService.selectFLCX(typeno);
        List<CodeName> codeNames = codeNameService.selectByTypeno(typeno);
        String flccname = "";
        if(flcc!=null){
            flccname = flcc.getTypename()+flcc.getSplitstr();
        }
        String bjattr[] = bjattrs.split(",");
        int length = codeType.getKindnum();
        int begin = Integer.parseInt(codeType.getCodebegin());
        int end = Integer.parseInt(codeType.getCodeend());
        int n = 0;
        Class<?> herosClass = CodeApplDetail.class;
//        Class<?> codeClass = Code.class;
        for(CodeApplDetail codeApplDetail:list){
            Map maxserialnumber = codeApplService.selectMaxserialNumber(typeno,begin,end,length);

            codename = flccname;
            CodeApplDetail codeApplDetail1 = new CodeApplDetail();
//            Code code = new Code();
            codeApplDetail1.setTypedetailno(typeno);
//            code.setTypedetailid(typeDetail.getId());
            if(!msflag){
                for (int i =0 ;i<bjattr.length;i++){
                    String attr = bjattr[i];
                    String meth="get"+attr.substring(0, 1).toUpperCase() + attr.substring(1);

                    Method m2 = herosClass.getMethod(meth);
                    String bjflag = (String) m2.invoke(codeApplDetail);
                    codename = codename + bjflag + codeNames.get(i).getSplitstr();

                    PropertyDescriptor pd = new PropertyDescriptor(attr, herosClass);
                    Method wM = pd.getWriteMethod();
                    wM.invoke(codeApplDetail1, bjflag.replaceAll("\"",""));
//                    wM.invoke(code, bjflag.replaceAll("\"",""));
                }
                codeApplDetail.setCodename(codename.substring(0,codename.length()-1));
            }
            if(!bmflag){
                for (int i =0 ;i<bjattr.length;i++){
                    String attr = bjattr[i];
                    String meth="get"+attr.substring(0, 1).toUpperCase() + attr.substring(1);
                    Method m2 = herosClass.getMethod(meth);
                    String bjflag = (String) m2.invoke(codeApplDetail);
                    PropertyDescriptor pd = new PropertyDescriptor(attr, herosClass);
                    Method wM = pd.getWriteMethod();
                    wM.invoke(codeApplDetail1, bjflag.replaceAll("\"",""));
//                    wM.invoke(code, bjflag.replaceAll("\"",""));
                }
//                List<Code> codes = codeService.select(code);
                List<CodeApplDetail> codeApplDetailExist = codeApplService.selectExistDetail(codeApplDetail1);
                if(codeApplDetailExist == null||codeApplDetailExist.size()==0){
                    String codeno = typeno + maxserialnumber.get("returnNo");
                    codeApplDetail.setCodeno(codeno);
                    codeApplDetail.setSerialnumber((Integer) maxserialnumber.get("serialnumber"));
                }else{
                    codeApplDetail.setCodeno(codeApplDetailExist.get(codeApplDetailExist.size()-1).getCodeno());
                }


            }

            codeApplService.updateCodeApplDetail(codeApplDetail);
            n = n+1;
        }
        json.put("num",n);
        return json;
    }

    public Map Save3(List<CodeApplDetail> list,String applyno,int isexpand) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException, IntrospectionException {
        Map json = new HashMap();
        Class<?> herosClass = CodeApplDetail.class;
        Class<?> herosClass2 = Code.class;
        int n = 0;
        List<Integer> codes =  new ArrayList<Integer>();
        for(CodeApplDetail codeApplDetail:list){
            //扩充或者新建
            if(codeApplDetail.getIsexpand()!=2){
                Code code = new Code();
                code.setCodeno(codeApplDetail.getCodeno());
                code.setCodename(codeApplDetail.getCodename());
                code.setTypedetailid(codeApplDetail.getTypedetailid());
                code.setInputman(codeApplDetail.getInputman());
                code.setInputdate(codeApplDetail.getInputdate());
                code.setIslocked(codeApplDetail.getIslocked());
                code.setIsexpand(codeApplDetail.getIsexpand());
                code.setApplyno(applyno);
                for (int i = 1 ; i<101;i++){
                    String meth="getT"+i;
                    String attr = "t"+i;
                    Method m2 = herosClass.getMethod(meth);
                    String bjflag = (String) m2.invoke(codeApplDetail);
                    PropertyDescriptor pd = new PropertyDescriptor(attr, herosClass2);
                    Method wM = pd.getWriteMethod();
                    if(bjflag==null){
                        wM.invoke(code, bjflag);
                    }else{
                        wM.invoke(code, bjflag.replaceAll("\"",""));
                    }

                }


                n = n+codeService.add(code);

                codes.add(codeService.selectNewId());

            }else{
                //修改流程
                int codeid = codeApplDetail.getCodeid();
                Code code = codeService.selectById(codeid);
                code.setIsexpand(2);
                codeService.update(code);
            }

        }

        json.put("num",n);
        json.put("codes",codes);
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "editcodeappldetail", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject editcodeappldetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        CodeApplDetail codeApplDetail = codeApplService.selectByDetailId(Integer.parseInt(id));
        List<String> column = selectColumn(codeApplDetail.getTypedetailid());
        Class<?> herosClass = CodeApplDetail.class;
        for (int j=0;j<column.size();j++){
            String meth="getT" + (j+1);
            Method m2 = herosClass.getMethod(meth);
            String a = column.get(j);
            String ttt = request.getParameter(a.replace("\"",""));
            PropertyDescriptor pd = new PropertyDescriptor("t"+(j+1), herosClass);
            Method wM = pd.getWriteMethod();
            wM.invoke(codeApplDetail, ttt.replaceAll("\"",""));
        }
        int i = codeApplService.updateCodeApplDetail(codeApplDetail);
        net.sf.json.JSONObject result=new net.sf.json.JSONObject();
        result.put("num", i);
        ResponseUtil.write(response, result);
        return null;
    }

    @ResponseBody
    @RequestMapping(value = "deletecodeappldetail", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject deletecodeappldetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        int i = codeApplService.deletecodeappldetail(Integer.parseInt(id));
        net.sf.json.JSONObject result=new net.sf.json.JSONObject();
        result.put("num", i);
        ResponseUtil.write(response, result);
        return null;
    }

    @ResponseBody
    @RequestMapping(value = "getMaxItemno", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject getMaxItemno(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        String applyno = request.getParameter("applyno");
        net.sf.json.JSONObject result=new net.sf.json.JSONObject();
        int   i = codeApplService.getMaxItemno(applyno);
        result.put("itemno", i);
        ResponseUtil.write(response, result);
        return null;
    }


    @ResponseBody
    @RequestMapping(value = "Query", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject query(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        String applyno = request.getParameter("applyno");
        String applystate = request.getParameter("applystate");
        String inputman = request.getParameter("inputman");
        String inputdate =request.getParameter("inputdate");
        CodeAppl codeAppl =new CodeAppl();
        codeAppl.setApplyno(applyno);
        codeAppl.setApplystate(applystate);
        codeAppl.setInputman(inputman);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if(!inputdate.equals("")){
            Date date = sdf.parse(inputdate);
            codeAppl.setInputdate(date);
        }

        JSONObject re = new JSONObject();
        JSONArray jslst = new JSONArray();
        List<CodeAppl> list = codeApplService.query(codeAppl);
        CodeAppl codeAppl1;
        if(list.size()>0) {
            for (int i=0;i<list.size();i++){
                JSONObject re1 = new JSONObject();
                codeAppl1 = (CodeAppl)list.get(i);
                re1.put("id",codeAppl1.getId());
                re1.put("applyno",codeAppl1.getApplyno());
                re1.put("applystate",codeAppl1.getApplystate());
                re1.put("inputman",codeAppl1.getInputman());
                re1.put("inputdate",codeAppl1.getInputdate()==null?"":sdf.format(codeAppl1.getInputdate()));
                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }


    @ResponseBody
    @RequestMapping(value = "selectByApplyno", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectByApplyno(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String applyno = request.getParameter("applyno");
        CodeAppl codeAppl = codeApplService.selectByApplyno(applyno);
        JSONObject re1 = new JSONObject();
        re1.put("id",codeAppl.getId());
        re1.put("applyno",codeAppl.getApplyno());
        re1.put("applystate",codeAppl.getApplystate());
        re1.put("inputman",codeAppl.getInputman());
        re1.put("inputdate",codeAppl.getInputdate());
        re1.put("applytype",codeAppl.getApplytype());
        re1.put("typedetailid",codeAppl.getTypedetailid());
        re1.put("applyreasons",codeAppl.getApplyreasons());
        re1.put("applystate",codeAppl.getApplystate());
        int typedetailid = codeAppl.getTypedetailid();
        TypeDetail typeDetail = typeDetailService.selectById(typedetailid);
        re1.put("typename",typeDetail.getTypename());
        re1.put("typeno",typeDetail.getTypeno());

        return re1;
    }

    @ResponseBody
    @RequestMapping(value="/import",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject impotr(HttpServletRequest request, @RequestParam(value = "bz-uploadExcel", required = false) MultipartFile file) throws Exception {
        String typedetailid = request.getParameter("typedetailid");
        //获取上传的文件
        MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
        MultipartFile file1 = multipart.getFile("bz-uploadExcel");
        Map map = selectByTypeDetailId(Integer.parseInt(typedetailid));
        List<String> attrDefineList = (List<String>) map.get("attrDefineList");
        List<AttrDefine> attrDefines = (List<AttrDefine>) map.get("attrs");

        InputStream in = file1.getInputStream();
        List<List<Object>> listob = ExcelUtil.getBankListByExcel(in,file.getOriginalFilename());
        JSONArray jslst = new JSONArray();

        for (int i = 0; i < listob.size(); i++) {
            JSONObject re1 = new JSONObject();
            List<Object> ob = listob.get(i);
            re1.put("id","");
            for (int j =0;j<ob.size();j++){
                String value  = (String) ob.get(j);
                if(j==0){
                    re1.put("itemno",value);
                }else if(j==1){
                    re1.put("codeno",value);
                }else if(j==2){
                    re1.put("codename",value);
                }else {
                    String viewattr = attrDefineList.get(j-3);
                    AttrDefine attrDefine = attrDefines.get(j-3);
                    if(value.equals("")){
                        re1.put(attrDefine.getAttrdefineno(),"");
                    }else{
                        if(attrDefine.getWidgettype()==5){
                            if(attrDefine.getDatabasetype()==1){
                                int basefid = attrDefine.getDatabaseid();
                                List<Base> baseList = baseService.selectByNoAndFid(value,basefid);
                                if(baseList!=null&&baseList.size()!=0){
                                    Base base = baseList.get(0);
                                    re1.put(viewattr,base.getBasename()+"("+base.getBaseno()+")");
                                }


                            }
                            if(attrDefine.getDatabasetype()==2){
                                int attrfid = attrDefine.getAttrid();
                                Attr attr = attrService.selectByNoAndFid(value,attrfid);
                                re1.put(viewattr,attr.getAttrname()+"("+attr.getAttrno()+")");

                            }
                            if(attrDefine.getDatabasetype()==3){
                                int factoryfid = attrDefine.getFactoryid();
                                Factory factory = factoryService.selectByNoAndFid(value,factoryfid);
                                re1.put(viewattr,factory.getAttrname()+"("+factory.getAttrno()+")");
                            }
                        }else{
                            re1.put(viewattr,value);
                        }
                    }
                }
            }

            jslst.add(re1);
        }

        JSONObject re = new JSONObject();
            re.put("rows",jslst);
            re.put("total",jslst.size());
            re.put("success",true);
            re.put("message","导入成功");

        return  re;
    }
    @ResponseBody
    @RequestMapping(value = "download", method = {RequestMethod.GET, RequestMethod.POST})
    public void download(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException {
        String typedetailid = request.getParameter("typedetailid");
        Map map = selectByTypeDetailId(Integer.parseInt(typedetailid));
        List<AttrDefine> attrDefines = (List<AttrDefine>) map.get("attrs");
        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("Sheet0");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

        HSSFCell cell = row.createCell((short) 0);
        cell.setCellValue("行号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 1);
        cell.setCellValue("主数据编码");
        cell.setCellStyle(style);
        cell = row.createCell((short) 2);
        cell.setCellValue("主数据描述");
        cell.setCellStyle(style);
        int i = 3;
        for (AttrDefine attrDefine:attrDefines){
            cell = row.createCell((short) i);
            cell.setCellValue(attrDefine.getAttrdefinename());
            cell.setCellStyle(style);
            i = i+1;
        }
        // 第六步，将文件存到指定位置
        Date date = new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        String name = "主数据创建"+sdf.format(date);
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+name+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            wb.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

    @ResponseBody
    @RequestMapping(value = "downloadExpand", method = {RequestMethod.GET, RequestMethod.POST})
    public void downloadExpand(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException {
        String typedetailid = request.getParameter("typedetailid");
        Map map = selectByTypeDetailId(Integer.parseInt(typedetailid));
        List<AttrDefine> attrDefines = (List<AttrDefine>) map.get("attrs");
        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("Sheet0");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

        HSSFCell cell = row.createCell((short) 0);
        cell.setCellValue("行号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 1);
        cell.setCellValue("主数据编码");
        cell.setCellStyle(style);
        cell = row.createCell((short) 2);
        cell.setCellValue("主数据描述");
        cell.setCellStyle(style);
        int i = 3;
        for (AttrDefine attrDefine:attrDefines){
            cell = row.createCell((short) i);
            cell.setCellValue(attrDefine.getAttrdefinename());
            cell.setCellStyle(style);
            i = i+1;
        }
        // 第六步，将文件存到指定位置
        String name = "主数据修改及扩充";
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+name+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            wb.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
}

