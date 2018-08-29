package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.partpunchingworkshop.service.InfoService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
@RequestMapping(value = "/Info")
public class InfoController {
    @Autowired
    private InfoService infoService;
    @ResponseBody
    @RequestMapping(value="/serach",method={RequestMethod.GET,RequestMethod.POST})
    public JSON Serach (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        List<BaseStatus> list = infoService.getStauts();

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
    @RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
    public Map query (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String name = request.getParameter("name");
        Map json = new HashMap();
        if(name.equals("发出指令")){
            List<ReModbusOrder> list = infoService.getList();
            if(list.size()>0){
                json.put("rows",list);
                json.put("total",list.size());
            }
        }else if(name.equals("写入指令")){
            List<WrModbusOrder> list = infoService.getList1();
            if(list.size()>0){
                json.put("rows",list);
                json.put("total",list.size());
            }
        }else {
            List<BaseStatus> list = infoService.getList2();
            if(list.size()>0){
                json.put("rows",list);
                json.put("total",list.size());
            }
        }
        return  json;

    }
    @ResponseBody
    @RequestMapping(value = "/Insert",method={RequestMethod.GET,RequestMethod.POST})
    public Map Insert (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String ip = request.getParameter("ip");
        String ReOrder = request.getParameter("ReOrder");
        String id = request.getParameter("id");
        ReModbusOrder reModbusOrder =  new ReModbusOrder();
        reModbusOrder.setIP(ip);
        reModbusOrder.setReOrder(ReOrder);
        Map json = new HashMap();
        if("".equals(id)){
            int n = infoService.insert(reModbusOrder);
            if(n>0){
                json.put("num",n);
            }
        }else {
            reModbusOrder.setID(Integer.parseInt(id));
            int n = infoService.update(reModbusOrder);
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
        String EquipID = request.getParameter("EquipID");
        String WriOrder = request.getParameter("WriOrder");
        String OrderName = request.getParameter("OrderName");
        String FieType = request.getParameter("FieType");
        String id = request.getParameter("id");
        WrModbusOrder wrModbusOrder =  new WrModbusOrder();
        wrModbusOrder.setEquipID(EquipID);
        wrModbusOrder.setFieType(FieType);
        wrModbusOrder.setWriOrder(WriOrder);
        wrModbusOrder.setOrderName(OrderName);
        Map json = new HashMap();
        if("".equals(id)){
            wrModbusOrder.setMark("0");
            wrModbusOrder.setTypes("0");
            int n = infoService.insert1(wrModbusOrder);
            if(n>0){
                json.put("num",n);
            }
        }else {
            wrModbusOrder.setID(Integer.parseInt(id));
            int n = infoService.update1(wrModbusOrder);
            if(n>0){
                json.put("num",n);
            }
        }

        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Insert2",method={RequestMethod.GET,RequestMethod.POST})
    public Map Insert2 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String StatusName = request.getParameter("StatusName");
        String StatusID = request.getParameter("StatusID");
        String DepartMent = request.getParameter("DepartMent");
        String id = request.getParameter("id");
        BaseStatus baseStatus =  new BaseStatus();
        baseStatus.setStatusName(StatusName);
        baseStatus.setStatusID(StatusID);
        baseStatus.setDepartMent(DepartMent);
        Map json = new HashMap();
        if("".equals(id)){
            int n = infoService.insert2(baseStatus);
            if(n>0){
                json.put("num",n);
            }
        }else {
            baseStatus.setID(Integer.parseInt(id));
            int n = infoService.update2(baseStatus);
            if(n>0){
                json.put("num",n);
            }
        }

        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Deletedata",method = {RequestMethod.POST,RequestMethod.GET})
    public  Map Delete(HttpServletRequest request) throws  UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String i = request.getParameter("i");
        String id = request.getParameter("id");
        Map json = new HashMap();
        if (i.equals("发出指令")) {
            ReModbusOrder reModbusOrder = new ReModbusOrder();
            reModbusOrder.setID(Integer.parseInt(id));
            int n = infoService.delete(reModbusOrder);
            if (n > 0) {
                json.put("num", n);
            }
        } else if (i.equals("写入指令")) {
            WrModbusOrder wrModbusOrder = new WrModbusOrder();
            wrModbusOrder.setID(Integer.parseInt(id));
            int n = infoService.delete1(wrModbusOrder);
            if (n > 0) {
                json.put("num", n);
            }
        } else if(i.equals("状态信息")){
               BaseStatus baseStatus =  new BaseStatus();
            baseStatus.setID(Integer.parseInt(id));
            int n = infoService.delete2(baseStatus);
            if (n > 0) {
                json.put("num", n);
            }
        }
        return json;
    }
}
