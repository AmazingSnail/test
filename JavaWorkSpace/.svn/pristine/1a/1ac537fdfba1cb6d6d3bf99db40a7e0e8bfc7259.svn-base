package com.dhchain.business.colddigitalworkshop.controller;

import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.colddigitalworkshop.service.ColdStoreService;
import com.dhchain.business.colddigitalworkshop.service.MaterialtakeinService;
import com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn;
import com.dhchain.business.colddigitalworkshop.vo.ColdStore;
import com.dhchain.business.colddigitalworkshop.vo.ColdStoreKey;
import com.dhchain.util.SAPConn;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoParameterList;
import com.sap.conn.jco.JCoTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/Materialtakein")
public class MaterialtakeinController {
    @Autowired
    private MaterialtakeinService materialtakeinService;
    @Autowired
    private ColdStoreService coldStoreService;
    @ResponseBody
    @RequestMapping(value = "/selectColdmaterlin", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdmaterlin(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        ColdMaterialIn ColdMaterialIn = new ColdMaterialIn();
        String plant = request.getParameter("plant");
        String inputman = request.getParameter("inputman");
        String PoNo = request.getParameter("PoNo");
        String type = request.getParameter("type");
        ColdMaterialIn.setPlant(plant);
        ColdMaterialIn.setInputman(inputman);
        ColdMaterialIn.setPono(PoNo);
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String dateNowStr = sdf.format(d);
        if(type!= null && !"".equals(type)){
            ColdMaterialIn.setInputdate(dateNowStr);
        }
        List<com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn> list = materialtakeinService.selectColdmaterlin(ColdMaterialIn);
        com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn RColdMaterialIn = new ColdMaterialIn();
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                RColdMaterialIn = list.get(i);
                Integer id = RColdMaterialIn.getId();
                String serialno = RColdMaterialIn.getSerialno();
                String PoItem = RColdMaterialIn.getPoitem();
                String fno = RColdMaterialIn.getFno();
                String fname = RColdMaterialIn.getFname();
                Double Number = RColdMaterialIn.getNumber();
                Double PoNumber = RColdMaterialIn.getPonumber();
                Double TakeNumber = RColdMaterialIn.getTakenumber();
                Double LeftNumber = RColdMaterialIn.getLeftnumber();
                Boolean isok = RColdMaterialIn.getIsok();
                String LGORT = RColdMaterialIn.getLgort();
                String unit = RColdMaterialIn.getUnit();
                Boolean isMove = RColdMaterialIn.getIsmove();
                String Moveman = RColdMaterialIn.getMoveman();
                String Movedate = RColdMaterialIn.getMovedate();
                Double UpLimit = RColdMaterialIn.getUplimit();
                Double DownLimit = RColdMaterialIn.getDownlimit();
                Boolean IsDone = RColdMaterialIn.getIsdone();
                Integer uyear = RColdMaterialIn.getUyear();
                Integer umonth = RColdMaterialIn.getUmonth();
                String SupportNo = RColdMaterialIn.getSupportno();
                String SupportName = RColdMaterialIn.getSupportname();
                String EKORG = RColdMaterialIn.getEkorg();
                String EKORGName = RColdMaterialIn.getEkorgname();
                String EKGRP = RColdMaterialIn.getEkgrp();
                String EKGRPName = RColdMaterialIn.getEkgrpname();
                String PoCreatTime = RColdMaterialIn.getPocreattime();
                String BUKRS = RColdMaterialIn.getBukrs();
                Boolean MoveOk = RColdMaterialIn.getMoveok();
                Boolean ReturnOk = RColdMaterialIn.getReturnok();
                String StockType = RColdMaterialIn.getStocktype();
                String MaterialDoc = RColdMaterialIn.getMaterialdoc();
                String MaterialDocYear = RColdMaterialIn.getMaterialdocyear();
                String MaterialDocItem = RColdMaterialIn.getMaterialdocitem();
                String BatchNo = RColdMaterialIn.getBatchno();
                Boolean IsTrans = RColdMaterialIn.getIstrans();
                String TransMan = RColdMaterialIn.getTransman();
                String TransDate = RColdMaterialIn.getTransdate();
                Boolean MoneyState = RColdMaterialIn.getMoneystate();
                Double NETPR = RColdMaterialIn.getNetpr();
                Double PEINH = RColdMaterialIn.getPeinh();
                String location = RColdMaterialIn.getLocation();
                String materialtype = RColdMaterialIn.getMaterialtype();
                String steelworks = RColdMaterialIn.getSteelworks();
                re.put("id", id);
                re.put("serialno", serialno);
                re.put("PoNo", PoNo);
                re.put("PoItem", PoItem);
                re.put("fno", fno);
                re.put("fname", fname);
                re.put("Number", Number);
                re.put("PoNumber", PoNumber);
                re.put("TakeNumber", TakeNumber);
                re.put("LeftNumber", LeftNumber);
                re.put("isok", isok);
                re.put("LGORT", LGORT);
                re.put("unit", unit);
                re.put("inputman", inputman);
                re.put("isMove", isMove);
                re.put("Moveman", Moveman);
                re.put("Movedate", Movedate);
                re.put("plant", plant);
                re.put("UpLimit", UpLimit);
                re.put("DownLimit", DownLimit);
                re.put("IsDone", IsDone);
                re.put("uyear", uyear);
                re.put("umonth", umonth);
                re.put("SupportNo", SupportNo);
                re.put("SupportName", SupportName);
                re.put("EKORG", EKORG);
                re.put("EKORGName", EKORGName);
                re.put("EKGRP", EKGRP);
                re.put("EKGRPName", EKGRPName);
                re.put("PoCreatTime", PoCreatTime);
                re.put("BUKRS", BUKRS);
                re.put("MoveOk", MoveOk);
                re.put("ReturnOk", ReturnOk);
                re.put("StockType", StockType);
                re.put("MaterialDoc", MaterialDoc);
                re.put("MaterialDocYear", MaterialDocYear);
                re.put("MaterialDocItem", MaterialDocItem);
                re.put("BatchNo", BatchNo);
                re.put("IsTrans", IsTrans);
                re.put("TransMan", TransMan);
                re.put("TransDate", TransDate);
                re.put("MoneyState", MoneyState);
                re.put("NETPR", NETPR);
                re.put("PEINH", PEINH);
                re.put("location", location);
                re.put("materialtype", materialtype);
                re.put("steelworks", steelworks);
                jslst.add(re);
            }
        }
        json.put("rows", jslst);
        json.put("total", list.size());
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/ZMM_O_003M7", method = {RequestMethod.GET, RequestMethod.POST})
    public Map ZMM_O_003M7(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JCoFunction function = null;
        JCoDestination destination = SAPConn.connect();
        String PlantIn = "";//需传入接口的事业部
        String LGORT = "";//需传入接口的库存地点
        String plant = request.getParameter("plant");
        String UserName = request.getParameter("UserName");
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        try {
            //调用ZEP_O_019函数
            function = destination.getRepository().getFunction("ZMM_O_004");
            JCoParameterList input = function.getImportParameterList();
//            //调用接口模块
            input.setValue("SMODEL", 7);
            input.setValue("S_EBELN", request.getParameter("PoNo"));
            if (request.getParameter("SupportNo") != null && !"".equals(request.getParameter("SupportNo").trim())) {
                input.setValue("S_LIFNR", "0000" + request.getParameter("SupportNo"));
            }
            PlantIn = materialtakeinService.getPlantIn(request.getParameter("plant"));
            LGORT = materialtakeinService.getLGORTIn(plant, UserName);
            input.setValue("S_WERKS", PlantIn);
            input.setValue("S_LGORT", LGORT);

            function.execute(destination);//执行接口程序
            JCoTable tb = function.getTableParameterList().getTable("POHEAD");
            for (int i = 0; i < tb.getNumRows(); i++) {
                tb.setRow(i);
                Map re = new HashMap();
                if (tb.getString("EBELN").substring(0, 2).equals("55")) {
                    re.put("id", i);
                    re.put("LIFNR", tb.getString("LIFNR"));
                    re.put("NAME1", tb.getString("NAME1"));
                    re.put("EBELN", tb.getString("EBELN"));
                    jslst.add(re);
                }
            }
            json.put("rows", jslst);
            json.put("total", tb.getNumRows());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/ZMM_O_003M5", method = {RequestMethod.GET, RequestMethod.POST})
    public Map ZMM_O_003M5(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JCoFunction function = null;
        JCoDestination destination = SAPConn.connect();
        String PlantIn = "";//需传入接口的事业部
        String LGORT = "";//需传入接口的库存地点
        String UserName = request.getParameter("UserName");
        String plant = request.getParameter("plant");
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        try {
            //调用ZMM_O_003函数
            function = destination.getRepository().getFunction("ZMM_O_004");
            JCoParameterList input = function.getImportParameterList();
//            //调用接口模块
            input.setValue("SMODEL", 5);
            input.setValue("S_EBELN", request.getParameter("PoNo"));
            if (request.getParameter("SupportNo") != null && !"".equals(request.getParameter("SupportNo").trim())) {
                input.setValue("S_LIFNR", request.getParameter("SupportNo"));
            }
            LGORT = materialtakeinService.getLGORTIn(plant, UserName);
            PlantIn = materialtakeinService.getPlantIn(request.getParameter("plant"));

            input.setValue("S_WERKS", PlantIn);
            input.setValue("S_LGORT", LGORT);

            function.execute(destination);//执行接口程序
            JCoTable tbhead = function.getTableParameterList().getTable("POHEAD");
            JCoTable tbitem = function.getTableParameterList().getTable("POITEM");
            if (tbhead.getNumRows() > 0) {
                tbhead.setRow(1);
                if (tbhead.getString("FRGZU").equals("X")) {
                    if (tbitem.getNumRows() > 0) {
                        for (int i = 0; i < tbitem.getNumRows(); i++) {
                            tbitem.setRow(i);
                            Map re = new HashMap();
                            re.put("EBELP", tbitem.getString("EBELP"));//行项目
                            re.put("MATNR", tbitem.getString("MATNR"));//编码
                            re.put("TXZ01", tbitem.getString("TXZ01"));//物料描述
                            re.put("MENGE", tbitem.getString("MENGE"));//采购数量
                            re.put("T_MENGE", tbitem.getString("T_MENGE"));//已收数量
                            re.put("L_MENGE", tbitem.getString("L_MENGE"));//剩余数量
                            re.put("EVERS", tbitem.getString("EVERS"));
                            re.put("LGORT", tbitem.getString("LGORT"));//收货地点
                            re.put("ELIKZ", tbitem.getString("ELIKZ"));//收货完成
                            re.put("R_MENGE", tbitem.getString("R_MENGE"));//退货数量
                            re.put("MEINS", tbitem.getString("MEINS"));//单位
                            re.put("UEBTO", tbitem.getString("UEBTO"));//过量限度
                            re.put("UNTTO", tbitem.getString("UNTTO"));//不足限度
                            re.put("WERKS", tbitem.getString("WERKS"));//工厂
                            re.put("NETPR", tbitem.getString("NETPR"));//净价
                            re.put("PEINH", tbitem.getString("PEINH"));//价格单位
                            jslst.add(re);
                        }
                    }
                }
            }

            json.put("rows", jslst);
            json.put("total", tbitem.getNumRows());
            json.put("LIFNR", tbhead.getString("LIFNR"));//供应商代码
            json.put("NAME1", tbhead.getString("NAME1"));//供应商名称
            json.put("EKORG", tbhead.getString("EKORG"));//采购组织
            json.put("EKGRP", tbhead.getString("EKGRP"));//采购组
            json.put("BUKRS", tbhead.getString("BUKRS"));//公司代码
            json.put("AEDAT", tbhead.getString("AEDAT"));//更改日期
            json.put("EKOTX", tbhead.getString("EKOTX"));//采购组织描述
            json.put("EKNAM", tbhead.getString("EKNAM"));//采购组描述
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/insertColdmsg", method = {RequestMethod.GET, RequestMethod.POST})
    public Map insertColdmsg(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String PoNo = request.getParameter("PoNo");
        String PoItem = request.getParameter("PoItem");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String inputman = request.getParameter("inputman");
        String plant = request.getParameter("plant");
        Double Number = 0d;
        if (request.getParameter("Number") != null) {
            Number = Double.parseDouble(request.getParameter("Number"));
        }
        Double PoNumber = 0d;
        if (request.getParameter("PoNumber") != null) {
            PoNumber = Double.parseDouble(request.getParameter("PoNumber"));
        }
        Double TakeNumber = 0d;
        if (request.getParameter("TakeNumber") != null) {
            TakeNumber = Double.parseDouble(request.getParameter("TakeNumber"));
        }
        Double LeftNumber = 0d;
        if (request.getParameter("LeftNumber") != null) {
            LeftNumber = Double.parseDouble(request.getParameter("LeftNumber"));
        }
        Boolean isok = true;
        if (request.getParameter("isok") != null) {
            isok = Boolean.parseBoolean(request.getParameter("isok"));
        }
        String LGORT = request.getParameter("LGORT");
        String unit = request.getParameter("unit");
        Boolean isMove = false;
        if (request.getParameter("isMove") != null) {
            isMove = Boolean.parseBoolean(request.getParameter("isMove"));
        }
        Double UpLimit = 0d;
        if (request.getParameter("UpLimit") != null) {
            UpLimit = Double.parseDouble(request.getParameter("UpLimit"));
        }
        Double DownLimit = 0d;
        if (request.getParameter("DownLimit") != null) {
            DownLimit = Double.parseDouble(request.getParameter("DownLimit"));
        }
        Boolean IsDone = false;
        if (request.getParameter("IsDone") != null) {
            IsDone = Boolean.parseBoolean(request.getParameter("IsDone"));
        }
        Integer uyear = 0;
        if (request.getParameter("uyear") != null) {
            uyear = Integer.parseInt(request.getParameter("uyear"));
        }
        Integer umonth = 0;
        if (request.getParameter("umonth") != null) {
            umonth = Integer.parseInt(request.getParameter("umonth"));
        }
        String SupportNo = request.getParameter("SupportNo");
        String SupportName = request.getParameter("SupportName");
        String EKORG = request.getParameter("EKORG");
        String EKORGName = request.getParameter("EKORGName");
        String EKGRP = request.getParameter("EKGRP");
        String EKGRPName = request.getParameter("EKGRPName");
        String PoCreatTime = request.getParameter("PoCreatTime");
        String BUKRS = request.getParameter("BUKRS");
        Boolean MoveOk = false;
        if (request.getParameter("MoveOk") != null) {
            MoveOk = Boolean.parseBoolean(request.getParameter("MoveOk"));
        }
        Boolean ReturnOk = false;
        if (request.getParameter("ReturnOk") != null) {
            ReturnOk = Boolean.parseBoolean(request.getParameter("ReturnOk"));
        }
        String StockType = request.getParameter("StockType");
        String MaterialDoc = request.getParameter("MaterialDoc");

        String MaterialDocYear = request.getParameter("MaterialDocYear");

        String MaterialDocItem = request.getParameter("MaterialDocItem");
        String BatchNo = request.getParameter("BatchNo");
        Boolean IsTrans = false;
        if (request.getParameter("IsTrans") != null) {
            IsTrans = Boolean.parseBoolean(request.getParameter("IsTrans"));
        }
        Boolean MoneyState = false;
        if (request.getParameter("MoneyState") != null) {
            MoneyState = Boolean.parseBoolean(request.getParameter("MoneyState"));
        }
        Double NETPR = 0d;
        if (request.getParameter("NETPR") != null) {
            NETPR = Double.parseDouble(request.getParameter("NETPR"));
        }
        Double PEINH = 0d;
        if (request.getParameter("PEINH") != null) {
            PEINH = Double.parseDouble(request.getParameter("PEINH"));
        }
        String location = request.getParameter("location");
        String materialtype = request.getParameter("materialtype");
        String steelworks = request.getParameter("steelworks");
        ColdMaterialIn ColdMaterialIn = new ColdMaterialIn();
        ColdMaterialIn.setInputman(inputman);
        ColdMaterialIn.setPono(PoNo);
        ColdMaterialIn.setPlant(plant);
        ColdMaterialIn.setPoitem(PoItem);
        ColdMaterialIn.setFno(fno);
        ColdMaterialIn.setFname(fname);
        ColdMaterialIn.setNumber(Number);
        ColdMaterialIn.setPonumber(PoNumber);
        ColdMaterialIn.setTakenumber(TakeNumber);
        ColdMaterialIn.setLeftnumber(LeftNumber);
        ColdMaterialIn.setIsok(isok);
        ColdMaterialIn.setLgort(LGORT);
        ColdMaterialIn.setUnit(unit);
        ColdMaterialIn.setIsmove(isMove);
        ColdMaterialIn.setUplimit(UpLimit);
        ColdMaterialIn.setDownlimit(DownLimit);
        ColdMaterialIn.setIsdone(IsDone);
        ColdMaterialIn.setUyear(uyear);
        ColdMaterialIn.setUmonth(umonth);
        ColdMaterialIn.setSupportno(SupportNo);
        ColdMaterialIn.setSupportname(SupportName);
        ColdMaterialIn.setEkorg(EKORG);
        ColdMaterialIn.setEkorgname(EKORGName);
        ColdMaterialIn.setEkgrp(EKGRP);
        ColdMaterialIn.setEkgrpname(EKGRPName);
        ColdMaterialIn.setPocreattime(PoCreatTime);
        ColdMaterialIn.setBukrs(BUKRS);
        ColdMaterialIn.setMoveok(MoveOk);
        ColdMaterialIn.setReturnok(ReturnOk);
        ColdMaterialIn.setStocktype(StockType);
        ColdMaterialIn.setMaterialdoc(MaterialDoc);
        ColdMaterialIn.setMaterialdocyear(MaterialDocYear);
        ColdMaterialIn.setMaterialdocitem(MaterialDocItem);
        ColdMaterialIn.setBatchno(BatchNo);
        ColdMaterialIn.setIstrans(IsTrans);
        ColdMaterialIn.setMoneystate(MoneyState);
        ColdMaterialIn.setNetpr(NETPR);
        ColdMaterialIn.setPeinh(PEINH);
        ColdMaterialIn.setLocation(location);
        ColdMaterialIn.setMaterialtype(materialtype);
        ColdMaterialIn.setSteelworks(steelworks);
        List<com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn> jslist = materialtakeinService.getSeId(ColdMaterialIn);
        com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn RColdMaterialIn;
        if (jslist.size() > 0) {
            RColdMaterialIn = jslist.get(0);
            int Serialno = Integer.parseInt(RColdMaterialIn.getSerialno()) + 1;
            ColdMaterialIn.setSerialno(Serialno + "");
        } else {
            String Serialno = umonth + "00001";
            ColdMaterialIn.setSerialno(Serialno);
        }
        int num = materialtakeinService.insertColdmsg(ColdMaterialIn);
        ColdStoreKey coldStoreKey = new ColdStoreKey();
        coldStoreKey.setFno(fno);
        coldStoreKey.setPlant(plant);
        List<ColdStore> list = coldStoreService.selectColdStore(coldStoreKey);
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = dateFormat.format( now );
        if (list.size()>0){
            int numStore = coldStoreService.updateColdStoreIn(ColdMaterialIn);
        }else{
            ColdStore coldStore = new ColdStore();
            coldStore.setFno(fno);
            coldStore.setFname(fname);
            coldStore.setPlant(plant);
            coldStore.setBeginstore(0d);
            coldStore.setInputstore(Number);
            coldStore.setOutputstore(0d);
            coldStore.setSapstore(Number);
            coldStore.setInputman(inputman);
            coldStore.setInputdate(date);
            coldStore.setBeginman(inputman);
            coldStore.setBegindate(date);
            int numStoreIn = coldStoreService.insertSelective(coldStore);
        }
        Map json = new HashMap();
        json.put("num", num);

        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/deletecoldmsg", method = {RequestMethod.GET, RequestMethod.POST})
    public Map deletecoldmsg(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        String plant = request.getParameter("plant");
        Double number = Double.parseDouble(request.getParameter("number"));
        coldMaterialIn.setId(Integer.parseInt(request.getParameter("id")));
        coldMaterialIn.setPlant(plant);
        coldMaterialIn.setFno(fno);
        coldMaterialIn.setFname(fname);
        coldMaterialIn.setNumber(number);
        int n = materialtakeinService.deletecoldmsg(coldMaterialIn);
        if (n>0){
            int num = coldStoreService.updateColdStoreBack(coldMaterialIn);
        }
        Map json = new HashMap();
        json.put("num", n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/SAPtakeIn", method = {RequestMethod.GET, RequestMethod.POST})
    public Map SAPtakeIn(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JCoFunction function = null;
        String PlantIn = "";
        Integer id = 0 ;
        String retsalse = "此记录已完成SAP同步" +
                "";//调用接口返回状态
        String Z_MBLNR = "";
        String Z_MJAHR = "";
        if(request.getParameter("id")!=null){
            id = Integer.parseInt(request.getParameter("id"));
        }
        String plant = request.getParameter("plant");
        String inputman = request.getParameter("inputman");
//        String PoNo = request.getParameter("PoNo");
        ColdMaterialIn ColdMaterialIn = new ColdMaterialIn();
        ColdMaterialIn.setId(id);
//        ColdMaterialIn.setInputman(inputman);
//        ColdMaterialIn.setPono(PoNo);
        List<com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn> list = materialtakeinService.selectColdmaterlinNeed(ColdMaterialIn);
        JCoDestination destination = SAPConn.connect();
        Map json = new HashMap();
        int n = 0;
        if (list.size() > 0) {
            try {
                //调用ZMM_O_003函数
                function = destination.getRepository().getFunction("ZMM_O_003");
                JCoParameterList input = function.getImportParameterList();
                //            //调用接口模块
                input.setValue("SMODEL", 6);
                input.getStructure("GDSMT_CODE").setValue(0, "01");
                JCoTable GDSMT_ITEM = function.getTableParameterList().getTable("ITAB");
                PlantIn = materialtakeinService.getPlantIn(request.getParameter("plant"));
                com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn RColdMaterialIn = new ColdMaterialIn();
                for (int i = 0; i < list.size(); i++) {
                    GDSMT_ITEM.appendRow();//增加一行
                    RColdMaterialIn = list.get(i);
                    GDSMT_ITEM.setValue("MOVE_TYPE", "101");
                    GDSMT_ITEM.setValue("MVT_IND", "B");
                    GDSMT_ITEM.setValue("PLANT", PlantIn);
                    GDSMT_ITEM.setValue("MATERIAL", RColdMaterialIn.getFno());
                    GDSMT_ITEM.setValue("ENTRY_QNT", RColdMaterialIn.getNumber());
                    GDSMT_ITEM.setValue("MOVE_STLOC", RColdMaterialIn.getLgort());
                    GDSMT_ITEM.setValue("STGE_LOC", RColdMaterialIn.getLgort());
                    GDSMT_ITEM.setValue("PO_NUMBER",RColdMaterialIn.getPono());
                    GDSMT_ITEM.setValue("PO_ITEM", RColdMaterialIn.getPoitem());
                    GDSMT_ITEM.setValue("ITEM_TEXT", "MDM创建");
                    if ("质检".equals(RColdMaterialIn.getStocktype())) {
                        GDSMT_ITEM.setValue("STCK_TYPE", "X");
                    } else if ("冻结".equals(RColdMaterialIn.getStocktype())) {
                        GDSMT_ITEM.setValue("STCK_TYPE", "S");
                    } else {
                        GDSMT_ITEM.setValue("STCK_TYPE", "");
                    }
                }
                function.execute(destination);//执行接口程序
                retsalse = function.getExportParameterList().getString("Z_MESSAGE");
                Z_MBLNR = function.getExportParameterList().getString("Z_MBLNR");
                Z_MJAHR = function.getExportParameterList().getString("Z_MJAHR");
                System.out.println(retsalse);
                if ("成功".equals(retsalse)) {
                    com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn NColdMaterialIn = new ColdMaterialIn();
                    for (int i = 0; i < list.size(); i++) {
                        NColdMaterialIn = list.get(i);
                        if (NColdMaterialIn.getIsok() && !NColdMaterialIn.getIsmove()) {
                            NColdMaterialIn.setIsmove(true);
                            NColdMaterialIn.setMoveman(inputman);
                            NColdMaterialIn.setMoveok(false);
                            NColdMaterialIn.setMaterialdoc(Z_MBLNR);
                            NColdMaterialIn.setMaterialdocyear(Z_MJAHR);
                            int num = i + 1;
                            NColdMaterialIn.setMaterialdocitem(num + "");
                            materialtakeinService.updatecoldmsg(NColdMaterialIn);
                        }

                    }
                    n = 1;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        json.put("num",n);
        json.put("retsalse",retsalse);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/SAPtakeChange", method = {RequestMethod.GET, RequestMethod.POST})
    public Map SAPtakeChange(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JCoFunction function = null;
        String PlantIn = "";
        String retsalse = "";//调用接口返回状态
        String plant = request.getParameter("plant");
        String inputman = request.getParameter("inputman");
        String PoNo = request.getParameter("PoNo");
        ColdMaterialIn ColdMaterialIn = new ColdMaterialIn();
        ColdMaterialIn.setPlant(plant);
        ColdMaterialIn.setInputman(inputman);
        ColdMaterialIn.setPono(PoNo);
        List<com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn> list = materialtakeinService.selectColdmaterlin(ColdMaterialIn);
        JCoDestination destination = SAPConn.connect();
        Map json = new HashMap();
        int n = 0;
        if (list.size() > 0) {
            try {
                //调用ZMM_O_003函数
                function = destination.getRepository().getFunction("ZMM_O_003");
                JCoParameterList input = function.getImportParameterList();
                //            //调用接口模块
                input.setValue("SMODEL", 6);
                input.getStructure("GDSMT_CODE").setValue(0, "04");
                JCoTable GDSMT_ITEM = function.getTableParameterList().getTable("ITAB");
                PlantIn = materialtakeinService.getPlantIn(request.getParameter("plant"));
                com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn RColdMaterialIn = new ColdMaterialIn();
                for (int i = 0; i < list.size(); i++) {
                    GDSMT_ITEM.appendRow();//增加一行
                    RColdMaterialIn = list.get(i);
                    GDSMT_ITEM.setValue("MOVE_TYPE", "321");
                    GDSMT_ITEM.setValue("PLANT", PlantIn);
                    GDSMT_ITEM.setValue("MATERIAL", RColdMaterialIn.getFno());
                    GDSMT_ITEM.setValue("ENTRY_QNT", RColdMaterialIn.getNumber());
                    GDSMT_ITEM.setValue("MOVE_STLOC", RColdMaterialIn.getLgort());
                    GDSMT_ITEM.setValue("STGE_LOC", RColdMaterialIn.getLgort());
                    GDSMT_ITEM.setValue("PO_NUMBER", PoNo);
                    GDSMT_ITEM.setValue("PO_ITEM", RColdMaterialIn.getPoitem());

                }
                function.execute(destination);//执行接口程序
                retsalse = function.getExportParameterList().getString("Z_MESSAGE");
                System.out.println(retsalse);
                if ("成功".equals(retsalse)) {
                    com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn NColdMaterialIn = new ColdMaterialIn();
                    for (int i = 0; i < list.size(); i++) {
                        NColdMaterialIn = list.get(i);
                        if (NColdMaterialIn.getIsok() && !NColdMaterialIn.getIsmove()) {
                            NColdMaterialIn.setIstrans(true);
                            NColdMaterialIn.setTransman(inputman);
                            NColdMaterialIn.setStocktype("非限制");
                            int m = materialtakeinService.updatecoldmsgFXZ(NColdMaterialIn);
                            n = m;
                        }
                    }
                    n = 1;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        json.put("num", n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/SAPtakeBack", method = {RequestMethod.GET, RequestMethod.POST})
    public Map SAPtakeBack(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        Integer id = 0 ;
        String PlantIn = "";
        String retsalse = "";
        Map json = new HashMap();
        int n = 0;
        JCoFunction function = null;
        String plant = request.getParameter("plant");
        String inputman = request.getParameter("inputman");
        if(request.getParameter("id")!=null){
            id = Integer.parseInt(request.getParameter("id"));
        }
        ColdMaterialIn ColdMaterialIn = new ColdMaterialIn();
        ColdMaterialIn.setId(id);
        List<com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn> list = materialtakeinService.selectcoldMsgById(ColdMaterialIn);
        com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn RColdMaterialIn = new ColdMaterialIn();
        JCoDestination destination = SAPConn.connect();
        if (list.size()>0){
            RColdMaterialIn = list.get(0);
            if (RColdMaterialIn.getIsmove()){
                try {
                    //调用ZMM_O_003函数
                    function = destination.getRepository().getFunction("ZMM_O_003");
                    JCoParameterList input = function.getImportParameterList();
                    //            //调用接口模块
                    input.setValue("SMODEL", 6);
                    input.getStructure("GDSMT_CODE").setValue(0, "01");
                    JCoTable GDSMT_ITEM = function.getTableParameterList().getTable("ITAB");
                    PlantIn = materialtakeinService.getPlantIn(request.getParameter("plant"));
                    if (RColdMaterialIn.getIsmove()&&RColdMaterialIn.getIsok()) {
                        GDSMT_ITEM.appendRow();//增加一行
//                        if ("质检".equals(RColdMaterialIn.getStocktype())){
//                            GDSMT_ITEM.setValue("STCK_TYPE", "X");
//                            GDSMT_ITEM.setValue("MOVE_TYPE", "102");
//                        }else{
                            GDSMT_ITEM.setValue("STCK_TYPE", "");
                            GDSMT_ITEM.setValue("MOVE_TYPE", "102");
//                        }
                        GDSMT_ITEM.setValue("MVT_IND", "B");
                        GDSMT_ITEM.setValue("PLANT", PlantIn);
                        GDSMT_ITEM.setValue("MATERIAL", RColdMaterialIn.getFno());
                        GDSMT_ITEM.setValue("ENTRY_QNT", RColdMaterialIn.getNumber());
                        GDSMT_ITEM.setValue("MOVE_STLOC", RColdMaterialIn.getLgort());
                        GDSMT_ITEM.setValue("STGE_LOC", RColdMaterialIn.getLgort());
                        GDSMT_ITEM.setValue("PO_NUMBER", RColdMaterialIn.getPono());
                        GDSMT_ITEM.setValue("PO_ITEM", RColdMaterialIn.getPoitem());
                        GDSMT_ITEM.setValue("ITEM_TEXT", "MDM退货");
                        GDSMT_ITEM.setValue("MOVE_REAS", "0001");
                        GDSMT_ITEM.setValue("REF_DOC_YR", RColdMaterialIn.getMaterialdocyear());
                        GDSMT_ITEM.setValue("REF_DOC", RColdMaterialIn.getMaterialdoc());
                        GDSMT_ITEM.setValue("REF_DOC_IT", RColdMaterialIn.getMaterialdocitem());

                        function.execute(destination);//执行接口程序
                        retsalse = function.getExportParameterList().getString("Z_MESSAGE");
                        System.out.println(retsalse);
                        System.out.println("成功".equals(retsalse));
                        com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn NColdMaterialIn = new ColdMaterialIn();
                        if ("成功".equals(retsalse)) {
                            System.out.println("进来了");
                            for (int i = 0; i < list.size(); i++) {
                                NColdMaterialIn = list.get(i);
                                if (NColdMaterialIn.getIsok() && NColdMaterialIn.getIsmove()) {
                                    NColdMaterialIn.setIsmove(false);
                                    NColdMaterialIn.setMoveman(inputman);
                                    NColdMaterialIn.setReturnok(false);
                                    NColdMaterialIn.setIstrans(false);
                                    int m =materialtakeinService.updatecoldmsgBack(NColdMaterialIn);
                                }
                            }
                            n = 1;
                        }else{
                            for (int i = 0; i < list.size(); i++) {
                                NColdMaterialIn = list.get(i);
                                if (NColdMaterialIn.getIsok() && NColdMaterialIn.getIsmove()) {
                                    NColdMaterialIn.setReturnok(false);
                                    int m =materialtakeinService.updatecoldmsgBack(NColdMaterialIn);
                                    n = m;
                                }
                            }
                        }
                        int mn =materialtakeinService.insertPoAgainstRecord(NColdMaterialIn);
                        n = mn;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        json.put("num", n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/selectColdmaterlinLeaveNumber", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdmaterlinLeaveNumber(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
        String pono = request.getParameter("pono");
        String poitem = request.getParameter("poitem");
        coldMaterialIn.setPono(pono);
        coldMaterialIn.setPoitem(poitem);
        Double number = materialtakeinService.selectColdmaterlinLeaveNumber(coldMaterialIn);
        System.out.println(number);
        Map json = new HashMap();
        json.put("number", number);
        return json;
    }
}
