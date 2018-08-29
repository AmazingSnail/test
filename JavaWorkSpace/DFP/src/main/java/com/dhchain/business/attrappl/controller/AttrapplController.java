package com.dhchain.business.attrappl.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.activiti.util.ResponseUtil;
import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.attrappl.service.AttrApplDetailService;
import com.dhchain.business.attrappl.service.AttrapplService;
import com.dhchain.business.attrappl.vo.AttrAppl;
import com.dhchain.business.attrappl.vo.AttrApplDetail;
import com.dhchain.business.exp.service.ExpService;
import com.dhchain.business.user.vo.ActUser;
import com.dhchain.business.user.vo.Group;
import com.dhchain.business.user.vo.MemberShip;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
//import org.activiti.engine.impl.pvm.PvmActivity;
//import org.activiti.engine.impl.pvm.PvmTransition;
//import org.activiti.engine.impl.pvm.process.ActivityImpl;
//import org.activiti.engine.impl.pvm.process.ProcessDefinitionImpl;
//import org.activiti.engine.impl.pvm.process.TransitionImpl;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.IdentityLink;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.faces.flow.FlowNode;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by zhenglb on 2017-10-11.
 */
@Controller
@RequestMapping("/attrappl")
public class AttrapplController {
    @Autowired
    private AttrapplService attrapplService;
    @Autowired
    private AttrApplDetailService attrApplDetailService;
    @Autowired
    private AttrService attrService;
    @Autowired
    private ExpService expService;
    @Resource
    private RuntimeService runtimeService;
    @Resource
    private TaskService taskService;
    @Resource
    private RepositoryService repositoryService;
    @Resource
    private HistoryService historyService;
    @Resource
    private ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
    @ResponseBody
    @RequestMapping(value = "Apply", method = {RequestMethod.GET, RequestMethod.POST})
    public String Apply(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String rows = request.getParameter("entities");
        AttrAppl attrAppl =new AttrAppl();
        String user = request.getParameter("user");
        Date date = new Date();
        String applyreasons = request.getParameter("applyreasons");
        attrAppl.setInputdate(date);
        attrAppl.setInputman(user);
        attrAppl.setApplyreasons(applyreasons);
        attrAppl.setApplystate("开始审核");
        attrAppl.setApplytype("创建并发送");
        String attrid = request.getParameter("attrid");
        attrAppl.setAttrid(Integer.parseInt(attrid));
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");

        String applyno = attrapplService.selectTodayMaxApplyno();
        attrAppl.setApplyno(applyno);
        int n = attrapplService.add(attrAppl);
        String[] attrApplRows = rows.split("、");
        AttrApplDetail attrApplDetail =new AttrApplDetail();
        int m = 0;
        List<AttrApplDetail> list = new ArrayList<AttrApplDetail>();
        for(String attrApplRow:attrApplRows){
            System.out.println(attrApplRow);
            String attra = attrApplRow.substring(1,attrApplRow.length()-1);
            String[] attrasx = attra.split(",");
            String itemno1 = attrasx[0].split(":")[1];
            attrApplDetail.setItemno(itemno1.replace("\"",""));
            String type = attrasx[1].split(":")[1];
            attrApplDetail.setRowtype(type.replace("\"","").equals("0")?"i":"m");
            String fname = attrasx[2].split(":")[1];
            attrApplDetail.setFattrname(fname.replace("\"",""));
            String fno = attrasx[3].split(":")[1];
            attrApplDetail.setFattrno(fno.replace("\"",""));
            String aname = attrasx[4].split(":")[1];
            attrApplDetail.setAttrname(aname.replace("\"",""));
            String ano = attrasx[5].split(":")[1];
            attrApplDetail.setAttrno(ano.replace("\"",""));
            String Mname = attrasx[6].split(":")[1];
            attrApplDetail.setMattrname(Mname.replace("\"",""));
            String Mno = attrasx[7].split(":")[1];
            attrApplDetail.setMattrno(Mno.replace("\"",""));
            String iscode1 = attrasx[8].split(":")[1];
            attrApplDetail.setIscode(iscode1.replace("\"","").equals("是")?1:0);
            String isrelate1 = attrasx[9].split(":")[1];
            attrApplDetail.setIsrelate(isrelate1.replace("\"","").equals("是")?1:0);
            String islocked1 = attrasx[10].split(":")[1];
            attrApplDetail.setIslocked(islocked1.replace("\"","").equals("是")?1:0);
            String fattrid1 = attrasx[11].split(":")[1];
            attrApplDetail.setFattrid(Integer.parseInt(fattrid1.replace("\"","")));
            attrApplDetail.setApplyno(applyno);
            int i = attrApplDetailService.insert(attrApplDetail);
            int newid = attrApplDetailService.selectNewId();
            m+=i;
            list.add(attrApplDetailService.selectById(newid));
        }
        Map<String,Object> variables=new HashMap<String,Object>();
        variables.put("applyno", applyno);
        // 启动流程
        ProcessInstance pi= runtimeService.startProcessInstanceByKey("vacationRequest4",variables);
        // 根据流程实例Id查询任务
        Task task=taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
        // 完成 学生填写请假单任务
//        taskService.complete(task.getId());
//        ExpAppl expAppl1=expApplService.findByApplyno(applyno);
//        //修改状态
//        expAppl1.setApplystate("待提交");
        attrAppl.setProcessInstanceId(pi.getProcessInstanceId());
//        // 修改请假单状态
        attrapplService.update(attrAppl);
        net.sf.json.JSONObject result=new net.sf.json.JSONObject();
        result.put("success", true);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        result.put("inputdate",sdf.format(attrAppl.getInputdate()));
        result.put("applyno", applyno);
        result.put("applytype", attrAppl.getApplytype());
        result.put("inputman", attrAppl.getInputman());
        ResponseUtil.write(response, result);
//        Save(list);
        return null;
//        Map json = new HashMap();
//        json.put("num",m);
//        Save(list);


    }

