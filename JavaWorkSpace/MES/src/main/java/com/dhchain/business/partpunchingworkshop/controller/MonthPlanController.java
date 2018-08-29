package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.partpunchingworkshop.vo.*;
import com.dhchain.business.partpunchingworkshop.service.MonthPlanService;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.IntrospectionException;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/MonthPlan")
public class MonthPlanController {

    @Autowired
    private MonthPlanService monthPlanService;

    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
    public JSON query1(HttpServletRequest request) throws UnsupportedEncodingException {

        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List jslist = monthPlanService.queryplant();
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        Map json = new HashMap();
        String plant = request.getParameter("plant");
        JSONArray jslst = new JSONArray();
        Syb syb;
        if (jslist.size() > 0) {
            for (int i = 0; i < jslist.size(); i++) {

                Map re = new HashMap();
                syb = (Syb) jslist.get(i);
                String Fno = syb.getFno();
                String Fname = syb.getFname();
                String Fremark = syb.getFremark();
                re.put("Fno", Fno);
                re.put("Fname", Fname);
                re.put("Fremark", Fremark);
                if(plant.equals(Fname)){
                    re.put("selected",true);
                }
                jslst.add(re);
            }


        }
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value="/FindFname",method={RequestMethod.GET,RequestMethod.POST})
    public JSON FindFname(HttpServletRequest request) throws UnsupportedEncodingException {
             JSONArray re = new JSONArray();
             List<BaseStatus> list = monthPlanService.FindFname();
             if(list.size()>0){
                 for(int i = 0;i<list.size();i++){
                     Map re1 = new HashMap();
                     BaseStatus baseStatus = list.get(i);
                     String Statusname = baseStatus.getStatusName();
                     re1.put("Statusname",Statusname);
                     re.add(re1);
                 }
             }
             return  re;
    }
        @ResponseBody
    @RequestMapping(value="/Serach",method={RequestMethod.GET,RequestMethod.POST})
    public Map serach (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umonth");
        String plant = request.getParameter("plant");
        String fname = request.getParameter("fname");
        String WorkProcedure = request.getParameter("WorkProcedure");
        String fno = request.getParameter("fno");
        String PartDrawing = request.getParameter("PartDrawing");
        String PartName = request.getParameter("PartName");
        PTPlan ptPlan = new PTPlan();
        ptPlan.setUyear(Integer.parseInt(uyear));
        ptPlan.setUmouth(Integer.parseInt(umonth));
        ptPlan.setPlant(plant);
        ptPlan.setFname(fname.trim());
        ptPlan.setFno(fno.trim());
        ptPlan.setPartName(PartName);
        ptPlan.setWorkProcedure(WorkProcedure.trim());
        ptPlan.setPartDrawing(PartDrawing.trim());
        String state = request.getParameter("state");
        Map json = new HashMap();
        if(state.equals("3")){
            List<PTPlan> list = monthPlanService.selectByAllKey(ptPlan);
            JSONArray jslst = new JSONArray();
            if(list.size()>0)
            {
                json.put("rows", list);
                json.put("total", list.size());
            }else {
                json.put("rows", 0);
                json.put("total", 0);
            }
        }else if(state.equals("2")){
            List<PTPlan> list = monthPlanService.selectByAllKey(ptPlan);
            JSONArray jslst = new JSONArray();
            List<PTPlan> list1 = new ArrayList<>();
            if(list.size()>0)
            {
                for(int i =0;i<list.size();i++){
                    PTPlan ptPlan1;
                    ptPlan1 = list.get(i);
                    Float RemainNum = ptPlan1.getRemainNum();
                    if(RemainNum<=0){
                        list1.add(ptPlan1);
                    }
                }
                json.put("rows", list1);
                json.put("total", list1.size());
            }else {
                json.put("rows", 0);
                json.put("total", 0);
            }
        }else if(state.equals("1")){
            List<PTPlan> list = monthPlanService.selectByAllKey(ptPlan);
            JSONArray jslst = new JSONArray();
            List<PTPlan> list1 = new ArrayList<>();
            if(list.size()>0)
            {
                for(int i =0;i<list.size();i++){
                    PTPlan ptPlan1;
                    ptPlan1 = list.get(i);
                    Float RemainNum = ptPlan1.getRemainNum();
                    if(RemainNum>0){
                        list1.add(ptPlan1);
                    }
                }
                json.put("rows", list1);
                json.put("total", list1.size());
            }else {
                json.put("rows", 0);
                json.put("total", 0);
            }
        }else if(state.equals("4")){
            ptPlan.setIsSend("1");
            List<PTPlan> list = monthPlanService.selectByAllKey(ptPlan);
            if(list.size()>0){
            json.put("rows", list);
            json.put("total", list.size());
        }else {
            json.put("rows", 0);
            json.put("total", 0);
        }
        }else if(state.equals("5")){
            ptPlan.setIsSend("0");
            List<PTPlan> list = monthPlanService.selectByAllKey(ptPlan);
            if(list.size()>0){
                json.put("rows", list);
                json.put("total", list.size());
            }else {
                json.put("rows", 0);
                json.put("total", 0);
            }
        }
        return json;

    }

