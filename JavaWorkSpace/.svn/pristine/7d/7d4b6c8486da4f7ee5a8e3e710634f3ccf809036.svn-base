package com.dhchain.business.rout.controller;

import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.activiti.util.ResponseUtil;
import com.dhchain.business.code.service.CodeService;
import com.dhchain.business.code.service.CodeTypeService;
import com.dhchain.business.code.vo.Code;
import com.dhchain.business.code.vo.CodeType;
import com.dhchain.business.rout.service.RoutApplService;
import com.dhchain.business.rout.service.RoutDetailService;
import com.dhchain.business.rout.service.RoutService;
import com.dhchain.business.rout.vo.Rout;
import com.dhchain.business.rout.vo.RoutAppl;
import com.dhchain.business.rout.vo.RoutDetail;
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
 * Created by zhenglb on 2017-10-30.
 */
@Controller
@RequestMapping("/routApply")
public class RoutApplyController {
    @Autowired
    private RoutService routService;
    @Autowired
    private RoutApplService routApplService;
    @Autowired
    private RoutDetailService routDetailService;
    @Autowired
    private CodeTypeService codeTypeService;
    @Autowired
    private CodeService codeService;
    @Autowired
    private TypeDetailService typeDetailService;
    @Resource
    private RuntimeService runtimeService;
    @Resource
    private TaskService taskService;
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
        RoutDetail routDetail = new RoutDetail();
        routDetail.setItemno(Integer.parseInt(itemno));
        routDetail.setCodename(codename);
        routDetail.setCodeno(codeno);
        routDetail.setTypedetailname(typedetailname);
        routDetail.setTypedetailno(typedetailno);
        routDetail.setTypedetailid(Integer.parseInt(typedetailid));
        routDetail.setInputman(user);
        routDetail.setInputdate(new Date());
        Map json = new HashMap();
        int n = routDetailService.add(routDetail);

