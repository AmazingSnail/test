package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.partpunchingworkshop.service.MissionIssuedService;
import com.dhchain.business.partpunchingworkshop.service.MonthPlanService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/MissionIssued")
public class MissionIssuedController {
    @Autowired
    private MonthPlanService monthPlanService;
    @Autowired
    private MissionIssuedService missionIssuedService;

    @ResponseBody
    @RequestMapping(value = "/query", method = {RequestMethod.GET, RequestMethod.POST})
    public Map Query(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String uyear = request.getParameter("uyear");//年
        String umonth = request.getParameter("umonth");//月
        String plant = request.getParameter("plant");//事业部
        String partname = request.getParameter("partname");//工序名称
        String PartDrawing = request.getParameter("PartDrawing");//零件规格
        String WorkProcedure = request.getParameter("WorkProcedure");//工序名称
        String fno = request.getParameter("fno");//工序名称
        PTPlan ptPlan = new PTPlan();
        ptPlan.setUyear(Integer.parseInt(uyear));
        ptPlan.setUmouth(Integer.parseInt(umonth));
        ptPlan.setPlant(plant);
        ptPlan.setPartName(partname);
        ptPlan.setPartDrawing(PartDrawing);
        ptPlan.setWorkProcedure(WorkProcedure);
        ptPlan.setFno(fno);
        ptPlan.setIsSend("1");
        Map json = new HashMap();
        List<PTPlan> list = monthPlanService.selectByAllKey(ptPlan);
        if (list.size() > 0) {
            json.put("rows", list);
            json.put("total", list.size());
        }
        return json;

    }

    @ResponseBody
    @RequestMapping(value = "/query1", method = {RequestMethod.GET, RequestMethod.POST})
    public Map Query1(HttpServletRequest request) throws UnsupportedEncodingException {


        List<PTProdTake> list = missionIssuedService.getTodaydate();
        Map json = new HashMap();
        List<PTProdTake> list1 = new ArrayList<>();
        if (list.size() > 0) {
          for(int i =0; i<list.size();i++){
            PTProdTake ptProdTake ;
            ptProdTake = list.get(i);
            if(ptProdTake.getStatus().equals("SC01")){
                ptProdTake.setProcess("计划中");
            }else if(ptProdTake.getStatus().equals("SC02")){
                ptProdTake.setProcess("生产中");
            }else if(ptProdTake.getStatus().equals("SC03")){
                ptProdTake.setProcess("已完成");
            }
            list1.add(ptProdTake);
          }
            json.put("rows", list1);
            json.put("total", list1.size());
        }
        return json;

    }

