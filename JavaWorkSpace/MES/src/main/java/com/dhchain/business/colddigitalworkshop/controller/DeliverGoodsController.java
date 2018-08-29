package com.dhchain.business.colddigitalworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.colddigitalworkshop.service.ColdOutService;
import com.dhchain.business.colddigitalworkshop.service.ColdPlantLgortService;
import com.dhchain.business.colddigitalworkshop.service.ColdStoreService;
import com.dhchain.business.colddigitalworkshop.vo.ColdOut;
import com.dhchain.business.colddigitalworkshop.vo.ColdPlantLgort;
import com.dhchain.business.colddigitalworkshop.vo.ColdStore;
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
@RequestMapping("/DeliverGoods")
public class DeliverGoodsController {
    @Autowired
    private ColdOutService coldOutService;
    @Autowired
    private ColdStoreService coldStoreService;
    @Autowired
    private ColdPlantLgortService coldPlantLgortService;
    @ResponseBody
    @RequestMapping(value = "/selectColdStore", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdStore(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        Double sapstore = 0d;
        if(request.getParameter("sapstore")!=null){
            sapstore =Double.parseDouble( request.getParameter("sapstore"));
        }
        ColdStore coldStore = new ColdStore();
        coldStore.setFno(fno);
        coldStore.setFname(fname);
        coldStore.setSapstore(sapstore);
        System.out.println("fno:"+fno+" fname:"+fname);
        List<ColdStore> list = coldStoreService.selectColdStoreList(coldStore);
        System.out.println(list.size());
        Map json = new HashMap();
        if (list.size() > 0) {
            json.put("rows", list);
            json.put("total", list.size());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/selectColdOutToday", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectColdOutToday(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdOut coldOut = new ColdOut();
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String date = dateFormat.format( now );
        String vbeln = request.getParameter("vbeln");
        coldOut.setOutputdate(date);
        coldOut.setCgvbeln(vbeln);
        List<ColdOut> list = coldOutService.selectColdOutToday(coldOut);
        Map json = new HashMap();
        if (list.size() > 0) {
            json.put("rows", list);
            json.put("total", list.size());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/insertColdOut", method = {RequestMethod.GET, RequestMethod.POST})
    public Map insertColdOut(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdOut coldOut = new ColdOut();
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = dateFormat.format( now );
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");

        String plant = request.getParameter("plant");
        String outadd = request.getParameter("outadd");
        String outaddname = request.getParameter("outaddname");
        String outputman = request.getParameter("outputman");
        String location = request.getParameter("location");
        String cgposnr = request.getParameter("cgposnr");
        String cgvbeln = request.getParameter("cgvbeln");
        String isdelete = request.getParameter("isdelete");
        coldOut.setOutputdate(date);
        coldOut.setFno(fno);
        coldOut.setFname(fname);
        if (request.getParameter("outnumber")!=null){
            coldOut.setOutnumber(Double.parseDouble(request.getParameter("outnumber")));
        }
        coldOut.setPlant(plant);
        coldOut.setOutadd(outadd);
        coldOut.setOutaddname(outaddname);
        coldOut.setOutputman(outputman);
        if (request.getParameter("ismove")!=null){
            coldOut.setIsmove(Boolean.parseBoolean(request.getParameter("ismove")));
        }
        if (request.getParameter("year")!=null){
            coldOut.setYear(Integer.parseInt(request.getParameter("year")));
        }
        if (request.getParameter("month")!=null){
            coldOut.setMonth(Integer.parseInt(request.getParameter("month")));
        }
        if (request.getParameter("istake")!=null){
            coldOut.setIstake(Boolean.parseBoolean(request.getParameter("istake")));
        }
        coldOut.setLocation(location);
        if (request.getParameter("isapp")!=null){
            coldOut.setIsapp(Boolean.parseBoolean(request.getParameter("isapp")));
        }
        if (request.getParameter("isdelete")!=null){
            coldOut.setIsdelete(Boolean.parseBoolean(request.getParameter("isdelete")));
        }
        if (request.getParameter("cgposnr")!=null &&!"".equals( request.getParameter("cgposnr"))){
            coldOut.setCgposnr(cgposnr);
        }
        if (request.getParameter("cgvbeln")!=null&&!"".equals( request.getParameter("cgvbeln"))){
            coldOut.setCgvbeln(cgvbeln);
        }
        List jslist = coldOutService.getSeId(coldOut);
        ColdOut RcoldOut;
        if(jslist.size()>0) {
            RcoldOut = (ColdOut)jslist.get(0);
            int Serialno = Integer.parseInt(RcoldOut.getSerialno())+1;
            coldOut.setSerialno(Serialno+"");
        }else{
            String Serialno = request.getParameter("month")+"00001";
            coldOut.setSerialno(Serialno);
        }
        int num = coldOutService.insertSelective(coldOut);
        if (num>0){
            int storenum = coldStoreService.updateColdStoreOut(coldOut);
        }
        Map json = new HashMap();
        json.put("num", num);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteColdOut", method = {RequestMethod.GET, RequestMethod.POST})
    public Map deleteColdOut(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdOut coldOut = new ColdOut();
        Integer id =0;
        if (request.getParameter("id")!=null){
            id = Integer.parseInt(request.getParameter("id"));
        }
        coldOut = coldOutService.selectByPrimaryKey(id);
        int num = coldOutService.deleteByPrimaryKey(id);
        if (num > 0) {
            int numStore =  coldStoreService.updateColdStoreOutBack(coldOut);
        }
        Map json = new HashMap();
        json.put("num", num);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/selectPlantLgortAll",method={RequestMethod.GET,RequestMethod.POST})
    public JSON selectPlantLgortAll(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        List<ColdPlantLgort> jslist = coldPlantLgortService.selectPlantLgortAll();
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        ColdPlantLgort coldPlantLgort;
        //System.out.println(plant);
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {
                Map re = new HashMap();
                coldPlantLgort =  jslist.get(i);
                String lgort = coldPlantLgort.getLgort();
                String plant = coldPlantLgort.getPlant();
                re.put("lgort", lgort);
                re.put("plant", plant);
                jslst.add(re);

            }
        }
        return jslst;
    }
}
