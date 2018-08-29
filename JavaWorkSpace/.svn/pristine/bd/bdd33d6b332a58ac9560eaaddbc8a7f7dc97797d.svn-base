package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.partpunchingworkshop.service.EquipmentMaintenanceService;
import com.dhchain.business.partpunchingworkshop.service.MonthPlanService;
import com.dhchain.business.partpunchingworkshop.vo.BaseUser;
import com.dhchain.business.partpunchingworkshop.vo.EQPFault;
import com.dhchain.business.partpunchingworkshop.vo.EQPFaultRed;
import com.dhchain.business.partpunchingworkshop.vo.PTMaterial;
import com.dhchain.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/EquipmentMaintenance")
public class EquipmentMaintenanceController {

     @Autowired
     private MonthPlanService monthPlanService;
     @Autowired
     private EquipmentMaintenanceService equipmentMaintenanceService;
    @ResponseBody
    @RequestMapping(value="/Search",method={RequestMethod.GET,RequestMethod.POST})
    public JSON Search(HttpServletRequest request) throws UnsupportedEncodingException {
        List<BaseUser> list = monthPlanService.getUsername();
        JSONArray jslst = new JSONArray();
        if(list.size()>0){
            for(int i = 0 ;i<list.size();i++){
                Map re = new HashMap();
                BaseUser baseUser;
                baseUser = list.get(i);
                String Username = baseUser.getUserName();
                re.put("Username",Username);
                jslst.add(re);
            }
        }
        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/SearchName",method={RequestMethod.GET,RequestMethod.POST})
    public JSON SearchName(HttpServletRequest request) throws UnsupportedEncodingException {
        List<PTMaterial> list = monthPlanService.getUsername1();
        JSONArray jslst = new JSONArray();
        if(list.size()>0){
            for(int i = 0 ;i<list.size();i++){
                Map re = new HashMap();
                PTMaterial ptMaterial;
                ptMaterial = list.get(i);
                String Username = ptMaterial.getProductMan();
                re.put("Username",Username);
                jslst.add(re);
            }
        }
        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/Serach",method={RequestMethod.GET,RequestMethod.POST})
    public Map query (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
          int days; //天数
          int hours; //时
          int minutes; //分
          int seconds; //秒
        String uyear = request.getParameter("uyear");
        String umouth = request.getParameter("umouth");
        String plant = request.getParameter("plant");
        String department = request.getParameter("department");
        String Username = request.getParameter("Username");
        String emSerStatus = request.getParameter("emSerStatus");
        String emFaultTypes = request.getParameter("emFaultTypes");
        String EquipID = request.getParameter("EquipID");
        String starttime1 = request.getParameter("starttime");
        String endtime1 = request.getParameter("endtime");
        String starttime =starttime1+" 00:00:00";
        String endtime =endtime1+" 23:59:59";
        EQPFault eqpFault = new EQPFault();
        eqpFault.setServiceMan(Username);
        eqpFault.setPlant(plant);
        eqpFault.setDepartMent(department);
        eqpFault.setSerStatus(emSerStatus);
        eqpFault.setFaultTypes(emFaultTypes);
        eqpFault.setEquipID(EquipID);
        eqpFault.setCallTime(starttime);
        eqpFault.setCallTime1(endtime);
        List<EQPFault> list = equipmentMaintenanceService.getData(eqpFault);
        List<EQPFault> list1 = new ArrayList<>();
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //System.out.println("当前时间：" + sdf.format(d));
        Map re = new HashMap();
          if(list.size()>0){
              for(int i = 0;i<list.size();i++){
                 EQPFault eqpFault1 ;
                 eqpFault1 = list.get(i);
                  String a = eqpFault1.getCallTime();//呼叫时间
                  if(!StringUtil.isEmpty(eqpFault1.getRepSendTime())){
                      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                      String b = eqpFault1.getRepSendTime();
                      Date firstDate =null;
                      try {
                          firstDate = dateFormat.parse(a);
                      } catch (ParseException e) {
                          e.printStackTrace();
                      }
                      Date secondDate  = null;
                      try {
                          secondDate = dateFormat.parse(b);
                      } catch (ParseException e) {
                          e.printStackTrace();
                      }
                      //得到两个日期对象的总毫秒数
                      long firstDateMilliSeconds = firstDate.getTime();//开始日期
                      long secondDateMilliSeconds = secondDate.getTime();//结束日期

                      //得到两者之差
                      long firstMinusSecond = secondDateMilliSeconds-firstDateMilliSeconds;

                      //毫秒转为秒
                      long milliSeconds = firstMinusSecond;
                      int totalSeconds = (int)(milliSeconds / 1000);

                      //得到总天数
                      days = totalSeconds / (3600*24);
                      int days_remains = totalSeconds % (3600*24);

                      //得到总小时数
                      hours = days_remains / 3600;
                      int remains_hours = days_remains % 3600;

                      //得到分种数
                      minutes = remains_hours / 60;

                      //得到总秒数
                      seconds = remains_hours % 60;

                      eqpFault1.setAccumTime(days+"天"+hours+"小时"+minutes+"分"+seconds+"秒");
                      list1.add(eqpFault1);
                  }else {
                      String today = sdf.format(d);
                      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                      Date firstDate =null;
                      try {
                          firstDate = dateFormat.parse(a);
                      } catch (ParseException e) {
                          e.printStackTrace();
                      }
                      Date secondDate  = null;
                      try {
                          secondDate = dateFormat.parse(today);
                      } catch (ParseException e) {
                          e.printStackTrace();
                      }
                      //得到两个日期对象的总毫秒数
                      long firstDateMilliSeconds = firstDate.getTime();
                      long secondDateMilliSeconds = secondDate.getTime();

                      //得到两者之差
                      long firstMinusSecond = secondDateMilliSeconds-firstDateMilliSeconds;

                      //毫秒转为秒
                      long milliSeconds = firstMinusSecond;
                      int totalSeconds = (int)(milliSeconds / 1000);

                      //得到总天数
                      days = totalSeconds / (3600*24);
                      int days_remains = totalSeconds % (3600*24);

                      //得到总小时数
                      hours = days_remains / 3600;
                      int remains_hours = days_remains % 3600;

                      //得到分种数
                      minutes = remains_hours / 60;

                      //得到总秒数
                      seconds = remains_hours % 60;

                      eqpFault1.setAccumTime(days+"天"+hours+"小时"+minutes+"分"+seconds+"秒");
                      list1.add(eqpFault1);
                  }


              }
              re.put("rows",list);
              re.put("total",list.size());
          }

        return  re;

    }
    @ResponseBody
    @RequestMapping(value = "/Serach1",method={RequestMethod.GET,RequestMethod.POST})
    public JSON Serach1 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String faultid = request.getParameter("faultid");
        String plant = request.getParameter("plant");
        String department = request.getParameter("department");
        EQPFaultRed  eqpFaultRed = new EQPFaultRed();
        eqpFaultRed.setFaultID(faultid);
        eqpFaultRed.setPlant(plant);
        eqpFaultRed.setDepartment(department);
        List<EQPFaultRed> list =  equipmentMaintenanceService.getRed(eqpFaultRed);
        JSONArray jslst = new JSONArray();
        if(list.size()>0){
            Map re = new HashMap();
            EQPFaultRed eqpFaultRed1;
            eqpFaultRed1 = list.get(0);
            String Fault = eqpFaultRed1.getFault();
            String Results = eqpFaultRed1.getResults();
            re.put("Fault",Fault);
            re.put("Results",Results);
            jslst.add(re);
        }
        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/Insert",method={RequestMethod.GET,RequestMethod.POST})
    public Map Insert (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String faultid = request.getParameter("faultid");
        String time = request.getParameter("time");
        String username = request.getParameter("username");
        String Results = request.getParameter("Results");
        String Fault = request.getParameter("Fault");
        String EquipID = request.getParameter("EquipID");
        EQPFaultRed eqpFaultRed = new EQPFaultRed();
        EQPFaultRed eqpFaultRed1 = new EQPFaultRed();
        eqpFaultRed1.setFaultID(faultid);
        eqpFaultRed.setFaultID(faultid);
        eqpFaultRed.setEquipID(EquipID);
        eqpFaultRed.setFault(Fault);
        eqpFaultRed.setResults(Results);
        Map json = new HashMap();
        List<EQPFaultRed> list = equipmentMaintenanceService.select(eqpFaultRed1);
        if(list.size()>0){
            eqpFaultRed.setModifyMan(username);
            eqpFaultRed.setModifyTime(time);
            int n = equipmentMaintenanceService.updateRed(eqpFaultRed);
            if(n>0){
                EQPFault eqpFault = new EQPFault();
                eqpFault.setFaultID(faultid);
                eqpFault.setSerStatus("WX04");
                eqpFault.setRepSendMan(username);
                eqpFault.setRepSendTime(time);
                int n1 = equipmentMaintenanceService.update(eqpFault);
                json.put("num",n1);
            }
        }else {
            eqpFaultRed.setRepSendMan(username);
            eqpFaultRed.setRepSendTime(time);
            int n = equipmentMaintenanceService.insert(eqpFaultRed);
            if(n>0){
                EQPFault eqpFault = new EQPFault();
                eqpFault.setFaultID(faultid);
                eqpFault.setSerStatus("WX04");
                eqpFault.setRepSendMan(username);
                eqpFault.setRepSendTime(time);
                int n1 = equipmentMaintenanceService.update(eqpFault);
                json.put("num",n1);
            }
        }




        return  json;
    }
}