    @ResponseBody
    @RequestMapping(value="/finish",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject serach1 (HttpServletRequest request) throws UnsupportedEncodingException {
        String fno = request.getParameter("fno");
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umouth");
        Double num = Double.parseDouble(request.getParameter("num"));
        PTOrderPlan ptOrderPlan = new PTOrderPlan();
        ptOrderPlan.setFno(fno);
        ptOrderPlan.setUmouth(Integer.parseInt(umonth));
        ptOrderPlan.setUyear(Integer.parseInt(uyear));
        List<PTOrderPlan> list = monthPlanService.selectByfno(ptOrderPlan);
        JSONObject json = new JSONObject();
        Double s;
        Double sum =0.0;
        int j;
        List<PTOrderPlan> list1 = new ArrayList<>();
        List<PTOrderPlan> list2 = new ArrayList<>();
        PTOrderPlan ptOrderPlan1 = new PTOrderPlan();
        PTOrderPlan ptOrderPlan2 = new PTOrderPlan();
        if(list.size()>0)
        {
            for(int i =0;i<list.size();i++)
            {
                ptOrderPlan1 = list.get(i);
                s = Double.parseDouble(ptOrderPlan1.getPlanNum());
                sum = s+ sum;
                j= ptOrderPlan1.getID();
                if(num-s>=0){
                   // ptOrderPlan1.setFinish(true);
                    ptOrderPlan1.setID(j);
                    int n = monthPlanService.updateFinsh(ptOrderPlan1);//更新完成情况字段
                    List<PTOrderPlan> list3 = monthPlanService.selectByid(ptOrderPlan1);
                    if(list3.size()>0){
                        PTOrderPlan ptOrderPlan3 ;
                        ptOrderPlan3 = list3.get(0);
                        if(ptOrderPlan3.getIsFinish()!=null){
                            if(ptOrderPlan3.getIsFinish().equals("1")){
                                ptOrderPlan1.setOver("完成");
                            }else{
                                ptOrderPlan1.setOver("未完成");
                            }
                        }
                    }
                }
                num = num -s;


                list1.add(ptOrderPlan1);
            }
            Map r = new HashMap();
            r.put("orderLine","合计");
            r.put("planNum",sum);
            JSONArray jslst2 = new JSONArray();
            jslst2.add(r);
            json.put("rows",list1);
            json.put("total",list1.size());
            json.put("footer",jslst2);
        }
        return  json;

    }

    @ResponseBody
    @RequestMapping(value = "/delete",method = {RequestMethod.GET,RequestMethod.POST})
    public  Map Delete (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String id = request.getParameter("ids");
        PTOrderPlan ptOrderPlan = new PTOrderPlan();
        ptOrderPlan.setID(Integer.parseInt(id));
        int n =   monthPlanService.deleteid(ptOrderPlan);//返回文件名
        if(n>0){
            json.put("num",n);
        }else {
            json.put("num",-1);
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Send",method = {RequestMethod.GET,RequestMethod.POST})
    public  Map Send (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umonth");
        String plant = request.getParameter("plant");
        PTPlan ptPlan1 = new PTPlan();
        ptPlan1.setUyear(Integer.parseInt(uyear));
        ptPlan1.setUmouth(Integer.parseInt(umonth));
        ptPlan1.setPlant(plant);
        List<PTPlan> LIST  = monthPlanService.getAll(ptPlan1);
        if(LIST.size()>0){
            for(int m = 0;m<LIST.size();m++){
                PTPlan ptPlan3 ;
                ptPlan3 = LIST.get(m);
                int ptid = ptPlan3.getID();
                String fno = ptPlan3.getFno();
                PTPlan ptPlan = new PTPlan();
                ptPlan.setID(ptid);
                ptPlan.setFno(fno);
                BaseCapacity baseCapacity = new BaseCapacity();
                baseCapacity.setFno(fno);
                List<BaseCapacity> list = monthPlanService.getCapacity(baseCapacity);
                int n =0;//产能标识
                int i = 0;//检验标准标识
                int j = 0;//文档标识
                int c = 0;//对应标识
                if(list.size()>0){
                    n=1;
                    ptPlan.setCapacity("1");
                }
                DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
                List<BaseCapacity> jslist = monthPlanService.getFtemp2(baseCapacity);
                DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
                BaseCapacity baseCapacity1;
                if(list.size()>0){
                    baseCapacity1 = jslist.get(0);
                    String PartDrawing = baseCapacity1.getFtemp2();
                    CraftFile craftFile = new CraftFile();
                    craftFile.setPartDrawing(PartDrawing);
                    List<CraftFile> list1 = monthPlanService.getCraftFile(craftFile);//查询文档是否存在
                    if(list1.size()>0){
                        j = 1;
                        ptPlan.setCraftFile("1");
                    }
                    BaseChkStd baseChkStd = new BaseChkStd();
                    baseChkStd.setPartDrawing(PartDrawing);
                    List<BaseChkStd> list2 = monthPlanService.getBaseChkStd(baseChkStd);//查询检验标准是否存在
                    if(list2.size()>0){
                        i = 1 ;
                        ptPlan.setChkStd("1");
                    }
                    PTOrderPlan ptOrderPlan = new PTOrderPlan();
                    ptOrderPlan.setFno(fno);
                    DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
                    List<PTOrderPlan> list3 = monthPlanService.selectByFno1(ptOrderPlan);//合同计划
                    DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
                    if(list3.size()>0){
                        c=1;
                        ptPlan.setOrderPlan("1");
                    }
                    if(n>0&&j>0&&i>0){
                        ptPlan.setIsSend("1");
                    }
                }

                int s = monthPlanService.updatePlan(ptPlan);
                if(s>0){
                    json.put("num",s);
                }else {
                    json.put("num",-1);
                }
            }
        }

        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/delete1",method = {RequestMethod.GET,RequestMethod.POST})
    public  Map Delete1 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String id = request.getParameter("ids");
        PTPlan ptPlan = new PTPlan();
        ptPlan.setID(Integer.parseInt(id));
        int n =   monthPlanService.deleteid1(ptPlan);
        if(n>0){
            json.put("num",n);
        }else {
            json.put("num",-1);
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/Serach2",method={RequestMethod.GET,RequestMethod.POST})
    public Map serach2 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umonth");
        String plant = request.getParameter("plant");
        String fname = request.getParameter("fname");
        String WorkCentre = request.getParameter("WorkCentre");
        String fno = request.getParameter("fno");
        String OrderLine = request.getParameter("OrderLine");
        PTOrderPlan ptOrderPlan = new PTOrderPlan();
        ptOrderPlan.setUyear(Integer.parseInt(uyear));
        ptOrderPlan.setUmouth(Integer.parseInt(umonth));
        ptOrderPlan.setPlant(plant);
        ptOrderPlan.setFno(fno.trim());
        ptOrderPlan.setFname(fname.trim());
        ptOrderPlan.setWorkCentre(WorkCentre.trim());
        ptOrderPlan.setOrderLine(OrderLine.trim());
        String state = request.getParameter("state");
        Map json = new HashMap();
        if(state.equals("1")){
            ptOrderPlan.setIsFinish("1");
        }else if(state.equals("2")){
            ptOrderPlan.setIsFinish("0");
        }else {

        }
        List<PTOrderPlan> list1 = new ArrayList<>();
        List<PTOrderPlan> list2 = new ArrayList<>();
        List<PTOrderPlan> list3 = new ArrayList<>();
        List<PTOrderPlan> list = monthPlanService.selectptOrderPlan(ptOrderPlan);

        JSONArray jslst = new JSONArray();
        PTOrderPlan ptOrderPlan1 = new PTOrderPlan();
        if(list.size()>0)
            {
                for(int i =0;i<list.size();i++) {
                    ptOrderPlan1 = list.get(i);
                    if (ptOrderPlan1.getIsFinish() != null) {
                        System.out.println(ptOrderPlan1.getIsFinish());
                        if (ptOrderPlan1.getIsFinish().equals("1")) {
                            ptOrderPlan1.setOver("完成");
                        } else {
                            ptOrderPlan1.setOver("未完成");
                        }
                    }
                    list1.add(ptOrderPlan1);
                    json.put("rows", list1);
                    json.put("total", list1.size());
                }

            }else {

                json.put("rows", 0);
                json.put("total", 0);
            }


        return json;

    }
    @ResponseBody
    @RequestMapping(value="/import",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject impotr(HttpServletRequest request, @RequestParam(value = "uploadFile", required = false) MultipartFile file) throws Exception {
        //获取上传的文件
        String User =request.getParameter("User");
        Integer year  =Integer.parseInt(request.getParameter("year"));
        Integer  month=Integer.parseInt(request.getParameter("month"));
        String plant = request.getParameter("plant");
        String time = request.getParameter("time");
        MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
        MultipartFile file1 = multipart.getFile("uploadFile");
        InputStream in = file1.getInputStream();
        //数据导入
        String  back = monthPlanService.importExcelInfo1(in,file,User,month,year,plant,time);
//        in.close();
        JSONObject re = new JSONObject();
        if(back.equals("OK")){
            re.put("success","true");
            re.put("message","导入成功");
        }else
        {
            re.put("success", "false");
            re.put("message", back);
        }
        return  re;
    }

    @ResponseBody
    @RequestMapping(value="/contract",method={RequestMethod.GET,RequestMethod.POST})
    public Map Contract (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umonth");
        String plant = request.getParameter("plant");
        String fname = request.getParameter("fname");
        String WorkProcedure = request.getParameter("WorkProcedure");
        String fno = request.getParameter("fno");
        String PartDrawing = request.getParameter("PartDrawing");
        String PartName = request.getParameter("PartName");
        PTPlan ptPlan = new PTPlan();
        ptPlan.setUyear(Integer.parseInt(uyear));
        ptPlan.setUmouth(Integer.parseInt(umonth));
        ptPlan.setPlant(plant);
        ptPlan.setFname(fname.trim());
        ptPlan.setFno(fno.trim());
        ptPlan.setPartName(PartName);
        ptPlan.setWorkProcedure(WorkProcedure.trim());
        ptPlan.setPartDrawing(PartDrawing.trim());
        int a = 0;
        Map json = new HashMap();
            List<PTPlan> list = monthPlanService.selectByAllKey(ptPlan);
            JSONArray jslst = new JSONArray();
            if(list.size()>0)
            {
                for(int i = 0 ;i<list.size();i++){
                    PTPlan ptPlan1 ;
                    ptPlan1 = list.get(i);
                    String fno1 = ptPlan1.getFno();
                    int umouth1 = ptPlan1.getUmouth();
                    int uyear1 = ptPlan1.getUyear();
                    String plant1 = ptPlan1.getPlant();
                    //Double num = Double.parseDouble(request.getParameter("num"));
                    PTOrderPlan ptOrderPlan4 = new PTOrderPlan();
                    ptOrderPlan4.setFno(fno1);
                    ptOrderPlan4.setUyear(uyear1);
                    ptOrderPlan4.setUmouth(umouth1);
                    ptOrderPlan4.setPlant(plant1);
                    int n2 = monthPlanService.updateALLfinish(ptOrderPlan4);
                    if(n2>0){
                        a++;
                    }
                }

            }
        json.put("num",a);



        return  json;
    }

}
