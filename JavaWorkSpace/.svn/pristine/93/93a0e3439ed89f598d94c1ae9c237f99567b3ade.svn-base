package com.dhchain.business.Tractor.controller;

import com.dhchain.business.Tractor.service.TractorService;
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
import java.util.Map;

/**
 * Created by ASUS on 2018/7/26.
 */
@Controller
@RequestMapping(value = "/Export")
public class ExportController {
    @Autowired
    private TractorService tractorService;
    @ResponseBody
    @RequestMapping(value="/Export",method={RequestMethod.GET,RequestMethod.POST})
    public void export(String ProductID, String serialID, String OrderID, String WERKS, String starttime, String endtime,
                       HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        request.setCharacterEncoding("utf-8");
        ProductID =  new String(request.getParameter("ProductID").getBytes("ISO-8859-1"),"UTF-8");
        serialID =  new String(request.getParameter("serialID").getBytes("ISO-8859-1"),"UTF-8");
        OrderID =  new String(request.getParameter("OrderID").getBytes("ISO-8859-1"),"UTF-8");
        WERKS =  new String(request.getParameter("WERKS").getBytes("ISO-8859-1"),"UTF-8");
        starttime =  new String(request.getParameter("starttime").getBytes("ISO-8859-1"),"UTF-8");
        endtime =  new String(request.getParameter("endtime").getBytes("ISO-8859-1"),"UTF-8");
        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        try {
            fileName = URLEncoder.encode("拖拉机合格证数据", "UTF-8");
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
        workbook = tractorService.exportExcel(ProductID,serialID,OrderID,WERKS,starttime,endtime);
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
