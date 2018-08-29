package com.dhchain.business.Tractor.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.Tractor.service.*;
import com.dhchain.business.Tractor.vo.*;
import com.dhchain.util.SAPConn;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoParameterList;
import com.sap.conn.jco.JCoTable;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import org.apache.poi.ss.formula.functions.T;
import org.dussan.vaadin.dcharts.base.BaseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;

//tuolaji
@Controller
@RequestMapping(value = "/Tractor")
public class TractorController {
@Autowired
private TractorService tractorService;
@Autowired
    private CultivatorService cultivatorService;
@Autowired
private TBasestatusService tBasestatusService;
@Autowired
private TBasedateService tBasedateService;
@Autowired
private TBasetyreService tBasetyreService;
@Autowired
private TBaseengineService tBaseengineService;
    @ResponseBody
    @RequestMapping(value="/serach",method={RequestMethod.GET, RequestMethod.POST})
    public Map Serach (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        TCerttractor tCerttractor = new TCerttractor();
        Example example = new Example(TCerttractor.class);
        Example.Criteria criteria = example.createCriteria();
        String ProductID = request.getParameter("ProductID");
        String serialID = request.getParameter("serialID");
        String OrderID = request.getParameter("OrderID");
        String plant = request.getParameter("plant2");
        String InspectionDate = request.getParameter("InspectionDate");
        if(StringUtil.isNotEmpty(InspectionDate)){
            criteria.andEqualTo("inspectiondate",InspectionDate);
        }else {
            String starttime1 = request.getParameter("starttime");
            String endtime1 = request.getParameter("endtime");
            String startime = starttime1 + " 00:00:00";
            String endtime = endtime1 + " 23:59:59";
            criteria.andGreaterThanOrEqualTo("inspectiondate",startime);
            criteria.andLessThanOrEqualTo("inspectiondate",endtime);
        }

        if (StringUtil.isNotEmpty(ProductID)) {
            criteria.andLike("productid","%" +ProductID.trim()+"%");
        }
        if(StringUtil.isNotEmpty(serialID)){
            criteria.andLike("serialid","%" +serialID.trim()+"%");
        }
        if(StringUtil.isNotEmpty(OrderID)){
            criteria.andLike("orderid","%" + OrderID.trim()+"%");
        }
        if (StringUtil.isNotEmpty(plant) ) {
            criteria.andEqualTo("plant",plant);
        }

        List<TCerttractor> list = tractorService.selectByExample(example);
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Query (HttpServletRequest request) throws UnsupportedEncodingException {

        Example example = new Example(TBasestatus.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("department","工厂");
        String plant = request.getParameter("plant");
        JSONArray jslst = new JSONArray();
        List<TBasestatus> list = tBasestatusService.selectByExample(example);
        if(list.size()>0){
            for(int i = 0 ;i<list.size();i++){
                Map re =  new HashMap();
                TBasestatus tBasestatus ;
                tBasestatus = list.get(i);
                String statusname = tBasestatus.getStatusname();
                String statusid = tBasestatus.getStatusid();
                re.put("statusname",statusname);
                re.put("statusid",statusid);
                if(plant.equals(statusname)){
                    re.put("selected",true);
                }
                jslst.add(re);
            }
        }
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value="/serachRFC",method={RequestMethod.GET, RequestMethod.POST})
    public JSON serachRFC (HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {


        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JCoFunction function = null;
        JCoDestination destination = SAPConn.connect();
        String result="";//调用接口返回状态
        String message="";//调用接口返回信息
        String ZSERIB = "";
        String ZSERI = request.getParameter("ZSERI");
        String AUFNR = request.getParameter("AUFNR");
        String WERKS = request.getParameter("WERKS");
        String ZJYRQBEGIN = request.getParameter("ZJYRQBEGIN");
        String ZJYRQEND = request.getParameter("ZJYRQEND");
        JSONArray jsonArray = new JSONArray();
        try {
            //调用ZDFP_O_001函数
            function = destination.getRepository().getFunction("ZDFP_O_001");
            JCoParameterList input = function.getImportParameterList();
            input.setValue("ZSERI", ZSERI);
            input.setValue("AUFNR", AUFNR);
            input.setValue("WERKS", WERKS);
            input.setValue("ZJYRQBEGIN", ZJYRQBEGIN);
            input.setValue("ZJYRQEND", ZJYRQEND);
            function.execute(destination);
            JCoTable TAB_RETURN = function.getTableParameterList().getTable("ZDFP_001");
            System.out.println(TAB_RETURN.getNumRows());
            if(TAB_RETURN.getNumRows()>0) {
                for (int num = 0; num < TAB_RETURN.getNumRows(); num++) {
                    Map json = new HashMap();
                    TAB_RETURN.setRow(num);
                    ZSERIB = TAB_RETURN.getString("ZSERI");
                    Example example = new Example(TCerttractor.class);
                    Example.Criteria criteria = example.createCriteria();
                    if (StringUtil.isNotEmpty(ZSERIB) ) {
                        criteria.andEqualTo("zseri",ZSERIB);
                    }
                    List<TCerttractor> list = tractorService.selectByExample(example);//排除存在拖拉机
                    if(list.size()>0){
                        continue;
                    }else{
                        json.put("WERKS",TAB_RETURN.getString("WERKS"));//工厂
                        json.put("AUFNR",TAB_RETURN.getString("AUFNR"));//生产订单号
                        json.put("ZSERI",TAB_RETURN.getString("ZSERI"));//序列号
                        json.put("ZMACH",TAB_RETURN.getString("ZMACH"));//机型
                        json.put("ZFDJH",TAB_RETURN.getString("ZFDJH"));//发动机号
                        json.put("ZCHYJ",TAB_RETURN.getString("ZCHYJ"));//柴油机
                        json.put("PLNBEZ",TAB_RETURN.getString("PLNBEZ"));//产品料号
                        json.put("MAKTX",TAB_RETURN.getString("MAKTX"));//物料描述
                        json.put("ZJYRQ",TAB_RETURN.getString("ZJYRQ"));//检验日期
                        jsonArray.add(json);
                    }

                }
            }
            Map re = new HashMap();
            re.put("num",TAB_RETURN.getNumRows());
            jsonArray.add(re);
        }catch (Exception e) {
            e.printStackTrace();
        }


        return jsonArray ;
    }
    @ResponseBody
    @RequestMapping(value = "/Juge",method ={RequestMethod.GET,RequestMethod.POST})
    public Map Juge(HttpServletRequest request) throws UnsupportedEncodingException{
        Map json = new HashMap();
        String ZSERIB = request.getParameter("ZSERI");
        Example example = new Example(TCerttractor.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(ZSERIB) ) {
            criteria.andEqualTo("zseri",ZSERIB);
        }
        List<TCerttractor> list = tractorService.selectByExample(example);//排除存在拖拉机
        if(list.size()>0){
            json.put("num",list.size());
            json.put("rows",list);
        }else{
            json.put("num",-1);
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Juge1",method ={RequestMethod.GET,RequestMethod.POST})
    public Map Juge1(HttpServletRequest request) throws UnsupportedEncodingException{
        Map json = new HashMap();
        String ZMACH = request.getParameter("ZMACH");
        Example example = new Example(TBasedate.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(ZMACH) ) {
            criteria.andEqualTo("zmach",ZMACH);
        }
        List<TBasedate> list = tBasedateService.selectByExample(example);//在主数据里面查询机型是否存在
        if(list.size()>0){
            json.put("num",list.size());
            json.put("rows",list);
        }else{
            json.put("num",-1);
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/insert",method={RequestMethod.GET, RequestMethod.POST})
    public Map Insert (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("ids");
        String serialNum = request.getParameter("serialNum");
        String ProductNum = request.getParameter("ProductNum");
        String ZCHYJ = request.getParameter("ZCHYJ");
        String user = request.getParameter("user");
        String time = request.getParameter("time");
        String Power = request.getParameter("Power");
        String Certdate = request.getParameter("Certdate");//发证日期
        String ZMACH = request.getParameter("ZMACH");
        String ZJYRQ = request.getParameter("ZJYRQ");//检验日期
        String CNJX = ZMACH;
        TBasedate tBasedate = new TBasedate();
        tBasedate.setZmach(CNJX);
        String Execstd = "";
        List<TBasedate> list2 = tBasedateService.getBZ(tBasedate);
        if(list2.size()>0){
                TBasedate tBasedate1;
                tBasedate1 = list2.get(0);
            Execstd = tBasedate1.getExecstd();//biaozhun
        }
        String FactoryID = request.getParameter("FactoryID");
        String BodyColor = request.getParameter("BodyColor");
         String WheelBase = request.getParameter("WheelBase");
         String WheelSizeH = request.getParameter("WheelSizeH");
         String WheelSizeQ = request.getParameter("WheelSizeQ");
         String AUFNR = request.getParameter("AUFNR");
         String WheelSize = WheelSizeQ.trim()+"|"+WheelSizeH.trim();//规格
         String AxleNum = request.getParameter("AxleNum");//轮胎数
         String plant = request.getParameter("plant");
         String plant2 = request.getParameter("plant1");//代码
        String Zfdjh = request.getParameter("Zfdjh");//发动机号码
         String type="" ;
         String Controlmode="" ;
         String AxleNum1="" ;//轮轴数
        int plant1 = 0;
        if(StringUtil.isEmpty(plant2)){
            plant2 = "信息中心";
            plant1 = 1001;
        }else {
            plant1   = Integer.parseInt(plant2.trim());
        }

        if(plant1==1050){
            type = "手扶拖拉机";
            Controlmode = "手扶式";
            AxleNum1 = "1";
            AxleNum = "2";
            Zfdjh = "—";
        }else {
            type = "轮式拖拉机";
            Controlmode = "方向盘式";
            AxleNum1 = "2";
        }
         String TireSpectQ = request.getParameter("TireSpectQ");
         String TireSpectH = request.getParameter("TireSpectH");
         String TireSpect = TireSpectQ.trim()+"|"+TireSpectH.trim();//轮距
         String OutlineSize1 = request.getParameter("OutlineSize");
         String [] ss = OutlineSize1.split("/");
         String OutlineSize = ss[0];
         String DemarcatedForce = request.getParameter("DemarcatedForce");
         String MinUse = request.getParameter("MinUse");
         String ManufactureDate = request.getParameter("ManufactureDate");
//        Example example1 = new Example(TBasedate.class);
//        Example.Criteria criteria1 = example1.createCriteria();
//        if (StringUtil.isNotEmpty(CNJX) ) {
//            criteria1.andEqualTo("zmach",CNJX);
//        }
//        String model = "";
//        List<TBasedate> list3 = tBasedateService.selectByExample(example1);
//        if(list2.size()>0){
//            TBasedate tBasedate1;
//            tBasedate1 = list3.get(0);
//            model = tBasedate.getModel();
//        }
         TCerttractor tCerttractor = new TCerttractor();
         tCerttractor.setProductid(ProductNum);
         tCerttractor.setSerialid(serialNum);
         tCerttractor.setZchyj(ZCHYJ);
         tCerttractor.setPower(Power);
         tCerttractor.setOrderid(AUFNR);
         tCerttractor.setCheckdate(ZJYRQ);
         tCerttractor.setFactoryid(FactoryID);
         tCerttractor.setBodycolor(BodyColor);
         tCerttractor.setWheelbase(WheelBase);
         tCerttractor.setWheelsize(TireSpect);
         tCerttractor.setAxlenum(AxleNum1);
         tCerttractor.setTirespect(WheelSize);
         tCerttractor.setOutlinesize(OutlineSize);
         tCerttractor.setDemarcatedforce(DemarcatedForce);
         tCerttractor.setMinuse(MinUse);
         tCerttractor.setManufacturedate(ManufactureDate+" 00:00:00");//tian yaogai
        tCerttractor.setCertid("913204001371917928"+serialNum);
        //tCerttractor.setCertdate(new Date().toString());
        tCerttractor.setCompanyname("常州东风农机集团有限公司");
        tCerttractor.setBrand("东风牌");
        tCerttractor.setZmach(CNJX);
        tCerttractor.setType(type);
        tCerttractor.setZcpxh(CNJX+type);
        tCerttractor.setZfdjh(Zfdjh);
        tCerttractor.setEmissionstd("GB 20891-2014第三阶段");
        tCerttractor.setFactoryid(serialNum);
        tCerttractor.setZseri(serialNum);
        tCerttractor.setControlmode(Controlmode);
        tCerttractor.setNumber("1");
        tCerttractor.setTiresnum(AxleNum);
        tCerttractor.setTracknumber("—");
        tCerttractor.setTracktype("—");
        tCerttractor.setGauge("—");
        tCerttractor.setMaxload("—");
        tCerttractor.setExecstd("本产品经过出厂检验，符合 "+ Execstd+ " 的要求，准予出厂，特此证明。  ");
        tCerttractor.setPlant(plant);
        tCerttractor.setPlantins(plant2);
        tCerttractor.setInspectiondate(ManufactureDate+" 00:00:00");

        if("".equals(id)){
            tCerttractor.setInputman(user);
            tCerttractor.setInputtime(time);
            int n =  tractorService.InsertUseGeneratedKeysMapper(tCerttractor);
//            int  n = 0;
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }else {
            String CertdateI = "";
            if("".equals(Certdate)){
                CertdateI = "";
            }else {
                CertdateI = Certdate;
            }
            tCerttractor.setCertdate(CertdateI+" 00:00:00");
            tCerttractor.setId(Integer.parseInt(id));
            tCerttractor.setModifyman(user);
            tCerttractor.setModifytime(time);
            int    n = tractorService.updateNotNull(tCerttractor);
//            int  n = 0;
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }


        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/Deletedata",method = {RequestMethod.GET,RequestMethod.POST})
    public  Map Delete(HttpServletRequest request) throws  UnsupportedEncodingException {
        Map json =  new HashMap();
        request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("id");
        String [] id1 = ids.split(",");
        for(int j = 0;j<id1.length;j++) {
            String id = id1[j];
            int n = tractorService.deleteByPrimaryKey(Integer.parseInt(id));
            if(n>0){
                json.put("num",n);
            }else {
                json.put("num",-1);
            }
        }

        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/irprint" ,method={RequestMethod.GET, RequestMethod.POST} )
    public void Irprint (HttpServletRequest request , HttpServletResponse resp) throws IOException, JRException {
        String temID1 = request.getParameter("serialno");
        String [] id1 = temID1.split(",");
        List<Object> list = new ArrayList<>();
        Date day=new Date();

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        ServletOutputStream out = resp.getOutputStream();
        List jasperPrintList = new ArrayList();
        for(int i = 0;i<id1.length;i++){
            String id = id1[i];
            Example example = new Example(TCerttractor.class);
            Example.Criteria criteria = example.createCriteria();
            if (StringUtil.isNotEmpty(id) ) {
                criteria.andEqualTo("id",id);
            }
            List<TCerttractor> list1 = tractorService.selectByExample(example);

            TCerttractor tCerttractor = new TCerttractor();
            if(list1.size()>0){
                InputStream inputStream = request.getServletContext().getResourceAsStream("ireport/Tractor.jasper");
                tCerttractor = list1.get(0);
                Map<String,Object> map1 = new HashMap<String,Object>();
                map1.put("CertID",tCerttractor.getCertid());
                String CertDate1 = "";
                if(StringUtil.isNotEmpty(tCerttractor.getCertdate())){
                    String c =tCerttractor.getCertdate().substring(0,10);
                    String [] m = c.split("-");
                    CertDate1  =m[0]+"年"+m[1]+"月"+m[2]+"日";
                }else {
                  String c=  df.format(new Date());
                    String [] m = c.split("-");
                    CertDate1  =m[0]+"年"+m[1]+"月"+m[2]+"日";
                    TCerttractor tCerttractor1 = new TCerttractor();
                    tCerttractor1.setCertdate(df.format(day));
                    tCerttractor1.setId(Integer.parseInt(id));
                    int    n = tractorService.updateNotNull(tCerttractor1);
                }

                map1.put("CertDate",CertDate1);
                map1.put("SCQYMC",tCerttractor.getCompanyname());
                map1.put("PP",tCerttractor.getBrand());
                map1.put("LX",tCerttractor.getType());
                String s = tCerttractor.getZmach();
                Example example1 = new Example(TBasedate.class);
                Example.Criteria criteria1 = example1.createCriteria();
                if (StringUtil.isNotEmpty(s) ) {
                    criteria1.andEqualTo("zmach",s);
                }
                String model = "";
                List<TBasedate> list2 = tBasedateService.selectByExample(example1);
                if(list2.size()>0){
                    TBasedate tBasedate;
                    tBasedate = list2.get(0);
                    model = tBasedate.getModel();
                }
                map1.put("ZCPXH",model+tCerttractor.getType());
                map1.put("ZCHYJ",tCerttractor.getZchyj());
                map1.put("ZFDJH",tCerttractor.getZfdjh());
                map1.put("Power",tCerttractor.getPower());
                map1.put("EmissionStd",tCerttractor.getEmissionstd());
                map1.put("FactoryID",tCerttractor.getFactoryid());
                map1.put("ZSERI",tCerttractor.getZseri());
                map1.put("BodyColor",tCerttractor.getBodycolor());
                map1.put("FS",tCerttractor.getControlmode());
                map1.put("Number",tCerttractor.getNumber());
                map1.put("AxleNum",tCerttractor.getAxlenum());
                String content2 = tCerttractor.getWheelbase();
                String outsize2 = "";
                if(content2.indexOf("（")!=-1){
                    String ss2 = content2.substring(content2.indexOf("（"),content2.indexOf("）")+1);
                    outsize2= content2.replace(ss2, ""); //最小质量
                }else {
                    outsize2  = content2;
                }
                map1.put("WheelBase",outsize2);
                map1.put("TiresNum",tCerttractor.getTiresnum());
                String Wheelsize1 =tCerttractor.getWheelsize();
                String [] a = Wheelsize1.split("\\|");
                String Wheelsize = a[0]+"/"+a[1];
                String Tirespect1 = tCerttractor.getTirespect();
                String [] b = Tirespect1.split("\\|");
                String Tirespect = b[0]+"/"+b[1];
                map1.put("TireSpect",Tirespect);
                map1.put("WheelSize",Wheelsize);
                map1.put("TrackNumber",tCerttractor.getTracknumber());
                map1.put("TrackType",tCerttractor.getTracktype());
                map1.put("Gauge",tCerttractor.getGauge());
                String content = tCerttractor.getOutlinesize();
                String outsize = "";
                if(content.indexOf("（")!=-1){
                    String ss = content.substring(content.indexOf("（"),content.indexOf("）")+1);
                    outsize = content.replace(ss, ""); //尺寸
                }else {
                    outsize  = content;
                }
                map1.put("OutlineSize",outsize);
                map1.put("DemarcatedForce",tCerttractor.getDemarcatedforce());
                String content1 = tCerttractor.getMinuse();
                String outsize1 = "";
                if(content1.indexOf("（")!=-1){
                    String ss1 = content1.substring(content1.indexOf("（"),content1.indexOf("）")+1);
                     outsize1 = content1.replace(ss1, ""); //最小质量
                }else {
                    outsize1  = content1;
                }
                map1.put("MinUse",outsize1);
                map1.put("MaxLoad",tCerttractor.getMaxload());
                String Manufacturedate = tCerttractor.getManufacturedate().substring(0,10);
                String [] Manufacturedate1 = Manufacturedate.split("-");
                String Manufacturedate2 = Manufacturedate1[0]+"年"+Manufacturedate1[1]+"月"+Manufacturedate1[2]+"日";
                map1.put("ManufactureDate",Manufacturedate2);
                map1.put("ExecStd",tCerttractor.getExecstd());
                String qrcode = "合格证编号："+tCerttractor.getCertid()+" " +"发证日期："+CertDate1+" "
                        +"生产企业名称："+tCerttractor.getCompanyname()+" " +"品牌："+tCerttractor.getBrand()+" " + "类型："+ tCerttractor.getType()+" "
                        +"型号名称："+model+tCerttractor.getType()+" "+ "发动机型号："+tCerttractor.getZchyj()+" "+"发动机号码："+tCerttractor.getZfdjh()
                        +" "+"功率/KW："+tCerttractor.getPower()+" "+ "排放标准号及排放阶段："+tCerttractor.getEmissionstd()+" "+
                        "出厂编号："+tCerttractor.getFactoryid()+" "+"底盘号："+tCerttractor.getZseri();
                map1.put("qrcode",qrcode);
                JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(list);
                resp.setContentType("application/pdf");
                JasperPrint jasperPrint1;
                //连打
                jasperPrint1 = JasperFillManager.fillReport(request.getServletContext().getResourceAsStream("ireport/Tractor.jasper"), map1,jrDataSource);

                jasperPrintList.add(jasperPrint1);
            }


        }
        JRPdfExporter exporter = new JRPdfExporter();
        exporter.setParameter(JRExporterParameter.JASPER_PRINT_LIST,jasperPrintList);
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, out);
//            exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);/**/
        exporter.setParameter(JRExporterParameter.CHARACTER_ENCODING, "UTF-8");
        exporter.exportReport();
        if (out != null){
            out.flush();
        }

//            out.flush();
        out.close();


    }
    public  String replace(String str) // 识别括号并将括号内容替换的函数
    {
        int head = str.indexOf('('); // 标记第一个使用左括号的位置
        if (head == -1)
            ; // 如果str中不存在括号，什么也不做，直接跑到函数底端返回初值str
        else {
            int next = head + 1; // 从head+1起检查每个字符
            int count = 1; // 记录括号情况
            do {
                if (str.charAt(next) == '(')
                    count++;
                else if (str.charAt(next) == ')')
                    count--;
                next++; // 更新即将读取的下一个字符的位置
                if (count == 0) // 已经找到匹配的括号
                {
                    String temp = str.substring(head, next); // 将两括号之间的内容及括号提取到temp中
                    str = str.replace(temp, ""); // 用空内容替换，复制给str
                    head = str.indexOf('('); // 找寻下一个左括号
                    next = head + 1; // 标记下一个左括号后的字符位置
                    count = 1; // count的值还原成1
                }
            } while (head != -1); // 如果在该段落中找不到左括号了，就终止循环
        }
        return str; // 返回更新后的str
    }
    @ResponseBody
    @RequestMapping(value="/look",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Look (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if(StringUtil.isNotEmpty(ZMACH)){
            TBaseengine tBaseengine = new TBaseengine();
            tBaseengine.setZmach(CNJX);
            TBasedate tBasedate = new TBasedate();
            tBasedate.setZmach(CNJX);
            List<TBaseengine> list = tBaseengineService.getDHJ(tBaseengine);
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            if(list.size()>0){
                for(int i =0;i<list.size();i++){
                    Map re = new HashMap();
                    TBaseengine tBaseengine1;
                    tBaseengine1 = list.get(i);
                    String ZCHYJ = tBaseengine1.getZchyj();//发动机
                    re.put("ZCHYJ",ZCHYJ);
                    jslst.add(re);
                }
            }
        }

        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/look1",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Look1 (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if(StringUtil.isNotEmpty(ZMACH)){
            TBaseengine tBaseengine = new TBaseengine();
            tBaseengine.setZmach(CNJX);
            TBasedate tBasedate = new TBasedate();
            tBasedate.setZmach(CNJX);

            List<TBaseengine> list1 = tBaseengineService.getDL(tBaseengine);
            if(list1.size()>0){
                for(int i =0;i<list1.size();i++){
                    Map re = new HashMap();
                    TBaseengine tBaseengine1;
                    tBaseengine1 = list1.get(i);
                    String Power = tBaseengine1.getPower();//功率
                    re.put("Power",Power);
                    jslst.add(re);
                }
            }

        }

        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/look2",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Look2 (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if(StringUtil.isNotEmpty(ZMACH)){
            TBaseengine tBaseengine = new TBaseengine();
            tBaseengine.setZmach(CNJX);
            TBasedate tBasedate = new TBasedate();
            tBasedate.setZmach(CNJX);
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            List<TBasedate> list2 = tBasedateService.getZJ(tBasedate);
            if(list2.size()>0){
                for(int i =0;i<list2.size();i++){
                    Map re = new HashMap();
                    TBasedate tBasedate1;
                    tBasedate1 = list2.get(i);
                    String  base = tBasedate1.getWheelbase();//轴距
                    re.put("base",base);
                    jslst.add(re);
                }
            }

        }

        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/look3",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Look3 (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if(StringUtil.isNotEmpty(ZMACH)){
            TBasedate tBasedate = new TBasedate();
            tBasedate.setZmach(CNJX);
            List<TBasedate> list3 = tBasedateService.getSize(tBasedate);
            if(list3.size()>0){
                for(int i =0;i<list3.size();i++){
                    Map re = new HashMap();
                    TBasedate tBasedate1;
                    tBasedate1 = list3.get(i);
                    String type = tBasedate1.getType();
                    String OutlineSize = "";
                    if(StringUtil.isEmpty(type)){
                         OutlineSize = tBasedate1.getOutsize();//尺寸
                    }else {
                        OutlineSize = tBasedate1.getOutsize() + "/" + tBasedate1.getType() ;
                    }

                    re.put("OutlineSize",OutlineSize);
                    jslst.add(re);
                }
            }

        }

        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/look4",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Look4 (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if(StringUtil.isNotEmpty(ZMACH)){
            TBasedate tBasedate = new TBasedate();
            tBasedate.setZmach(CNJX);
            List<TBasedate> list4 = tBasedateService.getForce(tBasedate);
            if(list4.size()>0){
                for(int i =0;i<list4.size();i++){
                    Map re = new HashMap();
                    TBasedate tBasedate1;
                    tBasedate1 = list4.get(i);
                    String force = tBasedate1.getDemarcatedforce();//牵引力
                    re.put("force",force);
                    jslst.add(re);
                }
            }

        }

        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/look5",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Look5 (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if(StringUtil.isNotEmpty(ZMACH)){
            TBaseengine tBaseengine = new TBaseengine();
            tBaseengine.setZmach(CNJX);
            TBasedate tBasedate = new TBasedate();
            tBasedate.setZmach(CNJX);
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            List<TBasedate> list5 = tBasedateService.getUse(tBasedate);
            if(list5.size()>0){
                for(int i =0;i<list5.size();i++){
                    Map re = new HashMap();
                    TBasedate tBasedate1;
                    tBasedate1 = list5.get(i);
                    String MinUse = tBasedate1.getMinuse();//最小重量
                    re.put("MinUse",MinUse);
                    jslst.add(re);
                }
            }

        }

        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/look6",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Look6 (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if(StringUtil.isNotEmpty(ZMACH)){
            TBaseengine tBaseengine = new TBaseengine();
            tBaseengine.setZmach(CNJX);
            TBasedate tBasedate = new TBasedate();
            tBasedate.setZmach(CNJX);
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            List<TBasetyre> list6 = tBasetyreService.getQL(tBasetyre);//前轮数据
            if(list6.size()>0){
                for(int i =0;i<list6.size();i++){
                    Map re = new HashMap();
                    TBasetyre tBasetyre1;
                    tBasetyre1 = list6.get(i);
                    String WheelSizeQ = tBasetyre1.getTirespect();//前轮数据
                    re.put("WheelSizeQ",WheelSizeQ);
                    jslst.add(re);
                }
            }

        }

        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/look7",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Look7 (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if(StringUtil.isNotEmpty(ZMACH)){
            TBaseengine tBaseengine = new TBaseengine();
            tBaseengine.setZmach(CNJX);
            TBasedate tBasedate = new TBasedate();
            tBasedate.setZmach(CNJX);
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            List<TBasetyre> list7 = tBasetyreService.getHL(tBasetyre);//后轮数据
            if(list7.size()>0){
                for(int i =0;i<list7.size();i++){
                    Map re = new HashMap();
                    TBasetyre tBasetyre1;
                    tBasetyre1 = list7.get(i);
                    String WheelSizeH = tBasetyre1.getTirespect();//后轮数据
                    re.put("WheelSizeH",WheelSizeH);
                    jslst.add(re);
                }
            }

        }

        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/sprect",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Sprect (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String n = request.getParameter("n");
        String CNJX = ZMACH;//场内机型
        if(StringUtil.isNotEmpty(ZMACH)){
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            tBasetyre.setTirespect(n);
            List<TBasetyre> list = tBasetyreService.getsprect(tBasetyre);//后轮轮胎轮距数据
            if(list.size()>0){
                for(int i =0;i<list.size();i++){
                    Map re = new HashMap();
                    TBasetyre tBasetyre1;
                    tBasetyre1 = list.get(i);
                    String TireSpectH = tBasetyre1.getWheelsize();//后轮数据
                    re.put("TireSpectH",TireSpectH);
                    jslst.add(re);
                }
            }

        }

        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/sprect1",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Sprect1 (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String n = request.getParameter("n");
        String CNJX = ZMACH;//场内机型
        if(StringUtil.isNotEmpty(ZMACH)){
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            tBasetyre.setTirespect(n);
            List<TBasetyre> list = tBasetyreService.getsprect1(tBasetyre);//后轮轮胎轮距数据
            if(list.size()>0){
                for(int i =0;i<list.size();i++){
                    Map re = new HashMap();
                    TBasetyre tBasetyre1;
                    tBasetyre1 = list.get(i);
                    String TireSpectQ = tBasetyre1.getWheelsize();//后轮数据
                    re.put("TireSpectQ",TireSpectQ);
                    jslst.add(re);
                }
            }

        }

        return  jslst;
    }
    @ResponseBody
    @RequestMapping(value="/query2",method={RequestMethod.GET,RequestMethod.POST})
    public JSON Query2 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        List<TBasestatus> list = tBasedateService.getStauts();
        JSONArray jslst = new JSONArray();
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                Map re = new HashMap();
                TBasestatus tBasestatus ;
                tBasestatus = list.get(i);
                String department = tBasestatus.getStatusname();
                String id = tBasestatus.getStatusid();
                re.put("text",department);
                re.put("id",id);
                jslst.add(re);
            }
        }

