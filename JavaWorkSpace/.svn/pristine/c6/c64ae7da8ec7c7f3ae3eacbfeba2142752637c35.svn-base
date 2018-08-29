package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.partpunchingworkshop.service.ProductionTaskService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.IntrospectionException;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/ProductionTask")
public class ProductionTaskController {
    @Autowired
    private ProductionTaskService productionTaskService;
    @ResponseBody
    @RequestMapping(value="/Serach",method={RequestMethod.GET,RequestMethod.POST})
    public Map serach (HttpServletRequest request) throws UnsupportedEncodingException {
        //String plant = request.getParameter("plant");
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String status = request.getParameter("state");
        String partDrawing = request.getParameter("partDrawing");
        String mouldID = request.getParameter("mouldID");
        String starttime1 = request.getParameter("starttime");
        String endtime1 = request.getParameter("endtime");
        String starttime = starttime1 + " 00:00:00";
        String endtime = endtime1 + " 23:59:59";
        String ptmStatus = request.getParameter("ptmStatus");
        PTProdTake ptProdTake = new PTProdTake();
        ptProdTake.setMouldID(mouldID.trim());
        ptProdTake.setPartDrawing(partDrawing.trim());
        ptProdTake.setPlant(plant);
        ptProdTake.setInputDate(starttime);
        ptProdTake.setInputDate1(endtime);
        ptProdTake.setStatus(ptmStatus.trim());
        if(status!=null){
            if(Integer.parseInt(status)==2){
                ptProdTake.setLocaFinish(true);
            }else if(Integer.parseInt(status)==1) {
                ptProdTake.setIsFinish(true);
            }else{

            }
        }

        Map json = new HashMap();
        List<PTProdTake> list = productionTaskService.select(ptProdTake);
        List<PTProdTake> list1 = new ArrayList<>();

        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                PTProdTake ptProdTake1;
                ptProdTake1 = list.get(i);
                String planid = ptProdTake1.getPlanID();
                String plant1 = ptProdTake1.getPlant();
                String department = ptProdTake1.getDepartMent();
                PTFinish ptFinish = new PTFinish();
                ptFinish.setPlanID(planid);
                ptFinish.setPlant(plant1);
                ptFinish.setDepartMent(department);
                List<PTFinish> list2 = productionTaskService.selectbyfno(ptFinish);
                if(list2.size()>0){
                    Double sum =0.0;
                    for(int j =0;j<list2.size();j++){
                        PTFinish ptFinish1 ;
                        ptFinish1 = list2.get(j);
                        if( !"".equals(ptFinish1.getWeightNum())){
                            Double a  = ptFinish1.getWeightNum();
                            sum = a + sum;
                        }


                    }
                    ptProdTake1.setRealFinishNum(sum);
                }
                if(ptProdTake1.getIsFinish()!=null){
                    if(ptProdTake1.getIsFinish()){
                        ptProdTake1.setProcess("确认");
                    }else {
                        ptProdTake1.setProcess("未确认");
                    }
                }

                if(ptProdTake1.getLocaFinish()){
                    ptProdTake1.setSure("确认");
                }else {
                    ptProdTake1.setSure("未确认");
                }
                list1.add(ptProdTake1);
            }
            json.put("rows", list1);
            json.put("total", list1.size());
        }
         return json;
    }
    @ResponseBody
    @RequestMapping(value="/SerachName",method={RequestMethod.GET,RequestMethod.POST})
    public Map SerachName (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String reelnum = request.getParameter("reelnum");
        String EquipID = request.getParameter("EquipID");
        String Username = request.getParameter("Username");
        String starttime1 = request.getParameter("starttime");
        String endtime1 = request.getParameter("endtime");
        String starttime = starttime1 + " 00:00:00";
        String endtime = endtime1 + " 23:59:59";
        PTMaterial ptMaterial = new PTMaterial();
        ptMaterial.setFno(fno);
        ptMaterial.setEquipID(EquipID);
        ptMaterial.setProductMan(Username);
        ptMaterial.setProductTime(starttime);
        ptMaterial.setProductTime1(endtime);
        ptMaterial.setReelnum(reelnum);
        ptMaterial.setFname(fname);
        List<PTMaterial> list = productionTaskService.getMaterial(ptMaterial);
        List<PTMaterial> list2 = new ArrayList<>();
        Map json = new HashMap();
        if(list.size()>0){
            for(int i = 0 ; i<list.size();i++){
                PTFinish ptFinish = new PTFinish();
                PTMaterial ptMaterial1;
                ptMaterial1 = list.get(i);
                String coldid = ptMaterial1.getColdID();
                ptFinish.setColdID(coldid);
                List<PTFinish> list1 = productionTaskService.getFinish(ptFinish);
                Double sum = 0.0;
                if(list1.size()>0){
                    for(int j =0;j<list1.size();j++) {
                        PTFinish ptFinish2;
                        ptFinish2 = list1.get(j);
                        Double a  = ptFinish2.getWeightNum();
                        sum = a + sum;
                    }
                }
                Double s = Double.parseDouble(ptMaterial1.getWeight()) ;
                if(s-sum>0){
                    ptMaterial1.setOver("0");
                }else {
                    ptMaterial1.setOver("1");
                }
                list2.add(ptMaterial1);
            }
            json.put("rows", list2);
            json.put("total", list2.size());
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/onclick",method={RequestMethod.GET,RequestMethod.POST})
    public JSON Onclick (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String coldid = request.getParameter("coldid");
        PTFinish ptFinish = new PTFinish();
        ptFinish.setColdID(coldid);
        List<PTFinish> list = productionTaskService.getFinish(ptFinish);
        Map json = new HashMap();
        JSONObject re = new JSONObject();
        Double sum = 0.0;
        if(list.size()>0){
            for(int i =0;i<list.size();i++) {
                PTFinish ptFinish1;
                ptFinish1 = list.get(i);
                Double a  = ptFinish1.getWeightNum();
                sum = a + sum;
            }
        }
        Map r = new HashMap();
        r.put("coldID","合计");
        r.put("fno",sum);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(r);
        re.put("rows",list);
        re.put("total",list.size());
        re.put("footer",jslst2);
        return  re;

    }
    @ResponseBody
    @RequestMapping(value="/jilian",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject jilian (HttpServletRequest request) throws UnsupportedEncodingException {

        request.setCharacterEncoding("utf-8");
        String  planID = request.getParameter("planID");
        String  plant = request.getParameter("plant");
        String  department = request.getParameter("department");
        PTFinish ptFinish = new PTFinish();
        ptFinish.setPlanID(planID);
        ptFinish.setDepartMent(department);
        ptFinish.setPlant(plant);
        List<PTFinish> list = productionTaskService.selectbyfno(ptFinish);
        Double sum = 0.0;
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        if(list.size()>0){
            for(int i =0;i<list.size();i++){
                PTFinish ptFinish1 ;
                ptFinish1 = list.get(i);
                String coldid = ptFinish1.getColdID();
                ColdDailyPlan coldDailyPlan =  new ColdDailyPlan();
                coldDailyPlan.setId(Integer.parseInt(coldid));
                DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
                List<ColdDailyPlan> list3 = productionTaskService.selectbyid(coldDailyPlan);
                DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
                String c="";
                if(list3.size()>0){
                    for(int n = 0;n<list3.size();n++){
                        ColdDailyPlan coldDailyPlan1;
                        coldDailyPlan1 = list3.get(n);
                        c = coldDailyPlan1.getReelnum();
                        ptFinish1.setReelnum(c);
                    }

                }

                Double a  = ptFinish1.getWeightNum();
                sum = a + sum;
                jslst.add(ptFinish1);
            }
        }
        Map r = new HashMap();
        r.put("planID","合计");
        r.put("weightNum",sum);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(r);
        re.put("rows",jslst);
        re.put("total",jslst.size());
        re.put("footer",jslst2);
        return  re;

    }
    @ResponseBody
    @RequestMapping(value="/sure",method={RequestMethod.GET,RequestMethod.POST})
    public Map Sure (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String planID = request.getParameter("planID");
        PTProdTake ptProdTake = new PTProdTake();
        ptProdTake.setPlanID(planID);
        ptProdTake.setFinishMan(name);
        ptProdTake.setFinishTime(time);
        ptProdTake.setIsFinish(true);
        ptProdTake.setPlant(plant);
        int n = productionTaskService.updatebyplanid(ptProdTake);

        Map json = new HashMap();

        json.put("num", n);
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/dissure",method={RequestMethod.GET,RequestMethod.POST})
    public Map DisSure (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String planID = request.getParameter("planID");
        PTProdTake ptProdTake = new PTProdTake();
        ptProdTake.setPlanID(planID);
        ptProdTake.setFinishMan("");
        ptProdTake.setFinishTime(null);
        ptProdTake.setIsFinish(false);
        ptProdTake.setPlant(plant);
        int n = productionTaskService.updatebyplanid1(ptProdTake);

        Map json = new HashMap();

        json.put("num", n);
        return  json;
    }

}