    @ResponseBody
    @RequestMapping(value = "/GetEquipID", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON GetEquipID(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String departMent = request.getParameter("departMent");
        BaseEquip baseEquip = new BaseEquip();
        baseEquip.setPlant(plant);
        baseEquip.setDepartMent(departMent);
        List<BaseEquip> list = missionIssuedService.getEquipID(baseEquip);
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                BaseEquip baseEquip1;
                baseEquip1 = list.get(i);
                String EquipID1 = baseEquip1.getEquipID();
                String EquipName = baseEquip1.getEquipName();
                String EquipID = EquipID1 +"-" + EquipName;
                re.put("equipID", EquipID);
                jslst.add(re);
            }
        }
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/GetMouldID", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON GetMouldID(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String partDrawing = request.getParameter("partDrawing");
        String plant = request.getParameter("plant");
        String departMent = request.getParameter("departMent");
        MoldStore moldStore = new MoldStore();
        moldStore.setPlant(plant);
        moldStore.setDepartMent(departMent);
        moldStore.setPartDrawing(partDrawing);
        List<MoldStore> list = missionIssuedService.GetMouldID(moldStore);
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                MoldStore moldStore1;
                moldStore1 = list.get(i);
                String MouldID = moldStore1.getMouldID();
                String MouldName = moldStore1.getMouldName();
                String moudIdname = MouldID+"-"+MouldName;
                re.put("mouldID", moudIdname);
                jslst.add(re);
            }
        }
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/GetproductMan", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON GetproductMan(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String equipID1 = request.getParameter("equipID");
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        if(equipID1!=null){
            String [] str = equipID1.split("-");
            String equipID = str[0];
            BaseUser baseUser = new BaseUser();
            baseUser.setEquipID(equipID);
            List<BaseUser> list = missionIssuedService.GetproductMan(baseUser);

            if (list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    Map re = new HashMap();
                    BaseUser baseUser1;
                    baseUser1 = list.get(i);
                    String productMan = baseUser1.getWorkMan();
                    re.put("productMan", productMan);
                    jslst.add(re);
                }
            }
        }

        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/GetCapacity", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON GetCapacity(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("fno");
        BaseCapacity baseCapacity = new BaseCapacity();
        baseCapacity.setFno(fno);
        List<BaseCapacity> list = missionIssuedService.GetCapacity(baseCapacity);
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                BaseCapacity baseCapacity1;
                baseCapacity1 = list.get(i);
                String Capacity = baseCapacity1.getCapacity();
                re.put("capacity", Capacity);
                jslst.add(re);
            }
        }
        return jslst;
    }

    @ResponseBody
    @RequestMapping(value = "/insertTake", method = {RequestMethod.GET, RequestMethod.POST})
    public Map  InsertTake(HttpServletRequest request) throws UnsupportedEncodingException, ParseException {
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("fno");
        String plant = request.getParameter("plant");
        String partDrawing = request.getParameter("partDrawing");
        String partName = request.getParameter("partName");
        String WorkCentre = request.getParameter("workCentre");
        String equipID1 = request.getParameter("equipID");
        String[]  strs1=equipID1.split("-");
        String mouldID1 = request.getParameter("mouldID");
        String[]  strs=mouldID1.split("-");
        String ids = request.getParameter("ids");
        String mouldID = strs[0];
        String equipID = strs1[0];
        String equipName = strs1[1];
         String productMan = request.getParameter("productMan");
        String productNum = request.getParameter("productNum");
        String ordertime1 = request.getParameter("orderTime");
        DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
        Date ordertime2 =  format1.parse(ordertime1);
        System.out.println(ordertime2);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String ordertime = formatter.format(ordertime2);
        String capacity = request.getParameter("capacity");
        String fname = request.getParameter("fname");
        String departMent = request.getParameter("departMent");
        String inputdate = request.getParameter("inputdate");
        String beginman = request.getParameter("beginman");
        String uyear = request.getParameter("uyear");
        String umonth =request.getParameter("umonth");
        PTProdTake ptProdTake = new PTProdTake();
        PTProdTake ptProdTake1 = new PTProdTake();
        ptProdTake1.setUyear(uyear);
        ptProdTake1.setUmouth(umonth);
        List<PTProdTake> list = missionIssuedService.getSerialno(ptProdTake1);
        String planid;
        String id;
        String a;
        String b;
        int  id1;
        String month;
        if(list.size()>0){
            PTProdTake ptProdTake2;
            ptProdTake2 = list.get(0);
            id = ptProdTake2.getPlanID();//C318030002
            id1 = Integer.parseInt(id.substring(6,10));
            a = id.substring(0,6);
            id1 = id1 +1;
            b =   String.format("%04d",id1);
            planid = a + b;
            System.out.println(planid);
        }else{
            int month1 = Integer.parseInt(umonth);
            month =   String.format("%02d",month1);
            planid = "C3"+uyear.substring(2,4)+month+"0001";
        }
        ptProdTake.setPlanID(planid);
        ptProdTake.setFno(fno);
        ptProdTake.setFname(fname);
        ptProdTake.setPlant(plant);
        ptProdTake.setPartDrawing(partDrawing);
        ptProdTake.setEquipID(equipID);
        ptProdTake.setMouldID(mouldID);
        ptProdTake.setProductMan(productMan);
        ptProdTake.setOrderTime(ordertime);
        ptProdTake.setPartName(partName);
        ptProdTake.setProductNum(Float.valueOf(productNum));
        ptProdTake.setCapacity(capacity);
        ptProdTake.setDepartMent(departMent);
        ptProdTake.setInputMan(beginman);
        ptProdTake.setInputDate(inputdate);
        ptProdTake.setUmouth(umonth);
        ptProdTake.setFinishNum(0.0);
        ptProdTake.setRealFinishNum(0.0);
        ptProdTake.setUyear(uyear);
        ptProdTake.setStatus("SC01");
        ptProdTake.setLocaFinish(false);
        ptProdTake.setQualRatio(0.0);
        ptProdTake.setCompRatio(0.0);
        ptProdTake.setIsFinish(false);
        ptProdTake.setWorkCentre(WorkCentre);
        int n = missionIssuedService.insertTake(ptProdTake);
        Map json = new HashMap();

        json.put("num", n);
        return  json;
    }
    @ResponseBody
    @RequestMapping(value = "/deleteTake", method = {RequestMethod.GET, RequestMethod.POST})
    public Map DeleteTake(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("fno");
        String id = request.getParameter("id");
        String productNum = request.getParameter("productNum");
        PTProdTake ptProdTake = new PTProdTake();
        ptProdTake.setID(Integer.parseInt(id));
        int n = missionIssuedService.deleteTake(ptProdTake);
        Map json = new HashMap();
        json.put("num", n);
        return  json;
    }
}