        if(n>0){
            int id = routDetailService.selectNewId();
            json.put("id",id);
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "routApplycolumndata", method = {RequestMethod.GET, RequestMethod.POST})
    public Map routApplycolumndata(HttpServletRequest request) throws UnsupportedEncodingException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {
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
    @RequestMapping(value = "selectById", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectById(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("detailId");
        RoutDetail routDetail = routDetailService.selectById(Integer.parseInt(id));
        JSONObject re1 = new JSONObject();
        re1.put("id",routDetail.getId());
        re1.put("codeno",routDetail.getCodeno());
        re1.put("codename",routDetail.getCodename());
        re1.put("islocked",routDetail.getIslocked());
        re1.put("inputman",routDetail.getInputman());
        re1.put("inputdate",routDetail.getInputdate());
        re1.put("itemno",routDetail.getItemno());
        re1.put("typedetailid",routDetail.getTypedetailid());
        re1.put("typedetailno",routDetail.getTypedetailno());
        re1.put("typedetailname",routDetail.getTypedetailname());

        re1.put("t1",routDetail.getT1());
        re1.put("t2",routDetail.getT2());
        re1.put("t3",routDetail.getT3());
        re1.put("t4",routDetail.getT4());
        re1.put("t5",routDetail.getT5());
        re1.put("t6",routDetail.getT6());
        re1.put("t7",routDetail.getT7());
        re1.put("t8",routDetail.getT8());
        re1.put("t9",routDetail.getT9());
        re1.put("t10",routDetail.getT10());
        re1.put("t11",routDetail.getT11());
        re1.put("t12",routDetail.getT12());
        re1.put("t13",routDetail.getT13());
        re1.put("t14",routDetail.getT14());
        re1.put("t15",routDetail.getT15());
        re1.put("t16",routDetail.getT16());
        re1.put("t17",routDetail.getT17());
        re1.put("t18",routDetail.getT18());
        re1.put("t19",routDetail.getT19());
        re1.put("t20",routDetail.getT20());
        re1.put("t21",routDetail.getT21());
        re1.put("t22",routDetail.getT22());
        re1.put("t23",routDetail.getT23());
        re1.put("t24",routDetail.getT24());
        re1.put("t25",routDetail.getT25());
        re1.put("t26",routDetail.getT26());
        re1.put("t27",routDetail.getT27());
        re1.put("t28",routDetail.getT28());
        re1.put("t29",routDetail.getT29());
        re1.put("t30",routDetail.getT30());
        re1.put("t31",routDetail.getT31());
        re1.put("t32",routDetail.getT32());
        re1.put("t33",routDetail.getT33());
        re1.put("t34",routDetail.getT34());
        re1.put("t35",routDetail.getT35());
        re1.put("t36",routDetail.getT36());
        re1.put("t37",routDetail.getT37());
        re1.put("t38",routDetail.getT38());
        re1.put("t39",routDetail.getT39());
        re1.put("t40",routDetail.getT40());
        re1.put("t41",routDetail.getT41());
        re1.put("t42",routDetail.getT42());
        re1.put("t43",routDetail.getT43());
        re1.put("t44",routDetail.getT44());
        re1.put("t45",routDetail.getT45());
        re1.put("t46",routDetail.getT46());
        re1.put("t47",routDetail.getT47());
        re1.put("t48",routDetail.getT48());
        re1.put("t49",routDetail.getT49());
        re1.put("t50",routDetail.getT50());
        re1.put("t51",routDetail.getT51());
        re1.put("t52",routDetail.getT52());
        re1.put("t53",routDetail.getT53());
        re1.put("t54",routDetail.getT54());
        re1.put("t55",routDetail.getT55());
        re1.put("t56",routDetail.getT56());
        re1.put("t57",routDetail.getT57());
        re1.put("t58",routDetail.getT58());
        re1.put("t59",routDetail.getT59());
        re1.put("t60",routDetail.getT60());
        re1.put("t61",routDetail.getT61());
        re1.put("t62",routDetail.getT62());
        re1.put("t63",routDetail.getT63());
        re1.put("t64",routDetail.getT64());
        re1.put("t65",routDetail.getT65());
        re1.put("t66",routDetail.getT66());
        re1.put("t67",routDetail.getT67());
        re1.put("t68",routDetail.getT68());
        re1.put("t69",routDetail.getT69());
        re1.put("t70",routDetail.getT70());
        re1.put("t71",routDetail.getT71());
        re1.put("t72",routDetail.getT72());
        re1.put("t73",routDetail.getT73());
        re1.put("t74",routDetail.getT74());
        re1.put("t75",routDetail.getT75());
        re1.put("t76",routDetail.getT76());
        re1.put("t77",routDetail.getT77());
        re1.put("t78",routDetail.getT78());
        re1.put("t79",routDetail.getT79());
        re1.put("t80",routDetail.getT80());
        re1.put("t81",routDetail.getT81());
        re1.put("t82",routDetail.getT82());
        re1.put("t83",routDetail.getT83());
        re1.put("t84",routDetail.getT84());
        re1.put("t85",routDetail.getT85());
        re1.put("t86",routDetail.getT86());
        re1.put("t87",routDetail.getT87());
        re1.put("t88",routDetail.getT88());
        re1.put("t89",routDetail.getT89());
        re1.put("t90",routDetail.getT90());
        re1.put("t91",routDetail.getT91());
        re1.put("t92",routDetail.getT92());
        re1.put("t93",routDetail.getT93());
        re1.put("t94",routDetail.getT94());
        re1.put("t95",routDetail.getT95());
        re1.put("t96",routDetail.getT96());
        re1.put("t97",routDetail.getT97());
        re1.put("t98",routDetail.getT98());
        re1.put("t99",routDetail.getT99());
        re1.put("t100",routDetail.getT100());


        return re1;
    }
    @ResponseBody
    @RequestMapping(value = "edit", method = {RequestMethod.GET, RequestMethod.POST})
    public Map edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("detailId");
        RoutDetail routDetail = routDetailService.selectById(Integer.parseInt(id));
        routDetail.setT1(request.getParameter("t1"));
        routDetail.setT2(request.getParameter("t2"));
        routDetail.setT3(request.getParameter("t3"));
        routDetail.setT4(request.getParameter("t4"));
        routDetail.setT5(request.getParameter("t5"));
        routDetail.setT6(request.getParameter("t6"));
        routDetail.setT7(request.getParameter("t7"));
        routDetail.setT8(request.getParameter("t8"));
        routDetail.setT9(request.getParameter("t9"));
        routDetail.setT10(request.getParameter("t10"));
        routDetail.setT11(request.getParameter("t11"));
        routDetail.setT12(request.getParameter("t12"));
        routDetail.setT13(request.getParameter("t13"));
        routDetail.setT14(request.getParameter("t14"));
        routDetail.setT15(request.getParameter("t15"));
        routDetail.setT16(request.getParameter("t16"));
        routDetail.setT17(request.getParameter("t17"));
        routDetail.setT18(request.getParameter("t18"));
        routDetail.setT19(request.getParameter("t19"));
        routDetail.setT20(request.getParameter("t20"));
        routDetail.setT21(request.getParameter("t21"));
        routDetail.setT22(request.getParameter("t22"));
        routDetail.setT23(request.getParameter("t23"));
        routDetail.setT24(request.getParameter("t24"));
        routDetail.setT25(request.getParameter("t25"));
        routDetail.setT26(request.getParameter("t26"));
        routDetail.setT27(request.getParameter("t27"));
        routDetail.setT28(request.getParameter("t28"));
        routDetail.setT29(request.getParameter("t29"));
        routDetail.setT30(request.getParameter("t30"));
        routDetail.setT31(request.getParameter("t31"));
        routDetail.setT32(request.getParameter("t32"));
        routDetail.setT33(request.getParameter("t33"));
        routDetail.setT34(request.getParameter("t34"));
        routDetail.setT35(request.getParameter("t35"));
        routDetail.setT36(request.getParameter("t36"));
        routDetail.setT37(request.getParameter("t37"));
        routDetail.setT38(request.getParameter("t38"));
        routDetail.setT39(request.getParameter("t39"));
        routDetail.setT40(request.getParameter("t40"));
        routDetail.setT41(request.getParameter("t41"));
        routDetail.setT42(request.getParameter("t42"));
        routDetail.setT43(request.getParameter("t43"));
        routDetail.setT44(request.getParameter("t44"));
        routDetail.setT45(request.getParameter("t45"));
        routDetail.setT46(request.getParameter("t46"));
        routDetail.setT47(request.getParameter("t47"));
        routDetail.setT48(request.getParameter("t48"));
        routDetail.setT49(request.getParameter("t49"));
        routDetail.setT50(request.getParameter("t50"));
        routDetail.setT51(request.getParameter("t51"));
        routDetail.setT52(request.getParameter("t52"));
        routDetail.setT53(request.getParameter("t53"));
        routDetail.setT54(request.getParameter("t54"));
        routDetail.setT55(request.getParameter("t55"));
        routDetail.setT56(request.getParameter("t56"));
        routDetail.setT57(request.getParameter("t57"));
        routDetail.setT58(request.getParameter("t58"));
        routDetail.setT59(request.getParameter("t59"));
        routDetail.setT60(request.getParameter("t60"));
        routDetail.setT61(request.getParameter("t61"));
        routDetail.setT62(request.getParameter("t62"));
        routDetail.setT63(request.getParameter("t63"));
        routDetail.setT64(request.getParameter("t64"));
        routDetail.setT65(request.getParameter("t65"));
        routDetail.setT66(request.getParameter("t66"));
        routDetail.setT67(request.getParameter("t67"));
        routDetail.setT68(request.getParameter("t68"));
        routDetail.setT69(request.getParameter("t69"));
        routDetail.setT70(request.getParameter("t70"));
        routDetail.setT71(request.getParameter("t71"));
        routDetail.setT72(request.getParameter("t72"));
        routDetail.setT73(request.getParameter("t73"));
        routDetail.setT74(request.getParameter("t74"));
        routDetail.setT75(request.getParameter("t75"));
        routDetail.setT76(request.getParameter("t76"));
        routDetail.setT77(request.getParameter("t77"));
        routDetail.setT78(request.getParameter("t78"));
        routDetail.setT79(request.getParameter("t79"));
        routDetail.setT80(request.getParameter("t80"));
        routDetail.setT81(request.getParameter("t81"));
        routDetail.setT82(request.getParameter("t82"));
        routDetail.setT83(request.getParameter("t83"));
        routDetail.setT84(request.getParameter("t84"));
        routDetail.setT85(request.getParameter("t85"));
        routDetail.setT86(request.getParameter("t86"));
        routDetail.setT87(request.getParameter("t87"));
        routDetail.setT88(request.getParameter("t88"));
        routDetail.setT89(request.getParameter("t89"));
        routDetail.setT90(request.getParameter("t90"));
        routDetail.setT91(request.getParameter("t91"));
        routDetail.setT92(request.getParameter("t92"));
        routDetail.setT93(request.getParameter("t93"));
        routDetail.setT94(request.getParameter("t94"));
        routDetail.setT95(request.getParameter("t95"));
        routDetail.setT96(request.getParameter("t96"));
        routDetail.setT97(request.getParameter("t97"));
        routDetail.setT98(request.getParameter("t98"));
        routDetail.setT99(request.getParameter("t99"));
        routDetail.setT100(request.getParameter("t100"));
        int n = routDetailService.edit(routDetail);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }


    @ResponseBody
    @RequestMapping(value = "Apply", method = {RequestMethod.GET, RequestMethod.POST})
    public String Apply(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String entities = request.getParameter("entities");
        RoutAppl routAppl =new RoutAppl();
        String user = request.getParameter("user");
        Date date = new Date();
        String applyreasons = request.getParameter("applyreasons");
        routAppl.setInputdate(date);
        routAppl.setInputman(user);
        routAppl.setApplyreasons(applyreasons);
        routAppl.setApplystate("开始审核");
        routAppl.setApplytype("创建并发送");
        String typedetailid = request.getParameter("typedetailid");
        String typedetailname = request.getParameter("typedetailname");
        String typedetailno = request.getParameter("typedetailno");
        routAppl.setTypedetailname(typedetailname);
        routAppl.setTypedetailno(typedetailno);
        routAppl.setTypedetailid(Integer.parseInt(typedetailid));
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");

        String applyno = routApplService.selectTodayMaxApplyno();
        routAppl.setApplyno(applyno);
        routApplService.add(routAppl);
        int n = routApplService.selectNewId();
        String[] ids = entities.split("、");
        RoutDetail routDetail =new RoutDetail();
        int m = 0;
        List<RoutDetail> list = new ArrayList<RoutDetail>();
        for(String id:ids){
            routDetail = routDetailService.selectById(Integer.parseInt(id));
            routDetail.setRoutapplid(n);
            routDetail.setApplyno(applyno);
            int i = routDetailService.edit(routDetail);


            m+=i;
            list.add(routDetail);
        }

//        Map json = new HashMap();
//        json.put("num",m);

        Map<String,Object> variables=new HashMap<String,Object>();
        variables.put("applyno", applyno);
        // 启动流程
        ProcessInstance pi= runtimeService.startProcessInstanceByKey("vacationRequest5",variables);
        // 根据流程实例Id查询任务
        Task task=taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
        // 完成 学生填写请假单任务
//        taskService.complete(task.getId());
//        ExpAppl expAppl1=expApplService.findByApplyno(applyno);
//        //修改状态
//        expAppl1.setApplystate("待提交");
        routAppl.setProcessInstanceId(pi.getProcessInstanceId());
//        // 修改请假单状态
        routApplService.update(routAppl);
        JSONObject result=new JSONObject();
        result.put("success", true);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        result.put("inputdate",sdf.format(routAppl.getInputdate()));
        result.put("applyno", applyno);
        result.put("applytype", routAppl.getApplytype());
        result.put("inputman", routAppl.getInputman());
        ResponseUtil.write(response, result);
//        Save(list);
        return null;

    }

    @ResponseBody
    @RequestMapping(value = "ApplyAndPass", method = {RequestMethod.GET, RequestMethod.POST})
    public String ApplyAndPass(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String entities = request.getParameter("entities");
        RoutAppl routAppl =new RoutAppl();
        String user = request.getParameter("user");
        Date date = new Date();
        String applyreasons = request.getParameter("applyreasons");
        routAppl.setInputdate(date);
        routAppl.setInputman(user);
        routAppl.setApplyreasons(applyreasons);
        routAppl.setApplystate("开始审核");
        routAppl.setApplytype("创建并发送");
        String typedetailid = request.getParameter("typedetailid");
        String typedetailname = request.getParameter("typedetailname");
        String typedetailno = request.getParameter("typedetailno");
        routAppl.setTypedetailname(typedetailname);
        routAppl.setTypedetailno(typedetailno);
        routAppl.setTypedetailid(Integer.parseInt(typedetailid));
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");

        String applyno = routApplService.selectTodayMaxApplyno();
        routAppl.setApplyno(applyno);
        routApplService.add(routAppl);
        int n = routApplService.selectNewId();
        String[] ids = entities.split("、");
        RoutDetail routDetail =new RoutDetail();
        int m = 0;
        List<RoutDetail> list = new ArrayList<RoutDetail>();
        for(String id:ids){
            routDetail = routDetailService.selectById(Integer.parseInt(id));
            routDetail.setRoutapplid(n);
            routDetail.setApplyno(applyno);
            int i = routDetailService.edit(routDetail);


            m+=i;
            list.add(routDetail);
        }

//        Map json = new HashMap();
//        json.put("num",m);

        Map<String,Object> variables=new HashMap<String,Object>();
        variables.put("applyno", applyno);
        // 启动流程
        ProcessInstance pi= runtimeService.startProcessInstanceByKey("vacationRequest5",variables);
        // 根据流程实例Id查询任务
        Task task=taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
        // 完成 学生填写请假单任务
        taskService.complete(task.getId());
        RoutAppl routAppl1=routApplService.findByApplyno(applyno);
        //修改状态
        routAppl1.setApplystate("待提交");
        routAppl1.setProcessInstanceId(pi.getProcessInstanceId());
        // 修改请假单状态
        routApplService.update(routAppl1);
        JSONObject result=new JSONObject();
        result.put("success", true);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        result.put("inputdate",sdf.format(routAppl1.getInputdate()));
        result.put("applyno", applyno);
        result.put("applytype", routAppl1.getApplytype());
        result.put("inputman", routAppl1.getInputman());
        ResponseUtil.write(response, result);
//        Save(list);
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
                RoutAppl routAppl=routApplService.findByApplyno(applyno);
                routAppl.setApplystate("审核通过");
                // 更新审核信息
                routApplService.update(routAppl);
                variables.put("msg", "通过");
                String taskname = task.getName();
                if(taskname.equals("工艺路线审核")){

                    List<RoutDetail> list = routDetailService.selectByApplyno(applyno);
                    Save(list);
                }
            }else{
                String applyno=(String) taskService.getVariable(taskId, "applyno");
                RoutAppl routAppl=routApplService.findByApplyno(applyno);
                routAppl.setApplystate("审核未通过");
                // 更新审核信息
                routApplService.update(routAppl);
                variables.put("msg", "未通过");
            }
        }
        if(state==1){
            String expAppl=(String) taskService.getVariable(taskId, "expAppl");
            variables.put("msg", "通过");
        }else{
            String applyno=(String) taskService.getVariable(taskId, "applyno");
            RoutAppl expAppl=routApplService.findByApplyno(applyno);
            expAppl.setApplystate("审核未通过");
            // 更新审核信息
            routApplService.update(expAppl);
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




    public Map Save(List<RoutDetail> list){
        Map json = new HashMap();
        Date date = new Date();
        int n = 0;
        Rout rout = new Rout();
        for(RoutDetail routDetail:list){
            rout.setCodename(routDetail.getCodename());
            rout.setCodeno(routDetail.getCodeno());
            rout.setInputdate(new Date());
            rout.setInputman(routDetail.getInputman());
            rout.setIslocked(false);
            rout.setT1(routDetail.getT1());
            rout.setT2(routDetail.getT2());
            rout.setT3(routDetail.getT3());
            rout.setT4(routDetail.getT4());
            rout.setT5(routDetail.getT5());
            rout.setT6(routDetail.getT6());
            rout.setT7(routDetail.getT7());
            rout.setT8(routDetail.getT8());
            rout.setT9(routDetail.getT9());
            rout.setT10(routDetail.getT10());
            rout.setT11(routDetail.getT11());
            rout.setT12(routDetail.getT12());
            rout.setT13(routDetail.getT13());
            rout.setT14(routDetail.getT14());
            rout.setT15(routDetail.getT15());
            rout.setT16(routDetail.getT16());
            rout.setT17(routDetail.getT17());
            rout.setT18(routDetail.getT18());
            rout.setT19(routDetail.getT19());
            rout.setT20(routDetail.getT20());
            rout.setT21(routDetail.getT21());
            rout.setT22(routDetail.getT22());
            rout.setT23(routDetail.getT23());
            rout.setT24(routDetail.getT24());
            rout.setT25(routDetail.getT25());
            rout.setT26(routDetail.getT26());
            rout.setT27(routDetail.getT27());
            rout.setT28(routDetail.getT28());
            rout.setT29(routDetail.getT29());
            rout.setT30(routDetail.getT30());
            rout.setT31(routDetail.getT31());
            rout.setT32(routDetail.getT32());
            rout.setT33(routDetail.getT33());
            rout.setT34(routDetail.getT34());
            rout.setT35(routDetail.getT35());
            rout.setT36(routDetail.getT36());
            rout.setT37(routDetail.getT37());
            rout.setT38(routDetail.getT38());
            rout.setT39(routDetail.getT39());
            rout.setT40(routDetail.getT40());
            rout.setT41(routDetail.getT41());
            rout.setT42(routDetail.getT42());
            rout.setT43(routDetail.getT43());
            rout.setT44(routDetail.getT44());
            rout.setT45(routDetail.getT45());
            rout.setT46(routDetail.getT46());
            rout.setT47(routDetail.getT47());
            rout.setT48(routDetail.getT48());
            rout.setT49(routDetail.getT49());
            rout.setT50(routDetail.getT50());
            rout.setT51(routDetail.getT51());
            rout.setT52(routDetail.getT52());
            rout.setT53(routDetail.getT53());
            rout.setT54(routDetail.getT54());
            rout.setT55(routDetail.getT55());
            rout.setT56(routDetail.getT56());
            rout.setT57(routDetail.getT57());
            rout.setT58(routDetail.getT58());
            rout.setT59(routDetail.getT59());
            rout.setT60(routDetail.getT60());
            rout.setT61(routDetail.getT61());
            rout.setT62(routDetail.getT62());
            rout.setT63(routDetail.getT63());
            rout.setT64(routDetail.getT64());
            rout.setT65(routDetail.getT65());
            rout.setT66(routDetail.getT66());
            rout.setT67(routDetail.getT67());
            rout.setT68(routDetail.getT68());
            rout.setT69(routDetail.getT69());
            rout.setT70(routDetail.getT70());
            rout.setT71(routDetail.getT71());
            rout.setT72(routDetail.getT72());
            rout.setT73(routDetail.getT73());
            rout.setT74(routDetail.getT74());
            rout.setT75(routDetail.getT75());
            rout.setT76(routDetail.getT76());
            rout.setT77(routDetail.getT77());
            rout.setT78(routDetail.getT78());
            rout.setT79(routDetail.getT79());
            rout.setT80(routDetail.getT80());
            rout.setT81(routDetail.getT81());
            rout.setT82(routDetail.getT82());
            rout.setT83(routDetail.getT83());
            rout.setT84(routDetail.getT84());
            rout.setT85(routDetail.getT85());
            rout.setT86(routDetail.getT86());
            rout.setT87(routDetail.getT87());
            rout.setT88(routDetail.getT88());
            rout.setT89(routDetail.getT89());
            rout.setT90(routDetail.getT90());
            rout.setT91(routDetail.getT91());
            rout.setT92(routDetail.getT92());
            rout.setT93(routDetail.getT93());
            rout.setT94(routDetail.getT94());
            rout.setT95(routDetail.getT95());
            rout.setT96(routDetail.getT96());
            rout.setT97(routDetail.getT97());
            rout.setT98(routDetail.getT98());
            rout.setT99(routDetail.getT99());
            rout.setT100(routDetail.getT100());
            int m = routService.insert(rout);
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
    @RequestMapping("/getRoutApplByTaskId")
    public Map getRoutApplByTaskId(HttpServletResponse response,String taskId) throws Exception{
        //先根据流程ID查询
        Task task=taskService.createTaskQuery().taskId(taskId).singleResult();
        RoutAppl routAppl=routApplService.getExpApplByTaskId(task.getProcessInstanceId());
        JSONObject result=new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        result.put("id", routAppl.getId());
        result.put("typedetailid", routAppl.getTypedetailid());
        result.put("applytype", routAppl.getApplytype());
        result.put("applyreasons", routAppl.getApplytype());
        result.put("applystate", routAppl.getApplystate());
        result.put("inputman", routAppl.getInputman());
        result.put("inputdate", sdf.format(routAppl.getInputdate()));
        result.put("applyno", routAppl.getApplyno());
        result.put("processInstanceId", routAppl.getProcessInstanceId());
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
        RoutAppl routAppl =new RoutAppl();
        routAppl.setApplyno(applyno);
        routAppl.setApplystate(applystate);
        routAppl.setInputman(inputman);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if(!inputdate.equals("")){
            Date date = sdf.parse(inputdate);
            routAppl.setInputdate(date);
        }

        com.alibaba.fastjson.JSONObject re = new com.alibaba.fastjson.JSONObject();
        JSONArray jslst = new JSONArray();
        List<RoutAppl> list = routApplService.select(routAppl);
        RoutAppl routAppl1;
        if(list.size()>0) {
            for (int i=0;i<list.size();i++){
                com.alibaba.fastjson.JSONObject re1 = new com.alibaba.fastjson.JSONObject();
                routAppl1 = (RoutAppl)list.get(i);
                re1.put("id",routAppl1.getId());
                re1.put("applyno",routAppl1.getApplyno());
                re1.put("applystate",routAppl1.getApplystate());
                re1.put("inputman",routAppl1.getInputman());
                re1.put("inputdate",routAppl1.getInputdate()==null?"":sdf.format(routAppl1.getInputdate()));
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
        RoutAppl routAppl = routApplService.findByApplyno(applyno);
        com.alibaba.fastjson.JSONObject re1 = new com.alibaba.fastjson.JSONObject();
        re1.put("id",routAppl.getId());
        re1.put("applyno",routAppl.getApplyno());
        re1.put("applystate",routAppl.getApplystate());
        re1.put("inputman",routAppl.getInputman());
        re1.put("inputdate",routAppl.getInputdate());
        re1.put("applytype",routAppl.getApplytype());
        re1.put("typedetailid",routAppl.getTypedetailid());
        re1.put("applyreasons",routAppl.getApplyreasons());
        int typedetailid = routAppl.getTypedetailid();
        TypeDetail typeDetail = typeDetailService.selectById(typedetailid);
        re1.put("typedetailno",typeDetail.getTypeno());
        re1.put("typedetailname",typeDetail.getTypename());

        return re1;
    }



    @ResponseBody
    @RequestMapping(value = "selectDetail", method = {RequestMethod.GET, RequestMethod.POST})
    public com.alibaba.fastjson.JSONObject selectDetail(HttpServletRequest request) throws UnsupportedEncodingException, ParseException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        request.setCharacterEncoding("utf-8");
        String applyno = request.getParameter("applyno");

        List<RoutDetail> list = routDetailService.selectByApplyno(applyno);
        RoutDetail routDetail;
        JSONArray jslst = new JSONArray();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        com.alibaba.fastjson.JSONObject re = new com.alibaba.fastjson.JSONObject();


        if(list.size()>0) {
            for (int i=0;i<list.size();i++){
                com.alibaba.fastjson.JSONObject re1 = new com.alibaba.fastjson.JSONObject();
                routDetail = (RoutDetail)list.get(i);
                re1.put("id",routDetail.getId());
                re1.put("applyno",routDetail.getApplyno());
                re1.put("itemno",routDetail.getItemno());
                re1.put("typedetailid",routDetail.getTypedetailid());
                re1.put("typedetailno",routDetail.getTypedetailno());
                re1.put("typedetailname",routDetail.getTypedetailname());
                re1.put("codeno",routDetail.getCodeno());
                re1.put("codename",routDetail.getCodename());
                re1.put("inputman",routDetail.getInputman());
                re1.put("inputdate",sdf.format(routDetail.getInputdate()));

                List<CodeType> list1 = codeTypeService.selectByTypeno(routDetail.getTypedetailno());
                Code code = codeService.selectByCodeno(routDetail.getCodeno());
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
}