        return jslst;

    }
    @ResponseBody
    @RequestMapping(value="/queryUser",method={RequestMethod.GET,RequestMethod.POST})
    public JSON QueryUser (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String User = request.getParameter("user");
        Uuser uuser = new Uuser();
        uuser.setLogin_name(User);
        List<Uuser> list = tBasedateService.getUser(uuser);
        JSONArray jslst = new JSONArray();
        if(list.size()>0){
            for(int i =0 ;i<list.size();i++){
                Map re = new HashMap();
                Uuser uuser1 ;
                uuser1 = list.get(i);
                String name = uuser1.getName();
                re.put("name",name);
                jslst.add(re);
            }
        }

        return jslst;

    }

    @ResponseBody
    @RequestMapping(value="/query1",method={RequestMethod.GET,RequestMethod.POST})
    public Map Query1 (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String name = request.getParameter("name");
        String BZmach = request.getParameter("BZmach");
        String plant = request.getParameter("plant");
         Map json = new HashMap();
        if(name.equals("车型合格证主数据")){
            Example example = new Example(TBasedate.class);
            Example.Criteria criteria = example.createCriteria();
            if(StringUtil.isNotEmpty(BZmach)){
                criteria.andEqualTo("zmach",BZmach);
            }
            if(StringUtil.isNotEmpty(plant)){
                criteria.andEqualTo("plant",plant);
            }
            List<TBasedate> list = tBasedateService.selectByExample(example);
            if(list.size()>0){
                json.put("rows",list);
                json.put("total",list.size());
            }
        }else if (name.equals("车型发动机")){
            Example example = new Example(TBaseengine.class);
            Example.Criteria criteria = example.createCriteria();
            if(StringUtil.isNotEmpty(BZmach)){
                criteria.andEqualTo("zmach",BZmach);
            }
            if(StringUtil.isNotEmpty(plant)){
                criteria.andEqualTo("plant",plant);
            }
            List<TBaseengine> list = tBaseengineService.selectByExample(example);
            if(list.size()>0){
                json.put("rows",list);
                json.put("total",list.size());
            }
        }else if (name.equals("车型轮胎")){
            Example example = new Example(TBasetyre.class);
            Example.Criteria criteria = example.createCriteria();
            if(StringUtil.isNotEmpty(BZmach)){
                criteria.andEqualTo("zmach",BZmach);
            }
            if(StringUtil.isNotEmpty(plant)){
                criteria.andEqualTo("plant",plant);
            }
            List<TBasetyre> list = tBasetyreService.selectByExample(example);
            if(list.size()>0){
                json.put("rows",list);
                json.put("total",list.size());
            }
        }

        return  json;

    }
    @ResponseBody
    @RequestMapping(value = "/Insert1",method = {RequestMethod.GET,RequestMethod.POST})
    public Map Insert1(HttpServletRequest request ) throws  UnsupportedEncodingException{
        Map json = new HashMap();
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String ZMACH = request.getParameter("ZMACH");
        String Type = request.getParameter("Type");
        String plant = request.getParameter("plant");
        String Model = request.getParameter("Model");
        String Wheelbase = request.getParameter("Wheelbase");
        String Outsize = request.getParameter("Outsize");
        String DemarcatedForce = request.getParameter("DemarcatedForce");
        String MinUse = request.getParameter("MinUse");
        String ExecStd = request.getParameter("ExecStd");
        String i = request.getParameter("i");
        String id = request.getParameter("id");
        TBasedate tBasedate = new TBasedate();
        tBasedate.setZmach(ZMACH);
        tBasedate.setDemarcatedforce(DemarcatedForce);
        tBasedate.setExecstd(ExecStd);
        tBasedate.setType(Type);
        tBasedate.setMinuse(MinUse);
        tBasedate.setModel(Model);
        tBasedate.setWheelbase(Wheelbase);
        tBasedate.setOutsize(Outsize);
        tBasedate.setPlant(plant);
        if(StringUtil.isNotEmpty(id)){
            tBasedate.setId(Integer.parseInt(id));
            tBasedate.setModifyman(name);
            tBasedate.setModifytime(time);
            int    n = tBasedateService.updateNotNull(tBasedate);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }else {
            tBasedate.setInputman(name);
            tBasedate.setInputtime(time);
            int n = tBasedateService.InsertUseGeneratedKeysMapper(tBasedate);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value = "/Insert2",method = {RequestMethod.GET,RequestMethod.POST})
    public Map Insert2(HttpServletRequest request ) throws  UnsupportedEncodingException{
        Map json = new HashMap();
        String time = request.getParameter("time");
            String name = request.getParameter("name");
        String ZMACH = request.getParameter("ZMACH");
        String ZCHYJ = request.getParameter("ZCHYJ");
        String Power = request.getParameter("Power");
        String i = request.getParameter("i");
        String plant = request.getParameter("plant");
        String id = request.getParameter("id");
       TBaseengine tBaseengine = new TBaseengine();
        tBaseengine.setZmach(ZMACH);
        tBaseengine.setZchyj(ZCHYJ);
        tBaseengine.setPower(Power);
        tBaseengine.setPlant(plant);
        if(StringUtil.isNotEmpty(id)){
            tBaseengine.setId(Integer.parseInt(id));
            tBaseengine.setModifyman(name);
            tBaseengine.setModifytime(time);
            int    n = tBaseengineService.updateNotNull(tBaseengine);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }else {
            tBaseengine.setInputman(name);
            tBaseengine.setInputtime(time);
            int n = tBaseengineService.InsertUseGeneratedKeysMapper(tBaseengine);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value = "/Insert3",method = {RequestMethod.GET,RequestMethod.POST})
    public Map Insert3(HttpServletRequest request ) throws  UnsupportedEncodingException{
        Map json = new HashMap();
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String ZMACH = request.getParameter("ZMACH");
        String Tyresize = request.getParameter("Tyresize");
        String Wheelsize = request.getParameter("Wheelsize");//轮胎型号
        String TireSpect = request.getParameter("TireSpect");
        String plant = request.getParameter("plant");
        String i = request.getParameter("i");
        String id = request.getParameter("id");
         TBasetyre tBasetyre = new TBasetyre();
         tBasetyre.setZmach(ZMACH);
         tBasetyre.setTyresize(Tyresize);
         tBasetyre.setWheelsize(Wheelsize);
         tBasetyre.setTirespect(TireSpect);
         tBasetyre.setPlant(plant);
        if(StringUtil.isNotEmpty(id)){
            tBasetyre.setId(Integer.parseInt(id));
            tBasetyre.setModifyman(name);
            tBasetyre.setModifytime(time);
            int    n = tBasetyreService.updateNotNull(tBasetyre);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }else {
            tBasetyre.setInputman(name);
            tBasetyre.setInputtime(time);
            int n = tBasetyreService.InsertUseGeneratedKeysMapper(tBasetyre);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value = "/Delete",method = {RequestMethod.GET,RequestMethod.POST})
    public Map Del(HttpServletRequest request) throws UnsupportedEncodingException{
        request.setCharacterEncoding("utf-8");
        String i = request.getParameter("i");
        String ids = request.getParameter("id");
        String [] id1 = ids.split(",");
        Map json = new HashMap();
        for(int j = 0;j<id1.length;j++) {
            String id = id1[j];
            if(i.equals("车型合格证主数据")){
                int n = tBasedateService.deleteByPrimaryKey(Integer.parseInt(id));
                if(n>0){
                    json.put("num",n);
                }else {
                    json.put("num",-1);
                }
            }else if(i.equals("车型发动机")){
                int n = tBaseengineService.deleteByPrimaryKey(Integer.parseInt(id));
                if(n>0){
                    json.put("num",n);
                }else {
                    json.put("num",-1);
                }
            }else if(i.equals("车型轮胎")){
                int n = tBasetyreService.deleteByPrimaryKey(Integer.parseInt(id));
                if(n>0){
                    json.put("num",n);
                }else {
                    json.put("num",-1);
                }
            }
        }


        return json;
    }
    @ResponseBody
    @RequestMapping(value="/import",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject impotr(HttpServletRequest request, @RequestParam(value = "uploadFile", required = false) MultipartFile file) throws Exception {
        //获取上传的文件
        String User =request.getParameter("User");
        String i =request.getParameter("i");

        String time = request.getParameter("time");
        MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
        MultipartFile file1 = multipart.getFile("uploadFile");
        InputStream in = file1.getInputStream();
        JSONObject re = new JSONObject();
        if(i.equals("车型合格证主数据")){
            //数据导入
            String  back = tBasedateService.importExcelInfo1(in,file,User,time);
//        in.close();

            if(back.equals("OK")){
                re.put("success","true");
                re.put("message","导入成功");
            }else
            {
                re.put("success", "false");
                re.put("message", back);
            }
        }else if(i.equals("车型发动机")){
            //数据导入
            String  back = tBaseengineService.importExcelInfo1(in,file,User,time);
//        in.close();

            if(back.equals("OK")){
                re.put("success","true");
                re.put("message","导入成功");
            }else
            {
                re.put("success", "false");
                re.put("message", back);
            }
        }else if(i.equals("车型轮胎")){
            //数据导入
            String  back = tBasetyreService.importExcelInfo1(in,file,User,time);
//        in.close();

            if(back.equals("OK")){
                re.put("success","true");
                re.put("message","导入成功");
            }else
            {
                re.put("success", "false");
                re.put("message", back);
            }
        }

        return  re;
    }
}
