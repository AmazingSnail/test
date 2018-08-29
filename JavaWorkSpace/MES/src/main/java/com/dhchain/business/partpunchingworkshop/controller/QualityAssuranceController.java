package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.partpunchingworkshop.service.QualityAssuranceService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/QualityAssurance")
public class QualityAssuranceController {
    @Autowired
    private QualityAssuranceService qualityAssuranceService;

    @ResponseBody
    @RequestMapping(value="/Query",method={RequestMethod.GET,RequestMethod.POST})
    public Map query (HttpServletRequest request) throws UnsupportedEncodingException {
           request.setCharacterEncoding("utf-8");
           String plant = request.getParameter("plant");
           String deparment = request.getParameter("deparment");
           String CheakTypes = request.getParameter("CheakTypes");
           String starttime1 = request.getParameter("starttime");
           String starttime = starttime1 +" 00:00:00";
           String endtime1 = request.getParameter("endtime");
           String endtime = endtime1+" 23:59:59";
           String EquipID = request.getParameter("EquipID");
           String CheakID = request.getParameter("CheakID");
           String PlanID = request.getParameter("PlanID");
           CHKResult chkResult =new CHKResult();
           if(!" ".equals(CheakTypes)){
               chkResult.setCheakTypes(CheakTypes);
           }
           chkResult.setPlant(plant);
           chkResult.setDepartment(deparment);
           chkResult.setRandomTime(starttime);
           chkResult.setRandomTime1(endtime);
           chkResult.setEquipID(EquipID);
           chkResult.setCheakID(CheakID);
           chkResult.setPlanID(PlanID);
        List<CHKResult> list = qualityAssuranceService.search(chkResult);
        Map json =  new HashMap();
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;

    }
    @ResponseBody
    @RequestMapping(value="/jilian",method={RequestMethod.GET,RequestMethod.POST})
    public Map jilian (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String cheakID = request.getParameter("cheakID");
        CHKDetail chkDetail = new CHKDetail();
        chkDetail.setCheakID(cheakID);
        List<CHKDetail> list = qualityAssuranceService.getbycheckID(chkDetail);
       Map json = new HashMap();
       if(list.size()>0){
           json.put("rows",list);
           json.put("total",list.size());
       }
        return  json;

    }
    @ResponseBody
    @RequestMapping(value="/Find",method={RequestMethod.GET,RequestMethod.POST})
    public Map Find (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
       String uyear =request.getParameter("uyear");
       String umonth =request.getParameter("umonth");
       String plant =request.getParameter("plant");
       PTPlan ptPlan = new PTPlan();
        PTFinish ptFinish = new PTFinish();
        ptFinish.setUyear(Integer.parseInt(uyear));
        ptFinish.setPlant(plant);
        ptFinish.setUmouth(Integer.parseInt(umonth));
       ptPlan.setPlant(plant);
       ptPlan.setUmouth(Integer.parseInt(umonth));
       ptPlan.setUyear(Integer.parseInt(uyear));
        List<PTPlan> list = qualityAssuranceService.getAll(ptPlan);
        List<PTFinish> list1 = qualityAssuranceService.getAll1(ptFinish);
        List<BaseUser> list2 = qualityAssuranceService.getUser();
       Map json = new HashMap();
        Double sum = 0.0;
        Double sum1 = 0.0;
        int c = list2.size();
       if(list.size()>0){
           for(int i = 0 ;i<list.size();i++){
               PTPlan ptPlan1;
               ptPlan1 = list.get(i);
               sum = sum + ptPlan1.getPlanNum();
           }
       }
       if(list1.size()>0){
           for(int i =0;i<list1.size();i++){
               PTFinish ptFinish1;
               ptFinish1 = list1.get(i);
               sum1 = sum1 + ptFinish1.getWeightNum();
           }
       }
        DecimalFormat df = new DecimalFormat("0.0");
       Double a =0.0;
       if(sum>0&&sum1>0){
           a = (sum1/sum *100);
       }
       String b = df.format(a);
        json.put("num",sum);
        json.put("num1",sum1);
        json.put("num2",b);
        json.put("num3",c);
        return  json;

    }
    @ResponseBody
    @RequestMapping(value = "/EquipID",method = {RequestMethod.GET,RequestMethod.POST})
    public JSON EquipID (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String department = request.getParameter("department");
        BaseEquip baseEquip = new BaseEquip();
        baseEquip.setDepartMent(department);
        baseEquip.setPlant(plant);
        List<BaseEquip> list = qualityAssuranceService.getEquipID(baseEquip);
        JSONArray jslst = new JSONArray();
        BaseEquip baseEquip1 = new BaseEquip();
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                Map re =  new HashMap();
                baseEquip1 = list.get(i);
                String EquipID = baseEquip1.getEquipID();
                re.put("EquipID",EquipID);
                jslst.add(re);
            }
        }
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/Matial",method = {RequestMethod.GET,RequestMethod.POST})
    public Map Matial (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umonth");
        Map json = new HashMap();
        List<PTPlan> list = qualityAssuranceService.getMatial();
        List list1 = new ArrayList();//原材料
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                PTPlan ptPlan;
                ptPlan = list.get(i);
                String a = ptPlan.getWeight();
                list1.add(a);
            }
            json.put("rows",list1);
        }

        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Matial2",method = {RequestMethod.GET,RequestMethod.POST})
    public Map Matial2 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umonth");
        Map json = new HashMap();
        List<PTFinish> list2 = qualityAssuranceService.getFinish();//产量
        List<PTPlan> list = qualityAssuranceService.getMatial();//原材料
        List list3 = new ArrayList();//利用率
        DecimalFormat df = new DecimalFormat("0.0");
        if(list2.size()>0){
            for(int m =0 ;m<list2.size();m++){
                PTFinish ptFinish;
                PTPlan ptPlan;
                ptFinish = list2.get(m);
                ptPlan = list.get(m);
                Double b = Double.parseDouble(ptPlan.getWeight());//原材料
                Double a = ptFinish.getWeightNum();//产量
                Double s ;
                String n;
                if(a>0&&b>0){
                    s =  a/b *100;
                }else {
                    s  = 0.0;
                }
                n = df.format(s);
                list3.add(n);
            }
            json.put("rows",list3);
        }

        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Matial1",method = {RequestMethod.GET,RequestMethod.POST})
    public Map Matial1 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umonth");
        Map json = new HashMap();
        List<PTFinish> list2 = qualityAssuranceService.getFinish();
        List list3 = new ArrayList();//产量
        if(list2.size()>0){
            for(int m =0 ;m<list2.size();m++){
                PTFinish ptFinish;
                ptFinish = list2.get(m);
                Double a = ptFinish.getWeightNum();
                list3.add(a);
            }
            json.put("rows",list3);
        }

        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Other",method = {RequestMethod.GET,RequestMethod.POST})
    public Map Other (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umonth");
        int a = 0;
        int b = 0;
        int c = 0;
        int d = 0;
        int e = 0;
        int f = 0;
        int g = 0;
        int h = 0;
        int i = 0;
        int j = 0;
        int k = 0;
        int l = 0;
        int m = 0;
        int n = 0;
        EQPStatus eqpStatus = new EQPStatus();
        eqpStatus.setPlant(plant);
        List<EQPStatus> list = qualityAssuranceService.getStatus(eqpStatus);
        a = list.size();
        if(a>0){
            for(int z = 0; z<a;z++){
                EQPStatus eqpStatus1;
                eqpStatus1 = list.get(z);
                if(eqpStatus1.getStatusName().equals("运行")){
                    b++;
                }else if(eqpStatus1.getStatusName().equals("停机")){
                     c++;
                }else if(eqpStatus1.getStatusName().equals("关机")){
                    d++;
                } else if(eqpStatus1.getStatusName().equals("故障")){
                    e++;
                }
            }
        }
        //待维护工艺
        PTPlan ptPlan = new PTPlan();
        ptPlan.setUyear(Integer.parseInt(uyear));
        ptPlan.setUmouth(Integer.parseInt(umonth));
        ptPlan.setPlant(plant);
        List<PTPlan> list1 = qualityAssuranceService.getAll(ptPlan);
        if(list1.size()>0){
            for(int x = 0;x<list1.size();x++){
                PTPlan ptPlan1;
                ptPlan1 = list1.get(x);
                if(ptPlan1.getOrderPlan().equals("0")){
                    f++;
                }
                if(ptPlan1.getCapacity().equals("0")){
                    g++;
                }
                if(ptPlan1.getChkStd().equals("0")){
                    h++;
                }
                if(ptPlan1.getCraftFile().equals("0")){
                    i++;
                }
            }
        }
        EQPFault eqpFault = new EQPFault();
        eqpFault.setPlant(plant);
        List<EQPFault> list2 = qualityAssuranceService.getFault(eqpFault);
        j = list2.size();
        if(j>0){
            for(int s=0;s<j;s++){
                EQPFault eqpFault1;
                eqpFault1 = list2.get(s);
                if(eqpFault1.getSerStatus().equals("WX01")){
                     k++;
                }else if(eqpFault1.getSerStatus().equals("WX02")){
                    l++;
                }
                else if(eqpFault1.getSerStatus().equals("WX03")){
                    m++;
                }else if(eqpFault1.getSerStatus().equals("WX04")){
                    n++;
                }
            }
        }
        Map json = new HashMap();
        json.put("a",a);
        json.put("b",b);
        json.put("c",c);
        json.put("d",d);
        json.put("e",e);
        json.put("f",f);
        json.put("g",g);
        json.put("h",h);
        json.put("i",i);
        json.put("j",j);
        json.put("k",k);
        json.put("l",l);
        json.put("m",m);
        json.put("n",n);
        return json;
    }

}
