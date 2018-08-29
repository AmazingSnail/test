package com.dhchain.business.colddigitalworkshop.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.colddigitalworkshop.service.ColdOutService;
import com.dhchain.business.colddigitalworkshop.service.MaterialtakeinService;
import com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn;
import com.dhchain.business.colddigitalworkshop.vo.ColdOut;
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
@RequestMapping("/TakeReport")
public class TakeReportController {
    @Autowired
    private ColdOutService coldOutService;
    @Autowired
    private MaterialtakeinService materialtakeinService;
    @ResponseBody
    @RequestMapping(value = "/selectColdmaterlinBydate", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdmaterlinBydate(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        ColdMaterialIn coldmaterialin = new ColdMaterialIn();
        String plant = request.getParameter("plant");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String begindate = request.getParameter("begindate");
        String enddate = request.getParameter("enddate");
        String state = request.getParameter("state");
        if(state!=null &&!"".equals(state)){
            if(state.equals("1")){
                coldmaterialin.setLocation("88-8");
            }else if(state.equals("2")){
                coldmaterialin.setLocation("999");
            }
        }
        coldmaterialin.setPlant(plant);
        coldmaterialin.setFno(fno);
        coldmaterialin.setFname(fname);
        coldmaterialin.setBegindate(begindate);
        coldmaterialin.setEnddate(enddate);
        List<ColdMaterialIn> list = materialtakeinService.selectColdmaterlinBydate(coldmaterialin);
        Map json = new HashMap();
        json.put("rows", list);
        json.put("total", list.size());
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/selectColdOutBydate", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdOutBydate(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdOut coldOut = new ColdOut();
        String plant = request.getParameter("plant");
        String fno = request.getParameter("fno");
        String outadd = request.getParameter("outadd");
        String begindate = request.getParameter("begindate");
        String enddate = request.getParameter("enddate");
        String state = request.getParameter("state");
        String vbeln = request.getParameter("vbeln");
        if(state!=null &&!"".equals(state)){
            if(state.equals("2")){
                coldOut.setLocation("999");
            }else if(state.equals("1")){
                coldOut.setLocation("88-8");
            }
        }
        coldOut.setPlant(plant);
        coldOut.setFno(fno);
        coldOut.setOutadd(outadd);
        coldOut.setBegindate(begindate);
        coldOut.setEnddate(enddate);
        coldOut.setCgvbeln(vbeln);
        List<ColdOut> list = coldOutService.selectColdOutBydate(coldOut);
        Map json = new HashMap();
        if (list.size() > 0) {
            json.put("rows", list);
            json.put("total", list.size());
        }
        return json;
    }
    @ResponseBody
    @RequestMapping("/trcexport")
    public void trcexport(String fno, String  begindate, String  plant, String fname, String enddate,String SelectState,HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        request.setCharacterEncoding("UTF-8");
        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        ColdOut coldOut = new ColdOut();
        ColdMaterialIn coldmaterialin = new ColdMaterialIn();

            coldmaterialin.setFno(fno);
            coldmaterialin.setFname(fname);
            coldmaterialin.setBegindate(begindate);
            coldmaterialin.setEnddate(enddate);
            coldmaterialin.setPlant(plant);
        coldOut.setFno(fno);
        coldOut.setFname(fname);
        coldOut.setBegindate(begindate);
        coldOut.setEnddate(enddate);
        coldOut.setPlant(plant);
        if ("1".equals(SelectState)){
            try {
                fileName = URLEncoder.encode("接收明细报表", "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }else{

            try {
                fileName = URLEncoder.encode("发出明细报表", "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }

        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HSSFWorkbook workbook=null;
        //导出Excel对象
        if ("1".equals(SelectState)){
            workbook = materialtakeinService.In_exportExcelInfo(coldmaterialin);
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
        }else{
            workbook = coldOutService.Out_exportExcelInfo(coldOut);
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
    @ResponseBody
    @RequestMapping(value = "/updateOutMsg", method = {RequestMethod.GET, RequestMethod.POST})
    public Map updateOutMsg(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdOut coldOut = new ColdOut();
//        Integer id = Integer.parseInt(request.getParameter("id"));
        Integer id = 0;
        String entities = request.getParameter("entities");
        entities = entities.replace("}{", "},{");
        entities = "[" + entities.toString() + "]";
        JSONArray jsonArray = JSONArray.parseArray(entities);
        for (int i=0;i<jsonArray.size();i++) {
            JSONObject row = jsonArray.getJSONObject(i);
            id = Integer.parseInt(row.getString("id"));
        }
        String vbeln = request.getParameter("vbeln");
//        String posnr = request.getParameter("posnr");
//        String cgvbeln = request.getParameter("cgvbeln");
//        String cgposnr = request.getParameter("cgposnr");
        coldOut.setId(id);
        coldOut.setVbeln(vbeln);
//        coldOut.setPosnr(posnr);
//        coldOut.setCgvbeln(cgvbeln);
//        coldOut.setCgposnr(cgposnr);
        int n = 0;
        n = coldOutService.updateByPrimaryKeySelective(coldOut);
        Map json = new HashMap();
        json.put("num", n);
        return json;
    }
}
