package com.dhchain.business.colddigitalworkshop.controller;

import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.colddigitalworkshop.service.ColdStoreService;
import com.dhchain.business.colddigitalworkshop.vo.ColdLocationStore;
import com.dhchain.business.colddigitalworkshop.vo.ColdStore;
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
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/Inventory")
public class InventoryController {
    @Autowired
    private ColdStoreService coldStoreService;
    @ResponseBody
    @RequestMapping(value = "/selectColdStore", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdStore(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String plant = request.getParameter("plant");
        Double sapstore = 0d;
        Integer state = 3;
        if (request.getParameter("sapstore")!=null){
            sapstore = Double.parseDouble(request.getParameter("sapstore"));
        }
        if (request.getParameter("state")!=null){
            state = Integer.parseInt(request.getParameter("state"));
        }
        System.out.println(sapstore+"==============="+state);
        ColdStore coldStore = new ColdStore();
        coldStore.setFno(fno);
        coldStore.setFname(fname);
        coldStore.setPlant(plant);
        coldStore.setSapstore(sapstore);
        coldStore.setState(state);
        List<ColdStore> list = coldStoreService.selectColdStoreList(coldStore);
        System.out.println(list.size());
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        if (list.size() > 0) {
            json.put("rows", list);
            json.put("total", list.size());
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/selectColdStoreLocation", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdStoreLocation(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("fno");
        String plant = request.getParameter("plant");
        Double leaveNumber = 0d;
        if(request.getParameter("leaveNumber")!=null){
            leaveNumber = Double.parseDouble(request.getParameter("leaveNumber"));
        }
        ColdLocationStore coldLocationStore = new ColdLocationStore();
        coldLocationStore.setFno(fno);
        coldLocationStore.setPlant(plant);
        coldLocationStore.setLeavenumber(leaveNumber);
        List<ColdLocationStore> list = coldStoreService.selectColdStoreLocation(coldLocationStore);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        if (list.size() > 0) {
            json.put("rows", list);
            json.put("total", list.size());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping("/itcexport")
    public void itcexport(String SelectState,HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.reset(); //清除buffer缓存
        Map<String, Object> map = new HashMap<String, Object>();
        // 指定下载的文件名
        String fileName = "";

        if ("1".equals(SelectState)) {
            try {
                fileName = URLEncoder.encode("原材料库存报表", "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        } else {

            try {
                fileName = URLEncoder.encode("成品库存报表", "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }

        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HSSFWorkbook workbook = null;
        //导出Excel对象
        if ("1".equals(SelectState)) {
            ColdLocationStore coldLocationStore = new ColdLocationStore();
            workbook = coldStoreService.Y_exportExcelInfo(coldLocationStore);
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
        } else {
            ColdLocationStore coldLocationStore = new ColdLocationStore();
            workbook = coldStoreService.C_exportExcelInfo(coldLocationStore);
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
}
