package com.dhchain.system.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.system.entity.OutputValue;
import com.dhchain.system.service.OutputValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wangq on 2018/5/24.
 */

@Controller
@RequestMapping("/OutputValue")
public class OutputValueController {
    @Autowired
    private OutputValueService outputValueService;
    @ResponseBody
    @RequestMapping(value = "/getOutputValue")
    public JSONObject getOutputValue(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String year = request.getParameter("year");
        String monat = request.getParameter("monat");
        String nwx = request.getParameter("nwx");
        JSONObject re = new JSONObject();
        List<OutputValue> jslist = new ArrayList<OutputValue>();
        jslist =  outputValueService.getOutputValue(year,monat,nwx);
        JSONArray jslst = new JSONArray();
        OutputValue data;
        Double SumActCZ=0.0;
        Double SumPlantCZ=0.0;
        Double YearSumActCZ=0.0;
        Double YearSumPlantCZ=0.0;
        DecimalFormat df = new DecimalFormat("0.00");
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                data = jslist.get(i);
                Double ActCZ= Double.valueOf(data.getY())/10000;//df.format();
                SumActCZ=SumActCZ+ActCZ;
                if(data.getW()!=null)
                {
                    SumPlantCZ = SumPlantCZ + Double.valueOf(data.getW());
                }
                else
                {
                    SumPlantCZ = SumPlantCZ + Double.valueOf(0);
                }
                YearSumActCZ=YearSumActCZ+Double.valueOf(data.getX())/10000;
                YearSumPlantCZ=YearSumPlantCZ+Double.valueOf(data.getZ());
                re1.put("Plant",data.getPlant());
                re1.put("ActCZ",df.format(ActCZ));
                re1.put("PlanCZ",data.getW());
                jslst.add(re1);
            }
            JSONObject relast = new JSONObject();
            relast.put("Plant","合计");
            relast.put("ActCZ",df.format(SumActCZ));
            relast.put("PlanCZ",SumPlantCZ.toString());
            jslst.add(relast);
            re.put("rows",jslst);
            re.put("total",jslst.size());
            //月度实际完成总产值
            re.put("SumActCZ",df.format(SumActCZ));
            //年度实际完成总产值
            re.put("YearSumActCZ",df.format(YearSumActCZ));
            //月度产值完成率 实际/计划
            re.put("MonthComplete",df.format(SumActCZ/SumPlantCZ*100));
            //年度产值完成率 实际/计划
            re.put("YearComplete",df.format(YearSumActCZ/YearSumPlantCZ*100));
        }

        return re;
    }
    @ResponseBody
    @RequestMapping(value = "/getOutputValueDay")
    public JSONObject getOutputValueDay(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String year = request.getParameter("year");
        String monat = request.getParameter("monat");
        String nwx = request.getParameter("nwx");
        JSONObject re = new JSONObject();
        List<OutputValue> jslist = new ArrayList<OutputValue>();
        jslist =  outputValueService.getOutputValueDay(year,monat,nwx);;
        JSONArray jslstDay = new JSONArray();
        JSONArray jslstDayValue = new JSONArray();
        OutputValue data;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                data = jslist.get(i);
                JSONObject reday = new JSONObject();
                reday.put("day",data.getR());
                jslstDay.add(reday);
                JSONObject reValue = new JSONObject();
                reValue.put("dayValue",data.getY());
                jslstDayValue.add(reValue);
            }
            re.put("day",jslstDay);
            re.put("dayValue",jslstDayValue);
        }
        return re;
    }
}
