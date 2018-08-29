package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.partpunchingworkshop.service.ElementDetailService;
import com.dhchain.business.partpunchingworkshop.service.ProductionTaskService;
import com.dhchain.business.partpunchingworkshop.vo.ColdDailyPlan;
import com.dhchain.business.partpunchingworkshop.vo.PTFinish;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/ElementDetail")
public class ElementDetailController {
    @Autowired
    private ElementDetailService elementDetailService;
    @Autowired
    private ProductionTaskService productionTaskService;
    @ResponseBody
    @RequestMapping(value="/Serach",method={RequestMethod.GET,RequestMethod.POST})
    public Map query (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String uyear = request.getParameter("uyear");
        String umouth = request.getParameter("umouth");
        String state = request.getParameter("state");
        String planID = request.getParameter("planID");
        String fno = request.getParameter("fno");
        String reelnum = request.getParameter("reelnum");
        String equipID = request.getParameter("equipID");
        String partDrawing = request.getParameter("partDrawing");
        String productMan = request.getParameter("productMan");
        String starttime1 = request.getParameter("starttime");
        String starttime = starttime1 + " 00:00:00";
        String endtime1 = request.getParameter("endtime");
        String endtime = endtime1 + " 23:59:59";
        Double sum = 0.0;
        List<PTFinish> list3 = new ArrayList();
        JSONObject re = new JSONObject();
        Map json = new HashMap();
            PTFinish ptFinish = new PTFinish();
            ptFinish.setPlant(plant);
            ptFinish.setProductTime(starttime);
            ptFinish.setProductTime1(endtime);
            ptFinish.setEquipID(equipID);
            ptFinish.setPlanID(planID);
            ptFinish.setFno(fno);
            ptFinish.setReelnum(reelnum);
            ptFinish.setPartDrawing(partDrawing);
            ptFinish.setProductMan(productMan);
            ptFinish.setUmouth(Integer.parseInt(umouth));
            ptFinish.setUyear(Integer.parseInt(uyear));
            List<PTFinish> list2 = elementDetailService.selectbyall(ptFinish);
            if(list2.size()>0){
                for(int j=0;j<list2.size();j++){
                    PTFinish ptFinish1;
                    ptFinish1 = list2.get(j);
                    Double a  = ptFinish1.getWeightNum();
                    sum = a + sum;
                    list3.add(ptFinish1);
                }
            }

        Map r = new HashMap();
        r.put("planID","合计");
        r.put("weightNum",sum);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(r);
        re.put("rows",list3);
        re.put("total",list3.size());
        re.put("footer",jslst2);
        return  re;
    }


    @ResponseBody
    @RequestMapping(value = "/updatenum",method = {RequestMethod.POST,RequestMethod.GET})
    public Map  UpdateNum(HttpServletRequest request) throws UnsupportedEncodingException{
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String number = request.getParameter("number");
        PTFinish ptFinish = new PTFinish();
        ptFinish.setWeightNum(Double.parseDouble(number));
        ptFinish.setID(Integer.parseInt(id));
        int n = elementDetailService.updatenum(ptFinish);
        Map json =  new HashMap();
        if(n>0){
            json.put("num",n);
        }
        return json;
    }
}

