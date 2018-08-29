package com.dhchain.business.colddigitalworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.colddigitalworkshop.service.ColdDailyPrintService;
import com.dhchain.business.colddigitalworkshop.service.ColdMonthPlanServivce;
import com.dhchain.business.colddigitalworkshop.service.ColdStoreService;
import com.dhchain.business.colddigitalworkshop.service.MaterialtakeinService;
import com.dhchain.business.colddigitalworkshop.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/CuttingSure")
public class CuttingSureController {
    @Autowired
    private ColdDailyPrintService coldDailyPrintService;
    @Autowired
    private MaterialtakeinService materialtakeinService;
    @Autowired
    private ColdStoreService coldStoreService;
    @Autowired
    private ColdMonthPlanServivce coldMonthPlanServivce;
    @ResponseBody
    @RequestMapping(value = "/selectColdDailyPrint", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdDailyPrint(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdDailyPrint coldDailyPrint = new ColdDailyPrint();
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String plant = request.getParameter("plant");
        String printman = request.getParameter("printman");
        String reelnums = request.getParameter("reelnums");
        coldDailyPrint.setBegindate(startTime);
        coldDailyPrint.setEnddate(endTime);
        coldDailyPrint.setPlant(plant);
        coldDailyPrint.setPrintman(printman);
        coldDailyPrint.setReelnums(reelnums);
        List<ColdDailyPrint> list = coldDailyPrintService.selectColdDailyPrint(coldDailyPrint);
        Map json = new HashMap();
        if (list.size() > 0) {
            //System.out.println(list);
            json.put("rows", list);
            json.put("total", list.size());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/selectColdDailyPrintSum", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdDailyPrintSum(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdDailyPrint coldDailyPrint = new ColdDailyPrint();
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String plant = request.getParameter("plant");
        String reelnums = request.getParameter("reelnums");
        coldDailyPrint.setBegindate(startTime);
        coldDailyPrint.setEnddate(endTime);
        coldDailyPrint.setPlant(plant);
        coldDailyPrint.setReelnums(reelnums);
        List<ColdDailyPrintSum> list = coldDailyPrintService.selectDailyPrintSum(coldDailyPrint);
        Double allNumber = 0d;
        Double allSureNumber = 0d;
        Map json = new HashMap();
        if (list.size() > 0) {
                for(int i = 0;i<list.size();i++) {
                    ColdDailyPrintSum coldDailyPrintSum = list.get(i);
                    if(coldDailyPrintSum.getWeight()!=null){
                        allNumber = allNumber+coldDailyPrintSum.getWeight();
                    }
                    if(coldDailyPrintSum.getWeightOk()!=null){
                        allSureNumber = allSureNumber+coldDailyPrintSum.getWeightOk();
                    }

                }
                Map r = new HashMap();
                r.put("reelnums","合计");
                r.put("weight",allNumber);
                r.put("weightOk",allSureNumber);
                JSONArray jslst2 = new JSONArray();
                jslst2.add(r);
                //System.out.println(list);
                json.put("rows", list);
                json.put("total", list.size());
                json.put("footer",jslst2);
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/selectPrintman",method={RequestMethod.GET,RequestMethod.POST})
    public JSON selectPrintman(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdDailyPrint coldDailyPrint = new ColdDailyPrint();
        List<ColdDailyPrint> jslist = coldDailyPrintService.selectPrintMan(coldDailyPrint);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        ColdDailyPrint RcoldDailyPrint;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                Map re = new HashMap();
                RcoldDailyPrint =  jslist.get(i);
                String printman = RcoldDailyPrint.getPrintman();
                re.put("printman",printman);
                jslst.add(re);

            }
        }
        return jslst;
    }

    @ResponseBody
    @RequestMapping(value="/update",method={RequestMethod.GET,RequestMethod.POST})
    public Map update(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdDailyPrint coldDailyPrint = new ColdDailyPrint();
        coldDailyPrint.setId(Integer.parseInt(request.getParameter("id")));
        Boolean istake =  Boolean.parseBoolean(request.getParameter("istake"));
        String takeman =  request.getParameter("takeman");
        String fids =  request.getParameter("fids");
        String fno = request.getParameter("fno");
        String weight = request.getParameter("weight");
        coldDailyPrint.setIstake(istake);
        coldDailyPrint.setTakeman(takeman);
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
        String hehe = dateFormat.format( now );
        coldDailyPrint.setTakedate(hehe);
        ColdDailyPrint coldDailyPrint1 = new ColdDailyPrint();
        String fidreel= fids.split("/")[1];
        if(fidreel!=null &&!"".equals(fidreel)){
            coldDailyPrint1.setFids(fidreel);
            coldDailyPrint1.setFno(fno);
            if(weight!=null){
                coldDailyPrint1.setWeight(weight);
            }

        }

        int n = coldDailyPrintService.updateByPrimaryKeySelective(coldDailyPrint);
        if(n>0){
            coldMonthPlanServivce.updateByFidChangeNum(coldDailyPrint1);
        }
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/updateweight",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateweight(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdDailyPrint coldDailyPrint = new ColdDailyPrint();
        coldDailyPrint.setId(Integer.parseInt(request.getParameter("id")));
        String weight = request.getParameter("weightnew");
        coldDailyPrint.setWeight(weight);

        int n = coldDailyPrintService.updateByPrimaryKeySelective(coldDailyPrint);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/updateSum",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateSum(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        int n =0;
        int number = 0;
        ColdDailyPrint coldDailyPrint = new ColdDailyPrint();
        Boolean istake =  Boolean.parseBoolean(request.getParameter("istake"));
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String plant = request.getParameter("plant");
        String printman = request.getParameter("printman");
        String reelnums = request.getParameter("reelnums");
        String takeman =  request.getParameter("takeman");
        String fno = request.getParameter("fno");
        coldDailyPrint.setBegindate(startTime);
        coldDailyPrint.setEnddate(endTime);
        coldDailyPrint.setPlant(plant);
        coldDailyPrint.setPrintman(printman);
        coldDailyPrint.setReelnums(reelnums);
        coldDailyPrint.setFno(fno);
        List<ColdDailyPrint> list = coldDailyPrintService.selectColdDailyPrint(coldDailyPrint);
        if (list.size() > 0) {
            for(int i =0;i<list.size();i++){
                Map re = new HashMap();
                ColdDailyPrint coldDailyPrintReturn = new ColdDailyPrint();
                coldDailyPrintReturn =  list.get(i);
                Boolean istakepd = coldDailyPrintReturn.getIstake();
                if(!istakepd){
                    coldDailyPrintReturn.setIstake(istake);
                    coldDailyPrintReturn.setTakeman(takeman);
                    String fids =  coldDailyPrintReturn.getFids();
                    String weight = coldDailyPrintReturn.getWeight();
                    Date now = new Date();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                    String hehe = dateFormat.format( now );
                    coldDailyPrintReturn.setTakedate(hehe);
                    ColdDailyPrint coldDailyPrint1 = new ColdDailyPrint();
                    String fidreel= fids.split("/")[1];
                    if(fidreel!=null &&!"".equals(fidreel)){
                        coldDailyPrint1.setFno(fno);
                        coldDailyPrint1.setFids(fidreel);

                        if(weight!=null){
                            coldDailyPrint1.setWeight(weight);
                        }

                    }

                    n = coldDailyPrintService.updateByPrimaryKeySelective(coldDailyPrintReturn);
                    if(n>0){
                        coldMonthPlanServivce.updateByFidChangeNum(coldDailyPrint1);
                    }

                    ColdDailyPrint coldDailyPrintStoreIn = new ColdDailyPrint();
                    Integer id = coldDailyPrintReturn.getId();
                    coldDailyPrintStoreIn = coldDailyPrintService.selectByPrimaryKey(id);
                    ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
                    coldMaterialIn.setFno(coldDailyPrintStoreIn.getFno());
                    coldMaterialIn.setFname(coldDailyPrintStoreIn.getFname());
                    coldMaterialIn.setNumber(Double.parseDouble(coldDailyPrintStoreIn.getWeight()));
                    coldMaterialIn.setInputman(coldDailyPrintStoreIn.getTakeman());

                    coldMaterialIn.setUyear(coldDailyPrintStoreIn.getYear());
                    coldMaterialIn.setUmonth(coldDailyPrintStoreIn.getMonth());
                    coldMaterialIn.setCuttingid(id.toString());
                    coldMaterialIn.setLocation("999");
                    coldMaterialIn.setPlant("材料零件");
                    List<ColdMaterialIn> jslist = materialtakeinService.getSeId(coldMaterialIn);
                    ColdMaterialIn RColdMaterialIn;
                    if (jslist.size() > 0) {
                        RColdMaterialIn = jslist.get(0);
                        int Serialno = Integer.parseInt(RColdMaterialIn.getSerialno()) + 1;
                        coldMaterialIn.setSerialno(Serialno + "");
                    } else {
                        String Serialno = coldDailyPrint.getYear() + "00001";
                        coldMaterialIn.setSerialno(Serialno);
                    }
                    coldMaterialIn.setInputdate(hehe);
                    int num = materialtakeinService.insertColdmsg(coldMaterialIn);
                    ColdStoreKey coldStoreKey = new ColdStoreKey();
                    coldStoreKey.setFno(coldDailyPrint.getFno());
                    coldStoreKey.setPlant("材料零件");
                    List<ColdStore> listStore = coldStoreService.selectColdStore(coldStoreKey);
                    if (listStore.size()>0){
                        int numStore = coldStoreService.updateColdStoreIn(coldMaterialIn);
                    }else{
                        ColdStore coldStore = new ColdStore();
                        coldStore.setFno(coldDailyPrint.getFno());
                        coldStore.setInputstore(Double.parseDouble(coldDailyPrintReturn.getWeight()));
                        coldStore.setOutputstore(0d);
                        coldStore.setFname(coldDailyPrint.getFname());
                        coldStore.setBeginstore(0d);

                        coldStore.setPlant("材料零件");

                        coldStore.setSapstore(Double.parseDouble(coldDailyPrintReturn.getWeight()));
                        coldStore.setInputman(coldDailyPrint.getTakeman());
                        coldStore.setInputdate(hehe);
                        coldStore.setBeginman(coldDailyPrint.getTakeman());
                        coldStore.setBegindate(hehe);
                        int numStoreIn = coldStoreService.insertSelective(coldStore);
                    }
                    if(n>0){
                        number++;
                    }
                }

            }
        }

        Map json = new HashMap();
        json.put("num",number);
        return json;
    }

    @ResponseBody
    @RequestMapping(value="/updateStoreIn",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateStoreIn(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdDailyPrint coldDailyPrint = new ColdDailyPrint();
        Integer id = Integer.parseInt(request.getParameter("id"));
        coldDailyPrint = coldDailyPrintService.selectByPrimaryKey(id);
        ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
        coldMaterialIn.setFno(coldDailyPrint.getFno());
        coldMaterialIn.setFname(coldDailyPrint.getFname());
        coldMaterialIn.setNumber(Double.parseDouble(coldDailyPrint.getWeight()));
        coldMaterialIn.setInputman(coldDailyPrint.getTakeman());

        coldMaterialIn.setUyear(coldDailyPrint.getYear());
        coldMaterialIn.setUmonth(coldDailyPrint.getMonth());
        coldMaterialIn.setCuttingid(id.toString());
        coldMaterialIn.setLocation("999");
        coldMaterialIn.setPlant("材料零件");
        List<ColdMaterialIn> jslist = materialtakeinService.getSeId(coldMaterialIn);
        ColdMaterialIn RColdMaterialIn;
        if (jslist.size() > 0) {
            RColdMaterialIn = jslist.get(0);
            int Serialno = Integer.parseInt(RColdMaterialIn.getSerialno()) + 1;
            coldMaterialIn.setSerialno(Serialno + "");
        } else {
            String Serialno = coldDailyPrint.getYear() + "00001";
            coldMaterialIn.setSerialno(Serialno);
        }
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
        String hehe = dateFormat.format( now );
        coldMaterialIn.setInputdate(hehe);
        int n = materialtakeinService.insertColdmsg(coldMaterialIn);
        ColdStoreKey coldStoreKey = new ColdStoreKey();
        coldStoreKey.setFno(coldDailyPrint.getFno());
        coldStoreKey.setPlant("材料零件");
        List<ColdStore> list = coldStoreService.selectColdStore(coldStoreKey);
        if (list.size()>0){
            int numStore = coldStoreService.updateColdStoreIn(coldMaterialIn);
        }else{
            ColdStore coldStore = new ColdStore();
            coldStore.setFno(coldDailyPrint.getFno());
            coldStore.setFname(coldDailyPrint.getFname());
            coldStore.setBeginstore(0d);
            coldStore.setInputstore(Double.parseDouble(coldDailyPrint.getWeight()));
            coldStore.setOutputstore(0d);
            coldStore.setPlant("材料零件");

            coldStore.setSapstore(Double.parseDouble(coldDailyPrint.getWeight()));
            coldStore.setInputman(coldDailyPrint.getTakeman());
            coldStore.setInputdate(hehe);
            coldStore.setBeginman(coldDailyPrint.getTakeman());
            coldStore.setBegindate(hehe);
            int numStoreIn = coldStoreService.insertSelective(coldStore);
        }
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value="/deleteStoreIn",method={RequestMethod.GET,RequestMethod.POST})
    public Map deleteStoreIn(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Integer cuttingid = Integer.parseInt(request.getParameter("cuttingid"));
        ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
        coldMaterialIn.setCuttingid(cuttingid.toString());
        int n = materialtakeinService.updateCutting(coldMaterialIn);
        if (n>0){
            ColdDailyPrint coldDailyPrint = new ColdDailyPrint();
            coldDailyPrint = coldDailyPrintService.selectByPrimaryKey(cuttingid);
            coldMaterialIn.setFno(coldDailyPrint.getFno());
            coldMaterialIn.setFname(coldDailyPrint.getFname());
            coldMaterialIn.setNumber(Double.parseDouble("-"+coldDailyPrint.getWeight()));
            coldMaterialIn.setInputman(coldDailyPrint.getTakeman());

            coldMaterialIn.setUyear(coldDailyPrint.getYear());
            coldMaterialIn.setUmonth(coldDailyPrint.getMonth());
            coldMaterialIn.setCuttingid(cuttingid.toString());
            coldMaterialIn.setLocation("999");
            coldMaterialIn.setPlant("材料零件");
            int numStore = coldStoreService.updateColdStoreIn(coldMaterialIn);
        }
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
}