    @ResponseBody
    @RequestMapping(value = "ApplyAndPass", method = {RequestMethod.GET, RequestMethod.POST})
    public String ApplyAndPass(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String rows = request.getParameter("entities");
        AttrAppl attrAppl =new AttrAppl();
        String user = request.getParameter("user");
        Date date = new Date();
        String applyreasons = request.getParameter("applyreasons");
        attrAppl.setInputdate(date);
        attrAppl.setInputman(user);
        attrAppl.setApplyreasons(applyreasons);
        attrAppl.setApplystate("开始审核");
        attrAppl.setApplytype("创建并发送");
        String attrid = request.getParameter("attrid");
        attrAppl.setAttrid(Integer.parseInt(attrid));
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");

        String applyno = attrapplService.selectTodayMaxApplyno();
        attrAppl.setApplyno(applyno);
        int n = attrapplService.add(attrAppl);
        String[] attrApplRows = rows.split("、");
        AttrApplDetail attrApplDetail =new AttrApplDetail();
        int m = 0;
        List<AttrApplDetail> list = new ArrayList<AttrApplDetail>();
        for(String attrApplRow:attrApplRows){
            System.out.println(attrApplRow);
            String attra = attrApplRow.substring(1,attrApplRow.length()-1);
            String[] attrasx = attra.split(",");
            String itemno1 = attrasx[0].split(":")[1];
            String itemno = itemno1.substring(1,itemno1.length()-1);
            attrApplDetail.setItemno(itemno);
            String type = attrasx[1].split(":")[1];
            String rowtype = type.substring(1,type.length()-1);
            attrApplDetail.setRowtype(rowtype.equals("0")?"i":"m");
            String fname = attrasx[2].split(":")[1];
            String fattrname = fname.substring(1,fname.length()-1);
            attrApplDetail.setFattrname(fattrname);
            String fno = attrasx[3].split(":")[1];
            String fattrno = fno.substring(1,fname.length()-1);
            attrApplDetail.setFattrno(fattrno);
            String aname = attrasx[4].split(":")[1];
            String attrname = aname.substring(1,aname.length()-1);
            attrApplDetail.setAttrname(attrname);
            String ano = attrasx[5].split(":")[1];
            String attrno = ano.substring(1,ano.length()-1);
            attrApplDetail.setAttrno(attrno);
            String Mname = attrasx[6].split(":")[1];
            String Mattrname = Mname.substring(1,Mname.length()-1);
            attrApplDetail.setMattrname(Mattrname);
            String Mno = attrasx[7].split(":")[1];
            String Mattrno = Mno.substring(1,Mno.length()-1);
            attrApplDetail.setMattrno(Mattrno);
            String iscode1 = attrasx[8].split(":")[1];
            String iscode = iscode1.substring(1,iscode1.length()-1);
            attrApplDetail.setIscode(iscode.equals("是")?1:0);
            String isrelate1 = attrasx[9].split(":")[1];
            String isrelate = isrelate1.substring(1,isrelate1.length()-1);
            attrApplDetail.setIsrelate(isrelate.equals("是")?1:0);
            String islocked1 = attrasx[10].split(":")[1];
            String islocked = islocked1.substring(1,islocked1.length()-1);
            attrApplDetail.setIslocked(islocked.equals("是")?1:0);
            String fattrid1 = attrasx[11].split(":")[1];
            String fattrid = fattrid1.substring(1,fattrid1.length()-1);
            attrApplDetail.setFattrid(Integer.parseInt(fattrid));
            attrApplDetail.setApplyno(applyno);
            int i = attrApplDetailService.insert(attrApplDetail);
            int newid = attrApplDetailService.selectNewId();

            m+=i;
            list.add(attrApplDetailService.selectById(newid));
        }
        Map<String,Object> variables=new HashMap<String,Object>();
        variables.put("applyno", applyno);
        // 启动流程
        ProcessInstance pi= runtimeService.startProcessInstanceByKey("vacationRequest4",variables);
        // 根据流程实例Id查询任务
        Task task=taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
        // 完成 学生填写请假单任务
        taskService.complete(task.getId());
        AttrAppl attrAppl1=attrapplService.selectByApplyno(applyno);
        //修改状态
        attrAppl1.setApplystate("待提交");
        attrAppl1.setProcessInstanceId(pi.getProcessInstanceId());
        // 修改请假单状态
        attrapplService.update(attrAppl1);
        JSONObject result=new JSONObject();
        result.put("success", true);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        result.put("inputdate",sdf.format(attrAppl1.getInputdate()));
        result.put("applyno", applyno);
        result.put("applytype", attrAppl1.getApplytype());
        result.put("inputman", attrAppl1.getInputman());
        ResponseUtil.write(response, result);
//        Save(list);
        return null;


    }


