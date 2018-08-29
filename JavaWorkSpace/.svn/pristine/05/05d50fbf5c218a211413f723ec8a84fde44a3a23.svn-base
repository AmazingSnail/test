package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.partpunchingworkshop.service.MouldManageService;
import com.dhchain.business.partpunchingworkshop.service.PersonnelMaintenanceService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
@RequestMapping(value = "/MouldManage")
public class MouldMangagementController {
    @Autowired
    private MouldManageService mouldMangageService;
    @Autowired
    private PersonnelMaintenanceService personnelMaintenanceService;
    @ResponseBody
    @RequestMapping(value="/Query",method={RequestMethod.GET,RequestMethod.POST})
    public JSON query (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String user = request.getParameter("username");
        BaseUser baseUser = new BaseUser();
        baseUser.setPlant(plant);
        baseUser.setUserName(user);
        List<BaseUser> list1 = mouldMangageService.getDepartment(baseUser);
        String  Department = "";
        if(list1.size()>0){
            BaseUser baseUser1 = list1.get(0);
            Department = baseUser1.getDepartMent();
        }
        List<BaseStatus> list =  personnelMaintenanceService.getDepartment();
        JSONArray jslst = new JSONArray();
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                BaseStatus baseStatus = list.get(i);
                String department = baseStatus.getStatusName();
                re.put("DepartMent", department);
                if(Department.equals(department)){
                    re.put("selected",true);
                }
                jslst.add(re);
            }
        }
        return  jslst;

    }
    @ResponseBody
    @RequestMapping(value="/Query1",method={RequestMethod.GET,RequestMethod.POST})
    public JSON query1 (HttpServletRequest request) throws UnsupportedEncodingException {
        List<BaseStatus> list = mouldMangageService.selectByNwx();
        JSONArray jslst = new JSONArray();
        BaseStatus baseStatus1;
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                baseStatus1 = list.get(i);
                String StatusName = baseStatus1.getStatusName();
                re.put("StatusName",StatusName);
                jslst.add(re);
            }
        }
        return  jslst;

    }
    @ResponseBody
    @RequestMapping(value = "/updateMould",method={RequestMethod.GET,RequestMethod.POST})
    public Map UpdateMould (HttpServletRequest request) throws UnsupportedEncodingException{
        String time = request.getParameter("time");
        String temple = request.getParameter("temple");
        String partDrawing = request.getParameter("partDrawing");
        String number = request.getParameter("number");
        String name = request.getParameter("name");
        String department = request.getParameter("department");
        String MouldID = request.getParameter("MouldID");
        String fname = request.getParameter("fname");
        String location = request.getParameter("location");
        String Tonnage = request.getParameter("Tonnage");
        String id = request.getParameter("id");
        MoldStore moldStore = new MoldStore();
        moldStore.setRemark(temple);
        moldStore.setInputDate(time);
        moldStore.setInputMan(name);
        moldStore.setMouldID(MouldID);
        moldStore.setMouldName(fname);
        moldStore.setPartDrawing(partDrawing);
        moldStore.setDepartMent(department);
        moldStore.setLocation(location);
        moldStore.setTonnage(Tonnage);
        moldStore.setNunber(number);
        moldStore.setID(Integer.parseInt(id));
        int n = mouldMangageService.updateMould(moldStore);//更新修改信息
        Map json = new HashMap();
        if(n>0){
            json.put("num",n);
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value="/Search",method={RequestMethod.GET,RequestMethod.POST})
    public Map query2 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umonth");
        String plant = request.getParameter("plant");
        String MouldID = request.getParameter("MouldID");
        String Tonnage = request.getParameter("Tonnage");
        String MouldName = request.getParameter("MouldName");
        String Location = request.getParameter("Location") ;
        String nwx = request.getParameter("nwx") ;
        String department = request.getParameter("department") ;
        MoldStore moldStore =  new MoldStore();
        moldStore.setDepartMent(department);
        moldStore.setPlant(plant);
        moldStore.setMouldID(MouldID);
        moldStore.setTonnage(Tonnage);
        moldStore.setMouldName(MouldName);
        moldStore.setLocation(Location);
        moldStore.setStatusName(nwx);
        List<MoldStore> list = mouldMangageService.selectAll(moldStore);
        Map json =new HashMap();
        List<MoldStore> list2 = new ArrayList();
        if(list.size()>0){
            for(int i = 0 ;i<list.size();i++){
                MoldStore moldStore1;
                moldStore1 = list.get(i);
                String a = moldStore1.getMouldID();
                MoldReplace moldReplace = new MoldReplace();
                moldReplace.setMoldID(a);
                List<MoldReplace> list1 = mouldMangageService.selecttime(moldReplace);

                String b;
                if(list1.size()>0){for(int j =0;j<list1.size();j++){
                    MoldReplace moldReplace1 ;
                    moldReplace1 = list1.get(0);
                    b = moldReplace1.getMoldRpBegTime();
                    moldStore1.setMoldRpBegTime(b);
                }
                }
                list2.add(moldStore1);
            }
            json.put("rows",list2);
            json.put("total",list2.size());
        }
         return  json;

    }
    @ResponseBody
    @RequestMapping(value = "/InsertMoldStore",method={RequestMethod.GET,RequestMethod.POST})
    public Map InsertMoldStore(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String time = request.getParameter("time");
        String uyear = request.getParameter("year");
        String year = uyear.substring(2,4);
        String umonth = request.getParameter("month");
        String Infname = request.getParameter("Infname");
        String Inlocation = request.getParameter("Inlocation");
        String InTonnage = request.getParameter("InTonnage");
        String number =  request.getParameter("number");
        String temple =  request.getParameter("temple");
        String plant = request.getParameter("plant");
        String  department = request.getParameter("department");
        String name = request.getParameter("name");
        String partDrawing = request.getParameter("partDrawing");
        String takekind = request.getParameter("takekind");
        MoldStore moldStore =  new MoldStore();
        String m ;
        int month = Integer.parseInt(umonth);
         m =   String.format("%02d",month);
        String a = "C3"+year+m;
        System.out.println(a);
        moldStore.setMouldID(a);
        List<MoldStore> list = mouldMangageService.selectbymouldid(moldStore);
        String mouldid;
        String id;
        String c;
        String b;
        int  id1;
       if(list.size()>0){
           MoldStore moldStore1 ;
           moldStore1 = list.get(0);
           mouldid = moldStore1.getMouldID();//C318030002
           id1 = Integer.parseInt(mouldid.substring(6,9));
           c = mouldid.substring(0,6);
           id1 = id1 +1;
           b =   String.format("%03d",id1);
           id = c + b;
           System.out.println(id);

       }else {
           id = a+"001";
       }
       moldStore.setMouldID(id);
       moldStore.setMouldName(Infname);
       moldStore.setPartDrawing(partDrawing);
       moldStore.setInputDate(time);
       moldStore.setInputMan(name);
       moldStore.setLocation(Inlocation);
       moldStore.setTonnage(InTonnage);
       moldStore.setNunber(number);
       moldStore.setRemark(temple);
       moldStore.setPlant(plant);
       moldStore.setDepartMent(department);
       moldStore.setStatus("MJ01");
       int n = mouldMangageService.insertMoldStore(moldStore);
        MoldInput moldInput = new MoldInput();
        moldInput.setMouldID(id);
        moldInput.setInputDate(time);
        moldInput.setInputMan(name);
        moldInput.setInputTypes(takekind);
        moldInput.setRemark(temple);
        moldInput.setLocation(Inlocation);
        int n1 = mouldMangageService.insertMoldInput(moldInput);
       Map json = new HashMap();
       json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/look",method={RequestMethod.GET,RequestMethod.POST})
    public Map Look(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");

        String fno = request.getParameter("partDrawing");
        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List<MoldStore> jslist = mouldMangageService.querypartDrawing(fno);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        Map json =  new HashMap();
        JSONObject re1 = new JSONObject();
        if(jslist.size()>0){
            for(int i = 0 ;i<jslist.size();i++){
                MoldStore moldStore;
                moldStore = jslist.get(0);
                String projectname = moldStore.getFtemp3();//图号名称
                String project = moldStore.getFtemp2();//图号
                re1.put("projectname",projectname);
                re1.put("project",project);
                re1.put("num",jslist.size());
            }
            return re1;
        }else {
            json.put("num",-1);
            return json;
        }

    }
    @ResponseBody
    @RequestMapping(value = "/LookSame",method={RequestMethod.GET,RequestMethod.POST})
    public Map LookSame(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");

        String Ftemp2 = request.getParameter("partDrawing");
        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List<MoldStore> jslist = mouldMangageService.querypartDrawing1(Ftemp2);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        Map json =  new HashMap();
        JSONObject re1 = new JSONObject();
        if(jslist.size()>0){
            for(int i = 0 ;i<jslist.size();i++){
                MoldStore moldStore;
                moldStore = jslist.get(0);
                String projectname = moldStore.getFtemp3();//图号名称
                re1.put("projectname",projectname);
                re1.put("num",jslist.size());
            }
            return re1;
        }else {
            json.put("num",-1);
            return json;
        }

    }
    @ResponseBody
    @RequestMapping(value = "/look2",method={RequestMethod.GET,RequestMethod.POST})
    public Map Look2(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("fno");
        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List<BaseCapacity> jslist = mouldMangageService.queryfno(fno.trim());
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        Map json =  new HashMap();
        JSONObject re1 = new JSONObject();
        if(jslist.size()>0){
            for(int i = 0 ;i<jslist.size();i++){
                BaseCapacity baseCapacity;
                baseCapacity = jslist.get(0);
                String fname = baseCapacity.getFname();
                String workcentre2 = baseCapacity.getWorkcentre2();
                String workcentre5 = baseCapacity.getWorkcentre5();
                String ftemp3 = baseCapacity.getFtemp3();
                String ftemp4 = baseCapacity.getFtemp4();
                re1.put("fname",fname);
                re1.put("workcentre2",workcentre2);
                re1.put("workcentre5",workcentre5);
                re1.put("ftemp3",ftemp3);
                re1.put("ftemp4",ftemp4);
                re1.put("num",jslist.size());
            }
            return re1;
        }else {
            json.put("num",-1);
            return json;
        }

    }
    @ResponseBody
    @RequestMapping(value = "/look1",method={RequestMethod.GET,RequestMethod.POST})
    public Map Look1(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String MouldID1 = request.getParameter("MouldID");
        List<MoldStore> jslist = mouldMangageService.queryMouldID1(MouldID1);
        Map json =  new HashMap();
        JSONObject re1 = new JSONObject();
        if(jslist.size()>0){
            for(int i = 0 ;i<jslist.size();i++){

                MoldStore moldStore;
                moldStore = jslist.get(0);
                String mouldName = moldStore.getMouldName();
                String partDrawing = moldStore.getPartDrawing();
                String location = moldStore.getLocation();
                String tonnage = moldStore.getTonnage();
                String nunber = moldStore.getNunber();
                String remark = moldStore.getRemark();
                re1.put("mouldName",mouldName);
                re1.put("partDrawing",partDrawing);
                re1.put("location",location);
                re1.put("tonnage",tonnage);
                re1.put("nunber",nunber);
                re1.put("remark",remark);

            }
            return re1;
        }else {
            json.put("num",-1);
            return json;
        }

    }
    @ResponseBody
    @RequestMapping(value = "/update",method={RequestMethod.GET,RequestMethod.POST})
    public  Map Update(HttpServletRequest request) throws UnsupportedEncodingException{
        request.setCharacterEncoding("utf-8");
        String MouldID = request.getParameter("MouldID");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String takekind = request.getParameter("takekind");
        MoldStore moldStore = new MoldStore();
        moldStore.setMouldID(MouldID);
        moldStore.setInputMan(name);
        moldStore.setInputDate(time);
        moldStore.setStatus("MJ01");
        List<MoldStore> list = mouldMangageService.selectbymouldid(moldStore);
        if(list.size()>0){
            MoldStore moldStore1;
            moldStore1 = list.get(0);
            MoldInput moldInput = new MoldInput();
            moldInput.setMouldID(MouldID);
            moldInput.setInputDate(time);
            moldInput.setInputMan(name);
            moldInput.setInputTypes(takekind);
            moldInput.setRemark(moldStore1.getRemark());
            moldInput.setLocation(moldStore.getLocation());
            int n1 = mouldMangageService.insertMoldInput(moldInput);
        }
        int n  = mouldMangageService.updateStatus(moldStore);

        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/out",method={RequestMethod.GET,RequestMethod.POST})
    public  Map Out(HttpServletRequest request) throws UnsupportedEncodingException{
        request.setCharacterEncoding("utf-8");
        String MouldID = request.getParameter("MouldID");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String LDepartment =  request.getParameter("LDepartment");
        String Outtemple=request.getParameter("Outtemple");
        String takekind=request.getParameter("outtakekind");
        MoldStore moldStore = new MoldStore();
        moldStore.setMouldID(MouldID);
        moldStore.setOutputMan(name);
        moldStore.setOutputTime(time);
        moldStore.setStatus("MJ03");
        moldStore.setRemark(Outtemple);
        moldStore.setLDepartment(LDepartment);
        int n  = mouldMangageService.out(moldStore);
        MoldOutput moldOutput = new MoldOutput();
        moldOutput.setMouldID(MouldID);
        moldOutput.setOutputTypes(takekind);
        moldOutput.setRemark(Outtemple);
        moldOutput.setOutputMan(name);
        moldOutput.setOutputTime(time);
        moldOutput.setLDepartment(LDepartment);
        int n1  = mouldMangageService.outMoldOutput(moldOutput);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Deleteid",method={RequestMethod.GET,RequestMethod.POST})
    public  Map Delete(HttpServletRequest request) throws UnsupportedEncodingException{
        request.setCharacterEncoding("utf-8");
        String MouldID = request.getParameter("MouldID");
        String Outtemple=request.getParameter("Outtemple");
        String takekind=request.getParameter("outtakekind");
        String name=request.getParameter("name");
        String time=request.getParameter("time");
        MoldStore moldStore = new MoldStore();
        moldStore.setMouldID(MouldID);
        moldStore.setStatus("MJ04");
        moldStore.setRemark(Outtemple);
        List<MoldStore> list = mouldMangageService.selectbymouldid(moldStore);
        if(list.size()>0){
            MoldStore moldStore1;
            moldStore1 = list.get(0);
            MoldOutput moldOutput = new MoldOutput();
            moldOutput.setMouldID(MouldID);
            moldOutput.setOutputTypes(takekind);
            moldOutput.setRemark(Outtemple);
            moldOutput.setOutputMan(name);
            moldOutput.setOutputTime(time);
            moldOutput.setLDepartment(moldStore1.getLDepartment());
            int n1  = mouldMangageService.outMoldOutput(moldOutput);
        }
        int n  = mouldMangageService.delete(moldStore);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

}
