package com.dhchain.business.colddigitalworkshop.controller;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.colddigitalworkshop.service.ColdMonthPlanServivce;
import com.dhchain.business.colddigitalworkshop.vo.ColdMonthPlan;
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
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/ColdMonthPlan")
public class ColdMonthPlanController {
    @Autowired
    private ColdMonthPlanServivce coldMonthPlanServivce;
    @ResponseBody
    @RequestMapping(value = "/selectColdMonthPlan", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdMonthPlan(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        Integer year = 0;
        Integer month = 0;
        if(request.getParameter("year")!=null){
            year = Integer.parseInt(request.getParameter("year"));
        }
        if(request.getParameter("month")!=null){
            month = Integer.parseInt(request.getParameter("month"));
        }
        ColdMonthPlan coldMonthPlan = new ColdMonthPlan();
        coldMonthPlan.setFno(fno);
        coldMonthPlan.setFname(fname);
        coldMonthPlan.setYear(year);
        coldMonthPlan.setMonth(month);
        List<ColdMonthPlan> list = coldMonthPlanServivce.selectByAllKey(coldMonthPlan);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        List<ColdMonthPlan> list1 = new ArrayList<>();
        ColdMonthPlan coldMonthPlan1 = new ColdMonthPlan();
        if (list.size() > 0) {
            for(int i=0;i<list.size();i++){
                coldMonthPlan1 = list.get(i);
                Double progress1 = coldMonthPlan1.getTakeweidgt()/coldMonthPlan1.getPlanweidgt()*100;
                DecimalFormat decimalFormat = new DecimalFormat(".#");
                Double progress2=Double.parseDouble(decimalFormat.format(progress1)) ;
                Double progress;
                if(progress2>100){
                    progress = 100.0;
                }else{
                    progress = progress2;
                }
                coldMonthPlan1.setProgress(progress.toString());
                list1.add(coldMonthPlan1);
            }
            json.put("rows", list1);
            json.put("total", list1.size());
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/insertChild", method = {RequestMethod.GET, RequestMethod.POST})
    public Map insertChild(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdMonthPlan coldMonthPlan = new ColdMonthPlan();
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String plannum = request.getParameter("plannum");
        String planweidgt = request.getParameter("planweidgt");
        String planman = request.getParameter("planman");
        String   ssl=request.getParameter("ssl");
        String   qcl=request.getParameter("qcl");
        String   njl=request.getParameter("njl");
        String   cdl=request.getParameter("cdl");
        String   gclzb=request.getParameter("gclzb");
        String   bsl=request.getParameter("bsl");
        String  ftl=request.getParameter("ftl");
        String   gclxh=request.getParameter("gclxh");
        String   mtcl=request.getParameter("mtcl");
        String   xmb=request.getParameter("xmb");
        String   dp=request.getParameter("dp");
        coldMonthPlan.setSsl(ssl);
        coldMonthPlan.setQcl(qcl);
        coldMonthPlan.setNjl(njl);
        coldMonthPlan.setCdl(cdl);
        coldMonthPlan.setGclzb(gclzb);
        coldMonthPlan.setBsl(bsl);
        coldMonthPlan.setFtl(ftl);
        coldMonthPlan.setGclxh(gclxh);
        coldMonthPlan.setMtcl(mtcl);
        coldMonthPlan.setXmb(xmb);
        coldMonthPlan.setDp(dp);
        String fparentid = null;
        coldMonthPlan.setFno(fno);
        coldMonthPlan.setPlanweidgt(Double.parseDouble(planweidgt));
        coldMonthPlan.setPlanman(planman);
        coldMonthPlan.setPlant("材料零件");
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
        String hehe = dateFormat.format( now );
        coldMonthPlan.setPlandate(hehe);
        if (request.getParameter("fparentid")!=null){
            coldMonthPlan.setFparentid(request.getParameter("fparentid"));
        }else{
            coldMonthPlan.setFparentid(fparentid);
        }
        if (request.getParameter("year")!=null){
            coldMonthPlan.setYear(Integer.parseInt(request.getParameter("year")));
        }
        if (request.getParameter("month")!=null){
            coldMonthPlan.setMonth(Integer.parseInt(request.getParameter("month")));
        }
        coldMonthPlan.setFname(fname);
        int n = coldMonthPlanServivce.insertSelective(coldMonthPlan);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/deleteChild", method = {RequestMethod.GET, RequestMethod.POST})
    public Map deleteChild(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Integer id = 0;
        if(request.getParameter("id")!=null){
            id = Integer.parseInt(request.getParameter("id"));
        }
        Map json = new HashMap();
        int n = coldMonthPlanServivce.deleteByPrimaryKey(id);

        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteParent", method = {RequestMethod.GET, RequestMethod.POST})
    public Map deleteParent(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Integer id = 0;
        Map json = new HashMap();
        if(request.getParameter("id")!=null){
            id = Integer.parseInt(request.getParameter("id"));
        }
        int n = coldMonthPlanServivce.deleteByFparentIdAndId(id);
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/update", method = {RequestMethod.GET, RequestMethod.POST})
    public Map update(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdMonthPlan coldMonthPlan = new ColdMonthPlan();
        Integer id = Integer.parseInt(request.getParameter("id"));
        Double planweidgt = Double.parseDouble(request.getParameter("planweidgt"));
        String   ssl=request.getParameter("ssl");
        String   qcl=request.getParameter("qcl");
        String   njl=request.getParameter("njl");
        String   cdl=request.getParameter("cdl");
        String   gclzb=request.getParameter("gclzb");
        String   bsl=request.getParameter("bsl");
        String  ftl=request.getParameter("ftl");
        String   gclxh=request.getParameter("gclxh");
        String   mtcl=request.getParameter("mtcl");
        String   xmb=request.getParameter("xmb");
        String   dp=request.getParameter("dp");
        coldMonthPlan.setId(id);
        coldMonthPlan.setPlanweidgt(planweidgt);
        coldMonthPlan.setSsl(ssl);
        coldMonthPlan.setQcl(qcl);
        coldMonthPlan.setNjl(njl);
        coldMonthPlan.setCdl(cdl);
        coldMonthPlan.setGclzb(gclzb);
        coldMonthPlan.setBsl(bsl);
        coldMonthPlan.setFtl(ftl);
        coldMonthPlan.setGclxh(gclxh);
        coldMonthPlan.setMtcl(mtcl);
        coldMonthPlan.setXmb(xmb);
        coldMonthPlan.setDp(dp);
        int n = coldMonthPlanServivce.updateByPrimaryKeySelective(coldMonthPlan);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping("/export")
    public void export(ColdMonthPlan query, String fno, Integer month, Integer year, String fname, HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        request.setCharacterEncoding("UTF-8");
            response.reset(); //清除buffer缓存
            Map<String,Object> map=new HashMap<String,Object>();
            // 指定下载的文件名
            String fileName="";
            try {
                fileName = URLEncoder.encode("冷轧月度计划", "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            query.setFno(fno);
            query.setFname(fname);
            query.setYear(year);
            query.setMonth(month);
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            HSSFWorkbook workbook=null;
            //导出Excel对象
            workbook = coldMonthPlanServivce.exportExcelInfo(query);
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
    @RequestMapping(value="/import",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject impotr(HttpServletRequest request, @RequestParam(value = "uploadFile", required = false) MultipartFile file) throws Exception {
        //获取上传的文件
        String User =request.getParameter("User");
        Integer year  =Integer.parseInt(request.getParameter("year"));
        Integer  month=Integer.parseInt(request.getParameter("month"));
        String mpupinst = request.getParameter("mpupinst");
        MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
        MultipartFile file1 = multipart.getFile("uploadFile");
        InputStream in = file1.getInputStream();
        //数据导入
        String  back = coldMonthPlanServivce.importExcelInfo(in,file,User,mpupinst,month,year);
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

}
