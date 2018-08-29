package com.dhchain.business.equipmentlist.controller;

import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.equipmentlist.service.PlanProBaseService;
import com.dhchain.business.equipmentlist.vo.PlanProBase;
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
 * Created by tongc on 2017-8-16.
 */
@Controller
@RequestMapping("/PlanPB")
public class PlanProBaseController {
    @Autowired
    private PlanProBaseService planProBaseService;

    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
    public Map query1(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        PlanProBase planProBase = new PlanProBase();
        String inputer   =  request.getParameter("plant");
        planProBase.setPlant(inputer);
        List jslist = planProBaseService.queryAsList(planProBase);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        PlanProBase RplanProBase;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {

                Map re = new HashMap();
                RplanProBase = (PlanProBase) jslist.get(i);
                int id = RplanProBase.getId();
                 String worklead=RplanProBase.getWorklead();
                 String worker=RplanProBase.getWorker();
                 String equipment=RplanProBase.getEquipment();
                 String equipmentkind=RplanProBase.getEquipmentkind();
                 String equipmentserial=RplanProBase.getEquipmentserial();
                re.put("id", id);
                re.put("worklead", worklead);
                re.put("worker", worker);
                re.put("equipment", equipment);
                re.put("equipmentkind", equipmentkind);
                re.put("equipmentserial", equipmentserial);
                re.put("plant", inputer);
                jslst.add(re);
            }
        }
        json.put("rows",jslst);
        json.put("total", jslist.size());
        return json;
    }

    @ResponseBody
    @RequestMapping(value="/update",method={RequestMethod.GET,RequestMethod.POST})
    public Map update(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        int id=Integer.parseInt(request.getParameter("zid"));
        String worklead=request.getParameter("zworklead");
        String worker=request.getParameter("zworker");
        String equipment=request.getParameter("zequipment");
        String equipmentkind=request.getParameter("zequipmentkind");
        String equipmentserial=request.getParameter("zequipmentserial");
        String plant=request.getParameter("zplant");
        PlanProBase planProBase = new PlanProBase();
        planProBase.setPlant(plant);
        planProBase.setId(id);
        planProBase.setWorklead(worklead);
        planProBase.setWorker(worker);
        planProBase.setEquipment(equipment);
        planProBase.setEquipmentkind(equipmentkind);
        planProBase.setEquipmentserial(equipmentserial);
        int n = planProBaseService.update(planProBase);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value="/delete",method={RequestMethod.GET,RequestMethod.POST})
    public Map delete(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        int id=Integer.parseInt(request.getParameter("zid"));
        PlanProBase planProBase = new PlanProBase();
        planProBase.setId(id);
        int n = planProBaseService.delete(planProBase);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value="/insert",method={RequestMethod.GET,RequestMethod.POST})
    public Map insert(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String worklead=request.getParameter("zworklead");
        String worker=request.getParameter("zworker");
        String equipment=request.getParameter("zequipment");
        String equipmentkind=request.getParameter("zequipmentkind");
        String equipmentserial=request.getParameter("zequipmentserial");
        String plant=request.getParameter("zplant");
        PlanProBase planProBase = new PlanProBase();
        planProBase.setPlant(plant);
        planProBase.setWorklead(worklead);
        planProBase.setWorker(worker);
        planProBase.setEquipment(equipment);
        planProBase.setEquipmentkind(equipmentkind);
        planProBase.setEquipmentserial(equipmentserial);
        int n = planProBaseService.insert(planProBase);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
}
