package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.partpunchingworkshop.service.MonthPlanService;
import com.dhchain.business.partpunchingworkshop.vo.Syb;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/ContractPlan")
public class ContractPlanController {
    @Autowired
    private MonthPlanService monthPlanService;

    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
    public JSON query1(HttpServletRequest request) throws UnsupportedEncodingException {

        List jslist = monthPlanService.queryplant();
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
        String  back = monthPlanService.importExcelInfo(in,file,User,month,year,plant,time);
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
