package com.dhchain.business.assembletrans.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.assembletrans.service.SybService;
import com.dhchain.business.assembletrans.vo.BMan;
import com.dhchain.business.assembletrans.vo.FlowLine;
import com.dhchain.business.assembletrans.vo.Syb;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by tongc on 2017-7-20.
 */
@Controller
@RequestMapping("/Syb")
public class SybController {
    @Autowired
    private SybService sybService;

    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
    public JSON query1(HttpServletRequest request) throws UnsupportedEncodingException {
        List jslist = sybService.queryAsList();
        String plant = request.getParameter("plant");
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        Syb syb;
        //System.out.println(plant);
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {

                Map re = new HashMap();
                syb = (Syb) jslist.get(i);
                String Fname = syb.getFname();
                String Fremark = syb.getFremark();
                String Fno = syb.getFno();

                re.put("Fno", Fno);
                re.put("Fname", Fname);
                re.put("Fremark", Fremark);
                if(plant.equals(Fname)){
                    re.put("selected",true);
                }
                jslst.add(re);

            }
        }

//        json.put("rows",jslst);
//        json.put("total", 1);
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value="/BMan",method={RequestMethod.GET,RequestMethod.POST})
    public JSON query2(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        BMan bMan = new BMan();
        if(request.getParameter("plant")!=null && !"".equals(request.getParameter("plant").trim())){
            bMan.setPlant(request.getParameter("plant"));
        }else{
            bMan.setPlant("传动链");
        }

        bMan.setWorkdepart("装配车间");
        List jslist = sybService.queryBMan(bMan);
        JSONArray jslst = new JSONArray();
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                bMan = (BMan) jslist.get(i);
                Map re = new HashMap();
                String worklead = bMan.getWorklead();
                re.put("worklead", worklead);
                jslst.add(re);
            }
        }

//        json.put("rows",jslst);
//        json.put("total", 1);
        return jslst;
    }


    @ResponseBody
    @RequestMapping(value="/KMan",method={RequestMethod.GET,RequestMethod.POST})
    public JSON query4(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        BMan bbMan = new BMan();
        String plant = "";
        if(request.getParameter("plant")!=null){
            plant = request.getParameter("plant");
        }else{
            plant = "传动链";
        }
        bbMan.setPlant(plant);
        List jslist = sybService.queryBManK(bbMan);
        JSONArray jslst = new JSONArray();
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                bbMan = (BMan) jslist.get(i);
                Map re = new HashMap();
                String inputman = bbMan.getInputman();
                re.put("inputman", inputman);
                jslst.add(re);
            }
        }
        return jslst;
    }

    @ResponseBody
    @RequestMapping(value="/CMan",method={RequestMethod.GET,RequestMethod.POST})
    public JSON query5(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        BMan bbMan = new BMan();
        String plant = "";
        if(request.getParameter("plant")!=null){
            plant = request.getParameter("plant");
        }else{
            plant = "传动链";
        }
        bbMan.setPlant(plant);
        List jslist = sybService.queryBManC(bbMan);
        JSONArray jslst = new JSONArray();
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                bbMan = (BMan) jslist.get(i);
                Map re = new HashMap();
                String ReportMan = bbMan.getReportMan();
                re.put("ReportMan", ReportMan);
                //.out.println(jslst);
                jslst.add(re);
            }
        }
        return jslst;
    }

    @ResponseBody
    @RequestMapping(value="/getFlowLine",method={RequestMethod.GET,RequestMethod.POST})
    public JSON getFlowLine(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        FlowLine flowLine = new FlowLine();
        flowLine.setPlant(request.getParameter("plant"));
        List jslist = sybService.queryFlowLine(flowLine);
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        FlowLine RflowLine;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                Map re = new HashMap();
                RflowLine = (FlowLine) jslist.get(i);
                String FLID = RflowLine.getFLID();
                String FLName = RflowLine.getFLName();
                re.put("FLID", FLID);
                re.put("FLName", FLName);
                jslst.add(re);

            }
        }

        return jslst;
    }

    @ResponseBody
    @RequestMapping(value="/getFlowLineFLID",method={RequestMethod.GET,RequestMethod.POST})
    public Map update(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        FlowLine flowLine = new FlowLine();
        flowLine.setPlant(request.getParameter("plant"));
        if (request.getParameter("equipment") !=null&&!"".equals(request.getParameter("equipment").trim())){
            flowLine.setFLName(request.getParameter("equipment"));
        }
        List jslist = sybService.queryFlowLine(flowLine);
        FlowLine RflowLine;
        Map json = new HashMap();
        if(jslist.size()>0){
                Map re = new HashMap();
                RflowLine = (FlowLine) jslist.get(0);
                String FLID = RflowLine.getFLID();
            json.put("FLID", FLID);
        }
        return json;
    }
}
