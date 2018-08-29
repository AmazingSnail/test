package com.dhchain.business.HeatTreatment.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.HeatTreatment.service.MCraftparamService;
import com.dhchain.business.HeatTreatment.service.ProductionProcessService;
import com.dhchain.business.HeatTreatment.vo.*;
import com.dhchain.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * Created by ASUS on 2018/7/6.
 */
@Controller
@RequestMapping(value = "/ProductionProcess")
public class ProductionProcessController {
    @Autowired
    private ProductionProcessService productionProcessService;
    @Autowired
    private MCraftparamService mCraftparamService;
    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET, RequestMethod.POST})
    public Map Query (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String plant = request.getParameter("plant");
        String PartDrawing = request.getParameter("PartDrawing");
        String PartName = request.getParameter("PartName");
        String matail = request.getParameter("matail");
        String MBMC = request.getParameter("MBMC");
        ProductionProcess productionProcess = new ProductionProcess();
        productionProcess.setPlant(plant);
        productionProcess.setPartdrawing(PartDrawing);
        productionProcess.setPartname(PartName);
        productionProcess.setMaterial(matail);
        productionProcess.setTempletnum(MBMC);
        List<ProductionProcess> list = productionProcessService.getData(productionProcess);
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }

    @ResponseBody
    @RequestMapping(value="/Juge",method={RequestMethod.GET, RequestMethod.POST})
    public Map Juge (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String partDrawing = request.getParameter("partDrawing");
        Example example = new Example(MCraftparam.class);
        Example.Criteria criteria = example.createCriteria();
       if(tk.mybatis.mapper.util.StringUtil.isNotEmpty(partDrawing)) {
            criteria.andEqualTo("partdrawing",partDrawing.trim());
        }
        List<MCraftparam> list = mCraftparamService.selectByExample(example);
       if(list.size()>0){
           json.put("num",list.size());
       }else {
           json.put("num",-1);
       }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/getMB",method={RequestMethod.GET, RequestMethod.POST})
    public JSON GetMB (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");

        JSONArray jslist = new JSONArray();
        String plant = request.getParameter("plant");
        MCraftmould mCraftmould = new MCraftmould();
        mCraftmould.setPlant(plant);
        List<MCraftmould> list = productionProcessService.getTempletname(mCraftmould);
        if(list.size()>0){
            for(int i = 0 ;i<list.size();i++){
                Map re = new HashMap();
                MCraftmould mCraftmould1 = list.get(i);
                String templetname =  mCraftmould1.getTempletname();
                re.put("templetname",templetname);
                jslist.add(re);

            }
        }
        return  jslist;
    }
    @ResponseBody
    @RequestMapping(value="/getTempletnum",method={RequestMethod.GET, RequestMethod.POST})
    public Map GetTempletnum (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");

        JSONObject re1 = new JSONObject();
        String templetname = request.getParameter("templetname");
        String plant = request.getParameter("plant");
        MCraftmould mCraftmould = new MCraftmould();
        mCraftmould.setTempletname(templetname);
        mCraftmould.setPlant(plant);
        List<MCraftmould> list = productionProcessService.getTempletnum(mCraftmould);
        if(list.size()>0){
            for(MCraftmould i : list){
                MCraftmould mCraftmould1 = i;
                String Templetnum = mCraftmould1.getTempletnum();
                String QuenchTemp1 = mCraftmould1.getQuenchtemp1();
                String QuenchTemp2 = mCraftmould1.getQuenchtemp2();
                String QuenchTemp3 = mCraftmould1.getQuenchtemp3();
                String QuenchTemp4 = mCraftmould1.getQuenchtemp4();
                String QuenchTemp5 = mCraftmould1.getQuenchtemp5();
                String QuenchTime = mCraftmould1.getQuenchtime();
                String CoolTemp = mCraftmould1.getCooltemp();
                String Carpotential = mCraftmould1.getCarpotential();
                String Coating = mCraftmould1.getCoating();
                String QuenchHard =mCraftmould1.getQuenchhard();
                String TemperTemp = mCraftmould1.getTempertemp();
                String CarbinolF = mCraftmould1.getCarbinolf();
                String TemperHard = mCraftmould1.getTemperhard();
                String TemperTime = mCraftmould1.getTempertime();
                re1.put("Templetnum",Templetnum);
                re1.put("QuenchTemp1",QuenchTemp1+"  "+ "°C");
                re1.put("QuenchTemp2",QuenchTemp2+"  "+ "°C");
                re1.put("QuenchTemp3",QuenchTemp3+"  "+ "°C");
                re1.put("QuenchTemp4",QuenchTemp4+"  "+ "°C");
                re1.put("QuenchTemp5",QuenchTemp5+"  "+ "°C");
                re1.put("QuenchTime",QuenchTime+"  "+ "min");
                re1.put("CoolTemp",CoolTemp+"  "+ "°C");
                re1.put("Carpotential",Carpotential+"  "+ "°C");
                re1.put("Coating",Coating+"  "+ "min");
                re1.put("QuenchHard",QuenchHard+"  "+ "HRC");
                re1.put("TemperTemp",TemperTemp+"  "+ "°C");
                re1.put("CarbinolF",CarbinolF+"  "+ "L/h");
                re1.put("TemperHard",TemperHard+"  "+ "HRC");
                re1.put("TemperTime",TemperTime+"  "+ "min");
            }
        }
        return  re1;
    }
   @ResponseBody
   @RequestMapping(value = "/Insert",method={RequestMethod.GET, RequestMethod.POST})
    public Map Insert(HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String partDrawing = request.getParameter("partDrawing");
        String partname = request.getParameter("partname");
        String MBid = request.getParameter("MBid");
        String MBname = request.getParameter("MBname");
        String ids = request.getParameter("ids");
        MCraftparam mCraftparam = new MCraftparam();
        mCraftparam.setPartdrawing(partDrawing);
        mCraftparam.setPartname(partname);
        mCraftparam.setPlant(plant);
        mCraftparam.setTempletname(MBname);
        mCraftparam.setTempletnum(MBid);
        if(StringUtil.isEmpty(ids)){
            mCraftparam.setInputman(name);
            mCraftparam.setInputtime(time);
            int n = mCraftparamService.InsertUseGeneratedKeysMapper(mCraftparam);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }else {
            mCraftparam.setId(Integer.parseInt(ids));
            mCraftparam.setModifyman(name);
            mCraftparam.setModifytime(time);
            int n = mCraftparamService.updateNotNull(mCraftparam);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }
        return json;
   }
   @ResponseBody
    @RequestMapping(value = "/Deletedata",method={RequestMethod.GET, RequestMethod.POST})
   public Map Deletedata(HttpServletRequest request) throws UnsupportedEncodingException {
    Map json = new HashMap();
    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
    int n = mCraftparamService.deleteByPrimaryKey(Integer.parseInt(id));
       if(n>0){
           json.put("num",n);
       }else {
           json.put("num",-1);
       }
    return  json;
    }
    @ResponseBody
    @RequestMapping(value = "/InsertMould",method={RequestMethod.GET, RequestMethod.POST})
    public Map InsertMould(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String MBname = request.getParameter("MBname");
        String MBid1 = request.getParameter("MBid");
        String plant = request.getParameter("plant");
        String plant1 = request.getParameter("plant1");
        String time = request.getParameter("time");
        String name = request.getParameter("name");
        String   quenchtemp1 = request.getParameter("quenchtemp1");
        String         quenchtemp1up = request.getParameter("quenchtemp1up");
        String          quenchtemp1low = request.getParameter("quenchtemp1low");
        String quenchtemp1st="";
        if(quenchtemp1up.equals(quenchtemp1low)){
            quenchtemp1st = quenchtemp1 +"±" +quenchtemp1up;
        }else {
            quenchtemp1st = quenchtemp1 + "+" +quenchtemp1up+"-"+quenchtemp1low;
        }
        String          quenchtemp2 = request.getParameter("quenchtemp2");
        String         quenchtemp2up = request.getParameter("quenchtemp2up");
        String         quenchtemp2low = request.getParameter("quenchtemp2low");
        String quenchtemp2st="";
        if(quenchtemp2up.equals(quenchtemp2low)){
            quenchtemp2st = quenchtemp2 +"±" +quenchtemp2up;
        }else {
            quenchtemp2st = quenchtemp2 + "+" +quenchtemp2up+"-"+quenchtemp2low;
        }
        String       quenchtemp3 = request.getParameter("quenchtemp3");
        String        quenchtemp3up = request.getParameter("quenchtemp3up");
        String        quenchtemp3low = request.getParameter("quenchtemp3low");
        String quenchtemp3st="";
        if(quenchtemp3up.equals(quenchtemp3low)){
            quenchtemp3st = quenchtemp3 +"±" +quenchtemp3up;
        }else {
            quenchtemp3st = quenchtemp3 + "+" +quenchtemp3up+"-"+quenchtemp3low;
        }
        String       quenchtemp4 = request.getParameter("quenchtemp4");
        String        quenchtemp4up = request.getParameter("quenchtemp4up");
        String        quenchtemp4low = request.getParameter("quenchtemp4low");
        String quenchtemp4st="";
        if(quenchtemp4up.equals(quenchtemp4low)){
            quenchtemp4st = quenchtemp4 +"±" +quenchtemp4up;
        }else {
            quenchtemp4st = quenchtemp4 + "+" +quenchtemp4up+"-"+quenchtemp4low;
        }
        String       quenchtemp5 = request.getParameter("quenchtemp5");
        String       quenchtemp5up = request.getParameter("quenchtemp5up");
        String      quenchtemp5low = request.getParameter("quenchtemp5low");
        String quenchtemp5st="";
        if(quenchtemp5up.equals(quenchtemp5low)){
            quenchtemp5st = quenchtemp5 +"±" +quenchtemp5up;
        }else {
            quenchtemp5st = quenchtemp5 + "+" +quenchtemp5up+"-"+quenchtemp5low;
        }
        String      QuenchTime = request.getParameter("QuenchTime");
        String      QuenchTimeup = request.getParameter("QuenchTimeup");
        String      QuenchTimelow = request.getParameter("QuenchTimelow");
        String QuenchTimest="";
        if(QuenchTimeup.equals(QuenchTimelow)){
            QuenchTimest = QuenchTime +"±" +QuenchTimeup;
        }else {
            QuenchTimest = QuenchTime + "+" +QuenchTimeup+"-"+QuenchTimelow;
        }
        String     CoolTemp = request.getParameter("CoolTemp");
        String      CoolTempup = request.getParameter("CoolTempup");
        String     CoolTemplow = request.getParameter("CoolTemplow");
        String CoolTempst="";
        if(CoolTempup.equals(CoolTemplow)){
            CoolTempst = CoolTemp +"±" +CoolTempup;
        }else {
            CoolTempst = CoolTemp + "+" +CoolTempup+"-"+CoolTemplow;
        }
        String      QuenchHardup = request.getParameter("QuenchHardup");
        String      QuenchHard = request.getParameter("QuenchHard");
        String      QuenchHardlow = request.getParameter("QuenchHardlow");
        String QuenchHardst="";
        if(QuenchHardup.equals(QuenchHardlow)){
            QuenchHardst = QuenchHard +"±" +QuenchHardup;
        }else {
            QuenchHardst = QuenchHard + "+" +QuenchHardup+"-"+QuenchHardlow;
        }
        String      CarbinolF = request.getParameter("CarbinolF");
        String      CarbinolFup = request.getParameter("CarbinolFup");
        String      CarbinolFlow = request.getParameter("CarbinolFlow");
        String CarbinolFst= "";
        if(CarbinolFup.equals(CarbinolFlow)){
            CarbinolFst = CarbinolF +"±" +CarbinolFup;
        }else {
            CarbinolFst = CarbinolF + "+" +CarbinolFup+"-"+CarbinolFlow;
        }
        String      Carpotential = request.getParameter("Carpotential");
        String      Carpotentialup = request.getParameter("Carpotentialup");
        String      Carpotentiallow = request.getParameter("Carpotentiallow");
        String Carpotentialst="";
        if(Carpotentialup.equals(Carpotentiallow)){
            Carpotentialst = Carpotential +"±" +Carpotentialup;
        }else {
            Carpotentialst = Carpotential + "+" +Carpotentialup+"-"+Carpotentiallow;
        }
        String       coating = request.getParameter("coating");
        String     coatingup = request.getParameter("coatingup");
        String     coatinglow = request.getParameter("coatinglow");
        String coatingst="";
        if(coatingup.equals(coatinglow)){
            coatingst = coating +"±" +coatingup;
        }else {
            coatingst = coatingup + "+" +coatingup+"-"+coatinglow;
        }
        String     tempertemp = request.getParameter("tempertemp");
        String     tempertempup = request.getParameter("tempertempup");
        String     tempertemplow = request.getParameter("tempertemplow");
        String tempertempst = "";
        if(tempertempup.equals(tempertemplow)){
            tempertempst = tempertemp +"±" +tempertempup;
        }else {
            tempertempst = tempertemp + "+" +tempertempup+"-"+tempertemplow;
        }
        String     temperhard = request.getParameter("temperhard");
        String     temperhardup = request.getParameter("temperhardup");
        String     temperhardlow = request.getParameter("temperhardlow");
        String temperhardst = "";
        if(temperhardup.equals(temperhardlow)){
            temperhardst = temperhard +"±" +temperhardup;
        }else {
            temperhardst = temperhard +"±" +temperhardup+"-"+temperhardlow;
        }
        String     tempertime = request.getParameter("tempertime");
        String     tempertimeup = request.getParameter("tempertimeup");
        String     tempertimelow = request.getParameter("tempertimelow");
        String tempertimest="";
        if(tempertimeup.equals(tempertimelow)){
            tempertimest = tempertime +"±" +tempertimeup;
        }else {
            tempertimest = tempertime +"±" +tempertimeup+"-"+tempertimelow;
        }
        String     ids = request.getParameter("ids");
        MCraftmould mCraftmould = new MCraftmould();
        mCraftmould.setPlant(plant1);
        mCraftmould.setTempletname(MBname);
        mCraftmould.setQuenchtemp1(quenchtemp1);
        mCraftmould.setQuenchtemp1up(quenchtemp1up);
        mCraftmould.setQuenchtemp1low(quenchtemp1low);
        mCraftmould.setQuenchtemp2(quenchtemp2);
        mCraftmould.setQuenchtemp2up(quenchtemp2up);
        mCraftmould.setQuenchtemp2low(quenchtemp2low);
        mCraftmould.setQuenchtemp3(quenchtemp3);
        mCraftmould.setQuenchtemp3up(quenchtemp3up);
        mCraftmould.setQuenchtemp3low(quenchtemp3low);
        mCraftmould.setQuenchtemp4(quenchtemp4);
        mCraftmould.setQuenchtemp4up(quenchtemp4up);
        mCraftmould.setQuenchtemp4low(quenchtemp4low);
        mCraftmould.setQuenchtemp5(quenchtemp5);
        mCraftmould.setQuenchtemp5up(quenchtemp5up);
        mCraftmould.setQuenchtemp5low(quenchtemp5low);
        mCraftmould.setQuenchtime(QuenchTime);
        mCraftmould.setQuenchtimeup(QuenchTimeup);
        mCraftmould.setQuenchtimelow(QuenchTimelow);
        mCraftmould.setQuenchtimest(QuenchTimest);
        mCraftmould.setCooltemp(CoolTemp);
        mCraftmould.setCooltempup(CoolTempup);
        mCraftmould.setCooltemplow(CoolTemplow);
        mCraftmould.setCooltempst(CoolTempst);
        mCraftmould.setQuenchhard(QuenchHard);
        mCraftmould.setQuenchhardst(QuenchHardst);
        mCraftmould.setQuenchhardup(QuenchHardup);
        mCraftmould.setQuenchhardlow(QuenchHardlow);
        mCraftmould.setCarbinolf(CarbinolF);
        mCraftmould.setCarbinolfst(CarbinolFst);
        mCraftmould.setCarbinolfup(CarbinolFup);
        mCraftmould.setCarbinolflow(CarbinolFlow);
        mCraftmould.setCarpotential(Carpotential);
        mCraftmould.setCarpotentialst(Carpotentialst);
        mCraftmould.setCarpotentialup(Carpotentialup);
        mCraftmould.setCarpotentiallow(Carpotentiallow);
        mCraftmould.setCoating(coating);
        mCraftmould.setCoatingst(coatingst);
        mCraftmould.setCoatingup(coatingup);
        mCraftmould.setCoatinglow(coatinglow);
        mCraftmould.setTempertemp(tempertemp);
        mCraftmould.setTempertempst(tempertempst);
        mCraftmould.setTempertempup(tempertempup);
        mCraftmould.setTempertemplow(tempertemplow);
        mCraftmould.setTemperhard(temperhard);
        mCraftmould.setTemperhardst(temperhardst);
        mCraftmould.setTemperhardup(temperhardup);
        mCraftmould.setTemperhardlow(temperhardlow);
        mCraftmould.setTempertime(tempertime);
        mCraftmould.setTempertimest(tempertimest);
        mCraftmould.setTempertimeup(tempertimeup);
        mCraftmould.setTempertimelow(tempertimelow);
        mCraftmould.setQuenchtemp1st(quenchtemp1st);
        mCraftmould.setQuenchtemp2st(quenchtemp2st);
        mCraftmould.setQuenchtemp3st(quenchtemp3st);
        mCraftmould.setQuenchtemp4st(quenchtemp4st);
        mCraftmould.setQuenchtemp5st(quenchtemp5st);
        String MBid = "";
        String b ="";
        int id1;
        if(StringUtil.isEmpty(MBid1)){
            MCraftmould mCraftmould1  = new MCraftmould();
            mCraftmould1.setPlant(plant);
            List<MCraftmould> list = productionProcessService.getMaxMBid(mCraftmould1);//获取最大的模板id;

            if(list.size()>0){
                MCraftmould mCraftmould2 = list.get(0);
                String mbid = mCraftmould2.getTempletnum();//CMB001
                id1 = Integer.parseInt(mbid.substring(3,6));
                id1 = id1 +1;
                b =   String.format("%03d",id1);
                MBid = plant + "MB" + b;
            }else {
                MBid = plant + "MB" +"001";
            }
            mCraftmould.setTempletnum(MBid);
        }else {
            mCraftmould.setTempletnum(MBid1);
        }


        if(StringUtil.isEmpty(ids)){
            mCraftmould.setInputman(name);
            mCraftmould.setInputtime(time);
            int n = productionProcessService.InsertUseGeneratedKeysMapper(mCraftmould);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }else {
            mCraftmould.setId(Integer.parseInt(ids));
            mCraftmould.setModifyman(name);
            mCraftmould.setModifytime(time);
            int n = productionProcessService.updateNotNull(mCraftmould);
            if(n>0){
                json.put("num",1);
            }else {
                json.put("num",0);
            }
        }
        return  json ;
    }
}
