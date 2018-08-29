package com.dhchain.business.code.controller;

import com.alibaba.fastjson.JSON;
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
import com.dhchain.business.code.service.CodeNameService;
import com.dhchain.business.code.service.CodeService;
import com.dhchain.business.code.service.CodeTypeService;
import com.dhchain.business.code.vo.Code;
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
import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by zhenglb on 2017-10-20.
 */
@Controller
@RequestMapping("/code")
public class CodeController {
    @Autowired
    private CodeService codeService;
    @Autowired
    private CodeTypeService codeTypeService;
    @Autowired
    private CodeNameService codeNameService;
    @Autowired
    private ViewService viewService;
    @Autowired
    private ExptypeService exptypeService;
    // lijq
    @Autowired
    private TypeDetailService typeDetailService;
    @Autowired
    private BaseService baseService;
    @Autowired
    private AttrService attrService;
    @Autowired
    private FactoryService factoryService;
    @Autowired
    private AttrDefineService attrDefineService;
    @ResponseBody
    @RequestMapping(value = "selectCodeAttr", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectCodeAttr(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typedetailid = request.getParameter("typedetailid");
        Code code = new Code();
        code.setTypedetailid(Integer.parseInt(typedetailid));
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Code> jslist =  codeService.select(code);
        JSONArray jslst = new JSONArray();
        Code code1;
        String codeno;
        boolean flag;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                code1 = (Code)jslist.get(i);
                codeno = code1.getCodeno();
                flag = codeService.iscontain(codeno);
                if(flag){
                    continue;
                }else{
                    re1.put("id",code1.getId());
                    re1.put("typedetailid",code1.getTypedetailid());
                    re1.put("codeno",code1.getCodeno());
                    re1.put("codename",code1.getCodename());
                    re1.put("islocked",code1.getIslocked()==0?"否":"是");
                    re1.put("inputman",code1.getInputman());
                    re1.put("inputdate",code1.getInputdate()==null?"":sdf.format(code1.getInputdate()));
                    jslst.add(re1);
                }

            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }
    @ResponseBody
    @RequestMapping(value = "selectEcharts", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectEcharts(HttpServletRequest request) throws UnsupportedEncodingException {
        Code code = new Code();
        JSONArray jslst = new JSONArray();
        List<Integer> typedetailids = codeService.selectTypes();
        for (Integer typedetailid:typedetailids){
            JSONObject re1 = new JSONObject();
            List<Code> codeList = codeService.selectByTypeDetailid(typedetailid);
            TypeDetail typeDetail = typeDetailService.selectById(typedetailid);
            re1.put("value",codeList.size());
            if(typeDetail!=null){
                re1.put("name",typeDetail.getTypename());
            }

            jslst.add(re1);
        }

        JSONObject re = new JSONObject();
        re.put("rows",jslst);

        return re;
    }


    @ResponseBody
    @RequestMapping(value = "selectDepartmentCodes", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectDepartmentCodes(HttpServletRequest request) throws UnsupportedEncodingException {
        List<Map> departmentCodes = codeService.selectDepartmentCodes();
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        for (Map map:departmentCodes){
            JSONObject re1 = new JSONObject();
            re1.put("organization",map.get("organization"));
            re1.put("num",map.get("num"));
            jslst.add(re1);
        }
        re.put("rows",jslst);
        return re;
    }

    @ResponseBody
    @RequestMapping(value = "completionRate", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject completionRate(HttpServletRequest request) throws UnsupportedEncodingException {
        List<Map> completionrate = codeService.completionRate();

        JSONObject re = new JSONObject();

        re.put("completionrate",completionrate);
        return re;
    }

    @ResponseBody
    @RequestMapping(value = "monthlyIncrement", method = {RequestMethod.GET, RequestMethod.POST})
    public Map monthlyIncrement(HttpServletRequest request) throws UnsupportedEncodingException {
        Map completionrate = codeService.monthlyIncrement();

        return completionrate;
    }

    @ResponseBody
    @RequestMapping(value = "selectRoutAttr", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectRoutAttr(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typedetailid = request.getParameter("typedetailid");
        Code code = new Code();
        code.setTypedetailid(Integer.parseInt(typedetailid));
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Code> jslist =  codeService.select(code);
        JSONArray jslst = new JSONArray();
        Code code1;
        String codeno;
        boolean flag;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                code1 = (Code)jslist.get(i);
                codeno = code1.getCodeno();
                flag = codeService.iscontainrout(codeno);
                if(flag){
                    continue;
                }else{
                    re1.put("id",code1.getId());
                    re1.put("typedetailid",code1.getTypedetailid());
                    re1.put("codeno",code1.getCodeno());
                    re1.put("codename",code1.getCodename());
                    re1.put("islocked",code1.getIslocked()==0?"否":"是");
                    re1.put("inputman",code1.getInputman());
                    re1.put("inputdate",code1.getInputdate()==null?"":sdf.format(code1.getInputdate()));
                    jslst.add(re1);
                }

            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }


    @ResponseBody
    @RequestMapping(value = "selectByTypedetailid", method = {RequestMethod.GET, RequestMethod.POST})
    public com.alibaba.fastjson.JSONObject selectByTypedetailid(HttpServletRequest request) throws UnsupportedEncodingException, ParseException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        request.setCharacterEncoding("utf-8");
        String typedetailid = request.getParameter("typedetailid");
        String typedetailno = request.getParameter("typedetailno");
        Code code1 = new Code();
        code1.setTypedetailid(Integer.parseInt(typedetailid));
        List<Code> list = codeService.select(code1);
        Code code;
        JSONArray jslst = new JSONArray();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        com.alibaba.fastjson.JSONObject re = new com.alibaba.fastjson.JSONObject();

        TypeDetail typeDetail;
        if(list.size()>0) {
            for (int i=0;i<list.size();i++){
                com.alibaba.fastjson.JSONObject re1 = new com.alibaba.fastjson.JSONObject();
                code = (Code)list.get(i);
                re1.put("id",code.getId());
                re1.put("typedetailid",code.getTypedetailid());
                typeDetail = typeDetailService.selectById(code.getTypedetailid());
                re1.put("typedetailno",typeDetail.getTypeno());
                re1.put("typedetailname",typeDetail.getTypename());
                re1.put("codeno",code.getCodeno());
                re1.put("codename",code.getCodename());
                re1.put("inputman",code.getInputman());
                if(code.getInputdate()!=null){
                    re1.put("inputdate",sdf.format(code.getInputdate()));
                }


                List<CodeType> list1 = codeTypeService.selectByTypeno(typedetailno);
                CodeType codeType;
                Class<?> herosClass = Code.class;
                if(list1.size()>0){
                    for (int j=0;j<list1.size();j++){
                        codeType = (CodeType)list1.get(j);
                        String meth = codeType.getAttrno();
                        meth="get"+meth.substring(0, 1).toUpperCase() + meth.substring(1);
                        Method m2 = herosClass.getMethod(meth);
                        m2.invoke(code);
                        re1.put(codeType.getAttrno(), m2.invoke(code));
                    }
                }
                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }

    //lijq
    @ResponseBody
    @RequestMapping(value = "/expApplycolumn", method = {RequestMethod.GET, RequestMethod.POST})
    public net.sf.json.JSONObject expApplycolumn(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typedetailno = request.getParameter("typedetailno");
        List<CodeType> list = codeTypeService.selectByTypeno(typedetailno);
        JSONArray jslst = new JSONArray();
        net.sf.json.JSONObject re = new net.sf.json.JSONObject();
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
        re3.put("hidden", false);
        jslst.add(re3);
        net.sf.json.JSONObject re4 = new net.sf.json.JSONObject();
        re4.put("title", "主数据分类名称");
        re4.put("field", "typedetailname");
        re4.put("width", "100px");
        re4.put("hidden", false);
        jslst.add(re4);
        net.sf.json.JSONObject re5 = new net.sf.json.JSONObject();
        re5.put("title", "主数据物料编码");
        re5.put("field", "codeno");
        re5.put("width", "100px");
        re5.put("hidden", false);
        jslst.add(re5);
        net.sf.json.JSONObject re6 = new net.sf.json.JSONObject();
        re6.put("title", "主数据物料名称");
        re6.put("field", "codename");
        re6.put("width", "100px");
        re6.put("hidden", false);
        jslst.add(re6);
        CodeType codeType;
        if(list.size()>0){
            for (int i=0;i<list.size();i++){
                net.sf.json.JSONObject re10 = new net.sf.json.JSONObject();
                codeType = (CodeType)list.get(i);

                re10.put("title",codeType.getAttrname());
                re10.put("field",codeType.getAttrno());
                re10.put("width","100px");
                re10.put("hidden",false);
                jslst.add(re10);


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
    @RequestMapping(value = "getCodeData", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject getCodeData(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typedetailid = request.getParameter("typedetailid");
        Code code = new Code();
        code.setTypedetailid(Integer.parseInt(typedetailid));
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Code> jslist =  codeService.getCodeData(code);
        JSONArray jslst = new JSONArray();
        Code code1;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                code1 = (Code)jslist.get(i);
                re1.put("id",code1.getId());
                re1.put("codeno",code1.getCodeno());
                re1.put("codename",code1.getCodename());

                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }



    @ResponseBody
    @RequestMapping(value = "/codeApplySTcolumn", method = {RequestMethod.GET, RequestMethod.POST})
    public  net.sf.json.JSONObject  codeApplySTcolumn(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typedetailid = request.getParameter("typedetailid");
        String typeno = request.getParameter("typeno");
        String bjattrs = "";
        int flag = 0;
        int werksflag = 0;
        List<CodeName> codeNames = codeNameService.selectByTypeno(typeno) ;
        TypeDetail typeDetail = typeDetailService.selectById(Integer.parseInt(typedetailid));
        Exptype exptype = exptypeService.selectById(typeDetail.getExptypeid()+"");
        List<View> views = viewService.selectByExptypeid(exptype.getId());
        JSONArray jslst = new JSONArray();
        JSONArray jslst2 = new JSONArray();
        JSONArray frozenBTColumn = new JSONArray();
        JSONArray frozenBTColumn2 = new JSONArray();
        View view;
        AttrDefine attrDefine;
        com.alibaba.fastjson.JSONObject re9 = new com.alibaba.fastjson.JSONObject();
        com.alibaba.fastjson.JSONObject re6 = new com.alibaba.fastjson.JSONObject();
        com.alibaba.fastjson.JSONObject re3 = new com.alibaba.fastjson.JSONObject();
        re9.put("colspan",1);
        re9.put("width",60);
        re9.put("align","center");
        re9.put("checkbox",true);
        re9.put("sortable",true);
        re9.put("hidden",true);
        frozenBTColumn.add(re9);
        re6.put("colspan",2);
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
        re8.put("title","编码");
        re8.put("width","60");
        re8.put("checkbox",true);
        re8.put("sortable",true);
        re8.put("hidden",true);
        frozenBTColumn2.add(re8);
        com.alibaba.fastjson.JSONObject re7 = new com.alibaba.fastjson.JSONObject();
        re7.put("field","isexpand");
        re7.put("title","扩充");
        re7.put("width","60");
        frozenBTColumn2.add(re7);
        com.alibaba.fastjson.JSONObject re11 = new com.alibaba.fastjson.JSONObject();
        re11.put("field","issuccess");
        re11.put("title","传输成功");
        re11.put("width","60");
        frozenBTColumn2.add(re11);
        com.alibaba.fastjson.JSONObject re4 = new com.alibaba.fastjson.JSONObject();
        com.alibaba.fastjson.JSONObject re5 = new com.alibaba.fastjson.JSONObject();
        re4.put("field","codeno");
        re4.put("title","主数据编码");
        re4.put("sortable",true);
        re4.put("remoteSort",false);
        re4.put("width","100");
        re5.put("field","codename");
        re5.put("title","主数据描述");
        re5.put("width","200");
        frozenBTColumn2.add(re4);
        frozenBTColumn2.add(re5);
        if(views.size()>0){
            for (int i=0;i<views.size();i++){
                view = views.get(i);
                com.alibaba.fastjson.JSONObject re1 = new com.alibaba.fastjson.JSONObject();
                List<AttrDefine> attrDefines = viewService.selectAttrDefines(view.getId());
                re1.put("colspan",attrDefines.size());
                re1.put("title",view.getViewname());
                re1.put("width",60*attrDefines.size());
                re1.put("align","center");
                jslst.add(re1);
                if(attrDefines.size()>0){
                    for (int j=0;j<attrDefines.size();j++){
                        flag+=1;
                        attrDefine = attrDefines.get(j);
                        if(view.getViewname().equals("基本视图")){
                            for (CodeName codeName:codeNames){
                                if (codeName.getAttrname().equals(attrDefine.getAttrdefinename())){
                                    String bjattr = "t" + flag;
                                    bjattrs =  bjattrs + bjattr+",";
                                }
                            }
                        }
                        com.alibaba.fastjson.JSONObject re2 = new com.alibaba.fastjson.JSONObject();
                        re2.put("field",view.getViewcode()+"_"+attrDefine.getAttrdefineno());
                        re2.put("title",attrDefine.getAttrdefinename());
                        re2.put("width","6%");
                        if(attrDefine.getIsrequired()==1){
                            com.alibaba.fastjson.JSONObject re10 = new com.alibaba.fastjson.JSONObject();
                            re10.put("required",true);
                            re2.put("data-options",re10);
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
        re.put("bjattrs",bjattrs);
        re.put("werksflag",werksflag);
        re.put("FirstFrozenColumns",frozenBTColumn);
        re.put("SecondFrozenColumns",frozenBTColumn2);
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

    public Map selectByTypeDetailId(int typedetailid){
        TypeDetail typeDetail = typeDetailService.selectById(typedetailid);
        Exptype exptype = exptypeService.selectById(typeDetail.getExptypeid()+"");
        List<View> views = viewService.selectByExptypeid(exptype.getId());
        List<String> attrDefineList = new ArrayList<String>();
        List<String> viewList = new ArrayList<String>();
        List<AttrDefine> attrs = new ArrayList<AttrDefine>();
        for (View view:views){
            viewList.add(view.getViewcode());
            List<AttrDefine> attrDefines = viewService.selectAttrDefines(view.getId());
            for (AttrDefine attrDefine:attrDefines){
                attrDefineList.add(view.getViewcode()+"_"+attrDefine.getAttrdefineno());
                attrs.add(attrDefine);
            }
        }
        Map map = new HashMap();
        map.put("attrDefineList",attrDefineList);
        map.put("viewList",viewList);
        map.put("attrs",attrs);
        return map;
    }

    /**
     * 查看code列表 查询慢 后面用多线程并发
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws IntrospectionException
     */
    @ResponseBody
    @RequestMapping(value = "select", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException, NoSuchMethodException, InvocationTargetException, IllegalAccessException, IntrospectionException {
        request.setCharacterEncoding("utf-8");
        String werksflag =  request.getParameter("werksflag");
        String exptypeparms = request.getParameter("parms");
        String[] exptypeparm = exptypeparms.split(",");
        String typedetailid = request.getParameter("typedetailid");
        Map map2 = selectByTypeDetailId(Integer.parseInt(typedetailid));
        List<AttrDefine> attrDefineList = (List<AttrDefine>) map2.get("attrs");
        Code code =new Code();
        Class<?> clazz = Code.class;
        code.setTypedetailid(Integer.parseInt(typedetailid));
//        String total = request.getParameter("total");
//        int kjtotal = Integer.parseInt(total);
//        if(kjtotal<11){
            for (String parm:exptypeparm){

                String data = request.getParameter(parm);
                if(data!=null){
                    if(data.equals("请选择")){
                        data = "";
                    }else if(data.indexOf("(")!=-1&&data.indexOf(")")!=-1){
                        int start = data.indexOf("(");
                        int end =  data.indexOf(")");
                        data = data.substring(start+1,end);
                    }
                    PropertyDescriptor pd = new PropertyDescriptor(parm, clazz);
                    Method wM = pd.getWriteMethod();
                    wM.invoke(code, data.replaceAll("\"",""));
                }else{
                    PropertyDescriptor pd = new PropertyDescriptor(parm, clazz);
                    Method wM = pd.getWriteMethod();
                    wM.invoke(code, "");
                }

            }
//        }else {
//            for (int i=1;i<11;i++){
//                String a = "t"+i;
//                String data = request.getParameter(a);
//                if(data.equals("请选择")){
//                    data = "";
//                }
//                PropertyDescriptor pd = new PropertyDescriptor(a, clazz);
//                Method wM = pd.getWriteMethod();
//                wM.invoke(code, data.replaceAll("\"",""));
//            }
//        }
        List<Code> codes = codeService.select(code);
        Code code1;
        List<String> column =selectColumn(Integer.parseInt(typedetailid));
        Class<?> herosClass = Code.class;
        JSONObject re = new JSONObject();
        JSONArray jslst = new JSONArray();
        String rebaseids = "";
        String rebaseitems = "";
        List<Integer> rebaseistemlist = new ArrayList<Integer>();
        AttrDefine werks = attrDefineService.selectByNo("MARC-WERKS");
        int werkbaseid = werks.getDatabaseid();
        int xhcs = 0;
        if(codes.size()>0) {
            for (int i=0;i<codes.size();i++){
                JSONObject re1 = new JSONObject();
                code1 = (Code)codes.get(i);
                String werksmeth="getT" + werksflag;
                Method werksmeth2 = herosClass.getMethod(werksmeth);
                String werkval = (String) werksmeth2.invoke(code1);
                List<Base> werkbase = baseService.selectByNoAndFid(werkval,werkbaseid);
                rebaseids =","+werkbase.get(0).getRebaseids()+",";
                rebaseitems =  werkbase.get(0).getRebaseitems()+",";
                String [] rebaseistemarr = rebaseitems.split(",");
                for (String rebaseitem :rebaseistemarr){
                    rebaseistemlist.add(Integer.parseInt(rebaseitem));
                    xhcs+=1;
                }

                for (int j=0;j<column.size();j++){
                    xhcs+=1;
                    String meth="getT" + (j+1);
                    Method m2 = herosClass.getMethod(meth);
                    String a = column.get(j);
                    String b = (String) m2.invoke(code1);
                    AttrDefine attrDefine = attrDefineList.get(j);
                    if(attrDefine.getWidgettype()==5){
                        int datebasetype = attrDefine.getDatabasetype();
                        if(datebasetype==1){
                            int basefid = attrDefine.getDatabaseid();
                            String basefidstr = ","+basefid+",";
                            Base base = null;
                            if(rebaseids.indexOf(basefidstr)!=-1){
                                for (Integer item:rebaseistemlist){
                                    xhcs+=1;
                                    Base baseitem = baseService.selectById(item);
                                    if(baseitem.getFid()==basefid&&baseitem.getBaseno().equals(b)){
                                        base = baseitem;
                                        break;

                                    }
                                }
                            }else{
                                List<Base> baseList = baseService.selectByNoAndFid(b,basefid);
                                if(baseList!=null&&baseList.size()==1){
                                    base = baseList.get(0);
                                }

                            }
                            if(base!=null){
                                re1.put(a,base.getBasename()+"("+base.getBaseno()+")");
                            }
//                            List<Base> bases = baseService.selectByNoAndFid(b,basefid);
//                            if(bases!=null){
//                                if(bases.size()==1){
//                                    re1.put(a,bases.get(0).getBasename()+"("+bases.get(0).getBaseno()+")");
//                                }else if(bases.size()>1){
//                                    //此处有问题 联动问题没解决
//                                    re1.put(a,bases.get(0).getBasename()+"("+bases.get(0).getBaseno()+")");
//                                }
//                            }

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

//                re1.put("itemno",codeApplDetail.getItemno());
                re1.put("codeno",code1.getCodeno());
                re1.put("codename",code1.getCodename());
                re1.put("id",code1.getId());
                re1.put("isexpand",code1.getIsexpand()==0?"":"√");
                re1.put("issuccess",code1.getIssuccess()==1?"√":"");
                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }


    @ResponseBody
    @RequestMapping(value = "selectcode", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectcode(HttpServletRequest request) throws UnsupportedEncodingException, NoSuchMethodException, InvocationTargetException, IllegalAccessException, IntrospectionException {
        request.setCharacterEncoding("utf-8");
        String typedetailid = request.getParameter("typedetailid");
        String itemnoStr = request.getParameter("itemno");
        int itemno = 0;
        if(itemnoStr!=null&&itemnoStr.equals("")){
            itemno = Integer.parseInt(request.getParameter("itemno"));
        }

        Code code =new Code();
        Class<?> clazz = Code.class;
        code.setTypedetailid(Integer.parseInt(typedetailid));
        String ids = request.getParameter("ids");
        String[] idArrray = ids.split(",");
        List<Code> codeList = codeService.select(code);
        List<Integer> removeids = new ArrayList<Integer>();
        List<Integer> allids = new ArrayList<Integer>();
        for (int i = 0;i<idArrray.length;i++){
            if(!idArrray[i].equals("")){
                int id = Integer.parseInt(idArrray[i]);
                removeids.add(id);
            }

        }
        for (Code codo2:codeList){
            allids.add(codo2.getId());
        }
        allids.removeAll(removeids);
        List<Code> codes = new ArrayList<Code>();
        for (int k:allids){
            codes.add(codeService.selectById(k));
        }
        Code code1;
        List<String> column =selectColumn(Integer.parseInt(typedetailid));
        Class<?> herosClass = Code.class;
        JSONObject re = new JSONObject();
        JSONArray jslst = new JSONArray();
        if(codes.size()>0) {
            for (int i=0;i<codes.size();i++){
                itemno = itemno + 10;
                JSONObject re1 = new JSONObject();
                code1 = (Code)codes.get(i);
                for (int j=0;j<column.size();j++){
                    String meth="getT" + (j+1);
                    Method m2 = herosClass.getMethod(meth);
                    String a = column.get(j);
                    String b = (String) m2.invoke(code1);
                    if(b!=null){
                        re1.put(a,b.replace("\"",""));
                    }

                }
                re1.put("itemno",itemno);
                re1.put("codeno",code1.getCodeno());
                re1.put("codename",code1.getCodename());
                re1.put("id",code1.getId());

                jslst.add(re1);

            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }


}
