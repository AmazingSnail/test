package com.dhchain.business.assembletrans.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.assembletrans.service.KCardService;
import com.dhchain.business.assembletrans.service.MplanService;
import com.dhchain.business.assembletrans.vo.CZG;
import com.dhchain.business.assembletrans.vo.KCard;
import com.dhchain.business.assembletrans.vo.Mplan;
import com.dhchain.business.equipmentlist.vo.PlanProBase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by tongc on 2017-7-22.
 */
@Controller
@RequestMapping("/KCard")
public class KCardController {

    @Autowired
    private KCardService kCardService;
    @Autowired
    private MplanService mplanService;
    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
    public Map query1(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        kCard.setPlant(request.getParameter("plant"));
        kCard.setUyear(request.getParameter("uyear"));
        kCard.setUmouth(request.getParameter("umouth"));
        if(request.getParameter("dhorderno")!=null){
            kCard.setDhorderno( request.getParameter("dhorderno"));
        }
        if(request.getParameter("PartDrawing")!=null){
            kCard.setPartDrawing(request.getParameter("PartDrawing"));
        }
        if(request.getParameter("fname")!=null){
            kCard.setFname( request.getParameter("fname"));
        }
        kCard.setInputman( request.getParameter("inputman"));
        kCard.setUday(request.getParameter("uday"));
        List jslist = kCardService.queryAsList(kCard);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        KCard RkCard;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {

                Map re = new HashMap();
                RkCard = (KCard) jslist.get(i);
                int id = RkCard.getId();
                String dhorderno = RkCard.getDhorderno();
                String PartDrawing = RkCard.getPartDrawing();
                float F3 = RkCard.getF3();
                String Descrip = RkCard.getDescrip();
                String serialno = RkCard.getSerialno();
                String fno = RkCard.getFno();
                float inputnum = RkCard.getInputnum();
                float takenum = RkCard.getTakenum();
                float inputNumKG = RkCard.getInputNumKG();
                String itemno = RkCard.getItemno();
                String unit = RkCard.getUnit();
                String ReportMan = RkCard.getReportMan();
                String AssScanNum = RkCard.getAssScanNum();
                float SplitF3 = RkCard.getSplitF3();
                String equipment = RkCard.getEquipment();
                String ConnectZore = RkCard.getConnectZore();
                String isok = RkCard.getIsok();
                String ismix = RkCard.getIsmix();
                String SAPSDOrder = RkCard.getSAPSDOrder();
                String inputman = RkCard.getInputman();
                String inputdate = RkCard.getInputdate();
                String TempInfo = RkCard.getTempInfo();
                String fname = RkCard.getFname();
                String surenum = RkCard.getSurenum();
                String IsCL = RkCard.getIsCL();
                String takeman = RkCard.getTakeman();
                String takedate = RkCard.getTakedate();
                String dutyman = RkCard.getDutyman();
                String plant = RkCard.getPlant();
                String meins = RkCard.getMeins();
                String planid = RkCard.getPlanid();
                String umouth = RkCard.getUmouth();
                String uyear = RkCard.getUyear();
                String serialno_hide = RkCard.getSerialnohide();
                String OrderTime="";
                if (RkCard.getOrderTime()!=null&&!"".equals(RkCard.getOrderTime().trim())){
                    OrderTime = RkCard.getOrderTime().substring(0,10);
                }
                String Color = RkCard.getColor();
                String IsPrint = RkCard.getIsPrint();
                String Ftemp10 = RkCard.getFtemp10();
                String GCXH = RkCard.getGCXH();
                String equipmentSerial = RkCard.getEquipmentSerial();
                String equipmentkind = RkCard.getEquipmentkind();
                float MillionF3 = RkCard.getMillionF3();
                float inputValue = RkCard.getInputValue();
                float sureValue = RkCard.getSureValue();
                float takeValue = RkCard.getTakeValue();

                re.put("id", id);
                re.put("dhorderno", dhorderno);
                re.put("PartDrawing", PartDrawing);
                re.put("AssScanNum", AssScanNum);
                re.put("F3", F3);
                re.put("Descrip", Descrip);
                re.put("itemno", itemno);
                re.put("serialno", serialno);
                re.put("fno", fno);
                re.put("inputnum", inputnum);
                re.put("takenum", takenum);
                re.put("inputNumKG", inputNumKG);
                re.put("unit", unit);
                re.put("AssScanNum", AssScanNum);
                re.put("SplitF3", SplitF3);
                re.put("equipment", equipment);
                re.put("ConnectZore", ConnectZore);
                re.put("isok", isok);
                re.put("ismix", ismix);
                re.put("SAPSDOrder", SAPSDOrder);
                re.put("inputman", inputman);
                re.put("inputdate", inputdate);
                re.put("TempInfo", TempInfo);
                re.put("fname", fname);
                re.put("surenum", surenum);
                re.put("IsCL", IsCL);
                re.put("takeman", takeman);
                re.put("takedate", takedate);
                re.put("dutyman", dutyman);
                re.put("plant", plant);
                re.put("meins", meins);
                re.put("umouth", umouth);
                re.put("planid", planid);
                re.put("uyear", uyear);
                re.put("serialno_hide", serialno_hide);
                re.put("serialno", serialno);
                re.put("OrderTime", OrderTime);
                re.put("Color", Color);
                re.put("IsPrint", IsPrint);
                re.put("Ftemp10", Ftemp10);
                re.put("GCXH", GCXH);
                re.put("equipmentSerial", equipmentSerial);
                re.put("equipmentkind", equipmentkind);
                re.put("ReportMan", ReportMan);
                re.put("MillionF3", MillionF3);
                re.put("inputValue", inputValue);
                re.put("sureValue", sureValue);
                re.put("takeValue", takeValue);
                jslst.add(re);
            }
        }

