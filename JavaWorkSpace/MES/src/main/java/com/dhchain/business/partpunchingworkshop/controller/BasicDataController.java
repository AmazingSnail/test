package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.HeatTreatment.service.ProductionProcessService;
import com.dhchain.business.HeatTreatment.vo.MCraftmould;
import com.dhchain.business.partpunchingworkshop.service.BasicDataService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import com.dhchain.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/BasicData")
public class BasicDataController {
    @Autowired
    private BasicDataService basicDataService;
    @Autowired
    private ProductionProcessService productionProcessService;
    @ResponseBody
    @RequestMapping(value="/serach",method={RequestMethod.GET,RequestMethod.POST})
    public JSON Serach (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        List<BaseStatus> list = basicDataService.getStauts();

        JSONArray jslst = new JSONArray();
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                Map re = new HashMap();
                BaseStatus baseStatus ;
                baseStatus = list.get(i);
                String department = baseStatus.getStatusName();
                re.put("text",department);
                jslst.add(re);
            }
        }

        return jslst;

    }
    @ResponseBody
    @RequestMapping(value="/getDepartMent",method={RequestMethod.GET,RequestMethod.POST})
    public JSON GetDepartMent (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        JSONArray jslst = new JSONArray();
        List<BaseStatus> list  = basicDataService.getDepartMentH();
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
              BaseStatus baseStatus = list.get(i);
              String Fremark = baseStatus.getStatusID();
              String Fname = baseStatus.getStatusName();
              re.put("Fremark",Fremark);
              re.put("Fname",Fname);
                if(plant.equals(Fname)){
                    re.put("selected",true);
                }
                jslst.add(re);
            }
        }
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value="/serach1",method={RequestMethod.GET,RequestMethod.POST})
    public JSON Serach1 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        List<BaseStatus> list = basicDataService.getStauts1();
        JSONArray jslst = new JSONArray();
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                Map re = new HashMap();
                BaseStatus baseStatus ;
                baseStatus = list.get(i);
                String department = baseStatus.getStatusName();
                re.put("text",department);
                re.put("num",list.size());
                jslst.add(re);
            }
        }

        return jslst;

    }
    @ResponseBody
    @RequestMapping(value="/serachA",method={RequestMethod.GET,RequestMethod.POST})
    public JSON SerachA (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        List<BaseStatus> list = basicDataService.getStautsA();
        JSONArray jslst = new JSONArray();
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                Map re = new HashMap();
                BaseStatus baseStatus ;
                baseStatus = list.get(i);
                String department = baseStatus.getStatusName();
                re.put("text",department);
                re.put("num",list.size());
                jslst.add(re);
            }
        }

        return jslst;

    }
    @ResponseBody
    @RequestMapping(value = "/Fno",method={RequestMethod.GET,RequestMethod.POST})
    public Map Fno (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String fno = request.getParameter("fno");
        BaseFno baseFno = new BaseFno();
        baseFno.setFno(fno.trim());
        List<BaseFno> list = basicDataService.getFno(baseFno);
        if(list.size()>0){
            json.put("num",list.size());
        }else {
            json.put("num",0);
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value = "/MFno",method={RequestMethod.GET,RequestMethod.POST})
    public Map MFno (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String fno = request.getParameter("fno");
        BaseMaterial baseMaterial = new BaseMaterial();
        baseMaterial.setFno(fno.trim());
        List<BaseMaterial> list = basicDataService.getMFno(baseMaterial);
        if(list.size()>0){
            json.put("num",list.size());
        }else {
            json.put("num",0);
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value = "/MeterType",method={RequestMethod.GET,RequestMethod.POST})
    public JSON MeterType (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");

        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List<BaseSupplier> jslist = basicDataService.getMeterType();
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        JSONObject re1 = new JSONObject();
        JSONArray jslst = new JSONArray();
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++){
                Map re =  new HashMap();
                BaseSupplier baseSupplier;
                baseSupplier = jslist.get(i);
                String MeterType = baseSupplier.getFtemp1();
                re.put("MeterType",MeterType);
                jslst.add(re);
            }
        }
        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/Savefno",method={RequestMethod.GET,RequestMethod.POST})
    public Map Savefno (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String jfname = request.getParameter("jfname");
        String jfno = request.getParameter("jfno");
        String workcentre2 = request.getParameter("workcentre2");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String i = request.getParameter("i");
        String id = request.getParameter("id");
        System.out.println(id);
        BaseFno baseFno = new BaseFno();
        baseFno.setFno(fno);
        baseFno.setFname(fname);
        baseFno.setJobFno(jfno);
        baseFno.setJobFname(jfname);
        baseFno.setWorkcentre2(workcentre2);
        if("".equals(id)){
            baseFno.setInputMan(name);
            baseFno.setInputTime(time);
            int n = basicDataService.insertF(baseFno);
            if(n>0){
                json.put("num",n);
            }
        }else {
            baseFno.setID(Integer.parseInt(id));
            baseFno.setModifyMan(name);
            baseFno.setModifyTime(time);
            int n = basicDataService.updateF(baseFno);
            if(n>0){
                json.put("num",n);
            }
        }

        return  json;
    }
    @ResponseBody
    @RequestMapping(value = "/SaveM",method={RequestMethod.GET,RequestMethod.POST})
    public Map SaveM (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String workcentre5 = request.getParameter("workcentre5");
        String temp3 = request.getParameter("temp3");
        String temp4 = request.getParameter("temp4");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String i = request.getParameter("i");
        String id = request.getParameter("id");
        BaseMaterial baseMaterial = new BaseMaterial();
        baseMaterial.setFno(fno);
        baseMaterial.setFname(fname);
        baseMaterial.setWorkcentre5(workcentre5);
        baseMaterial.setFtemp3(temp3);
        baseMaterial.setFtemp4(temp4);
        System.out.println(id);
        if("".equals(id)){
            baseMaterial.setInputMan(name);
            baseMaterial.setInputTime(time);
            int n = basicDataService.insertM(baseMaterial);
            if(n>0){
                json.put("num",n);
            }
        }else {
            baseMaterial.setModifyMan(name);
            baseMaterial.setModifyTime(time);
            baseMaterial.setID(Integer.parseInt(id));
            int n = basicDataService.updateM(baseMaterial);
            if(n>0){
                json.put("num",n);
            }
        }

        return  json;
    }
    @ResponseBody
    @RequestMapping(value = "/SaveaS",method={RequestMethod.GET,RequestMethod.POST})
    public Map SaveaS (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String MeterType = request.getParameter("MeterType");
        String supper = request.getParameter("supper");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String i = request.getParameter("i");
        String id = request.getParameter("id");
        BaseSupplier baseSupplier = new BaseSupplier();
        baseSupplier.setMeterType(MeterType);
        baseSupplier.setSupplier(supper);
        if("".equals(id)){
            baseSupplier.setInputMan(name);
            baseSupplier.setInputTime(time);
            int n = basicDataService.insertS(baseSupplier);
            if(n>0){
                json.put("num",n);
            }
        }else {
            baseSupplier.setID(Integer.parseInt(id));
            baseSupplier.setModifyMan(name);
            baseSupplier.setModifyTime(time);
            int n = basicDataService.updateS(baseSupplier);
            if(n>0){
                json.put("num",n);
            }
        }

        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
    public Map query (HttpServletRequest request) throws UnsupportedEncodingException {
         request.setCharacterEncoding("utf-8");
         String name = request.getParameter("name");
         String plant = request.getParameter("plant");
         Map json = new HashMap();
         if(name.equals("检验标准")){
             List<BaseChkStd> list = basicDataService.getList();
             if(list.size()>0){
                 json.put("rows",list);
                 json.put("total",list.size());
             }
         }else if(name.equals("产能表")){
             List<BaseCapacity> list = basicDataService.getList1();
             if(list.size()>0){
                 json.put("rows",list);
                 json.put("total",list.size());
             }
         }else if(name.equals("设备表")){
             List<BaseEquip> list = basicDataService.getList2();
             if(list.size()>0){
                 json.put("rows",list);
                 json.put("total",list.size());
             }
         }else if(name.equals("报工编码")){
             List<BaseFno> list = basicDataService.getList3();
             if(list.size()>0){
                 json.put("rows",list);
                 json.put("total",list.size());
             }
         }else if(name.equals("外购材料")){
             List<BaseMaterial> list = basicDataService.getList4();
             if(list.size()>0){
                 json.put("rows",list);
                 json.put("total",list.size());
             }
         }else if(name.equals("材料供方")){
             BaseSupplier baseSupplier = new BaseSupplier();
             baseSupplier.setPlant(plant);
             baseSupplier.setDepartment("零件车间");
             List<BaseSupplier> list = basicDataService.getList5(baseSupplier);
             if(list.size()>0){
                 json.put("rows",list);
                 json.put("total",list.size());
             }
         }
        return  json;

    }
    @ResponseBody
    @RequestMapping(value="/queryh",method={RequestMethod.GET,RequestMethod.POST})
    public Map Hquery (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String name = request.getParameter("name");
        String plant = request.getParameter("plant");
        Map json = new HashMap();
        if(name.equals("设备表")) {
            BaseEquip baseEquip = new BaseEquip() ;
            baseEquip.setEquipID(plant);
            List<BaseEquip> list = basicDataService.getListHE(baseEquip);
            if (list.size() > 0) {
                json.put("rows", list);
                json.put("total", list.size());
            }
        }
        if(name.equals("工艺模板")) {
            List<MCraftmould> list = basicDataService.getMould();//获取工艺模板数据
            if (list.size() > 0) {
                json.put("rows", list);
                json.put("total", list.size());
            }
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Insert",method={RequestMethod.GET,RequestMethod.POST})
    public Map Insert (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String PartDrawing = request.getParameter("PartDrawing");
        String PartName = request.getParameter("PartName");
        String HoleHD = request.getParameter("HoleHD");
        String Aperture = request.getParameter("Aperture");
        String HoleSite = request.getParameter("HoleSite");
        String Height = request.getParameter("Height");
        String Thickness = request.getParameter("Thickness");
        String Facade = request.getParameter("Facade");
        String Leuchtfeld = request.getParameter("Leuchtfeld");
        String i = request.getParameter("i");
        String id = request.getParameter("id");
        Map json = new HashMap();
            BaseChkStd baseChkStd = new BaseChkStd();
            baseChkStd.setPartDrawing(PartDrawing);
            baseChkStd.setPartName(PartName);
            baseChkStd.setHoleHD(HoleHD);
            baseChkStd.setAperture(Aperture);
            baseChkStd.setHoleSite(HoleSite);
            baseChkStd.setHeight(Height);
            baseChkStd.setThickness(Thickness);
            baseChkStd.setFacade(Facade);
            baseChkStd.setLeuchtfeld(Leuchtfeld);
            if("".equals(id)){
                baseChkStd.setInputMan(name);
                baseChkStd.setInputTime(time);
                int n = basicDataService.insert(baseChkStd);
                if(n>0){
                    json.put("num",n);
                }
            }else {
                baseChkStd.setID(Integer.parseInt(id));
                baseChkStd.setModifyMan(name);
                baseChkStd.setModifyTime(time);
                int n = basicDataService.update(baseChkStd);
                if(n>0){
                    json.put("num",n);
                }
            }




        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Insert1",method={RequestMethod.GET,RequestMethod.POST})
    public Map Insert1 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String Capacity = request.getParameter("Capacity");
        String i = request.getParameter("i");
        String id = request.getParameter("id");
        Map json = new HashMap();
         BaseCapacity baseCapacity = new BaseCapacity();
        baseCapacity.setFno(fno);
        baseCapacity.setFname(fname);
        baseCapacity.setCapacity(Capacity);
        baseCapacity.setWorkHours("18");
        if("".equals(id)){
            baseCapacity.setInputMan(name);
            baseCapacity.setInputTime(time);
            int n = basicDataService.insert1(baseCapacity);
            if(n>0){
                json.put("num",n);
            }
        }else {
            baseCapacity.setModifyMan(name);
            baseCapacity.setModifyTime(time);
            baseCapacity.setID(Integer.parseInt(id));
            int n = basicDataService.update1(baseCapacity);
            if(n>0){
                json.put("num",n);
            }
        }




        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/InsertEquip",method={RequestMethod.GET,RequestMethod.POST})
    public Map InsertEquip (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String EquipName = request.getParameter("EquipName");
        String EquipType = request.getParameter("EquipType");
        String EquipDHID = request.getParameter("EquipDHID");
        String Manufacturer = request.getParameter("Manufacturer");
        String DepartMent = request.getParameter("DepartMent");
        String plant = request.getParameter("plant");
        String IP = request.getParameter("ip");
        String IPNO = request.getParameter("ipno");
        String i = request.getParameter("i");
        String id = request.getParameter("id");
        Map json = new HashMap();
        BaseStatus baseStatus = new BaseStatus();
        baseStatus.setStatusName(DepartMent);
        BaseEquip baseEquip2 =  new BaseEquip();
        EQPStatus eqpStatus = new EQPStatus();
        List<BaseStatus> list = basicDataService.getStatusID(baseStatus);
        if(list.size()>0){
            BaseStatus baseStatus1 ;
            baseStatus1 = list.get(0);
            String a = baseStatus1.getStatusID();
            BaseEquip baseEquip = new BaseEquip();
            baseEquip.setEquipID(a);
            List<BaseEquip> list1 = basicDataService.getEquipID(baseEquip);
            if(list1.size()>0){
                BaseEquip baseEquip1;
                baseEquip1 = list1.get(0);
                String EquipID = baseEquip1.getEquipID();
                String b = EquipID.substring(2,5);
                int c = Integer.parseInt(b)+1;
                String newString = String.format("%03d", c);
                String EquipID1 = a + newString;
                baseEquip2.setEquipID(EquipID1);
                eqpStatus.setEquipID(EquipID1);
            }else {
                String EquipID1 = a + "001";
                baseEquip2.setEquipID(EquipID1);
                eqpStatus.setEquipID(EquipID1);
            }
        }
        baseEquip2.setPlant(plant);
        baseEquip2.setDepartMent(DepartMent);
        baseEquip2.setEquipDHID(EquipDHID);
        baseEquip2.setEquipName(EquipName);
        baseEquip2.setEquipType(EquipType);
        baseEquip2.setIP(IP);
        baseEquip2.setIPNO(IPNO);
        baseEquip2.setManufacturer(Manufacturer);
        if("".equals(id)){
        baseEquip2.setInputMan(name);
        baseEquip2.setInputTime(time);
        int n1 = basicDataService.insertEquip(baseEquip2);
        if(n1>0){
            eqpStatus.setEquipStatus("SB06");
            int n2 = basicDataService.insertEquipStatus(eqpStatus);
            json.put("num",n2);
        }
        }else {
            baseEquip2.setModifyMan(name);
            baseEquip2.setModifyTime(time);
            baseEquip2.setID(Integer.parseInt(id));
            int n1 = basicDataService.updateEquip(baseEquip2);
            if(n1>0){
                json.put("num",n1);
            }
        }

        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Deletedata",method = {RequestMethod.POST,RequestMethod.GET})
    public  Map Delete(HttpServletRequest request) throws  UnsupportedEncodingException{
        request.setCharacterEncoding("utf-8");
        String i= request.getParameter("i");
        String id =  request.getParameter("id");
        String EquipID =  request.getParameter("EquipID");
        Map json =  new HashMap();
        if(i.equals("检验标准")){
            BaseChkStd baseChkStd =  new BaseChkStd();
            baseChkStd.setID(Integer.parseInt(id));
            int n =basicDataService.delete(baseChkStd);

            if(n>0){
                json.put("num",n);
            }
        }else if(i.equals("产能表")){
            BaseCapacity baseCapacity =new BaseCapacity();
            baseCapacity.setID(Integer.parseInt(id));
            int n =basicDataService.delete1(baseCapacity);
            if(n>0){
                json.put("num",n);
            }
        }else if(i.equals("设备表")){
            BaseEquip baseEquip =new BaseEquip();
            EQPStatus eqpStatus = new EQPStatus();
            baseEquip.setID(Integer.parseInt(id));

            int n =basicDataService.delete2(baseEquip);

            if(n>0){
                if(!StringUtil.isEmpty(EquipID)){
                    eqpStatus.setEquipID(EquipID);
                    int n1 =basicDataService.delete3(eqpStatus);
                    if(n1>0){
                        json.put("num",n1);
                    }
                }

            }
        }else if(i.equals("报工编码")){
             BaseFno  baseFno =  new BaseFno();
             baseFno.setID(Integer.parseInt(id));
             int n  = basicDataService.deleteF(baseFno);
            if(n>0){
                json.put("num",n);
            }
        }else if(i.equals("外购材料")){
            BaseMaterial  baseMaterial =  new BaseMaterial();
            baseMaterial.setID(Integer.parseInt(id));
            int n  = basicDataService.deleteM(baseMaterial);
            if(n>0){
                json.put("num",n);
            }
        }else if(i.equals("材料供方")){
            BaseSupplier  baseSupplier =  new BaseSupplier();
            baseSupplier.setID(Integer.parseInt(id));
            int n  = basicDataService.deleteS(baseSupplier);
            if(n>0){
                json.put("num",n);
            }
        }else if(i.equals("工艺模板")){
            MCraftmould mCraftmould = new MCraftmould();
            mCraftmould.setId(Integer.parseInt(id));
            int n =  basicDataService.deleteMould(mCraftmould);
            if(n>0){
                json.put("num",n);
            }
        }

        return json;
    }
}
