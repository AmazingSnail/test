package com.dhchain.business.HeatTreatment.controller;

import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.HeatTreatment.service.PlanningManagementService;
import com.dhchain.business.HeatTreatment.vo.MPtheatplan;
import com.dhchain.business.HeatTreatment.vo.MaterialCoding;
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
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.IntrospectionException;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ct on 2018/7/5.
 */
@Controller
@RequestMapping(value = "/PlanningManagement")
public class PlanningManagementController {
    @Autowired
    private PlanningManagementService planningManagementService;
    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET, RequestMethod.POST})
    public Map Query (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
          String fno = request.getParameter("fno");
          String fname = request.getParameter("fname");
          String ProcessNode = request.getParameter("ProcessNode");
          String Fname = request.getParameter("Fname");
          String WorkCentre = request.getParameter("WorkCentre");
          MaterialCoding materialCoding = new MaterialCoding();
          materialCoding.setFno(fno);
          materialCoding.setFname(fname);
          materialCoding.setF1(ProcessNode);
          materialCoding.setFname1(Fname);
          materialCoding.setWorkcentre2(WorkCentre.trim());
        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List<MaterialCoding> list = planningManagementService.getFno(materialCoding);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/queryR",method={RequestMethod.GET, RequestMethod.POST})
    public Map queryr (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
          String fno = request.getParameter("fno");
          String fname = request.getParameter("fname");
          String Norms = request.getParameter("Norms");
          String FCZ = request.getParameter("FCZ");
          String ftype = request.getParameter("ftype");
          MaterialCoding materialCoding = new MaterialCoding();
          materialCoding.setFno(fno);
          materialCoding.setFname(fname);
          materialCoding.setFtemp7(ftype);
          materialCoding.setFtemp3(FCZ);
          materialCoding.setFtemp4(Norms);
        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List<MaterialCoding> list = planningManagementService.getInfo(materialCoding);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/queryDay",method={RequestMethod.GET, RequestMethod.POST})
    public Map QueryDay (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String ProcessNode = request.getParameter("ProcessNode");
        String AxleNum3 = request.getParameter("AxleNum3");
        String WorkCentre = request.getParameter("WorkCentre");
        String inputdata = request.getParameter("inputdata");
        String plant = request.getParameter("Plant");
        Example example = new Example(MPtheatplan.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(inputdata)) {
            String startime = inputdata + " 00:00:00";
            String endtime = inputdata + " 23:59:59";
            criteria.andGreaterThanOrEqualTo("inputdate",startime);
            criteria.andLessThanOrEqualTo("inputdate",endtime);
        }
        if (StringUtil.isNotEmpty(fno)) {
            criteria.andLike("fno","%" +fno.trim()+"%");
        }
        if (StringUtil.isNotEmpty(fname)) {
            criteria.andLike("fname","%" +fname.trim()+"%");
        }
        if (StringUtil.isNotEmpty(AxleNum3)) {
            criteria.andLike("fname","%" +AxleNum3.trim()+"%");
        }
        if (StringUtil.isNotEmpty(ProcessNode)) {
            criteria.andEqualTo("processnode",ProcessNode.trim());
        }
        if (StringUtil.isNotEmpty(plant)) {
            criteria.andEqualTo("plant",plant.trim());
        }
        if (StringUtil.isNotEmpty(WorkCentre)) {
            criteria.andLike("workcentre","%" +WorkCentre.trim()+"%");
        }
        List<MPtheatplan> list = planningManagementService.selectByExample(example);
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/insertFno",method={RequestMethod.GET, RequestMethod.POST})
    public Map InsertFno (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String plant = request.getParameter("plant");
        String time = request.getParameter("time");
        String username = request.getParameter("username");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String workcentre = request.getParameter("workcentre");
        String f1 = request.getParameter("f1");
        String f5 = request.getParameter("f5");
        String ftemp2 = request.getParameter("ftemp2");
        String ftemp3 = request.getParameter("ftemp3");
        String ftemp4 = request.getParameter("ftemp4");
        MPtheatplan mPtheatplan = new MPtheatplan();
        mPtheatplan.setDepartment("热处理车间");
        mPtheatplan.setFname(fname);
        mPtheatplan.setPartdrawing(ftemp2);
        mPtheatplan.setPartname(ftemp3);
        mPtheatplan.setMaterial(ftemp4);
        mPtheatplan.setWorkcentre(workcentre);
        mPtheatplan.setFno(fno);
        mPtheatplan.setProcessnode(f1);
        mPtheatplan.setSurface(f5);
        mPtheatplan.setPlant(plant);
        mPtheatplan.setInputman(username);
        mPtheatplan.setInputdate(time);
        int n =planningManagementService.InsertUseGeneratedKeysMapper(mPtheatplan);
        if(n>0){
            json.put("num",n);
        }else {
            json.put("num",-1);
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/Juge",method={RequestMethod.GET, RequestMethod.POST})
    public Map Juge (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json =  new HashMap();
        String fno = request.getParameter("fno");
        Example example = new Example(MPtheatplan.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(fno)) {
            criteria.andEqualTo("fno",fno);
        }
        List<MPtheatplan> list = planningManagementService.selectByExample(example);
        if(list.size()>0){
            json.put("num",list.size());
        }else {
            json.put("num",-1);
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/import",method={RequestMethod.GET, RequestMethod.POST})
    public JSONObject impotr(HttpServletRequest request, @RequestParam(value = "uploadFile", required = false) MultipartFile file) throws Exception {
        String time = request.getParameter("time");
        String name = request.getParameter("User");
        MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
        MultipartFile file1 = multipart.getFile("uploadFile");
        InputStream in = file1.getInputStream();
        //数据导入
        String  back = planningManagementService.importExcelInfo(in,file,time,name);
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
    @RequestMapping(value="/deleteTake",method={RequestMethod.GET, RequestMethod.POST})
    public Map DeleteTake (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json =  new HashMap();
         request.setCharacterEncoding("utf-8");
         String id = request.getParameter("id");
         int n = planningManagementService.deleteByPrimaryKey(Integer.parseInt(id));
         if(n>0){
             json.put("num",n);
         }else {
             json.put("num",-1);
         }
        return  json;
    }
}
