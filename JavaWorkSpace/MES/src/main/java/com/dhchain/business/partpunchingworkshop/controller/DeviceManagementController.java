package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.HeatTreatment.vo.MEqpheatstatus;
import com.dhchain.business.partpunchingworkshop.service.BasicDataService;
import com.dhchain.business.partpunchingworkshop.service.DeviceManagementService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/DeviceManagement")
public class DeviceManagementController {
    @Autowired
    private DeviceManagementService deviceManagementService;
    @Autowired
    private BasicDataService basicDataService;

    @RequestMapping(value="/upload",method={RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String upload(MultipartFile file, HttpServletRequest request) throws IOException{
        request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("ID");
        String path = "D:\\apache-tomcat-7.0.72-windows-x64\\webapps\\LJMES\\v-1.0.0-zh_CN-\\LJMES\\img";
        String fileName = file.getOriginalFilename();
        BaseUser baseUser = new BaseUser();
        baseUser.setID(Integer.parseInt(ids));
        String s  = "$UI/LJMES/img/" + fileName;
        File dir = new File(path,fileName);
        baseUser.setImgSrc(s);
        baseUser.setImgName(fileName);
        int n = deviceManagementService.updateUser(baseUser);
        if(!dir.exists()){
            dir.mkdirs();
        }
        //MultipartFile自带的解析方法
        file.transferTo(dir);
        return "ok!";
    }



    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
    public JSON query (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant1= request.getParameter("param1");
        String plant =  new String(plant1.getBytes("ISO-8859-1"),"UTF-8");//不要提交代码
        BaseEquip baseEquip =new BaseEquip();
        baseEquip.setPlant(plant);
        List<BaseEquip> list = deviceManagementService.getdepartment(baseEquip);

        JSONArray jslst = new JSONArray();
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                Map re = new HashMap();
                BaseEquip baseEquip1 ;
                baseEquip1 = list.get(i);
                String department = baseEquip1.getDepartMent();
                re.put("text",department);
                jslst.add(re);
            }
        }

        return jslst;

    }
    @ResponseBody
    @RequestMapping(value="/query1",method={RequestMethod.GET,RequestMethod.POST})
    public JSON Query (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("param1");
        String plant1 =  new String(plant .getBytes("ISO-8859-1"),"UTF-8");
        BaseEquip baseEquip =new BaseEquip();
        baseEquip.setPlant(plant1);
        List<BaseEquip> list = deviceManagementService.getdepartment(baseEquip);

        JSONArray jslst = new JSONArray();
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                Map re = new HashMap();
                BaseEquip baseEquip1 ;
                baseEquip1 = list.get(i);
                String department = baseEquip1.getDepartMent();
                re.put("text",department);
                jslst.add(re);
            }
        }

        return jslst;

    }
    @ResponseBody
    @RequestMapping(value="/DeviceInfo",method={RequestMethod.GET,RequestMethod.POST})
    public JSON DeviceInfo (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String department = request.getParameter("department");
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        BaseEquip baseEquip =new BaseEquip();
        baseEquip.setPlant(plant);
        baseEquip.setDepartMent(department);
        List<BaseEquip> list = deviceManagementService.getInfo(baseEquip);
        JSONArray jslst = new JSONArray();
        Map re1 = new HashMap();
        int a = 0;
        int b = 0;
        int c = 0;
        int d = 0;
        int e = 0;
        int f = 0;
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                Map re = new HashMap();
                BaseEquip baseEquip1 ;
                baseEquip1 = list.get(i);
                int id = baseEquip1.getID();
                String EquipID = baseEquip1.getEquipID();
                EQPStatus eqpStatus = new EQPStatus();
                eqpStatus.setEquipID(EquipID);
                List<EQPStatus> list1 = deviceManagementService.getbyEquipID(eqpStatus);
                PTFinish ptFinish = new PTFinish();
                ptFinish.setEquipID(EquipID);
                ptFinish.setUmouth(Integer.parseInt(month));
                ptFinish.setUyear(Integer.parseInt(year));
                List<PTFinish> list4 = deviceManagementService.getEquipIDnum(ptFinish);
                String EquipStatus ="";
                String DatePower = "";
                String FactNum = "0.0";
                Double  sum = 0.0;
                if(list4.size()>0){
                  for(int j =0;j<list4.size();j++){
                      PTFinish ptFinish1 = list4.get(j);
                      sum = sum+ ptFinish1.getWeightNum();
                  }
                }
                FactNum = sum.toString();
                EQPPower eqpPower = new EQPPower();
                eqpPower.setEquipID(EquipID);
                List<EQPPower> list5 = deviceManagementService.getbyEquipIDD(eqpPower);
                if (list5.size()>0){
                    EQPPower eqpPower1 = list5.get(0);
                    FactNum = eqpPower1.getDatePower();
                }
                if(list1.size()>0){
                    EQPStatus eqpStatus1;
                    eqpStatus1 = list1.get(0);
                    EquipStatus = eqpStatus1.getEquipStatus();
                    if(EquipStatus.equals("SB01")){
                        a++;
                    }else if(EquipStatus.equals("SB02")){
                        b++;
                    }else if(EquipStatus.equals("SB03")){
                        c++;
                    }else if(EquipStatus.equals("SB04")){
                        d++;
                    }else if(EquipStatus.equals("SB05")){
                       e++;
                    }else if(EquipStatus.equals("SB06")){
                       f++;
                    }
                }
                BaseStatus baseStatus =  new BaseStatus();
                baseStatus.setStatusName(department);
                List<BaseStatus> list3 = basicDataService.getStatusID(baseStatus);
                List<EQPStatus> list2 = new ArrayList<>();
                if(list3.size()>0){
                    String bm;
                    BaseStatus baseStatus1 ;
                    baseStatus1 = list3.get(0);
                    bm = baseStatus1.getStatusID();
                    EQPStatus eqpStatus1 = new EQPStatus();
                    eqpStatus1.setEquipID(bm);
                     list2 = deviceManagementService.getSize(eqpStatus1);
                }


                re.put("id",id);
                re.put("EquipID",EquipID);
                re.put("EquipStatus",EquipStatus);
                re.put("DatePower",DatePower);
                re.put("FactNum",FactNum);
                re.put("num",list2.size());
                re.put("total",list.size());
                jslst.add(re);
            }
            re1.put("a",a);
            re1.put("b",b);
            re1.put("c",c);
            re1.put("d",d);
            re1.put("e",e);
            re1.put("f",f);
            jslst.add(re1);
        }

        return jslst;

    }
    @ResponseBody
    @RequestMapping(value="/DeviceInfoH",method={RequestMethod.GET,RequestMethod.POST})
    public JSON DeviceInfoH (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String department = request.getParameter("department");
        BaseEquip baseEquip =new BaseEquip();
        baseEquip.setPlant(plant);
        baseEquip.setDepartMent(department);
        List<BaseEquip> list = deviceManagementService.getInfo(baseEquip);
        JSONArray jslst = new JSONArray();
        Map re1 = new HashMap();
        int a = 0;
        int b = 0;
        int c = 0;
        int d = 0;
        int e = 0;
        int f = 0;
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                Map re = new HashMap();
                BaseEquip baseEquip1 ;
                baseEquip1 = list.get(i);
                int id = baseEquip1.getID();
                String EquipID = baseEquip1.getEquipID();
                MEqpheatstatus mEqpheatstatus = new MEqpheatstatus();
                mEqpheatstatus.setEquipid(EquipID);
                List<MEqpheatstatus> list1 = deviceManagementService.getbyEquipIDH(mEqpheatstatus);
                String EquipStatus ="";
                String quenchtemp3 = "";
                String tempertemp2 = "";
                String carpotential = "";
                String cooltemp = "";
                if(list1.size()>0){
                    MEqpheatstatus mEqpheatstatus1;
                    mEqpheatstatus1 = list1.get(0);
                    EquipStatus = mEqpheatstatus1.getEqstatus();
                    quenchtemp3 = mEqpheatstatus1.getQuenchtemp3();
                    tempertemp2  =mEqpheatstatus1.getTempertemp2();
                    carpotential  =mEqpheatstatus1.getCarpotential();
                    cooltemp  =mEqpheatstatus1.getCooltemp();
                    if(EquipStatus.equals("SB01")){
                        a++;
                    }else if(EquipStatus.equals("SB02")){
                        b++;
                    }else if(EquipStatus.equals("SB03")){
                        c++;
                    }else if(EquipStatus.equals("SB04")){
                        d++;
                    }else if(EquipStatus.equals("SB05")){
                       e++;
                    }else if(EquipStatus.equals("SB06")){
                       f++;
                    }
                }
                BaseStatus baseStatus =  new BaseStatus();
                baseStatus.setStatusName(department);
                List<BaseStatus> list3 = basicDataService.getStatusID(baseStatus);
                List<MEqpheatstatus> list2 = new ArrayList<>();
                if(list3.size()>0){
                    String bm;
                    BaseStatus baseStatus1 ;
                    baseStatus1 = list3.get(0);
                    bm = baseStatus1.getStatusID();
                    MEqpheatstatus mEqpheatstatus1 = new MEqpheatstatus();
                    mEqpheatstatus1.setEquipid(bm);
                     list2 = deviceManagementService.getSizeH(mEqpheatstatus1);
                }


                re.put("id",id);
                re.put("EquipID",EquipID);
                re.put("EquipStatus",EquipStatus);
                re.put("quenchtemp3",quenchtemp3);
                re.put("tempertemp2",tempertemp2);
                re.put("carpotential",carpotential);
                re.put("cooltemp",cooltemp);
                re.put("num",list2.size());
                re.put("total",list.size());
                jslst.add(re);
            }
            re1.put("a",a);
            re1.put("b",b);
            re1.put("c",c);
            re1.put("d",d);
            re1.put("e",e);
            re1.put("f",f);
            jslst.add(re1);
        }

        return jslst;

    }

    @ResponseBody
    @RequestMapping(value="/Search",method={RequestMethod.GET,RequestMethod.POST})
    public JSON Search (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant1 = request.getParameter("plant");
        List<BaseEquip> list = deviceManagementService.getplant();
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                BaseEquip baseEquip;
                baseEquip = list.get(i);
                String plant = baseEquip.getPlant();
                re.put("plant",plant);
                if(plant1.equals(plant)){
                    re.put("selected",true);
                }
                jslst.add(re);
            }
        }
        return jslst;
    }
}
