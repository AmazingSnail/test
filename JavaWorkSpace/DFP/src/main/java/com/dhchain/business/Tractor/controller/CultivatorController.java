package com.dhchain.business.Tractor.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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

//shougeji
@Controller
@RequestMapping(value = "/Cultivator")
public class CultivatorController {
    @Autowired
    private CultivatorService cultivatorService;
    @Autowired
    private TractorService tractorService;
    @Autowired
    private TBasedateService tBasedateService;
    @Autowired
    private TBasetyreService tBasetyreService;
    @Autowired
    private TBaseengineService tBaseengineService;
    @ResponseBody
    @RequestMapping(value = "/serach",method={RequestMethod.GET, RequestMethod.POST})
    public Map Serach (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        Example example = new Example(TCertharvester.class);
        Example.Criteria criteria = example.createCriteria();
        String ProductID = request.getParameter("ProductID");
        String serialID = request.getParameter("serialID");
        String OrderID = request.getParameter("OrderID");
        String plant = request.getParameter("plant");
        String plant2 = request.getParameter("plant2");
        String InspectionDate = request.getParameter("InspectionDate1");
        if (StringUtil.isNotEmpty(ProductID)) {
            criteria.andLike("productid","%" +ProductID.trim()+"%");
        }
        if(StringUtil.isNotEmpty(serialID)){
            criteria.andLike("serialid","%" +serialID.trim()+"%");
        }
        if(StringUtil.isNotEmpty(OrderID)){
            criteria.andLike("orderid","%" + OrderID.trim()+"%");
        }

        if(StringUtil.isNotEmpty(InspectionDate)){
            criteria.andEqualTo("inspectiondate",InspectionDate);
            if (StringUtil.isNotEmpty(plant) ) {
                criteria.andEqualTo("plant",plant2);
            }
        }else {
            String starttime1 = request.getParameter("starttime");
            String endtime1 = request.getParameter("endtime");
            String startime = starttime1 + " 00:00:00";
            String endtime = endtime1 + " 23:59:59";
            criteria.andGreaterThanOrEqualTo("inspectiondate",startime);
            criteria.andLessThanOrEqualTo("inspectiondate",endtime);
            if (StringUtil.isNotEmpty(plant) ) {
                criteria.andEqualTo("plant",plant);
            }
        }
        List<TCertharvester> list = cultivatorService.selectByExample(example);
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json ;
    }
    @ResponseBody
    @RequestMapping(value = "/Juge",method ={RequestMethod.GET,RequestMethod.POST})
    public Map Juge(HttpServletRequest request) throws UnsupportedEncodingException{
        Map json = new HashMap();
        String ZSERIB = request.getParameter("ZSERI");
        Example example = new Example(TCertharvester.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(ZSERIB) ) {
            criteria.andEqualTo("rackid",ZSERIB);
        }
        List<TCertharvester> list = cultivatorService.selectByExample(example);//排除存在拖拉机
        if(list.size()>0){
            json.put("num",list.size());
            json.put("rows",list);
        }else{
            json.put("num",-1);
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/irprint" ,method={RequestMethod.GET, RequestMethod.POST} )
    public void Irprint (HttpServletRequest request , HttpServletResponse resp) throws IOException, JRException {
        String temID1 = request.getParameter("serialno");
        String [] id1 = temID1.split(",");
        Date day=new Date();

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        List<Object> list = new ArrayList<>();
        ServletOutputStream out = resp.getOutputStream();
        List jasperPrintList = new ArrayList();
        for(int i = 0;i<id1.length;i++){
            String id = id1[i];
            Example example = new Example(TCertharvester.class);
            Example.Criteria criteria = example.createCriteria();
            if (StringUtil.isNotEmpty(id) ) {
                criteria.andEqualTo("id",id);
            }
            List<TCertharvester> list1 = cultivatorService.selectByExample(example);

            TCertharvester tCertharvester = new TCertharvester();
            if(list1.size()>0){
                InputStream inputStream = request.getServletContext().getResourceAsStream("ireport/Cultivator.jasper");
                tCertharvester = list1.get(0);
                Map<String,Object> map1 = new HashMap<String,Object>();
                map1.put("CertID",tCertharvester.getCertid());
                String CertDate1 = "";
                if(StringUtil.isNotEmpty(tCertharvester.getCertdate())){
                    String c =tCertharvester.getCertdate().substring(0,10);
                    String [] m = c.split("-");
                    CertDate1  =m[0]+"年"+m[1]+"月"+m[2]+"日";
                }else {
                    String c=  df.format(new Date());
                    String [] m = c.split("-");
                    CertDate1  =m[0]+"年"+m[1]+"月"+m[2]+"日";
                    TCertharvester tCertharvester1 = new TCertharvester();
                    tCertharvester1.setCertdate(df.format(day));
                    tCertharvester1.setId(Integer.parseInt(id));
                    int    n = cultivatorService.updateNotNull(tCertharvester1);
                }
                map1.put("CertDate",CertDate1);
                map1.put("SCQYMC",tCertharvester.getCompanyname());
                map1.put("PP",tCertharvester.getBrand());
                map1.put("LX",tCertharvester.getType());
                String s = tCertharvester.getZmach();
                Example example1 = new Example(TBasedate.class);
                Example.Criteria criteria1 = example1.createCriteria();
                if (StringUtil.isNotEmpty(s) ) {
                    criteria1.andEqualTo("zmach",s);
                }
                String model = "";
                String type = "";
                List<TBasedate> list2 = tBasedateService.selectByExample(example1);
                if(list2.size()>0){
                    TBasedate tBasedate;
                    tBasedate = list2.get(0);
                    model = tBasedate.getModel();
                    type = tBasedate.getType();
                }
                map1.put("ZCPXH",model+type);
                map1.put("ZCHYJ",tCertharvester.getZchyj());
                map1.put("ZFDJH",tCertharvester.getZfdjh());
                map1.put("Power",tCertharvester.getPower());
                map1.put("EmissionStd",tCertharvester.getEmissionstd());
                map1.put("FactoryID",tCertharvester.getFactoryid());
                map1.put("ZSERI",tCertharvester.getRackid());
                map1.put("BodyColor",tCertharvester.getBodycolor());
                map1.put("FS",tCertharvester.getControlmode());
                map1.put("Number",tCertharvester.getNumber());
                map1.put("AxleNum",tCertharvester.getAxlenum());
                map1.put("WheelBase",tCertharvester.getWheelbase());
                map1.put("TiresNum",tCertharvester.getTiresnum());

                map1.put("TireSpect",tCertharvester.getTirespect());
                map1.put("WheelSize",tCertharvester.getWheelsize());
                map1.put("TrackNumber",tCertharvester.getTracknumber());
                map1.put("TrackType",tCertharvester.getTracktype());
                map1.put("Gauge",tCertharvester.getGauge());
                map1.put("OutlineSize",tCertharvester.getOutsize());
                map1.put("DemarcatedForce",tCertharvester.getCutwidth());
                map1.put("MinUse",tCertharvester.getFeedvolume());
                map1.put("MaxLoad",tCertharvester.getHarmachquy());
                String Manufacturedate = tCertharvester.getManufacturedate().substring(0,10);
                String [] Manufacturedate1 = Manufacturedate.split("-");
                String Manufacturedate2 = Manufacturedate1[0]+"年"+Manufacturedate1[1]+"月"+Manufacturedate1[2]+"日";
                map1.put("ManufactureDate",Manufacturedate2);
                map1.put("ExecStd",tCertharvester.getExecstd());
                String qrcode = "合格证编号："+tCertharvester.getCertid()+" " +"发证日期："+CertDate1+" "
                        +"生产企业名称："+tCertharvester.getCompanyname()+" " +"品牌："+tCertharvester.getBrand()+" " + "类型："+ tCertharvester.getType()+" "
                        +"型号名称："+model+type+" "+ "发动机型号："+tCertharvester.getZchyj()+" "+"发动机号码："+tCertharvester.getZfdjh()
                        +" "+"功率/KW："+tCertharvester.getPower()+" "+ "排放标准号及排放阶段："+tCertharvester.getEmissionstd()+" "+
                        "出厂编号："+tCertharvester.getFactoryid()+" "+"底盘号："+tCertharvester.getRackid();
                map1.put("qrcode",qrcode);
                JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(list);
                resp.setContentType("application/pdf");
                JasperPrint jasperPrint1;
                //连打
                jasperPrint1 = JasperFillManager.fillReport(request.getServletContext().getResourceAsStream("ireport/Cultivator.jasper"), map1,jrDataSource);

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
    @ResponseBody
    @RequestMapping(value="/serachRFCS",method={RequestMethod.GET, RequestMethod.POST})
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
                    Example example = new Example(TCertharvester.class);
                    Example.Criteria criteria = example.createCriteria();
                    if (StringUtil.isNotEmpty(ZSERIB) ) {
                        criteria.andEqualTo("rackid",ZSERIB);
                    }
                    List<TCertharvester> list = cultivatorService.selectByExample(example);//排除存在拖拉机
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
    @RequestMapping(value = "/insert",method={RequestMethod.GET, RequestMethod.POST})
    public Map Insert (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        request.setCharacterEncoding("utf-8");
        String serialNum = request.getParameter("serialNum");
        String ProductNum = request.getParameter("ProductNum");
        String id = request.getParameter("ids");
        String ZCHYJ = request.getParameter("ZCHYJ");
        String user = request.getParameter("user");
        String time = request.getParameter("time");
        String Power = request.getParameter("Power");
        String Certdate = request.getParameter("Certdate");//发证日期
        String FactoryID = request.getParameter("FactoryID");
        String Gauge = request.getParameter("Gauge");
        String CutWidth = request.getParameter("CutWidth");
        String ZMACH = request.getParameter("ZMACH");
        String ZJYRQ = request.getParameter("ZJYRQ");
        String TrackType = request.getParameter("TrackType");
        String FeedVolume = request.getParameter("FeedVolume");
        String HarMachQuy = request.getParameter("HarMachQuy");
        String OutlineSize = request.getParameter("OutlineSize");
        String ManufactureDate = request.getParameter("CManufactureDate");
        String plant = request.getParameter("plant");//sap daima
        String plant1 = request.getParameter("plant1");//shiyebu
        String Zfdjh = request.getParameter("Zfdjh");
        String AUFNR = request.getParameter("AUFNR");
        if(StringUtil.isEmpty(plant)){
            plant="信息中心";
            plant1= "1001";
        }
        TBasedate tBasedate = new TBasedate();
        tBasedate.setZmach(ZMACH);
        String Execstd = "";
        List<TBasedate> list2 = tBasedateService.getBZ(tBasedate);
        if(list2.size()>0){
            TBasedate tBasedate1;
            tBasedate1 = list2.get(0);
            Execstd = tBasedate1.getExecstd();//biaozhun
        }
        TCertharvester tCertharvester = new TCertharvester();
        tCertharvester.setProductid(ProductNum);
        tCertharvester.setSerialid(serialNum);
        tCertharvester.setZchyj(ZCHYJ);
        tCertharvester.setPower(Power);
        tCertharvester.setOrderid(AUFNR);
        tCertharvester.setFactoryid(FactoryID);
        tCertharvester.setBodycolor("橙/白");
        tCertharvester.setWheelbase("—");
        tCertharvester.setWheelsize("—");
        tCertharvester.setAxlenum("—");
        tCertharvester.setTiresnum("—");
        tCertharvester.setOutsize(OutlineSize);
        tCertharvester.setCutwidth(CutWidth);
        tCertharvester.setFeedvolume(FeedVolume);
        tCertharvester.setHarmachquy(HarMachQuy);
        tCertharvester.setManufacturedate(ManufactureDate+" 00:00:00");//tian yaogai
        tCertharvester.setCertid("913204001371917928"+serialNum);
        //tCerttractor.setCertdate(new Date().toString());
        tCertharvester.setCompanyname("常州东风农机集团有限公司");
        tCertharvester.setBrand("东华牌");
        tCertharvester.setType("履带式联合收割（获）机");
        tCertharvester.setZcpxh(ZMACH+"履带式联合收割（获）机");
        tCertharvester.setZfdjh(Zfdjh);
        tCertharvester.setEmissionstd("GB 20891-2014第三阶段");
        tCertharvester.setFactoryid(serialNum);
        tCertharvester.setRackid(serialNum);
        tCertharvester.setCheckdate(ZJYRQ);
        tCertharvester.setControlmode("操纵杆式");
        tCertharvester.setNumber("1");
        tCertharvester.setTirespect("—");
        tCertharvester.setTracknumber("2");
        tCertharvester.setZmach(ZMACH);
        tCertharvester.setTracktype(TrackType);
        tCertharvester.setGauge(Gauge);
        tCertharvester.setExecstd("本产品经过出厂检验，符合"+ Execstd+ "    的要求，准予出厂，特此证明。  ");
        tCertharvester.setPlant(plant1);
        tCertharvester.setPlantins(plant);
        tCertharvester.setInspectiondate(ManufactureDate+" 00:00:00");

         if("".equals(id)){
             tCertharvester.setInputman(user);
             tCertharvester.setInputtime(time);
            int n = cultivatorService.InsertUseGeneratedKeysMapper(tCertharvester);
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
             tCertharvester.setCertdate(CertdateI+" 00:00:00");
             tCertharvester.setId(Integer.parseInt(id));
             tCertharvester.setModifyman(user);
             tCertharvester.setModifytime(time);
            int    n = cultivatorService.updateNotNull(tCertharvester);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/insertOther",method={RequestMethod.GET, RequestMethod.POST})
    public Map insertOther (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        request.setCharacterEncoding("utf-8");
        String serialNum = request.getParameter("serialNum");
        String id = request.getParameter("ids");
        String ZCHYJ = request.getParameter("ZCHYJ");
        String user = request.getParameter("user");
        String time = request.getParameter("time");
        String Power = request.getParameter("Power");
        String Certdate = request.getParameter("Certdate");//发证日期
        String FactoryID = request.getParameter("FactoryID");//生产订单号
        String CCBH = request.getParameter("CCBH");//出厂编号
        String Gauge = request.getParameter("Gauge");//轴距
        String HX = "";
        if(StringUtil.isEmpty(Gauge)){
            HX = "---";
        }else {
            HX = Gauge;
        }

        String Gauge1 = request.getParameter("Gauge1");//轨距
        String HX1 = "";
        if(StringUtil.isEmpty(Gauge1)){
            HX1 = "---";
        }else {
            HX1 = Gauge1;
        }
        String CutWidth = request.getParameter("CutWidth");
        String ZMACH = request.getParameter("ZMACH");
        String ZJYRQ = request.getParameter("ZJYRQ");
        String TrackType = request.getParameter("TrackType");
        String HX2 = "";
        if(StringUtil.isEmpty(TrackType)){
            HX2 = "---";
        }else {
            HX2= TrackType;
        }
        String FeedVolume = request.getParameter("FeedVolume");
        String HarMachQuy = request.getParameter("HarMachQuy");
        String OutlineSize = request.getParameter("OutlineSize");
        String ManufactureDate = request.getParameter("CManufactureDate");
        String plant = request.getParameter("plant");//sap daima
        String plant1 = request.getParameter("plant1");//shiyebu
        String Zfdjh = request.getParameter("Zfdjh");
        String OWheelSizeQ = request.getParameter("OWheelSizeQ");
        String OWheelSizeH = request.getParameter("OWheelSizeH");
        String OTireSpectQ = request.getParameter("OTireSpectQ");
        String OTireSpectH = request.getParameter("OTireSpectH");
        String AxleNum12 = request.getParameter("AxleNum12"); //轮胎数
        TBasedate tBasedate = new TBasedate();
        tBasedate.setZmach(ZMACH);
        String Execstd = "";
        List<TBasedate> list2 = tBasedateService.getBZ(tBasedate);
        if(list2.size()>0){
            TBasedate tBasedate1;
            tBasedate1 = list2.get(0);
            Execstd = tBasedate1.getExecstd();//biaozhun
        }
        TCertharvester tCertharvester = new TCertharvester();
        tCertharvester.setSerialid(serialNum);
        tCertharvester.setZchyj(ZCHYJ);
        tCertharvester.setPower(Power);
        tCertharvester.setOrderid(FactoryID);
        tCertharvester.setBodycolor("蓝色");
        tCertharvester.setWheelbase(HX);
        tCertharvester.setWheelsize(OTireSpectQ+"/"+OTireSpectH);
        tCertharvester.setAxlenum("2");
        tCertharvester.setTiresnum(AxleNum12);
        tCertharvester.setOutsize(OutlineSize);
        tCertharvester.setCutwidth(CutWidth);
        tCertharvester.setFeedvolume(FeedVolume);
        tCertharvester.setHarmachquy(HarMachQuy);
        tCertharvester.setManufacturedate(ManufactureDate+" 00:00:00");//tian yaogai
        tCertharvester.setCertid("913204001371917928"+CCBH);
        //tCerttractor.setCertdate(new Date().toString());
        tCertharvester.setCompanyname("常州东风农机集团有限公司");
        tCertharvester.setBrand("东华牌");
        tCertharvester.setType("棉花收获机");
        tCertharvester.setZcpxh(ZMACH+"自走式采棉机");
        tCertharvester.setZfdjh(Zfdjh);
        tCertharvester.setEmissionstd("GB 20891-2014第三阶段");
        tCertharvester.setFactoryid(CCBH);
        tCertharvester.setRackid(serialNum);
        tCertharvester.setCheckdate(ZJYRQ);
        tCertharvester.setControlmode("方向盘式");
        tCertharvester.setNumber("1");
        tCertharvester.setTirespect(OWheelSizeQ+"/"+OWheelSizeH);
        tCertharvester.setTracknumber("—");
        tCertharvester.setZmach(ZMACH);
        tCertharvester.setTracktype(HX2);
        tCertharvester.setGauge(HX1);
        tCertharvester.setExecstd("本产品经过出厂检验，符合"+ Execstd+ "    的要求，准予出厂，特此证明。  ");
        tCertharvester.setPlant(plant1);
        tCertharvester.setPlantins(plant);
        tCertharvester.setInspectiondate(ManufactureDate+" 00:00:00");

        if("".equals(id)){
            tCertharvester.setInputman(user);
            tCertharvester.setInputtime(time);
            int n = cultivatorService.InsertUseGeneratedKeysMapper(tCertharvester);
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
            tCertharvester.setCertdate(CertdateI+" 00:00:00");
            tCertharvester.setId(Integer.parseInt(id));
            tCertharvester.setModifyman(user);
            tCertharvester.setModifytime(time);
            int    n = cultivatorService.updateNotNull(tCertharvester);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/getLJQ",method={RequestMethod.GET, RequestMethod.POST})
    public JSON GetLJQ (HttpServletRequest request) throws UnsupportedEncodingException {
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
    @RequestMapping(value="/getLJH",method={RequestMethod.GET, RequestMethod.POST})
    public JSON GetLJH (HttpServletRequest request) throws UnsupportedEncodingException {
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
    @RequestMapping(value="/getZJ",method={RequestMethod.GET, RequestMethod.POST})
    public JSON GetZJ (HttpServletRequest request) throws UnsupportedEncodingException {
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
            List<TBasedate> list2 = tBasedateService.getZJType(tBasedate);
            if(list2.size()>0){
                for(int i =0;i<list2.size();i++){
                    Map re = new HashMap();
                    TBasedate tBasedate1;
                    tBasedate1 = list2.get(i);
                    String  Gauge = tBasedate1.getType();//轴距
                    re.put("Gauge",Gauge);
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
            List<TBasetyre> list = tBasetyreService.getsprect(tBasetyre);//后轮轮胎规格数据
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
            List<TBasetyre> list = tBasetyreService.getsprect1(tBasetyre);//后轮轮胎规格数据
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
    @RequestMapping(value = "/Deletedata",method = {RequestMethod.GET,RequestMethod.POST})
    public  Map Delete(HttpServletRequest request) throws  UnsupportedEncodingException {
        Map json =  new HashMap();
        request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("id");
        String [] id1 = ids.split(",");
        for(int j = 0;j<id1.length;j++) {
            String id = id1[j];
            int n = cultivatorService.deleteByPrimaryKey(Integer.parseInt(id));
            if(n>0){
                json.put("num",n);
            }else {
                json.put("num",-1);
            }
        }

        return json;
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
        String CNJX =ZMACH;//场内机型
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
                    String OutlineSize = tBasedate1.getOutsize();//尺寸
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
    @RequestMapping(value = "/Gauge",method = {RequestMethod.GET,RequestMethod.POST})
    public JSON Gauge(HttpServletRequest request) throws  UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if (StringUtil.isNotEmpty(ZMACH)) {
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            List<TBasetyre> list6 = tBasetyreService.getZJ(tBasetyre);//轴距
            if (list6.size() > 0) {
                for (int i = 0; i < list6.size(); i++) {
                    Map re = new HashMap();
                    TBasetyre tBasetyre1;
                    tBasetyre1 = list6.get(i);
                    String Gauge = tBasetyre1.getWheelsize();//前轮数据
                    re.put("Gauge", Gauge);
                    jslst.add(re);
                }
            }

        }

        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/Gauge1",method = {RequestMethod.GET,RequestMethod.POST})
    public JSON Gauge1(HttpServletRequest request) throws  UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if (StringUtil.isNotEmpty(ZMACH)) {
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            List<TBasetyre> list6 = tBasetyreService.getZJ1(tBasetyre);//轴距
            if (list6.size() > 0) {
                for (int i = 0; i < list6.size(); i++) {
                    Map re = new HashMap();
                    TBasetyre tBasetyre1;
                    tBasetyre1 = list6.get(i);
                    String Gauge = tBasetyre1.getWheelsize();//前轮数据
                    re.put("Gauge", Gauge);
                    jslst.add(re);
                }
            }
        }
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/TrackType",method = {RequestMethod.GET,RequestMethod.POST})
    public JSON TrackType(HttpServletRequest request) throws  UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if (StringUtil.isNotEmpty(ZMACH)) {
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            List<TBasetyre> list6 = tBasetyreService.getTireSpect(tBasetyre);//轴距
            if (list6.size() > 0) {
                for (int i = 0; i < list6.size(); i++) {
                    Map re = new HashMap();
                    TBasetyre tBasetyre1;
                    tBasetyre1 = list6.get(i);
                    String TrackType = tBasetyre1.getTirespect();//前轮数据
                    re.put("TrackType", TrackType);
                    jslst.add(re);
                }
            }

        }

        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/TrackType1",method = {RequestMethod.GET,RequestMethod.POST})
    public JSON TrackType1(HttpServletRequest request) throws  UnsupportedEncodingException {//采棉机和玉米机
        JSONArray jslst = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String ZMACH = request.getParameter("ZMACH");
        String CNJX = ZMACH;//场内机型
        if (StringUtil.isNotEmpty(ZMACH)) {
            TBasetyre tBasetyre = new TBasetyre();
            tBasetyre.setZmach(CNJX);
            List<TBasetyre> list6 = tBasetyreService.getTireSpect1(tBasetyre);//轴距
            if (list6.size() > 0) {
                for (int i = 0; i < list6.size(); i++) {
                    Map re = new HashMap();
                    TBasetyre tBasetyre1;
                    tBasetyre1 = list6.get(i);
                    String TrackType = tBasetyre1.getTirespect();//前轮数据
                    re.put("TrackType", TrackType);
                    jslst.add(re);
                }
            }

        }

        return jslst;
    }
}
