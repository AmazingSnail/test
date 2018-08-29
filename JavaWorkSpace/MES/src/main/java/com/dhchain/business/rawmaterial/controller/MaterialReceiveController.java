package com.dhchain.business.rawmaterial.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.HeatTreatment.vo.MaterialCoding;
import com.dhchain.business.rawmaterial.service.MaterialReceiveService;
import com.dhchain.business.rawmaterial.service.MaterialSendService;
import com.dhchain.business.rawmaterial.vo.*;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import com.dhchain.util.SAPConn;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoParameterList;
import com.sap.conn.jco.JCoTable;
import jxl.write.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 材料接受后台方法
 *
 * @author ct
 * @date 2018-08-06
 */
@Controller
@RequestMapping(value = "/MaterialReceive")
public class MaterialReceiveController {
    @Autowired
    private MaterialReceiveService materialReceiveService;
    @Autowired
    private MaterialSendService materialSendService;
    @ResponseBody
    @RequestMapping(value="/queryDday",method={RequestMethod.GET, RequestMethod.POST})
    public Map queryDday (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String time = request.getParameter("time");
        MMaterialreceive mMaterialreceive = new MMaterialreceive();
        mMaterialreceive.setPlant(plant);
        List<MMaterialreceive> list = materialReceiveService.getDay(mMaterialreceive);
        Map re = new HashMap();
        if (list.size()>0){
            re.put("rows",list);
            re.put("total",list.size());
        }
        return  re;
    }
    @ResponseBody
    @RequestMapping(value = "/ZMM_O_003M7", method = {RequestMethod.GET, RequestMethod.POST})
    public Map ZMM_O_003M7(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JCoFunction function = null;
        JCoDestination destination = SAPConn.connect();
        //需传入接口的库存地点
        String LGORT = "";
        //需传入接口的事业部
        String PlantIn = "";
        String UserName = request.getParameter("UserName");
        String plant = request.getParameter("plant");
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        try {
            //调用ZEP_O_019函数
            function = destination.getRepository().getFunction("ZMM_O_004");
            JCoParameterList input = function.getImportParameterList();
//            //调用接口模块
            input.setValue("S_EBELN", request.getParameter("PoNo"));
            input.setValue("SMODEL", 7);

            if (request.getParameter("SupportNo") != null && !"".equals(request.getParameter("SupportNo").trim())) {
                input.setValue("S_LIFNR", "0000" + request.getParameter("SupportNo"));
            }
            DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
            PlantIn = materialReceiveService.getPlantIn(request.getParameter("plant"));
            DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
            DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
            LGORT = materialReceiveService.getLGORTIn(plant, UserName);
            DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());


            input.setValue("S_WERKS", PlantIn);
            input.setValue("S_LGORT", LGORT);
            //执行接口程序
            function.execute(destination);
            JCoTable tb = function.getTableParameterList().getTable("POHEAD");
            for (int i = 0; i < tb.getNumRows(); i++) {
                tb.setRow(i);
                Map re = new HashMap();
                    re.put("id", i);
                    re.put("LIFNR", tb.getString("LIFNR"));
                    re.put("NAME1", tb.getString("NAME1"));
                    re.put("EBELN", tb.getString("EBELN"));
                    jslst.add(re);
            }
            json.put("rows", jslst);
            json.put("total", tb.getNumRows());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/MaterialReceive",method={RequestMethod.GET, RequestMethod.POST})
    public Map materialReceive (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
       Map re = new HashMap();
       String fno = request.getParameter("fno");
       String ftemp3 = request.getParameter("ftemp3");
       String ftemp4 = request.getParameter("ftemp4");
       String ftemp7 = request.getParameter("ftemp7");
       String pono = request.getParameter("pono");
       String supporname = request.getParameter("supporname");
       String receivenum = request.getParameter("receivenum");
       String item = request.getParameter("item");
       String fname = request.getParameter("fname");
       String heatno = request.getParameter("heatno");
       String plant = request.getParameter("plant");
       String inputdate = request.getParameter("inputdate");
       String ReceiveMan = request.getParameter("ReceiveMan");
       String uyear = request.getParameter("uyear");
       String umonth = request.getParameter("umonth");
       String Department = "原材料仓库";
       MMaterialreceive mMaterialreceive2 = new MMaterialreceive();
       mMaterialreceive2.setUmonth(umonth);
       mMaterialreceive2.setUyear(uyear);
        String Serialno = "";

        List<MMaterialreceive> list = materialReceiveService.getSerialno(mMaterialreceive2);
        if (list.size()>0){
             MMaterialreceive mMaterialreceive1 = list.get(0);
             String s = mMaterialreceive1.getSerialno();
            String b2 ="";
            int num = 6;
             if(s.length()>num){
                 int   a = umonth.length();
                 String  b = s.substring(a,7);
                 int b1 = Integer.parseInt(b)+1;
                 b2  =   String.format("%05d",b1);
             }else {
                 int   a = umonth.length();
                 String  b = s.substring(a,6);
                 int b1 = Integer.parseInt(b)+1;
                 b2  =   String.format("%05d",b1);
             }

            Serialno = umonth + b2;
        }else {
            Serialno = umonth+"00001";
        }
        MMaterialreceive mMaterialreceive = new MMaterialreceive();
        mMaterialreceive.setSerialno(Serialno);
        mMaterialreceive.setPlant(plant);
        mMaterialreceive.setDepartment(Department);
        mMaterialreceive.setPono(pono);
        mMaterialreceive.setFno(fno);
        mMaterialreceive.setFname(fname);
        mMaterialreceive.setNorms(ftemp4);
        mMaterialreceive.setHeatno(heatno);
        mMaterialreceive.setMaterial(ftemp3);
        mMaterialreceive.setSupporname(supporname);
        mMaterialreceive.setReceivedate(inputdate);
        mMaterialreceive.setReceivenum(receivenum);
        mMaterialreceive.setItem(item);
        mMaterialreceive.setReceiveman(ReceiveMan);
        mMaterialreceive.setReceivetime(inputdate);
        mMaterialreceive.setUyear(uyear);
        mMaterialreceive.setUmonth(umonth);
        mMaterialreceive.setIscheck("未检验");
        int n = materialReceiveService.InsertUseGeneratedKeysMapper(mMaterialreceive);
        if(n>0){
            re.put("num",n);
        }else {
            re.put("num",-1);
        }
        return  re;
    }
   @ResponseBody
    @RequestMapping(value = "/deleteMaterial",method={RequestMethod.GET, RequestMethod.POST})
   public Map deleteMaterial (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
       String id = request.getParameter("id");
       int n = materialReceiveService.deleteByPrimaryKey(Integer.parseInt(id));
        Map re = new HashMap();
       if(n>0){
           re.put("num",n);
       }else {
           re.put("num",-1);
       }
        return re;
   }
    @ResponseBody
    @RequestMapping(value = "/FindSp",method={RequestMethod.GET, RequestMethod.POST})
    public JSON findSp (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray re = new JSONArray();
        Map json = new HashMap();
        request.setCharacterEncoding("utf-8");
        String  plant = request.getParameter("plant");
        BaseSupplier baseSupplier =new BaseSupplier();
        baseSupplier.setPlant(plant);
        baseSupplier.setDepartment("原料库");
        List<BaseSupplier> list = materialReceiveService.getSupplier(baseSupplier);
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                BaseSupplier baseSupplier1 = list.get(i);
                String supporname = baseSupplier1.getSupplier();
                json.put("supporname",supporname);
                re.add(json);
            }
        }
        return re;
    }
    @ResponseBody
    @RequestMapping(value = "/ReceviceIn",method={RequestMethod.GET, RequestMethod.POST})
    public JSONObject receviceIn (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String result = request.getParameter("result");
        String supporname = request.getParameter("supporname");
        String endtime = request.getParameter("endtime");
        String starttime = request.getParameter("starttime");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String HeatNo = request.getParameter("HeatNo");
        Example example = new Example(MMaterialreceive.class);
        Example.Criteria criteria = example.createCriteria();
            String startime1 = starttime + " 00:00:00.000";
            String endtime1 = endtime + " 23:59:59.000";
        Timestamp startTime2=Timestamp.valueOf(startime1);
        Timestamp endtime2=Timestamp.valueOf(endtime1);
          criteria.andBetween("receivedate",startTime2,endtime2);
        if (StringUtil.isNotEmpty(fno)) {
            criteria.andLike("fno","%" +fno.trim()+"%");
        }
        if (StringUtil.isNotEmpty(fname)) {
            criteria.andLike("fname","%" +fname.trim()+"%");
        }
        if (StringUtil.isNotEmpty(HeatNo)) {
            criteria.andLike("heatno","%" +HeatNo.trim()+"%");
        }
        if (StringUtil.isNotEmpty(plant)){
            criteria.andEqualTo("plant",plant.trim());
        }
        if (StringUtil.isNotEmpty(supporname)){
            criteria.andEqualTo("supporname",supporname.trim());
        }
        if (StringUtil.isNotEmpty(result)){
            criteria.andEqualTo("ischeck",result.trim());
        }
        List<MMaterialreceive> list = materialReceiveService.selectByExample(example);
        Map re = new HashMap();
        int sum  = 0;
        if (list.size()>0){
            for(MMaterialreceive i :list){
                int num = Integer.parseInt(i.getReceivenum());
                sum = sum + num;
            }
        }
        re.put("pono","合计");
        re.put("receivenum",sum);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(re);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("rows",list);
        jsonObject.put("total",list.size());
        jsonObject.put("footer",jslst2);
        return  jsonObject;
    }
    @ResponseBody
    @RequestMapping(value = "/ReceviceInAll",method={RequestMethod.GET, RequestMethod.POST})
    public JSONObject receviceInAll (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String result = request.getParameter("result");
        String supporname = request.getParameter("supporname");
        String endtime = request.getParameter("endtime");
        String starttime = request.getParameter("starttime");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String HeatNo = request.getParameter("HeatNo");
        Map re = new HashMap();
        JSONObject jsonObject = new JSONObject();
        Materialreceive materialreceive = new Materialreceive();
        materialreceive.setPlant(plant);
        materialreceive.setIscheck(result);
        materialreceive.setSupporname(supporname);
        materialreceive.setReceivedate(starttime+" 00:00:00.000");
        materialreceive.setReceivedate1(endtime+" 23:59:59.000");
        materialreceive.setFno(fno);
        materialreceive.setFname(fname);
        materialreceive.setHeatno(HeatNo);
        List<Materialreceive> list = materialReceiveService.getReceviceInAll(materialreceive);
        int sum  = 0;
        if (list.size()>0){
          for(Materialreceive i :list){
              int num = Integer.parseInt(i.getReceivenum());
              sum = sum + num;
          }
        }
        re.put("pono","合计");
        re.put("receivenum",sum);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(re);
        jsonObject.put("rows",list);
        jsonObject.put("total",list.size());
        jsonObject.put("footer",jslst2);
        return  jsonObject;
    }
    @ResponseBody
    @RequestMapping(value = "/ReceviceOut",method={RequestMethod.GET, RequestMethod.POST})
    public JSONObject receviceOut (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONObject jsonObject = new JSONObject();
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String supporname = request.getParameter("supporname");
        String endtime = request.getParameter("endtime");
        String starttime = request.getParameter("starttime");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String HeatNo = request.getParameter("HeatNo");
        Example example = new Example(MMaterialsend.class);
        Example.Criteria criteria = example.createCriteria();
        String startime1 = starttime + " 00:00:00.000";
        String endtime1 = endtime + " 23:59:59.000";
        Timestamp startTime2=Timestamp.valueOf(startime1);
        Timestamp endtime2=Timestamp.valueOf(endtime1);
        criteria.andBetween("outputtime",startTime2,endtime2);
        if (StringUtil.isNotEmpty(fno)) {
            criteria.andLike("fno","%" +fno.trim()+"%");
        }
        if (StringUtil.isNotEmpty(fname)) {
            criteria.andLike("fname","%" +fname.trim()+"%");
        }
        if (StringUtil.isNotEmpty(HeatNo)) {
            criteria.andLike("heatno","%" +HeatNo.trim()+"%");
        }
        if (StringUtil.isNotEmpty(plant)){
            criteria.andEqualTo("plant",plant.trim());
        }
        if (StringUtil.isNotEmpty(supporname)){
            criteria.andEqualTo("supporname",supporname.trim());
        }
        List<MMaterialsend> list = materialSendService.selectByExample(example);
        Map re = new HashMap();
        int sum  = 0;
        if (list.size()>0){
            for(MMaterialsend i :list){
                int num = Integer.parseInt(i.getOutputnum());
                sum = sum + num;
            }
        }
        re.put("pono","合计");
        re.put("outputnum",sum);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(re);
        jsonObject.put("rows",list);
        jsonObject.put("total",list.size());
        jsonObject.put("footer",jslst2);
        return  jsonObject;
    }
    @ResponseBody
    @RequestMapping(value = "/ReceviceOutAll",method={RequestMethod.GET, RequestMethod.POST})
    public JSONObject receViceOutAll (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String result = request.getParameter("result");
        String supporname = request.getParameter("supporname");
        String endtime = request.getParameter("endtime");
        String starttime = request.getParameter("starttime");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String HeatNo = request.getParameter("HeatNo");
        Map re = new HashMap();
        JSONObject jsonObject = new JSONObject();
        Materialsend materialsend = new Materialsend();
        materialsend.setPlant(plant);
        materialsend.setSupporname(supporname);
        materialsend.setOutputtime(starttime+" 00:00:00.000");
        materialsend.setOutputtime1(endtime+" 23:59:59.000");
        materialsend.setFno(fno);
        materialsend.setFname(fname);
        materialsend.setHeatno(HeatNo);
        List<Materialsend> list = materialReceiveService.getReceviceOutAll(materialsend);
        int sum  = 0;
        if (list.size()>0){
            for(Materialsend i :list){
                int num = Integer.parseInt(i.getOutputnum());
                sum = sum + num;
            }
        }
        re.put("fno","合计");
        re.put("outputnum",sum);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(re);
        jsonObject.put("rows",list);
        jsonObject.put("total",list.size());
        jsonObject.put("footer",jslst2);
        return  jsonObject;
    }
}
