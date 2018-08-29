package com.dhchain.business.DeliveryOrder.controller;

/**
 * Created by lar on 2018-07-09.
 */

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.DeliveryOrder.service.DeliveryOrderService;
import com.dhchain.business.DeliveryOrder.service.ZSD022_ITEMService;
import com.dhchain.business.DeliveryOrder.service.Zsd022TimeService;
import com.dhchain.business.DeliveryOrder.vo.ZSD022_ITEM;
import com.dhchain.business.DeliveryOrder.vo.Zsd022;
import com.dhchain.business.DeliveryOrder.vo.Zsd022Time;
import com.dhchain.business.partpunchingworkshop.vo.MaterialCoding;
import com.dhchain.business.partpunchingworkshop.vo.ZInventory;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import javax.servlet.http.HttpServletRequest;
import java.beans.IntrospectionException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/DeliveryOrderController")
public class DeliveryOrderController {
    @Autowired
    private DeliveryOrderService deliveryOrderService;
    @Autowired
    private Zsd022TimeService zsd022TimeService;
    @Autowired
    private ZSD022_ITEMService zsd022_ItemService;

    @ResponseBody
    @RequestMapping(value="/Serach",method={RequestMethod.GET,RequestMethod.POST})
    public Map Serach (HttpServletRequest request) throws UnsupportedEncodingException {
        String Z1 = request.getParameter("Z1");
        String Z2 = request.getParameter("Z2");
        String Z3 = request.getParameter("Z3");
        String Z4 = request.getParameter("Z4");
        String Z5 = request.getParameter("Z5");
        String Z6 = request.getParameter("Z6");
        String Z7 = request.getParameter("Z7");
        String Z8 = request.getParameter("Z8");
        String Z9 = request.getParameter("Z9");
        Zsd022 zsd022 = new Zsd022();
        if (StringUtil.isNotEmpty(Z1)) {
            zsd022.setFHXTBH(Z1.trim());
        }
        if (StringUtil.isNotEmpty(Z2)) {
            zsd022.setFIELD30(Z2.trim());
        }
        if (StringUtil.isNotEmpty(Z3)) {
            zsd022.setFHYWY(Z3.trim());
        }
        if (StringUtil.isNotEmpty(Z4)) {
            zsd022.setFHKHMC(Z4.trim());
        }
        if (StringUtil.isNotEmpty(Z5)) {
            zsd022.setFIELD20(Z5.trim());
        }
        if (StringUtil.isNotEmpty(Z6)) {
            zsd022.setFHYSFS(Z6.trim());
        }
        if (StringUtil.isNotEmpty(Z7)) {
            zsd022.setFHBBJE(Z7.trim());
        }
        if (StringUtil.isNotEmpty(Z8)) {
            zsd022.setFHKHDH(Z8.trim());
        }
        if (StringUtil.isNotEmpty(Z9)) {
            zsd022.setFHXXDZ(Z9.trim());
        }
        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List<Zsd022> list = deliveryOrderService.selectSame3(zsd022);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        Map json = new HashMap();
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }

    @ResponseBody
    @RequestMapping(value = "/TSerach",method = {RequestMethod.GET,RequestMethod.POST})
    public Map Serach2 (HttpServletRequest request) throws UnsupportedEncodingException  {
        String fhxtbh = request.getParameter("fhxtbh");
        Zsd022Time zsd022Time = new Zsd022Time();
        if (StringUtil.isNotEmpty(fhxtbh)) {
            zsd022Time.setFHXTBH(fhxtbh.trim());
        }
        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List<Zsd022Time> list = zsd022TimeService.selectSame4(zsd022Time);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        Map json = new HashMap();
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value = "/DSerach",method = {RequestMethod.GET,RequestMethod.POST})
    public Map Serach3 (HttpServletRequest request) throws UnsupportedEncodingException  {
        String D1 = request.getParameter("D1");
        String D2 = request.getParameter("D2");
        String D3 = request.getParameter("D3");
        String D4 = request.getParameter("D4");
        String D5 = request.getParameter("D5");
        String D6 = request.getParameter("D6");
        String fcodeid = request.getParameter("fcodeid");
        ZSD022_ITEM zsd022_item = new ZSD022_ITEM();
        zsd022_item.setFcodeid(fcodeid);
        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List<ZSD022_ITEM> list = zsd022_ItemService.selectSame5(zsd022_item);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        Map json = new HashMap();
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
}