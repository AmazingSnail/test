package com.dhchain.business.HeatTreatment.controller;

import com.dhchain.business.HeatTreatment.service.PMissionIssuedService;
import com.dhchain.business.HeatTreatment.service.PlanningManagementService;
import com.dhchain.business.partpunchingworkshop.service.ElementDetailService;
import com.dhchain.business.partpunchingworkshop.service.MonthPlanService;
import com.dhchain.business.partpunchingworkshop.service.MouldManageService;
import com.dhchain.business.partpunchingworkshop.service.ProductionTaskService;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import java.util.HashMap;
import java.util.Map;

/**
 * Created by ASUS on 2018/7/9.
 */
@Controller
@RequestMapping(value = "/Export")
public class Exportcontroller {
    @Autowired
    private PlanningManagementService planningManagementService;
    @Autowired
    private MonthPlanService monthPlanService;
    @Autowired
    private ElementDetailService elementDetailService;
    @Autowired
    private MouldManageService mouldMangageService;
    @Autowired
    private ProductionTaskService productionTaskService;
    @Autowired
    private PMissionIssuedService pMissionIssuedService;
    @ResponseBody
    @RequestMapping(value="/pmExport",method={RequestMethod.GET,RequestMethod.POST})
    public void Export(String fno, String fname, String AxleNum3, String ProcessNode, String pmiPlant, String WorkCentre,
                       HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        request.setCharacterEncoding("utf-8");
        fno = request.getParameter("fno");
        String fno1 =  new String(fno.getBytes("ISO-8859-1"),"UTF-8");
        fname = request.getParameter("fname");
        String fname1 =  new String(fname.getBytes("ISO-8859-1"),"UTF-8");
        AxleNum3 = request.getParameter("AxleNum3");
        String AxleNum =  new String(AxleNum3.getBytes("ISO-8859-1"),"UTF-8");
        ProcessNode = request.getParameter("ProcessNode");
        String ProcessNode1 =  new String(ProcessNode.getBytes("ISO-8859-1"),"UTF-8");
        pmiPlant = request.getParameter("pmiPlant");
        String plant =  new String(pmiPlant.getBytes("ISO-8859-1"),"UTF-8");
        WorkCentre = request.getParameter("WorkCentre");
        String WorkCentre1 =  new String(WorkCentre.getBytes("ISO-8859-1"),"UTF-8");
        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        try {
            fileName = URLEncoder.encode("计划导出数据", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HSSFWorkbook workbook=null;
        //导出Excel对象
        workbook = planningManagementService.exportExcel(fno1,fname1,AxleNum,ProcessNode1,plant,WorkCentre1);
        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            workbook.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @ResponseBody
    @RequestMapping(value="/CpmonpExport",method={RequestMethod.GET,RequestMethod.POST})
    public void export( String uyear, String umonth,String plant, String fname, String WorkCentre, String OrderLine, String fno,String state,
                        HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        request.setCharacterEncoding("utf-8");
        uyear = request.getParameter("uyear");
       String uyear1 =   new String(uyear.getBytes("ISO-8859-1"),"UTF-8");
        umonth = new String(request.getParameter("umonth").getBytes("ISO-8859-1"),"UTF-8");
        plant =  new String(request.getParameter("plant").getBytes("ISO-8859-1"),"UTF-8");
        fname =  new String(request.getParameter("fname").getBytes("ISO-8859-1"),"UTF-8");
        WorkCentre =  new String(request.getParameter("WorkCentre").getBytes("ISO-8859-1"),"UTF-8");
        fno =  new String(request.getParameter("fno").getBytes("ISO-8859-1"),"UTF-8");
        OrderLine =  new String(request.getParameter("OrderLine").getBytes("ISO-8859-1"),"UTF-8");
        state =  new String(request.getParameter("state").getBytes("ISO-8859-1"),"UTF-8");
        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        try {
            fileName = URLEncoder.encode("合同计划数据", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HSSFWorkbook workbook=null;
        //导出Excel对象
        workbook = monthPlanService.exportExcel(plant,uyear1,umonth,fname,WorkCentre,OrderLine,fno,state);
        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            workbook.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @ResponseBody
    @RequestMapping(value="/Export",method={RequestMethod.GET,RequestMethod.POST})
    public void Export( String uyear, String umouth,String plant, String planID, String fno, String reelnum, String equipID,String partDrawing,String productMan,
                        String state,String starttime,String endtime,
                        HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        uyear =  new String(request.getParameter("uyear").getBytes("ISO-8859-1"),"UTF-8");
        umouth =  new String(request.getParameter("umouth").getBytes("ISO-8859-1"),"UTF-8");
        plant =  new String(request.getParameter("plant").getBytes("ISO-8859-1"),"UTF-8");
        planID =  new String(request.getParameter("planID").getBytes("ISO-8859-1"),"UTF-8");
        fno =  new String(request.getParameter("fno").getBytes("ISO-8859-1"),"UTF-8");
        reelnum =  new String(request.getParameter("reelnum").getBytes("ISO-8859-1"),"UTF-8");
        equipID =  new String(request.getParameter("equipID").getBytes("ISO-8859-1"),"UTF-8");
        partDrawing =  new String(request.getParameter("partDrawing").getBytes("ISO-8859-1"),"UTF-8");
        productMan =  new String(request.getParameter("productMan").getBytes("ISO-8859-1"),"UTF-8");
        state =  new String(request.getParameter("state").getBytes("ISO-8859-1"),"UTF-8");
        starttime =  new String(request.getParameter("starttime").getBytes("ISO-8859-1"),"UTF-8");
        endtime =  new String(request.getParameter("endtime").getBytes("ISO-8859-1"),"UTF-8");
        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        try {
            fileName = URLEncoder.encode("完成明细数据", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HSSFWorkbook workbook=null;
        //导出Excel对象
        workbook = elementDetailService.exportExcel(plant,uyear,umouth,planID,fno,reelnum,equipID,partDrawing,productMan,starttime,endtime,state);
        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            workbook.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    @ResponseBody
    @RequestMapping(value="/mpmonpExport",method={RequestMethod.GET,RequestMethod.POST})
    public void export( String uyear, String umouth,String plant, String fname, String WorkProcedure, String Fno, String PartDrawing,String PartName,String name,
                        String state,
                        HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        request.setCharacterEncoding("utf-8");
        uyear =  new String(request.getParameter("uyear").getBytes("ISO-8859-1"),"UTF-8");
        umouth =  new String(request.getParameter("umouth").getBytes("ISO-8859-1"),"UTF-8");
        plant =  new String(request.getParameter("plant").getBytes("ISO-8859-1"),"UTF-8");
        fname =  new String(request.getParameter("fname").getBytes("ISO-8859-1"),"UTF-8");
        WorkProcedure =  new String(request.getParameter("WorkProcedure").getBytes("ISO-8859-1"),"UTF-8");
        Fno =  new String(request.getParameter("Fno").getBytes("ISO-8859-1"),"UTF-8");
        PartDrawing =  new String(request.getParameter("PartDrawing").getBytes("ISO-8859-1"),"UTF-8");
        PartName =  new String(request.getParameter("PartName").getBytes("ISO-8859-1"),"UTF-8");
        state =  new String(request.getParameter("state").getBytes("ISO-8859-1"),"UTF-8");
        name =  new String(request.getParameter("name").getBytes("ISO-8859-1"),"UTF-8");
        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        try {
            fileName = URLEncoder.encode("月度计划数据", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HSSFWorkbook workbook=null;
        //导出Excel对象
        workbook = monthPlanService.exportExce2(plant,uyear,umouth,fname,WorkProcedure,Fno,PartDrawing,PartName,state);
        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            workbook.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @ResponseBody
    @RequestMapping(value = "/Export1",method={RequestMethod.GET,RequestMethod.POST})
    public  void Export1(String plant, String department, String MouldID, String Tonnage, String MouldName,String Location,String nwx,
                        HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException{

        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        try {
            fileName = URLEncoder.encode("模具库存数据", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HSSFWorkbook workbook=null;
        //导出Excel对象
        workbook = mouldMangageService.exportExce(plant,department,MouldID,Tonnage,MouldName,Location,nwx);
        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            workbook.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    @ResponseBody
    @RequestMapping(value="/Export2",method={RequestMethod.GET,RequestMethod.POST})
    public void Export2( String uyear, String umouth,String plant, String MouldID, String PartDrawing,String ptmStatus,
                        String state,
                        HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        umouth =  new String(request.getParameter("umouth").getBytes("ISO-8859-1"),"UTF-8");
        uyear =  new String(request.getParameter("uyear").getBytes("ISO-8859-1"),"UTF-8");
        plant =  new String(request.getParameter("plant").getBytes("ISO-8859-1"),"UTF-8");
        MouldID =  new String(request.getParameter("MouldID").getBytes("ISO-8859-1"),"UTF-8");
        PartDrawing =  new String(request.getParameter("PartDrawing").getBytes("ISO-8859-1"),"UTF-8");
        ptmStatus =  new String(request.getParameter("ptmStatus").getBytes("ISO-8859-1"),"UTF-8");
        state =  new String(request.getParameter("state").getBytes("ISO-8859-1"),"UTF-8");
        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        try {
            fileName = URLEncoder.encode("任务计划数据导出", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HSSFWorkbook workbook=null;
        //导出Excel对象
        workbook = productionTaskService.exportExce(umouth,uyear,plant,MouldID,PartDrawing,ptmStatus,state);
        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            workbook.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @ResponseBody
    @RequestMapping(value="/PMExport",method={RequestMethod.GET,RequestMethod.POST})
    public void PMExport( String uyear, String umouth,String plant, String Status, String EquipID,String fno,
                         String fname,
                         HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        umouth =  new String(request.getParameter("umouth").getBytes("ISO-8859-1"),"UTF-8");
        uyear =  new String(request.getParameter("uyear").getBytes("ISO-8859-1"),"UTF-8");
        plant =  new String(request.getParameter("plant").getBytes("ISO-8859-1"),"UTF-8");
        Status =  new String(request.getParameter("Status").getBytes("ISO-8859-1"),"UTF-8");
        EquipID =  new String(request.getParameter("EquipID").getBytes("ISO-8859-1"),"UTF-8");
        fno =  new String(request.getParameter("fno").getBytes("ISO-8859-1"),"UTF-8");
        fname =  new String(request.getParameter("fname").getBytes("ISO-8859-1"),"UTF-8");
        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        try {
            fileName = URLEncoder.encode("进度管理数据导出", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HSSFWorkbook workbook=null;
        //导出Excel对象
        workbook = pMissionIssuedService.exportExce(umouth,uyear,plant,Status,EquipID,fno,fname);
        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            workbook.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