        json.put("rows",jslst);
        json.put("total", jslist.size());
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/insert",method={RequestMethod.GET,RequestMethod.POST})
    public Map insert(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String izplant   = request.getParameter("zplant");
        String izDescrip   =  request.getParameter("zDescrip");
        KCard kCard = new KCard();
        kCard.setDhorderno(request.getParameter("zdhorderno"));
        kCard.setPartDrawing( request.getParameter("zPartDrawing"));
        kCard.setF3(Float.parseFloat(request.getParameter("zF3")));
        kCard.setDescrip(izDescrip);
        kCard.setInputdate(request.getParameter("zinputdate"));
        kCard.setPlant(izplant);
        kCard.setItemno(request.getParameter("zOrderline"));
        kCard.setUyear(request.getParameter("zuyear"));
        kCard.setUmouth(request.getParameter("zumouth"));
        kCard.setFno(request.getParameter("fno"));
        kCard.setSAPSDOrder(request.getParameter("SAPSDOrder"));
        kCard.setTakenum(Float.parseFloat(request.getParameter("takenum")));
        kCard.setSurenum(request.getParameter("surenum"));
        kCard.setMeins( request.getParameter("meins"));
        kCard.setUnit( request.getParameter("Dunit"));
        kCard.setFname( request.getParameter("fname"));
        kCard.setInputnum(Float.parseFloat(request.getParameter("inputnum")));
        kCard.setInputman( request.getParameter("inputman"));
        kCard.setDutyman( request.getParameter("dutyman"));
        kCard.setIsPrint(request.getParameter("isprint"));
        kCard.setPlanid(request.getParameter("planid"));
        kCard.setOrderLine( request.getParameter("OrderLine"));
        kCard.setIsTake(request.getParameter("IsTake"));
        kCard.setConnectZore( request.getParameter("ConnectZore"));
        kCard.setFtemp10( request.getParameter("Ftemp10"));
        kCard.setReportMan( request.getParameter("ReportMan"));
        kCard.setDutyman( request.getParameter("dutyman"));
        kCard.setAssScanNum(request.getParameter("AssScanNum"));
        kCard.setColor( request.getParameter("Color"));
        kCard.setIsCL( request.getParameter("iscl"));
        kCard.setSureMan( request.getParameter("SureMan"));
        kCard.setSuredate( request.getParameter("Suredate"));
        kCard.setIssure(request.getParameter("IsSure"));
        kCard.setOrderTime( request.getParameter("OrderTime"));
        kCard.setIsok( request.getParameter("IsOK"));
        kCard.setPlanTransmit( request.getParameter("planTransmit"));
        kCard.setPrinttimes( request.getParameter("printtimes"));
        kCard.setContrast( request.getParameter("Contrast"));
        kCard.setF10( request.getParameter("f10"));
        kCard.setSendTime( request.getParameter("SendTime"));
        kCard.setInputnumKG( Float.parseFloat(request.getParameter("inputnumKG")));
        kCard.setIsmix( request.getParameter("ismix"));
        kCard.setPoNo( request.getParameter("PoNo"));
        kCard.setPoItem( request.getParameter("PoItem"));
        kCard.setNwx( request.getParameter("nwx"));
        kCard.setTasktype( request.getParameter("tasktype"));

        kCard.setGCXH(request.getParameter("GCXH"));
        if(request.getParameter("SplitF3")!=null){
            kCard.setSplitF3(Float.parseFloat(request.getParameter("SplitF3")));
        }else {
            kCard.setSplitF3(0f);
        }

        kCard.setEquipment(request.getParameter("equipment"));
        kCard.setEquipmentkind(request.getParameter("equipmentkind"));
        kCard.setEquipmentSerial(request.getParameter("equipmentSerial"));
        if (request.getParameter("MillionF3")!=null){
            kCard.setMillionF3(Float.parseFloat(request.getParameter("MillionF3")));
        }else{
            kCard.setMillionF3(0.00f);
        }

        kCard.setIsok("true");
        List jslist = kCardService.querySeId(kCard);
        KCard RkCard;
        if(jslist.size()>0) {
            RkCard = (KCard)jslist.get(0);
            int Serialno = Integer.parseInt(RkCard.getSerialno())+1;
            int Serialno_hide = Integer.parseInt(RkCard.getSerialnohide())+1;
            kCard.setSerialno(Serialno+"");
            kCard.setSerialno_hide(Serialno_hide+"");
        }else{
            String Serialno = request.getParameter("zumouth")+"00001";
            String Serialno_hide = "1";
            kCard.setSerialno(Serialno);
            kCard.setSerialno_hide(Serialno_hide);
        }
        int n = kCardService.insert(kCard);
        Map json = new HashMap();
        json.put("num",n);

        return json;
    }
    @ResponseBody
    @RequestMapping(value="/delete",method={RequestMethod.GET,RequestMethod.POST})
    public Map delete(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        kCard.setId(Integer.parseInt(request.getParameter("id")));
        int n = kCardService.delete(kCard);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value="/update",method={RequestMethod.GET,RequestMethod.POST})
    public Map update(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        kCard.setId(Integer.parseInt(request.getParameter("id")));
        String zF3 =  request.getParameter("zF3");
        String zDescrip =  request.getParameter("zDescrip");
        kCard.setF3(Float.parseFloat(zF3));
        kCard.setDescrip(zDescrip);
        int n = kCardService.update(kCard);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/queryCZG",method={RequestMethod.GET,RequestMethod.POST})
    public JSON queryCZG(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        CZG czg = new CZG();
        czg.setPlant( request.getParameter("plant"));
        //czg.setPlant(new String( request.getParameter("plant").getBytes("ISO-8859-1") , "UTF-8"));
        czg.setWorklead( request.getParameter("worklead"));
        //czg.setWorklead(new String( request.getParameter("worklead").getBytes("ISO-8859-1") , "UTF-8"));
        List<CZG> jslist = kCardService.queryCZG(czg);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        CZG Rczg;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                Map re = new HashMap();
                Rczg =  jslist.get(i);
                String worker = Rczg.getWorker();
                re.put("worker",worker);
                jslst.add(re);

            }
        }
        return jslst;
    }

    @ResponseBody
    @RequestMapping(value="/selectIdPackIn",method={RequestMethod.GET,RequestMethod.POST})
    public Map selectIdPackIn(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        int n =0;
        int id = 0;
        if(request.getParameter("id")!=null){
            kCard.setId( Integer.parseInt(request.getParameter("id")));
            kCard.setAssRetrun("1");
        }else{
            kCard.setId(id);
        }

        List<KCard> jslist = kCardService.selectidInPackIn(kCard);
        if(jslist.size()>0){
            n=0;
        }else{
            n=1;
        }
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/selectLastMonthTake",method={RequestMethod.GET,RequestMethod.POST})
    public Map selectLastMonthTake(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        float n =0;
        String OrderLine = request.getParameter("OrderLine");
        String plant = request.getParameter("plant");
        String fno = request.getParameter("fno");
        kCard.setPlant(plant);
        kCard.setOrderLine(OrderLine);
        kCard.setFno(fno);
        List<KCard> jslist = kCardService.selectLastMonthTake(kCard);
        if(jslist.size()>0){
            KCard Rkcard =  jslist.get(0);
            n=Rkcard.getInputnum();
        }else{
            n=0;
        }
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/queryYS",method={RequestMethod.GET,RequestMethod.POST})
    public JSON queryYS(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Mplan mplan = new Mplan();
        String inputer   =  request.getParameter("plant");
        String selectState = request.getParameter("selectState");
        mplan.setPlant(inputer);
        mplan.setUyear(request.getParameter("uyear"));
        mplan.setUmouth(request.getParameter("umouth"));
        mplan.setDutyman(request.getParameter("Dutyman"));
        if(request.getParameter("dhorderno")!=null){
            mplan.setDhorderno( request.getParameter("dhorderno"));
        }
        if(request.getParameter("PartDrawing")!=null){
            mplan.setPartDrawing( request.getParameter("PartDrawing"));
        }
        if(request.getParameter("fname")!=null){
            mplan.setFname(request.getParameter("fname"));
        }
        if(request.getParameter("Color")!=null&&!"".equals(request.getParameter("Color").trim())){
            mplan.setColor( request.getParameter("Color"));
        }
        if(request.getParameter("F3")!=null&&!"".equals(request.getParameter("F3").trim())){
            mplan.setF3( Integer.parseInt(request.getParameter("F3")));
        }
        if(request.getParameter("nwx")!=null&&!"".equals(request.getParameter("nwx").trim())){
            mplan.setNwx(request.getParameter("nwx"));
        }
        List<Mplan> jslist = mplanService.queryYS(mplan);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        Mplan Rmplan;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                Map re = new HashMap();
                Rmplan =  jslist.get(i);
                String Color = Rmplan.getColor();
                re.put("Color",Color);
                jslst.add(re);

            }
        }
        return jslst;
    }

    @ResponseBody
    @RequestMapping(value="/queryCZRK",method={RequestMethod.GET,RequestMethod.POST})
    public Map query2(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        //String zplant   = new String( request.getParameter("plant").getBytes("ISO-8859-1") , "UTF-8");
        String zplant   =  request.getParameter("plant");
        String State = request.getParameter("State");
        String zdhorderno = "";
        if(request.getParameter("dhorderno")!=null){
            zdhorderno =  request.getParameter("dhorderno");
        }
        String zPartDrawing = "";
        if(request.getParameter("PartDrawing")!=null){
            zPartDrawing =  request.getParameter("PartDrawing");
        }
        String zfname = "";
        if(request.getParameter("fname")!=null){
            zfname =  request.getParameter("fname");
        }
        String zfno = "";
        if(request.getParameter("fno")!=null &&!"".equals(request.getParameter("fno").trim())){
            zfno =  request.getParameter("fno");
        }
        String zserialno = "";
        if(request.getParameter("serialno")!=null &&!"".equals(request.getParameter("serialno").trim())){
            zserialno =  request.getParameter("serialno");
        }

        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String zissure = request.getParameter("issure");
        String zIsTake = request.getParameter("IsTake");
        String zinputman = request.getParameter("inputman");
        String zReportMan = request.getParameter("ReportMan");
        List jslist ;
        if("1".equals(State)){
            if ("0".equals(zissure)){
                jslist = kCardService.querySumCZRKQR(zdhorderno,zPartDrawing,zfname,zplant,startTime,endTime,zissure,zIsTake,zinputman,zReportMan,zfno,zserialno);
            }else if ("0".equals(zIsTake)){
                jslist = kCardService.querySumCZRKRK(zdhorderno,zPartDrawing,zfname,zplant,startTime,endTime,zissure,zIsTake,zinputman,zReportMan,zfno,zserialno);
            }else{
                jslist = kCardService.querySumCZRK(zdhorderno,zPartDrawing,zfname,zplant,startTime,endTime,zissure,zIsTake,zinputman,zReportMan,zfno,zserialno);
            }
        }else{
            if ("0".equals(zissure)){
                jslist = kCardService.queryCZRKQR(zdhorderno,zPartDrawing,zfname,zplant,startTime,endTime,zissure,zIsTake,zinputman,zReportMan,zfno,zserialno);
            }else if ("0".equals(zIsTake)){
                jslist = kCardService.queryCZRKRK(zdhorderno,zPartDrawing,zfname,zplant,startTime,endTime,zissure,zIsTake,zinputman,zReportMan,zfno,zserialno);
            }else{
                jslist = kCardService.queryCZRK(zdhorderno,zPartDrawing,zfname,zplant,startTime,endTime,zissure,zIsTake,zinputman,zReportMan,zfno,zserialno);
            }
        }
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        KCard RkCard;
        float allInputValue = 0;
        float allSureValue = 0;
        float allTakeValue = 0;
        float allInputWJ = 0;
        float allSureWJ = 0;
        float allTakeWJ = 0;
        float allinputnum = 0;
        float inputValue = 0;
        float sureValue = 0;
        float takeValue = 0;
        float inputWJ = 0;
        float sureWJ = 0;
        float takeWJ = 0;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                Map re = new HashMap();
                RkCard = (KCard) jslist.get(i);
                float id = RkCard.getId();
                String dhorderno = RkCard.getDhorderno();
                String PartDrawing = RkCard.getPartDrawing();
                float F3 = RkCard.getF3();
                String Descrip = RkCard.getDescrip();
                String serialno = RkCard.getSerialno();
                String fno = RkCard.getFno();
                float inputnum = RkCard.getInputnum();
                float takenum = RkCard.getTakenum();
                float inputNumKG = RkCard.getInputNumKG();
                String itemno = RkCard.getItemno();
                String unit = RkCard.getUnit();
                String ReportMan = RkCard.getReportMan();
                String AssScanNum = RkCard.getAssScanNum();
                float SplitF3 = RkCard.getSplitF3();
                String equipment = RkCard.getEquipment();
                String ConnectZore = RkCard.getConnectZore();
                String isok = RkCard.getIsok();
                String ismix = RkCard.getIsmix();
                String SAPSDOrder = RkCard.getSAPSDOrder();
                String inputman = RkCard.getInputman();
                String inputdate = RkCard.getInputdate();
                String TempInfo = RkCard.getTempInfo();
                String fname = RkCard.getFname();
                String surenum = RkCard.getSurenum();
                String IsCL = RkCard.getIsCL();
                String takeman = RkCard.getTakeman();
                String takedate = RkCard.getTakedate();
                String dutyman = RkCard.getDutyman();
                String plant = RkCard.getPlant();
                String meins = RkCard.getMeins();
                String planid = RkCard.getPlanid();
                String umouth = RkCard.getUmouth();
                String uyear = RkCard.getUyear();
                String OrderTime = RkCard.getOrderTime();
                String Color = RkCard.getColor();
                String IsPrint = RkCard.getIsPrint();
                String Ftemp10 = RkCard.getFtemp10();
                String GCXH = RkCard.getGCXH();
                String equipmentSerial = RkCard.getEquipmentSerial();
                String equipmentkind = RkCard.getEquipmentkind();
                String issure = RkCard.getIssure();
                String IsTake = RkCard.getIsTake();
                String OrderLine = RkCard.getOrderLine();
                String PackTake = RkCard.getPackTake();
                String PackTakeMan = RkCard.getPackTakeMan();
                String PackTakeDate = RkCard.getPackTakeDate();
                String  inputReportMan = RkCard.getInputReportMan();
                if("0".equals(State)){
                    inputValue = RkCard.getInputValue();
                    sureValue = RkCard.getSureValue();
                    takeValue = RkCard.getTakeValue();
                    inputWJ = RkCard.getInputWJ();
                    sureWJ = RkCard.getSureWJ();
                    takeWJ = RkCard.getTakeWJ();
                    allInputValue += inputValue;
                    allSureValue += sureValue;
                    allTakeValue += takeValue;
                    allInputWJ += inputWJ;
                    allSureWJ += sureWJ;
                    allTakeWJ += takeWJ;
                    allinputnum += inputnum;
                }


                re.put("id", id);
                re.put("dhorderno", dhorderno);
                re.put("PartDrawing", PartDrawing);
                re.put("F3", F3);
                re.put("Descrip", Descrip);
                re.put("itemno", itemno);
                re.put("OrderLine", OrderLine);
                re.put("serialno", serialno);
                re.put("fno", fno);
                re.put("inputnum", inputnum);
                re.put("takenum", takenum);
                re.put("inputNumKG", inputNumKG);
                re.put("unit", unit);
                re.put("AssScanNum", AssScanNum);
                re.put("SplitF3", SplitF3);
                re.put("equipment", equipment);
                re.put("ConnectZore", ConnectZore);
                re.put("isok", isok);
                re.put("ismix", ismix);
                re.put("SAPSDOrder", SAPSDOrder);
                re.put("inputman", inputman);
                re.put("inputdate", inputdate);
                re.put("TempInfo", TempInfo);
                re.put("fname", fname);
                re.put("surenum", surenum);
                re.put("IsCL", IsCL);
                re.put("takeman", takeman);
                re.put("takedate", takedate);
                re.put("dutyman", dutyman);
                re.put("plant", plant);
                re.put("meins", meins);
                re.put("umouth", umouth);
                re.put("planid", planid);
                re.put("uyear", uyear);
                re.put("OrderTime", OrderTime);
                re.put("Color", Color);
                re.put("IsPrint", IsPrint);
                re.put("Ftemp10", Ftemp10);
                re.put("GCXH", GCXH);
                re.put("equipmentSerial", equipmentSerial);
                re.put("equipmentkind", equipmentkind);
                re.put("ReportMan", ReportMan);
                re.put("issure", issure);
                re.put("IsTake", IsTake);
                re.put("inputValue", inputValue);
                re.put("sureValue", sureValue);
                re.put("takeValue", takeValue);
                re.put("inputWJ", inputWJ);
                re.put("sureWJ", sureWJ);
                re.put("takeWJ", takeWJ);
                re.put("PackTake", PackTake);
                re.put("PackTakeMan", PackTakeMan);
                re.put("PackTakeDate", PackTakeDate);
                re.put("inputReportMan", inputReportMan);
                jslst.add(re);
            }
        }
        Map r = new HashMap();
        r.put("fno","合计");
        r.put("inputnum",allinputnum);
        r.put("inputValue",allInputValue);
        r.put("sureValue",allSureValue);
        r.put("takeValue",allTakeValue);
        r.put("inputWJ",allInputWJ);
        r.put("sureWJ",allSureWJ);
        r.put("takeWJ",allTakeWJ);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(r);
        json.put("rows",jslst);
        json.put("total", jslist.size());
        json.put("footer",jslst2);
        return json;
    }

    @ResponseBody
    @RequestMapping(value="/updateCZ",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateCZ(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        kCard.setId(Integer.parseInt(request.getParameter("id")));
        kCard.setIssure(request.getParameter("issure"));
        kCard.setSureMan(request.getParameter("sureman"));
        kCard.setFinputman(request.getParameter("sureman"));
        kCard.setSurenum(request.getParameter("surenum"));
        int n = kCardService.update(kCard);
        int m = kCardService.updatePackageIn(kCard);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/updateCZ1",method={RequestMethod.GET,RequestMethod.POST})//扫码入库
    public Map updateCZ1(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        kCard.setId(Integer.parseInt(request.getParameter("id")));
        kCard.setIssure(request.getParameter("issure"));
        kCard.setSureMan(request.getParameter("sureman"));
        kCard.setFinputman(request.getParameter("sureman"));
        kCard.setOnlyScan(request.getParameter("onlyscan"));
        kCard.setSurenum(request.getParameter("surenum"));
        int n = kCardService.update1(kCard);
        int m = kCardService.updatePackageIn(kCard);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/updateRK",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateRK(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        kCard.setId(Integer.parseInt(request.getParameter("id")));
        kCard.setIsTake(request.getParameter("IsTake"));
        kCard.setInputReportMan(request.getParameter("inputReportMan"));
        kCard.setTakeman(request.getParameter("takeman"));
        kCard.setTakenum(Float.parseFloat(request.getParameter("takenum")));
        int n = kCardService.updateRK(kCard);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/updateRK1",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateRK1(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        kCard.setId(Integer.parseInt(request.getParameter("id")));
        kCard.setIsTake(request.getParameter("IsTake"));
        kCard.setIsTakeScan(request.getParameter("IsTakeScan"));
        kCard.setTakeman(request.getParameter("takeman"));
        kCard.setTakeman(request.getParameter("takeman"));
        kCard.setTakenum(Float.parseFloat(request.getParameter("takenum")));
        int n = kCardService.updateRK1(kCard);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/updateCZRK",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateCZRK(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        kCard.setId(Integer.parseInt(request.getParameter("id")));
        kCard.setItemno(request.getParameter("itemno"));
        kCard.setInputnum(Float.parseFloat(request.getParameter("inputnum")));
        kCard.setReportMan(request.getParameter("ReportMan"));
        kCard.setOrderTime(request.getParameter("OrderTime"));
        int n = kCardService.updateCZRK(kCard);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/updateDY",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateDY(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        KCard kCard = new KCard();
        kCard.setId(Integer.parseInt(request.getParameter("id")));
        kCard.setIsPrint(request.getParameter("IsPrint"));
        int n = kCardService.updateDY(kCard);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value="/getKCardById",method={RequestMethod.GET,RequestMethod.POST})
    public Map getKCardById(HttpServletRequest request) throws UnsupportedEncodingException {
        KCard kCard = new KCard();
        kCard.setId(Integer.parseInt(request.getParameter("id")));
        List<KCard> list = kCardService.getKCardById(kCard);
        Map json = new HashMap();
        if(list.size()>0){
            KCard RkCard = list.get(0);
            json.put("PackTake",RkCard.getPackTake());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value="/getSB",method={RequestMethod.GET,RequestMethod.POST})
    public Map getSB(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        PlanProBase planProBase = new PlanProBase();
        planProBase.setPlant(request.getParameter("plant"));
        planProBase.setWorklead(request.getParameter("worklead"));
        planProBase.setWorker(request.getParameter("worker"));
        List jslist = kCardService.getSB(planProBase);
        PlanProBase RplanProBase;
        Map json = new HashMap();
        String equipmentSerial = "";
        String equipmentkind ="";
        String equipment = "";
        if(jslist.size()>0) {
            RplanProBase = (PlanProBase) jslist.get(0);
             equipmentSerial =  RplanProBase.getEquipmentserial();
             equipmentkind = RplanProBase.getEquipmentkind();
             equipment = RplanProBase.getEquipment();
        }
        json.put("equipment",equipment);
        json.put("equipmentkind",equipmentkind);
        json.put("equipmentSerial",equipmentSerial);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/isSure",method={RequestMethod.GET,RequestMethod.POST})
    public JSON isSure(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String a = request.getParameter("scan");
        String []str = a.split("/");
        String ids = str[0];
        KCard kCard = new KCard();
        if(!"".equals(ids)&&!" ".equals(ids)){
            kCard.setId(Integer.parseInt(ids));
        }

        List<KCard> list = kCardService.getIssure(kCard);
        JSONArray jslist = new JSONArray();
        if(list.size()>0){
            KCard kCard1 = new KCard();
            kCard1 = list.get(0);
            int id =  kCard1.getId();
            Float inputnum = kCard1.getInputnum();
            String OrderLine = kCard1.getOrderLine();
            String fno = kCard1.getFno();
            String plant = kCard1.getPlant();
            String issure = kCard1.getIssure();
            String planid = kCard1.getPlanid();
            String IsTake = kCard1.getIsTake();
            Map re = new HashMap();
            re.put("id",id);
            re.put("issure",issure);
            re.put("inputnum",inputnum);
            re.put("OrderLine",OrderLine);
            re.put("fno",fno);
            re.put("plant",plant);
            re.put("planid",planid);
            re.put("IsTake",IsTake);
            jslist.add(re);
        }
        return jslist;
    }
    @ResponseBody
    @RequestMapping(value="/queryScan",method={RequestMethod.GET,RequestMethod.POST})
    public Map QueryScan(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String State = "0";
        KCard kCard = new KCard();
        kCard.setOnlyScan("1");
        String plant1 = request.getParameter("plant");
        kCard.setPlant(plant1);
        List<KCard> jslist = kCardService.queryScan(kCard);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        KCard RkCard;
        float allInputValue = 0;
        float allSureValue = 0;
        float allTakeValue = 0;
        float allInputWJ = 0;
        float allSureWJ = 0;
        float allTakeWJ = 0;
        float allinputnum = 0;
        float inputValue = 0;
        float sureValue = 0;
        float takeValue = 0;
        float inputWJ = 0;
        float sureWJ = 0;
        float takeWJ = 0;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                Map re = new HashMap();
                RkCard = (KCard) jslist.get(i);
                float id = RkCard.getId();
                String dhorderno = RkCard.getDhorderno();
                String PartDrawing = RkCard.getPartDrawing();
                float F3 = RkCard.getF3();
                String Descrip = RkCard.getDescrip();
                String serialno = RkCard.getSerialno();
                String fno = RkCard.getFno();
                float inputnum = RkCard.getInputnum();
                float takenum = RkCard.getTakenum();
                float inputNumKG = RkCard.getInputNumKG();
                String itemno = RkCard.getItemno();
                String unit = RkCard.getUnit();
                String ReportMan = RkCard.getReportMan();
                String AssScanNum = RkCard.getAssScanNum();
                float SplitF3 = RkCard.getSplitF3();
                String equipment = RkCard.getEquipment();
                String ConnectZore = RkCard.getConnectZore();
                String isok = RkCard.getIsok();
                String ismix = RkCard.getIsmix();
                String SAPSDOrder = RkCard.getSAPSDOrder();
                String inputman = RkCard.getInputman();
                String inputdate = RkCard.getInputdate();
                String TempInfo = RkCard.getTempInfo();
                String fname = RkCard.getFname();
                String surenum = RkCard.getSurenum();
                String IsCL = RkCard.getIsCL();
                String takeman = RkCard.getTakeman();
                String takedate = RkCard.getTakedate();
                String dutyman = RkCard.getDutyman();
                String plant = RkCard.getPlant();
                String meins = RkCard.getMeins();
                String planid = RkCard.getPlanid();
                String umouth = RkCard.getUmouth();
                String uyear = RkCard.getUyear();
                String OrderTime = RkCard.getOrderTime();
                String Color = RkCard.getColor();
                String IsPrint = RkCard.getIsPrint();
                String Ftemp10 = RkCard.getFtemp10();
                String GCXH = RkCard.getGCXH();
                String equipmentSerial = RkCard.getEquipmentSerial();
                String equipmentkind = RkCard.getEquipmentkind();
                String issure = RkCard.getIssure();
                String IsTake = RkCard.getIsTake();
                String OrderLine = RkCard.getOrderLine();
                String PackTake = RkCard.getPackTake();
                String PackTakeMan = RkCard.getPackTakeMan();
                String PackTakeDate = RkCard.getPackTakeDate();
                if("0".equals(State)){
                    inputValue = RkCard.getInputValue();
                    sureValue = RkCard.getSureValue();
                    takeValue = RkCard.getTakeValue();
                    inputWJ = RkCard.getInputWJ();
                    sureWJ = RkCard.getSureWJ();
                    takeWJ = RkCard.getTakeWJ();
                    allInputValue += inputValue;
                    allSureValue += sureValue;
                    allTakeValue += takeValue;
                    allInputWJ += inputWJ;
                    allSureWJ += sureWJ;
                    allTakeWJ += takeWJ;
                    allinputnum += inputnum;
                }


                re.put("id", id);
                re.put("dhorderno", dhorderno);
                re.put("PartDrawing", PartDrawing);
                re.put("F3", F3);
                re.put("Descrip", Descrip);
                re.put("itemno", itemno);
                re.put("OrderLine", OrderLine);
                re.put("serialno", serialno);
                re.put("fno", fno);
                re.put("inputnum", inputnum);
                re.put("takenum", takenum);
                re.put("inputNumKG", inputNumKG);
                re.put("unit", unit);
                re.put("AssScanNum", AssScanNum);
                re.put("SplitF3", SplitF3);
                re.put("equipment", equipment);
                re.put("ConnectZore", ConnectZore);
                re.put("isok", isok);
                re.put("ismix", ismix);
                re.put("SAPSDOrder", SAPSDOrder);
                re.put("inputman", inputman);
                re.put("inputdate", inputdate);
                re.put("TempInfo", TempInfo);
                re.put("fname", fname);
                re.put("surenum", surenum);
                re.put("IsCL", IsCL);
                re.put("takeman", takeman);
                re.put("takedate", takedate);
                re.put("dutyman", dutyman);
                re.put("plant", plant);
                re.put("meins", meins);
                re.put("umouth", umouth);
                re.put("planid", planid);
                re.put("uyear", uyear);
                re.put("OrderTime", OrderTime);
                re.put("Color", Color);
                re.put("IsPrint", IsPrint);
                re.put("Ftemp10", Ftemp10);
                re.put("GCXH", GCXH);
                re.put("equipmentSerial", equipmentSerial);
                re.put("equipmentkind", equipmentkind);
                re.put("ReportMan", ReportMan);
                re.put("issure", issure);
                re.put("IsTake", IsTake);
                re.put("inputValue", inputValue);
                re.put("sureValue", sureValue);
                re.put("takeValue", takeValue);
                re.put("inputWJ", inputWJ);
                re.put("sureWJ", sureWJ);
                re.put("takeWJ", takeWJ);
                re.put("PackTake", PackTake);
                re.put("PackTakeMan", PackTakeMan);
                re.put("PackTakeDate", PackTakeDate);
                jslst.add(re);
            }
        }
        Map r = new HashMap();
        r.put("fno","合计");
        r.put("inputnum",allinputnum);
        r.put("inputValue",allInputValue);
        r.put("sureValue",allSureValue);
        r.put("takeValue",allTakeValue);
        r.put("inputWJ",allInputWJ);
        r.put("sureWJ",allSureWJ);
        r.put("takeWJ",allTakeWJ);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(r);
        json.put("rows",jslst);
        json.put("total", jslist.size());
        json.put("footer",jslst2);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/queryTakeScan",method={RequestMethod.GET,RequestMethod.POST})
    public Map QueryTakeScan(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String State = "0";
        KCard kCard = new KCard();
        kCard.setIsTakeScan("1");
        String plant1 = request.getParameter("plant");
        kCard.setPlant(plant1);
        List<KCard> jslist = kCardService.queryTakeScan(kCard);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        KCard RkCard;
        float allInputValue = 0;
        float allSureValue = 0;
        float allTakeValue = 0;
        float allInputWJ = 0;
        float allSureWJ = 0;
        float allTakeWJ = 0;
        float allinputnum = 0;
        float inputValue = 0;
        float sureValue = 0;
        float takeValue = 0;
        float inputWJ = 0;
        float sureWJ = 0;
        float takeWJ = 0;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                Map re = new HashMap();
                RkCard = (KCard) jslist.get(i);
                float id = RkCard.getId();
                String dhorderno = RkCard.getDhorderno();
                String PartDrawing = RkCard.getPartDrawing();
                float F3 = RkCard.getF3();
                String Descrip = RkCard.getDescrip();
                String serialno = RkCard.getSerialno();
                String fno = RkCard.getFno();
                float inputnum = RkCard.getInputnum();
                float takenum = RkCard.getTakenum();
                float inputNumKG = RkCard.getInputNumKG();
                String itemno = RkCard.getItemno();
                String unit = RkCard.getUnit();
                String ReportMan = RkCard.getReportMan();
                String AssScanNum = RkCard.getAssScanNum();
                float SplitF3 = RkCard.getSplitF3();
                String equipment = RkCard.getEquipment();
                String ConnectZore = RkCard.getConnectZore();
                String isok = RkCard.getIsok();
                String ismix = RkCard.getIsmix();
                String SAPSDOrder = RkCard.getSAPSDOrder();
                String inputman = RkCard.getInputman();
                String inputdate = RkCard.getInputdate();
                String TempInfo = RkCard.getTempInfo();
                String fname = RkCard.getFname();
                String surenum = RkCard.getSurenum();
                String IsCL = RkCard.getIsCL();
                String takeman = RkCard.getTakeman();
                String takedate = RkCard.getTakedate();
                String dutyman = RkCard.getDutyman();
                String plant = RkCard.getPlant();
                String meins = RkCard.getMeins();
                String planid = RkCard.getPlanid();
                String umouth = RkCard.getUmouth();
                String uyear = RkCard.getUyear();
                String OrderTime = RkCard.getOrderTime();
                String Color = RkCard.getColor();
                String IsPrint = RkCard.getIsPrint();
                String Ftemp10 = RkCard.getFtemp10();
                String GCXH = RkCard.getGCXH();
                String equipmentSerial = RkCard.getEquipmentSerial();
                String equipmentkind = RkCard.getEquipmentkind();
                String issure = RkCard.getIssure();
                String IsTake = RkCard.getIsTake();
                String OrderLine = RkCard.getOrderLine();
                String PackTake = RkCard.getPackTake();
                String PackTakeMan = RkCard.getPackTakeMan();
                String PackTakeDate = RkCard.getPackTakeDate();
                if("0".equals(State)){
                    inputValue = RkCard.getInputValue();
                    sureValue = RkCard.getSureValue();
                    takeValue = RkCard.getTakeValue();
                    inputWJ = RkCard.getInputWJ();
                    sureWJ = RkCard.getSureWJ();
                    takeWJ = RkCard.getTakeWJ();
                    allInputValue += inputValue;
                    allSureValue += sureValue;
                    allTakeValue += takeValue;
                    allInputWJ += inputWJ;
                    allSureWJ += sureWJ;
                    allTakeWJ += takeWJ;
                    allinputnum += inputnum;
                }


                re.put("id", id);
                re.put("dhorderno", dhorderno);
                re.put("PartDrawing", PartDrawing);
                re.put("F3", F3);
                re.put("Descrip", Descrip);
                re.put("itemno", itemno);
                re.put("OrderLine", OrderLine);
                re.put("serialno", serialno);
                re.put("fno", fno);
                re.put("inputnum", inputnum);
                re.put("takenum", takenum);
                re.put("inputNumKG", inputNumKG);
                re.put("unit", unit);
                re.put("AssScanNum", AssScanNum);
                re.put("SplitF3", SplitF3);
                re.put("equipment", equipment);
                re.put("ConnectZore", ConnectZore);
                re.put("isok", isok);
                re.put("ismix", ismix);
                re.put("SAPSDOrder", SAPSDOrder);
                re.put("inputman", inputman);
                re.put("inputdate", inputdate);
                re.put("TempInfo", TempInfo);
                re.put("fname", fname);
                re.put("surenum", surenum);
                re.put("IsCL", IsCL);
                re.put("takeman", takeman);
                re.put("takedate", takedate);
                re.put("dutyman", dutyman);
                re.put("plant", plant);
                re.put("meins", meins);
                re.put("umouth", umouth);
                re.put("planid", planid);
                re.put("uyear", uyear);
                re.put("OrderTime", OrderTime);
                re.put("Color", Color);
                re.put("IsPrint", IsPrint);
                re.put("Ftemp10", Ftemp10);
                re.put("GCXH", GCXH);
                re.put("equipmentSerial", equipmentSerial);
                re.put("equipmentkind", equipmentkind);
                re.put("ReportMan", ReportMan);
                re.put("issure", issure);
                re.put("IsTake", IsTake);
                re.put("inputValue", inputValue);
                re.put("sureValue", sureValue);
                re.put("takeValue", takeValue);
                re.put("inputWJ", inputWJ);
                re.put("sureWJ", sureWJ);
                re.put("takeWJ", takeWJ);
                re.put("PackTake", PackTake);
                re.put("PackTakeMan", PackTakeMan);
                re.put("PackTakeDate", PackTakeDate);
                jslst.add(re);
            }
        }
        Map r = new HashMap();
        r.put("fno","合计");
        r.put("inputnum",allinputnum);
        r.put("inputValue",allInputValue);
        r.put("sureValue",allSureValue);
        r.put("takeValue",allTakeValue);
        r.put("inputWJ",allInputWJ);
        r.put("sureWJ",allSureWJ);
        r.put("takeWJ",allTakeWJ);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(r);
        json.put("rows",jslst);
        json.put("total", jslist.size());
        json.put("footer",jslst2);
        return json;
    }

}
