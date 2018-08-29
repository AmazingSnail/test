package com.dhchain.business.exp.controller;

import com.alibaba.fastjson.JSONArray;

import com.dhchain.business.activiti.util.ResponseUtil;
import com.dhchain.business.code.service.CodeService;
import com.dhchain.business.code.service.CodeTypeService;
import com.dhchain.business.code.vo.Code;
import com.dhchain.business.code.vo.CodeType;
import com.dhchain.business.exp.service.ExpApplService;
import com.dhchain.business.exp.service.ExpDetailService;
import com.dhchain.business.exp.service.ExpService;
import com.dhchain.business.exp.vo.Exp;
import com.dhchain.business.exp.vo.ExpAppl;
import com.dhchain.business.exp.vo.ExpDetail;
import com.dhchain.business.type.service.TypeDetailService;
import com.dhchain.business.type.vo.TypeDetail;
import com.dhchain.business.user.vo.ActUser;
import com.dhchain.business.user.vo.Group;
import com.dhchain.business.user.vo.MemberShip;
import net.sf.json.JSONObject;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.IdentityLink;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by zhenglb on 2017-10-20.
 */
@Controller
@RequestMapping("/expApply")
public class ExpApplyController {
    @Autowired
    private CodeTypeService codeTypeService;
    @Autowired
    private ExpDetailService expDetailService;
    @Autowired
    private CodeService codeService;
    @Autowired
    private ExpApplService expApplService;
    @Autowired
    private ExpService expService;
    @Autowired
    private TypeDetailService typeDetailService;
    @Resource
    private RuntimeService runtimeService;
    @Resource
    private TaskService taskService;
    @ResponseBody
    @RequestMapping(value = "/expApplycolumn", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject expApplycolumn(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typedetailno = request.getParameter("typedetailno");
        List<CodeType> list = codeTypeService.selectByTypeno(typedetailno);
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        JSONObject re1 = new JSONObject();
        re1.put("title", "ID");
        re1.put("field", "id");
        re1.put("width", "50px");
        re1.put("hidden", true);
        jslst.add(re1);
        JSONObject re2 = new JSONObject();
        re2.put("title", "行号");
        re2.put("field", "itemno");
        re2.put("width", "100px");
        re2.put("hidden", false);
        re2.put("editor", "'text'");
        jslst.add(re2);
        JSONObject re3 = new JSONObject();
        re3.put("title", "主数据分类编码");
        re3.put("field", "typedetailno");
        re3.put("width", "100px");
        re3.put("hidden", false);
        jslst.add(re3);
        JSONObject re4 = new JSONObject();
        re4.put("title", "主数据分类名称");
        re4.put("field", "typedetailname");
        re4.put("width", "100px");
        re4.put("hidden", false);
        jslst.add(re4);
        JSONObject re5 = new JSONObject();
        re5.put("title", "主数据物料编码");
        re5.put("field", "codeno");
        re5.put("width", "100px");
        re5.put("hidden", false);
        jslst.add(re5);
        JSONObject re6 = new JSONObject();
        re6.put("title", "主数据物料名称");
        re6.put("field", "codename");
        re6.put("width", "100px");
        re6.put("hidden", false);
        jslst.add(re6);
        CodeType codeType;
        if(list.size()>0){
            for (int i=0;i<list.size();i++){
                JSONObject re10 = new JSONObject();
                codeType = (CodeType)list.get(i);

                    re10.put("title",codeType.getAttrname());
                    re10.put("field",codeType.getAttrno());
                    re10.put("width","100px");
                    re10.put("hidden",false);
                    jslst.add(re10);


            }
        }
        JSONObject re7 = new JSONObject();
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
    @RequestMapping(value = "addDetail", method = {RequestMethod.GET, RequestMethod.POST})
    public Map addDetail(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typedetailid = request.getParameter("typedetailid");
        String itemno = request.getParameter("itemno");
        String typedetailno = request.getParameter("typedetailno");
        String typedetailname = request.getParameter("typedetailname");
        String codeno = request.getParameter("codeno");
        String codename = request.getParameter("codename");
        String user = request.getParameter("user");
        ExpDetail expDetail = new ExpDetail();
        expDetail.setItemno(Integer.parseInt(itemno));
        expDetail.setCodename(codename);
        expDetail.setCodeno(codeno);
        expDetail.setTypedetailname(typedetailname);
        expDetail.setTypedetailno(typedetailno);
        expDetail.setTypedetailid(Integer.parseInt(typedetailid));
        expDetail.setInputman(user);
        expDetail.setInputdate(new Date());
        Map json = new HashMap();
        int n = expDetailService.add(expDetail);

        if(n>0){
           int id = expDetailService.selectNewId();
            json.put("id",id);
        }




        return json;
    }


    @ResponseBody
    @RequestMapping(value = "expApplycolumndata", method = {RequestMethod.GET, RequestMethod.POST})
    public Map expApplycolumndata(HttpServletRequest request) throws UnsupportedEncodingException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        int id = Integer.parseInt(request.getParameter("id"));
        int itemno = Integer.parseInt(request.getParameter("itemno"));
        String typedetailno = request.getParameter("typedetailno");
        String codeno = request.getParameter("codeno");
        String typedetailname = request.getParameter("typedetailname");
        String codename = request.getParameter("codename");
        json.put("id",id);
        json.put("itemno",itemno);
        json.put("typedetailno",typedetailno);
        json.put("typedetailname",typedetailname);
        json.put("codeno",codeno);
        json.put("codename",codename);
        List<CodeType> list = codeTypeService.selectByTypeno(typedetailno);
        Code code = codeService.selectByCodeno(codeno);
        CodeType codeType;
        Class<?> herosClass = Code.class;
        if(list.size()>0){
            for (int i=0;i<list.size();i++){
                codeType = (CodeType)list.get(i);
                String meth = codeType.getAttrno();
                meth="get"+meth.substring(0, 1).toUpperCase() + meth.substring(1);
                Method m2 = herosClass.getMethod(meth);
                m2.invoke(code);
                json.put(codeType.getAttrno(), m2.invoke(code));


            }
        }
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "selectDetail", method = {RequestMethod.GET, RequestMethod.POST})
    public com.alibaba.fastjson.JSONObject selectDetail(HttpServletRequest request) throws UnsupportedEncodingException, ParseException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        request.setCharacterEncoding("utf-8");
        String applyno = request.getParameter("applyno");

        List<ExpDetail> list = expDetailService.selectByApplyno(applyno);
        ExpDetail expDetail;
        JSONArray jslst = new JSONArray();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        com.alibaba.fastjson.JSONObject re = new com.alibaba.fastjson.JSONObject();


        if(list.size()>0) {
            for (int i=0;i<list.size();i++){
                com.alibaba.fastjson.JSONObject re1 = new com.alibaba.fastjson.JSONObject();
                expDetail = (ExpDetail)list.get(i);
                re1.put("id",expDetail.getId());
                re1.put("applyno",expDetail.getApplyno());
                re1.put("itemno",expDetail.getItemno());
                re1.put("typedetailid",expDetail.getTypedetailid());
                re1.put("typedetailno",expDetail.getTypedetailno());
                re1.put("typedetailname",expDetail.getTypedetailname());
                re1.put("codeno",expDetail.getCodeno());
                re1.put("codename",expDetail.getCodename());
                re1.put("inputman",expDetail.getInputman());
                re1.put("inputdate",sdf.format(expDetail.getInputdate()));

                List<CodeType> list1 = codeTypeService.selectByTypeno(expDetail.getTypedetailno());
                Code code = codeService.selectByCodeno(expDetail.getCodeno());
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

    @ResponseBody
    @RequestMapping(value = "selectById", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectById(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("detailId");
        ExpDetail expDetail = expDetailService.selectById(Integer.parseInt(id));
        JSONObject re1 = new JSONObject();
        re1.put("id",expDetail.getId());
        re1.put("codeno",expDetail.getCodeno());
        re1.put("codename",expDetail.getCodename());
        re1.put("islocked",expDetail.getIslocked());
        re1.put("inputman",expDetail.getInputman());
        re1.put("inputdate",expDetail.getInputdate());
        re1.put("itemno",expDetail.getItemno());
        re1.put("typedetailid",expDetail.getTypedetailid());
        re1.put("typedetailno",expDetail.getTypedetailno());
        re1.put("typedetailname",expDetail.getTypedetailname());

        re1.put("t1",expDetail.getT1());
        re1.put("t2",expDetail.getT2());
        re1.put("t3",expDetail.getT3());
        re1.put("t4",expDetail.getT4());
        re1.put("t5",expDetail.getT5());
        re1.put("t6",expDetail.getT6());
        re1.put("t7",expDetail.getT7());
        re1.put("t8",expDetail.getT8());
        re1.put("t9",expDetail.getT9());
        re1.put("t10",expDetail.getT10());
        re1.put("t11",expDetail.getT11());
        re1.put("t12",expDetail.getT12());
        re1.put("t13",expDetail.getT13());
        re1.put("t14",expDetail.getT14());
        re1.put("t15",expDetail.getT15());
        re1.put("t16",expDetail.getT16());
        re1.put("t17",expDetail.getT17());
        re1.put("t18",expDetail.getT18());
        re1.put("t19",expDetail.getT19());
        re1.put("t20",expDetail.getT20());
        re1.put("t21",expDetail.getT21());
        re1.put("t22",expDetail.getT22());
        re1.put("t23",expDetail.getT23());
        re1.put("t24",expDetail.getT24());
        re1.put("t25",expDetail.getT25());
        re1.put("t26",expDetail.getT26());
        re1.put("t27",expDetail.getT27());
        re1.put("t28",expDetail.getT28());
        re1.put("t29",expDetail.getT29());
        re1.put("t30",expDetail.getT30());
        re1.put("t31",expDetail.getT31());
        re1.put("t32",expDetail.getT32());
        re1.put("t33",expDetail.getT33());
        re1.put("t34",expDetail.getT34());
        re1.put("t35",expDetail.getT35());
        re1.put("t36",expDetail.getT36());
        re1.put("t37",expDetail.getT37());
        re1.put("t38",expDetail.getT38());
        re1.put("t39",expDetail.getT39());
        re1.put("t40",expDetail.getT40());
        re1.put("t41",expDetail.getT41());
        re1.put("t42",expDetail.getT42());
        re1.put("t43",expDetail.getT43());
        re1.put("t44",expDetail.getT44());
        re1.put("t45",expDetail.getT45());
        re1.put("t46",expDetail.getT46());
        re1.put("t47",expDetail.getT47());
        re1.put("t48",expDetail.getT48());
        re1.put("t49",expDetail.getT49());
        re1.put("t50",expDetail.getT50());
        re1.put("t51",expDetail.getT51());
        re1.put("t52",expDetail.getT52());
        re1.put("t53",expDetail.getT53());
        re1.put("t54",expDetail.getT54());
        re1.put("t55",expDetail.getT55());
        re1.put("t56",expDetail.getT56());
        re1.put("t57",expDetail.getT57());
        re1.put("t58",expDetail.getT58());
        re1.put("t59",expDetail.getT59());
        re1.put("t60",expDetail.getT60());
        re1.put("t61",expDetail.getT61());
        re1.put("t62",expDetail.getT62());
        re1.put("t63",expDetail.getT63());
        re1.put("t64",expDetail.getT64());
        re1.put("t65",expDetail.getT65());
        re1.put("t66",expDetail.getT66());
        re1.put("t67",expDetail.getT67());
        re1.put("t68",expDetail.getT68());
        re1.put("t69",expDetail.getT69());
        re1.put("t70",expDetail.getT70());
        re1.put("t71",expDetail.getT71());
        re1.put("t72",expDetail.getT72());
        re1.put("t73",expDetail.getT73());
        re1.put("t74",expDetail.getT74());
        re1.put("t75",expDetail.getT75());
        re1.put("t76",expDetail.getT76());
        re1.put("t77",expDetail.getT77());
        re1.put("t78",expDetail.getT78());
        re1.put("t79",expDetail.getT79());
        re1.put("t80",expDetail.getT80());
        re1.put("t81",expDetail.getT81());
        re1.put("t82",expDetail.getT82());
        re1.put("t83",expDetail.getT83());
        re1.put("t84",expDetail.getT84());
        re1.put("t85",expDetail.getT85());
        re1.put("t86",expDetail.getT86());
        re1.put("t87",expDetail.getT87());
        re1.put("t88",expDetail.getT88());
        re1.put("t89",expDetail.getT89());
        re1.put("t90",expDetail.getT90());
        re1.put("t91",expDetail.getT91());
        re1.put("t92",expDetail.getT92());
        re1.put("t93",expDetail.getT93());
        re1.put("t94",expDetail.getT94());
        re1.put("t95",expDetail.getT95());
        re1.put("t96",expDetail.getT96());
        re1.put("t97",expDetail.getT97());
        re1.put("t98",expDetail.getT98());
        re1.put("t99",expDetail.getT99());
        re1.put("t100",expDetail.getT100());


        return re1;
    }

    @ResponseBody
    @RequestMapping(value = "edit", method = {RequestMethod.GET, RequestMethod.POST})
    public Map edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("detailId");
        ExpDetail expDetail = expDetailService.selectById(Integer.parseInt(id));
        expDetail.setT1(request.getParameter("t1"));
        expDetail.setT2(request.getParameter("t2"));
        expDetail.setT3(request.getParameter("t3"));
        expDetail.setT4(request.getParameter("t4"));
        expDetail.setT5(request.getParameter("t5"));
        expDetail.setT6(request.getParameter("t6"));
        expDetail.setT7(request.getParameter("t7"));
        expDetail.setT8(request.getParameter("t8"));
        expDetail.setT9(request.getParameter("t9"));
        expDetail.setT10(request.getParameter("t10"));
        expDetail.setT11(request.getParameter("t11"));
        expDetail.setT12(request.getParameter("t12"));
        expDetail.setT13(request.getParameter("t13"));
        expDetail.setT14(request.getParameter("t14"));
        expDetail.setT15(request.getParameter("t15"));
        expDetail.setT16(request.getParameter("t16"));
        expDetail.setT17(request.getParameter("t17"));
        expDetail.setT18(request.getParameter("t18"));
        expDetail.setT19(request.getParameter("t19"));
        expDetail.setT20(request.getParameter("t20"));
        expDetail.setT21(request.getParameter("t21"));
        expDetail.setT22(request.getParameter("t22"));
        expDetail.setT23(request.getParameter("t23"));
        expDetail.setT24(request.getParameter("t24"));
        expDetail.setT25(request.getParameter("t25"));
        expDetail.setT26(request.getParameter("t26"));
        expDetail.setT27(request.getParameter("t27"));
        expDetail.setT28(request.getParameter("t28"));
        expDetail.setT29(request.getParameter("t29"));
        expDetail.setT30(request.getParameter("t30"));
        expDetail.setT31(request.getParameter("t31"));
        expDetail.setT32(request.getParameter("t32"));
        expDetail.setT33(request.getParameter("t33"));
        expDetail.setT34(request.getParameter("t34"));
        expDetail.setT35(request.getParameter("t35"));
        expDetail.setT36(request.getParameter("t36"));
        expDetail.setT37(request.getParameter("t37"));
        expDetail.setT38(request.getParameter("t38"));
        expDetail.setT39(request.getParameter("t39"));
        expDetail.setT40(request.getParameter("t40"));
        expDetail.setT41(request.getParameter("t41"));
        expDetail.setT42(request.getParameter("t42"));
        expDetail.setT43(request.getParameter("t43"));
        expDetail.setT44(request.getParameter("t44"));
        expDetail.setT45(request.getParameter("t45"));
        expDetail.setT46(request.getParameter("t46"));
        expDetail.setT47(request.getParameter("t47"));
        expDetail.setT48(request.getParameter("t48"));
        expDetail.setT49(request.getParameter("t49"));
        expDetail.setT50(request.getParameter("t50"));
        expDetail.setT51(request.getParameter("t51"));
        expDetail.setT52(request.getParameter("t52"));
        expDetail.setT53(request.getParameter("t53"));
        expDetail.setT54(request.getParameter("t54"));
        expDetail.setT55(request.getParameter("t55"));
        expDetail.setT56(request.getParameter("t56"));
        expDetail.setT57(request.getParameter("t57"));
        expDetail.setT58(request.getParameter("t58"));
        expDetail.setT59(request.getParameter("t59"));
        expDetail.setT60(request.getParameter("t60"));
        expDetail.setT61(request.getParameter("t61"));
        expDetail.setT62(request.getParameter("t62"));
        expDetail.setT63(request.getParameter("t63"));
        expDetail.setT64(request.getParameter("t64"));
        expDetail.setT65(request.getParameter("t65"));
        expDetail.setT66(request.getParameter("t66"));
        expDetail.setT67(request.getParameter("t67"));
        expDetail.setT68(request.getParameter("t68"));
        expDetail.setT69(request.getParameter("t69"));
        expDetail.setT70(request.getParameter("t70"));
        expDetail.setT71(request.getParameter("t71"));
        expDetail.setT72(request.getParameter("t72"));
        expDetail.setT73(request.getParameter("t73"));
        expDetail.setT74(request.getParameter("t74"));
        expDetail.setT75(request.getParameter("t75"));
        expDetail.setT76(request.getParameter("t76"));
        expDetail.setT77(request.getParameter("t77"));
        expDetail.setT78(request.getParameter("t78"));
        expDetail.setT79(request.getParameter("t79"));
        expDetail.setT80(request.getParameter("t80"));
        expDetail.setT81(request.getParameter("t81"));
        expDetail.setT82(request.getParameter("t82"));
        expDetail.setT83(request.getParameter("t83"));
        expDetail.setT84(request.getParameter("t84"));
        expDetail.setT85(request.getParameter("t85"));
        expDetail.setT86(request.getParameter("t86"));
        expDetail.setT87(request.getParameter("t87"));
        expDetail.setT88(request.getParameter("t88"));
        expDetail.setT89(request.getParameter("t89"));
        expDetail.setT90(request.getParameter("t90"));
        expDetail.setT91(request.getParameter("t91"));
        expDetail.setT92(request.getParameter("t92"));
        expDetail.setT93(request.getParameter("t93"));
        expDetail.setT94(request.getParameter("t94"));
        expDetail.setT95(request.getParameter("t95"));
        expDetail.setT96(request.getParameter("t96"));
        expDetail.setT97(request.getParameter("t97"));
        expDetail.setT98(request.getParameter("t98"));
        expDetail.setT99(request.getParameter("t99"));
        expDetail.setT100(request.getParameter("t100"));
        int n = expDetailService.edit(expDetail);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "Apply", method = {RequestMethod.GET, RequestMethod.POST})
    public String Apply(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String entities = request.getParameter("entities");
        ExpAppl expAppl =new ExpAppl();
        String user = request.getParameter("user");
        Date date = new Date();
        String applyreasons = request.getParameter("applyreasons");
        expAppl.setInputdate(date);
        expAppl.setInputman(user);
        expAppl.setApplyreasons(applyreasons);
        expAppl.setApplystate("开始审核");
        expAppl.setApplytype("创建并发送");
        String typedetailid = request.getParameter("typedetailid");
        String typedetailname = request.getParameter("typedetailname");
        String typedetailno = request.getParameter("typedetailno");
        expAppl.setTypedetailname(typedetailname);
        expAppl.setTypedetailno(typedetailno);
        expAppl.setTypedetailid(Integer.parseInt(typedetailid));
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");

        String applyno = expApplService.selectTodayMaxApplyno();
        expAppl.setApplyno(applyno);
        expApplService.add(expAppl);
        int n = expApplService.selectNewId();
        String[] ids = entities.split("、");
        ExpDetail expDetail =new ExpDetail();
        int m = 0;
        List<ExpDetail> list = new ArrayList<ExpDetail>();
        for(String id:ids){
            expDetail = expDetailService.selectById(Integer.parseInt(id));
            expDetail.setExpapplid(n);
            expDetail.setApplyno(applyno);
            int i = expDetailService.edit(expDetail);


            m+=i;
            list.add(expDetail);
        }

//        Map json = new HashMap();
//        json.put("num",m);

        Map<String,Object> variables=new HashMap<String,Object>();
        variables.put("applyno", applyno);
        // 启动流程
        ProcessInstance pi= runtimeService.startProcessInstanceByKey("vacationRequest3",variables);
        // 根据流程实例Id查询任务
        Task task=taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
        // 完成 学生填写请假单任务
//        taskService.complete(task.getId());
//        ExpAppl expAppl1=expApplService.findByApplyno(applyno);
//        //修改状态
//        expAppl1.setApplystate("待提交");
        expAppl.setProcessInstanceId(pi.getProcessInstanceId());
//        // 修改请假单状态
        expApplService.update(expAppl);
        JSONObject result=new JSONObject();
        result.put("success", true);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        result.put("inputdate",sdf.format(expAppl.getInputdate()));
        result.put("applyno", applyno);
        result.put("applytype", expAppl.getApplytype());
        result.put("inputman", expAppl.getInputman());
        ResponseUtil.write(response, result);
//        Save(list);
        return null;

    }


    @ResponseBody
    @RequestMapping(value = "ApplyAndPass", method = {RequestMethod.GET, RequestMethod.POST})
    public String ApplyAndPass(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String entities = request.getParameter("entities");
        ExpAppl expAppl =new ExpAppl();
        String user = request.getParameter("user");
        Date date = new Date();
        String applyreasons = request.getParameter("applyreasons");
        expAppl.setInputdate(date);
        expAppl.setInputman(user);
        expAppl.setApplyreasons(applyreasons);
        expAppl.setApplystate("开始审核");
        expAppl.setApplytype("创建并发送");
        String typedetailid = request.getParameter("typedetailid");
        String typedetailname = request.getParameter("typedetailname");
        String typedetailno = request.getParameter("typedetailno");
        expAppl.setTypedetailname(typedetailname);
        expAppl.setTypedetailno(typedetailno);
        expAppl.setTypedetailid(Integer.parseInt(typedetailid));
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");

        String applyno = expApplService.selectTodayMaxApplyno();
        expAppl.setApplyno(applyno);
       expApplService.add(expAppl);
       int n = expApplService.selectNewId();
        String[] ids = entities.split("、");
        ExpDetail expDetail =new ExpDetail();
        int m = 0;
        List<ExpDetail> list = new ArrayList<ExpDetail>();
        for(String id:ids){
            expDetail = expDetailService.selectById(Integer.parseInt(id));
            expDetail.setExpapplid(n);
            expDetail.setApplyno(applyno);
            int i = expDetailService.edit(expDetail);


            m+=i;
            list.add(expDetail);
        }

//        Map json = new HashMap();
//        json.put("num",m);

        Map<String,Object> variables=new HashMap<String,Object>();
        variables.put("applyno", applyno);
        // 启动流程
        ProcessInstance pi= runtimeService.startProcessInstanceByKey("vacationRequest3",variables);
        // 根据流程实例Id查询任务
        Task task=taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
        // 完成 学生填写请假单任务
        taskService.complete(task.getId());
        ExpAppl expAppl1=expApplService.findByApplyno(applyno);
        //修改状态
        expAppl1.setApplystate("待提交");
        expAppl1.setProcessInstanceId(pi.getProcessInstanceId());
        // 修改请假单状态
        expApplService.update(expAppl1);
        JSONObject result=new JSONObject();
        result.put("success", true);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        result.put("inputdate",sdf.format(expAppl1.getInputdate()));
        result.put("applyno", applyno);
        result.put("applytype", expAppl1.getApplytype());
        result.put("inputman", expAppl1.getInputman());
        ResponseUtil.write(response, result);
//        Save(list);
        return null;

    }



    public Map Save(List<ExpDetail> list){
        Map json = new HashMap();
        Date date = new Date();
        int n = 0;
        Exp exp = new Exp();
        for(ExpDetail expDetail:list){
            exp.setCodename(expDetail.getCodename());
            exp.setCodeno(expDetail.getCodeno());
            exp.setInputdate(new Date());
            exp.setInputman(expDetail.getInputman());
            exp.setIslocked(false);
            exp.setT1(expDetail.getT1());
            exp.setT2(expDetail.getT2());
            exp.setT3(expDetail.getT3());
            exp.setT4(expDetail.getT4());
            exp.setT5(expDetail.getT5());
            exp.setT6(expDetail.getT6());
            exp.setT7(expDetail.getT7());
            exp.setT8(expDetail.getT8());
            exp.setT9(expDetail.getT9());
            exp.setT10(expDetail.getT10());
            exp.setT11(expDetail.getT11());
            exp.setT12(expDetail.getT12());
            exp.setT13(expDetail.getT13());
            exp.setT14(expDetail.getT14());
            exp.setT15(expDetail.getT15());
            exp.setT16(expDetail.getT16());
            exp.setT17(expDetail.getT17());
            exp.setT18(expDetail.getT18());
            exp.setT19(expDetail.getT19());
            exp.setT20(expDetail.getT20());
            exp.setT21(expDetail.getT21());
            exp.setT22(expDetail.getT22());
            exp.setT23(expDetail.getT23());
            exp.setT24(expDetail.getT24());
            exp.setT25(expDetail.getT25());
            exp.setT26(expDetail.getT26());
            exp.setT27(expDetail.getT27());
            exp.setT28(expDetail.getT28());
            exp.setT29(expDetail.getT29());
            exp.setT30(expDetail.getT30());
            exp.setT31(expDetail.getT31());
            exp.setT32(expDetail.getT32());
            exp.setT33(expDetail.getT33());
            exp.setT34(expDetail.getT34());
            exp.setT35(expDetail.getT35());
            exp.setT36(expDetail.getT36());
            exp.setT37(expDetail.getT37());
            exp.setT38(expDetail.getT38());
            exp.setT39(expDetail.getT39());
            exp.setT40(expDetail.getT40());
            exp.setT41(expDetail.getT41());
            exp.setT42(expDetail.getT42());
            exp.setT43(expDetail.getT43());
            exp.setT44(expDetail.getT44());
            exp.setT45(expDetail.getT45());
            exp.setT46(expDetail.getT46());
            exp.setT47(expDetail.getT47());
            exp.setT48(expDetail.getT48());
            exp.setT49(expDetail.getT49());
            exp.setT50(expDetail.getT50());
            exp.setT51(expDetail.getT51());
            exp.setT52(expDetail.getT52());
            exp.setT53(expDetail.getT53());
            exp.setT54(expDetail.getT54());
            exp.setT55(expDetail.getT55());
            exp.setT56(expDetail.getT56());
            exp.setT57(expDetail.getT57());
            exp.setT58(expDetail.getT58());
            exp.setT59(expDetail.getT59());
            exp.setT60(expDetail.getT60());
            exp.setT61(expDetail.getT61());
            exp.setT62(expDetail.getT62());
            exp.setT63(expDetail.getT63());
            exp.setT64(expDetail.getT64());
            exp.setT65(expDetail.getT65());
            exp.setT66(expDetail.getT66());
            exp.setT67(expDetail.getT67());
            exp.setT68(expDetail.getT68());
            exp.setT69(expDetail.getT69());
            exp.setT70(expDetail.getT70());
            exp.setT71(expDetail.getT71());
            exp.setT72(expDetail.getT72());
            exp.setT73(expDetail.getT73());
            exp.setT74(expDetail.getT74());
            exp.setT75(expDetail.getT75());
            exp.setT76(expDetail.getT76());
            exp.setT77(expDetail.getT77());
            exp.setT78(expDetail.getT78());
            exp.setT79(expDetail.getT79());
            exp.setT80(expDetail.getT80());
            exp.setT81(expDetail.getT81());
            exp.setT82(expDetail.getT82());
            exp.setT83(expDetail.getT83());
            exp.setT84(expDetail.getT84());
            exp.setT85(expDetail.getT85());
            exp.setT86(expDetail.getT86());
            exp.setT87(expDetail.getT87());
            exp.setT88(expDetail.getT88());
            exp.setT89(expDetail.getT89());
            exp.setT90(expDetail.getT90());
            exp.setT91(expDetail.getT91());
            exp.setT92(expDetail.getT92());
            exp.setT93(expDetail.getT93());
            exp.setT94(expDetail.getT94());
            exp.setT95(expDetail.getT95());
            exp.setT96(expDetail.getT96());
            exp.setT97(expDetail.getT97());
            exp.setT98(expDetail.getT98());
            exp.setT99(expDetail.getT99());
            exp.setT100(expDetail.getT100());
            int m = expService.insert(exp);
            n+=m;
        }
        json.put("num",n);
        return json;
    }

    /**
     * 查询流程信息
     * @param response
     * @param taskId  流程实例ID
     * @return
     * @throws Exception
     */
    @RequestMapping("/getExpApplByTaskId")
    public Map getExpApplByTaskId(HttpServletResponse response,String taskId) throws Exception{
        //先根据流程ID查询
        Task task=taskService.createTaskQuery().taskId(taskId).singleResult();
        ExpAppl expAppl=expApplService.getExpApplByTaskId(task.getProcessInstanceId());
        JSONObject result=new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        result.put("id", expAppl.getId());
        result.put("typedetailid", expAppl.getTypedetailid());
        result.put("applytype", expAppl.getApplytype());
        result.put("applyreasons", expAppl.getApplytype());
        result.put("applystate", expAppl.getApplystate());
        result.put("inputman", expAppl.getInputman());
        result.put("inputdate", sdf.format(expAppl.getInputdate()));
        result.put("applyno", expAppl.getApplyno());
        result.put("processInstanceId", expAppl.getProcessInstanceId());
        ResponseUtil.write(response, result);
        return null;
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
        if(currentGroup.getName().contains("admin")){
            if(state==1){
                String applyno=(String) taskService.getVariable(taskId, "applyno");
                ExpAppl expAppl=expApplService.findByApplyno(applyno);
                expAppl.setApplystate("审核通过");
                // 更新审核信息
                expApplService.update(expAppl);
                variables.put("msg", "通过");
                String taskname = task.getName();
                if(taskname.equals("审核")){

                    List<ExpDetail> list = expDetailService.selectByApplyno(applyno);
                    Save(list);
                }
            }else{
                String applyno=(String) taskService.getVariable(taskId, "applyno");
                ExpAppl expAppl=expApplService.findByApplyno(applyno);
                expAppl.setApplystate("审核未通过");
                // 更新审核信息
                expApplService.update(expAppl);
                variables.put("msg", "未通过");
            }
        }
        if(state==1){
            String expAppl=(String) taskService.getVariable(taskId, "expAppl");
            variables.put("msg", "通过");
        }else{
            String applyno=(String) taskService.getVariable(taskId, "applyno");
            ExpAppl expAppl=expApplService.findByApplyno(applyno);
            expAppl.setApplystate("审核未通过");
            // 更新审核信息
            expApplService.update(expAppl);
            variables.put("msg", "未通过");
        }

        // 设置流程变量
//        variables.put("dasy", leaveDays);
        // 获取流程实例id
        String processInstanceId=task.getProcessInstanceId();
        // 设置用户id
        List list = taskService.getIdentityLinksForTask(taskId);
        IdentityLink li = (IdentityLink)list.get(0);
        Authentication.setAuthenticatedUserId(currentUser.getFirstName()+currentUser.getLastName()+"["+li.getGroupId()+"]");
        // 添加批注信息
        taskService.addComment(taskId, processInstanceId, comment);
        // 完成任务
        taskService.complete(taskId, variables);
        JSONObject result=new JSONObject();
        result.put("success", true);
        ResponseUtil.write(response, result);
        return null;
    }


    @ResponseBody
    @RequestMapping(value = "Query", method = {RequestMethod.GET, RequestMethod.POST})
    public com.alibaba.fastjson.JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException, ParseException {
        request.setCharacterEncoding("utf-8");
        String applyno = request.getParameter("applyno");
        String applystate = request.getParameter("applystate");
        String inputman = request.getParameter("inputman");
        String inputdate =request.getParameter("inputdate");
        ExpAppl expAppl =new ExpAppl();
        expAppl.setApplyno(applyno);
        expAppl.setApplystate(applystate);
        expAppl.setInputman(inputman);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if(!inputdate.equals("")){
            Date date = sdf.parse(inputdate);
            expAppl.setInputdate(date);
        }

        com.alibaba.fastjson.JSONObject re = new com.alibaba.fastjson.JSONObject();
        JSONArray jslst = new JSONArray();
        List<ExpAppl> list = expApplService.select(expAppl);
        ExpAppl expAppl1;
        if(list.size()>0) {
            for (int i=0;i<list.size();i++){
                com.alibaba.fastjson.JSONObject re1 = new com.alibaba.fastjson.JSONObject();
                expAppl1 = (ExpAppl)list.get(i);
                re1.put("id",expAppl1.getId());
                re1.put("applyno",expAppl1.getApplyno());
                re1.put("applystate",expAppl1.getApplystate());
                re1.put("inputman",expAppl1.getInputman());
                re1.put("inputdate",expAppl1.getInputdate()==null?"":sdf.format(expAppl1.getInputdate()));
                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }


    @ResponseBody
    @RequestMapping(value = "selectByApplyno", method = {RequestMethod.GET, RequestMethod.POST})
    public com.alibaba.fastjson.JSONObject selectByApplyno(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String applyno = request.getParameter("applyno");
        ExpAppl expAppl = expApplService.findByApplyno(applyno);
        com.alibaba.fastjson.JSONObject re1 = new com.alibaba.fastjson.JSONObject();
        re1.put("id",expAppl.getId());
        re1.put("applyno",expAppl.getApplyno());
        re1.put("applystate",expAppl.getApplystate());
        re1.put("inputman",expAppl.getInputman());
        re1.put("inputdate",expAppl.getInputdate());
        re1.put("applytype",expAppl.getApplytype());
        re1.put("typedetailid",expAppl.getTypedetailid());
        re1.put("applyreasons",expAppl.getApplyreasons());
        int typedetailid = expAppl.getTypedetailid();
        TypeDetail typeDetail = typeDetailService.selectById(typedetailid);
        re1.put("typedetailno",typeDetail.getTypeno());
        re1.put("typedetailname",typeDetail.getTypename());

        return re1;
    }

}