    public Map Save(List<AttrApplDetail> list){
        Map json = new HashMap();
        Date date = new Date();
        int n = 0;
        for(AttrApplDetail attrApplDetail:list){
            if(attrApplDetail.getRowtype().equals("i")){
                String applyno = attrApplDetail.getApplyno();
                AttrAppl attrAppl = attrapplService.selectByApplyno(applyno);
                int Fattrid = attrApplDetail.getFattrid();
                Attr Fattr = attrService.selectById(Fattrid);
                int Fid = Fattr.getId();
                Attr attr = new Attr();
                attr.setFid(Fid);
                attr.setIslocked(attrApplDetail.getIslocked());
                attr.setIsrelate(attrApplDetail.getIsrelate());
                attr.setIscode(attrApplDetail.getIscode());
                attr.setAttrname(attrApplDetail.getAttrname());
                attr.setAttrno(attrApplDetail.getAttrno());
                attr.setInputdate(date);
                attr.setInputman(attrAppl.getInputman());
                attr.setRemark(attrAppl.getApplyreasons());
                n+=attrService.add(attr);
                int newid = attrService.selectNewId();
                Attr attr1 = attrService.selectById(newid);
                Attr parent;
                if(attr1.getFid()==0){
                    attr1.setFlag(";"+attr1.getId()+"-"+1);
                    attrService.updateById(attr1);
                }else {
                    parent = attrService.selectById(attr1.getFid());
                    attr1.setFlag(parent.getFlag()+"-"+attr1.getId());
                    attrService.updateById(attr1);
                }

            }else{
                String applyno = attrApplDetail.getApplyno();
                AttrAppl attrAppl = attrapplService.selectByApplyno(applyno);
                int Fattrid = attrApplDetail.getFattrid();
                Attr Fattr = attrService.selectById(Fattrid);
                Fattr.setModifydate(date);
                Fattr.setModifyman(attrAppl.getInputman());
                Fattr.setAttrno(attrApplDetail.getMattrno());
                Fattr.setAttrname(attrApplDetail.getMattrname());
                Fattr.setRemark(attrAppl.getApplyreasons());
                Fattr.setIscode(attrApplDetail.getIscode());
                Fattr.setIsrelate(attrApplDetail.getIsrelate());
                Fattr.setIslocked(attrApplDetail.getIslocked());
                boolean f = attrService.updateById(Fattr);
                if(f){
                    n+=1;
                }
            }
        }
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "Query", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException, ParseException {
        request.setCharacterEncoding("utf-8");
        String applyno = request.getParameter("applyno");
        String applystate = request.getParameter("applystate");
        String inputman = request.getParameter("inputman");
        String inputdate =request.getParameter("inputdate");
        AttrAppl attrAppl =new AttrAppl();
        attrAppl.setApplyno(applyno);
        attrAppl.setApplystate(applystate);
        attrAppl.setInputman(inputman);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if(!inputdate.equals("")){
            Date date = sdf.parse(inputdate);
            attrAppl.setInputdate(date);
        }

        JSONObject re = new JSONObject();
        JSONArray jslst = new JSONArray();
        List<AttrAppl> list = attrapplService.select(attrAppl);
        AttrAppl attrAppl1;
        if(list.size()>0) {
            for (int i=0;i<list.size();i++){
                JSONObject re1 = new JSONObject();
                attrAppl1 = (AttrAppl)list.get(i);
                re1.put("id",attrAppl1.getId());
                re1.put("applyno",attrAppl1.getApplyno());
                re1.put("applystate",attrAppl1.getApplystate());
                re1.put("inputman",attrAppl1.getInputman());
                re1.put("inputdate",attrAppl1.getInputdate()==null?"":sdf.format(attrAppl1.getInputdate()));
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
        AttrAppl attrAppl = attrapplService.selectByApplyno(applyno);
        JSONObject re1 = new JSONObject();
        re1.put("id",attrAppl.getId());
        re1.put("applyno",attrAppl.getApplyno());
        re1.put("applystate",attrAppl.getApplystate());
        re1.put("inputman",attrAppl.getInputman());
        re1.put("inputdate",attrAppl.getInputdate());
        re1.put("applytype",attrAppl.getApplytype());
        re1.put("attrid",attrAppl.getAttrid());
        re1.put("applyreasons",attrAppl.getApplyreasons());
        int attrid = attrAppl.getAttrid();
        Attr attr = attrService.selectById(attrid);
        if(attr!=null){
            re1.put("attrname",attr.getAttrname());
        }


        return re1;
    }


    @ResponseBody
    @RequestMapping(value = "selectDetail", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectDetail(HttpServletRequest request) throws UnsupportedEncodingException, ParseException {
        request.setCharacterEncoding("utf-8");
        String applyno = request.getParameter("applyno");

        List<AttrApplDetail> list = attrApplDetailService.selectByApplyno(applyno);
        AttrApplDetail attrApplDetail;
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        if(list.size()>0) {
            for (int i=0;i<list.size();i++){
                JSONObject re1 = new JSONObject();
                attrApplDetail = (AttrApplDetail)list.get(i);
                re1.put("id",attrApplDetail.getId());
                re1.put("applyno",attrApplDetail.getApplyno());
                re1.put("itemno",attrApplDetail.getItemno());
                re1.put("rowtype",attrApplDetail.getRowtype().equals("i")?"新增":"修改");
                re1.put("attrno",attrApplDetail.getAttrno());
                re1.put("attrname",attrApplDetail.getAttrname());
                re1.put("fattrno",attrApplDetail.getFattrno());
                re1.put("fattrname",attrApplDetail.getFattrname());
                re1.put("Mattrno",attrApplDetail.getMattrno());
                re1.put("Mattrname",attrApplDetail.getMattrname());
                re1.put("islocked",attrApplDetail.getIslocked()==0?"否":"是");
                re1.put("isrelate",attrApplDetail.getIsrelate()==0?"否":"是");
                re1.put("iscode",attrApplDetail.getIscode()==0?"否":"是");
                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
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
//        if(currentGroup.getName().contains("admin")){
        if(taskname.equals("审核属性申请")){
                if(state==1){
                    String applyno=(String) taskService.getVariable(taskId, "applyno");
                    AttrAppl attrAppl=attrapplService.selectByApplyno(applyno);
                    attrAppl.setApplystate("审核通过");
                    // 更新审核信息
                    attrapplService.update(attrAppl);
                    variables.put("statu", 1);
                    List<AttrApplDetail> list = attrApplDetailService.selectByApplyno(applyno);
                    Save(list);

                }else{
                    String applyno=(String) taskService.getVariable(taskId, "applyno");
                    AttrAppl attrAppl=attrapplService.selectByApplyno(applyno);
                    attrAppl.setApplystate("审核未通过");
                    // 更新审核信息
                    attrapplService.update(attrAppl);
                    variables.put("statu",2);
                }
            }
//        }
//        if(state==1){
//            String attrAppl=(String) taskService.getVariable(taskId, "attrAppl");
//            variables.put("msg", "通过");
//        }else{
//            String applyno=(String) taskService.getVariable(taskId, "applyno");
//            AttrAppl attrAppl=attrapplService.selectByApplyno(applyno);
//            attrAppl.setApplystate("审核未通过");
//            // 更新审核信息
//            attrapplService.update(attrAppl);
//            variables.put("msg", "未通过");
//        }

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
        net.sf.json.JSONObject result=new net.sf.json.JSONObject();
        result.put("success", true);
        ResponseUtil.write(response, result);
        return null;
    }


    /**
     * 查询流程信息
     * @param response
     * @param taskId  流程实例ID
     * @return
     * @throws Exception
     */
    @RequestMapping("/getAttrApplByTaskId")
    public Map getAttrApplByTaskId(HttpServletResponse response,String taskId) throws Exception{
        //先根据流程ID查询
        Task task=taskService.createTaskQuery().taskId(taskId).singleResult();
        AttrAppl attrAppl=attrapplService.getAttrApplByTaskId(task.getProcessInstanceId());
        net.sf.json.JSONObject result=new net.sf.json.JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        result.put("id", attrAppl.getId());
        result.put("attrid", attrAppl.getAttrid());
        Attr attr = attrService.selectById(attrAppl.getAttrid());
        result.put("attrname", attr.getAttrname());
        result.put("applytype", attrAppl.getApplytype());
        result.put("applyreasons", attrAppl.getApplytype());
        result.put("applystate", attrAppl.getApplystate());
        result.put("inputman", attrAppl.getInputman());
        result.put("inputdate", sdf.format(attrAppl.getInputdate()));
        result.put("applyno", attrAppl.getApplyno());
        result.put("reason", attrAppl.getApplyreasons());
        result.put("processInstanceId", attrAppl.getProcessInstanceId());
        ResponseUtil.write(response, result);
        return null;
    }


    @ResponseBody
    @RequestMapping(value = "edit", method = {RequestMethod.GET, RequestMethod.POST})
    public Map edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String rowtype = request.getParameter("rowtype");
        String attrname = request.getParameter("attrname");
        String attrno = request.getParameter("attrno");
        String Mattrname = request.getParameter("Mattrname");
        String Mattrno = request.getParameter("Mattrno");
        String iscode = request.getParameter("iscode");
        String isrelate = request.getParameter("isrelate");
        String islocked = request.getParameter("islocked");
        Date date =new Date();
        AttrApplDetail attrApplDetail = attrApplDetailService.selectById(Integer.parseInt(id));
        if(iscode.equals("否")){
            attrApplDetail.setIscode(0);
        }else {
            attrApplDetail.setIscode(1);
        }
        if(isrelate.equals("否")){
            attrApplDetail.setIsrelate(0);
        }else {
            attrApplDetail.setIsrelate(1);
        }

        if(islocked.equals("否")){
            attrApplDetail.setIslocked(0);
        }else {
            attrApplDetail.setIslocked(1);
        }

        if(rowtype.equals("新增")){
            attrApplDetail.setRowtype("i");
        }else {
            attrApplDetail.setRowtype("m");
        }

        attrApplDetail.setAttrno(attrno);
        attrApplDetail.setAttrname(attrname);
        attrApplDetail.setMattrno(Mattrno);
        attrApplDetail.setMattrname(Mattrname);
        int n = attrApplDetailService.edit(attrApplDetail);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }


}
