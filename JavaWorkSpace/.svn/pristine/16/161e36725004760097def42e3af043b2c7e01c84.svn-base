package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.partpunchingworkshop.service.BasicDataService;
import com.dhchain.business.partpunchingworkshop.service.InventoryService;
import com.dhchain.business.partpunchingworkshop.vo.MaterialCoding;
import com.dhchain.business.partpunchingworkshop.vo.ZInventory;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

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
@RequestMapping(value = "/Inventory")
public class BasicDataController {
    @Autowired
    private BasicDataService basicDataService;
    @Autowired
    private InventoryService inventoryService;
    @ResponseBody
    @RequestMapping(value="/serach",method={RequestMethod.GET, RequestMethod.POST})
    public Map Serach (HttpServletRequest request) throws UnsupportedEncodingException {
        String matnr = request.getParameter("matnr");
        String maktx = request.getParameter("maktx");
        String zbjnrx = request.getParameter("zbjnrx");
        String f2 = request.getParameter("f2");
        String f3 = request.getParameter("f3");
        String f4 = request.getParameter("f4");
        String f5 = request.getParameter("f5");
        String f9 = request.getParameter("f9");
        String f10 = request.getParameter("f10");
        String f11 = request.getParameter("f11");
        MaterialCoding materialCoding = new MaterialCoding();
        if (StringUtil.isNotEmpty(maktx)) {
            materialCoding.setMaktx(maktx.trim());
        }
        if (StringUtil.isNotEmpty(matnr)) {
            materialCoding.setMatnr(matnr.trim());
        }
        if (StringUtil.isNotEmpty(zbjnrx)) {
            materialCoding.setZbjnrx(zbjnrx.trim());
        }
        if (StringUtil.isNotEmpty(f2)) {
            materialCoding.setF2(f2.trim());
        }
        if (StringUtil.isNotEmpty(f3)) {
            materialCoding.setF3(f3.trim());
        }
        if (StringUtil.isNotEmpty(f4)) {
            materialCoding.setF4(f4.trim());
        }
        if (StringUtil.isNotEmpty(f5)) {
            materialCoding.setF5(f5.trim());
        }
        if (StringUtil.isNotEmpty(f9)) {
            materialCoding.setF9(f9.trim());
        }
        if (StringUtil.isNotEmpty(f10)) {
            materialCoding.setF10(f10.trim());
        }
        if (StringUtil.isNotEmpty(f11)) {
            materialCoding.setF10(f11.trim());
        }
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<MaterialCoding> list = basicDataService.selectSame1(materialCoding);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        Map json = new HashMap();
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;

    }
    @ResponseBody
    @RequestMapping(value = "/onclick",method = {RequestMethod.GET, RequestMethod.POST})
    public Map Onclick(ZInventory ZInventory) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        Example example = new Example(com.dhchain.business.partpunchingworkshop.vo.ZInventory.class);
        Example.Criteria criteria = example.createCriteria();
        com.dhchain.business.partpunchingworkshop.vo.ZInventory zInventory = new ZInventory();
        if (tk.mybatis.mapper.util.StringUtil.isNotEmpty(ZInventory.getMatnr())) {
            criteria.andEqualTo("matnr", ZInventory.getMatnr());
        }
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<com.dhchain.business.partpunchingworkshop.vo.ZInventory> list = inventoryService.selectByExample(example);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        Map json = new HashMap();
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/Export",method={RequestMethod.GET, RequestMethod.POST})
    public void export(String maktx, String matnr,
                       HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        request.setCharacterEncoding("utf-8");
        maktx = request.getParameter("maktx");
        matnr = request.getParameter("matnr");
        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        try {
            fileName = URLEncoder.encode("合同计划数据", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HSSFWorkbook workbook=null;
        //导出Excel对象
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        workbook = basicDataService.exportExce(maktx,matnr);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
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
    @RequestMapping(value = "/Judge",method = {RequestMethod.GET, RequestMethod.POST})
    public Map Judge(HttpServletRequest request) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        Map json = new HashMap();
        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        List<MaterialCoding> list = basicDataService.getJudge();
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        if(list.size()>0){
            MaterialCoding materialCoding ;
            materialCoding = list.get(0);
            String isRun = materialCoding.getIsRun();
            if(isRun.equals("0")){
                json.put("num",0);
            }else {
                json.put("num",1);
            }
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/query",method = {RequestMethod.GET, RequestMethod.POST})
    public JSON Query(HttpServletRequest request) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        JSONArray jslst = new JSONArray();
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<MaterialCoding> list = basicDataService.getF2();
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        MaterialCoding materialCoding = new MaterialCoding();
        if(list.size()>0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                materialCoding = list.get(i);
                if(materialCoding.getF2()!=null){
                    String f2 = materialCoding.getF2();
                    re.put("f2",f2);
                    jslst.add(re);
                }

            }
        }
        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/queryf4",method = {RequestMethod.GET, RequestMethod.POST})
    public JSON Queryf4(HttpServletRequest request) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        JSONArray jslst = new JSONArray();
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<MaterialCoding> list = basicDataService.getF4();
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        MaterialCoding materialCoding = new MaterialCoding();
        if(list.size()>0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                materialCoding = list.get(i);
                if(materialCoding.getF4()!=null){
                    String f4 = materialCoding.getF4();
                    re.put("f4",f4);
                    jslst.add(re);
                }

            }
        }
        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/queryf5",method = {RequestMethod.GET, RequestMethod.POST})
    public JSON Queryf5(HttpServletRequest request) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        JSONArray jslst = new JSONArray();
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<MaterialCoding> list = basicDataService.getF5();
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        MaterialCoding materialCoding = new MaterialCoding();
        if(list.size()>0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                materialCoding = list.get(i);
                if(materialCoding.getF5()!=null){
                    String f5 = materialCoding.getF5();
                    re.put("f5",f5);
                    jslst.add(re);
                }

            }
        }
        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/queryf9",method = {RequestMethod.GET, RequestMethod.POST})
    public JSON Queryf9(HttpServletRequest request) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        JSONArray jslst = new JSONArray();
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<MaterialCoding> list = basicDataService.getF9();
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        MaterialCoding materialCoding = new MaterialCoding();
        if(list.size()>0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                materialCoding = list.get(i);
                if(materialCoding.getF9()!=null){
                    String f9 = materialCoding.getF9();
                    re.put("f9",f9);
                    jslst.add(re);
                }

            }
        }
        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/queryf6",method = {RequestMethod.GET, RequestMethod.POST})
    public JSON Queryf6(HttpServletRequest request) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        JSONArray jslst = new JSONArray();
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<MaterialCoding> list = basicDataService.getF6();
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        MaterialCoding materialCoding = new MaterialCoding();
        if(list.size()>0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                materialCoding = list.get(i);
                if(materialCoding.getF6()!=null){
                    String f6 = materialCoding.getF6();
                    re.put("f6",f6);
                    jslst.add(re);
                }

            }
        }
        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/queryf10",method = {RequestMethod.GET, RequestMethod.POST})
    public JSON Queryf10(HttpServletRequest request) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        JSONArray jslst = new JSONArray();
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<MaterialCoding> list = basicDataService.getF10();
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        MaterialCoding materialCoding = new MaterialCoding();
        if(list.size()>0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                materialCoding = list.get(i);
                if(materialCoding.getF10()!=null){
                    String f10 = materialCoding.getF10();
                    re.put("f10",f10);
                    jslst.add(re);
                }

            }
        }
        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/queryf11",method = {RequestMethod.GET, RequestMethod.POST})
    public JSON Queryf11(HttpServletRequest request) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        JSONArray jslst = new JSONArray();
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<MaterialCoding> list = basicDataService.getF11();
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        MaterialCoding materialCoding = new MaterialCoding();
        if(list.size()>0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                materialCoding = list.get(i);
                if(materialCoding.getF11()!=null){
                    String f11 = materialCoding.getF11();
                    re.put("f11",f11);
                    jslst.add(re);
                }

            }
        }
        return  jslst;
    }

}
