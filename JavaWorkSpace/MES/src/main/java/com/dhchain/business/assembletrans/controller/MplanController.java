package com.dhchain.business.assembletrans.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.assembletrans.service.MplanService;
import com.dhchain.business.assembletrans.vo.Mplan;
import com.dhchain.business.assembletrans.vo.PlanDuty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by tongc on 2017-7-20.
 */
@Controller
@RequestMapping("/Mplan")
public class MplanController {
    @Autowired
    private MplanService mplanService;

    @ResponseBody
    @RequestMapping(value="/getman",method={RequestMethod.GET,RequestMethod.POST})
    public JSON GetMan(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String user=  request.getParameter("user");
        String plant=  request.getParameter("plant");
        PlanDuty planDuty1 = new PlanDuty();
        planDuty1.setWorklead(user);
        planDuty1.setPlant(plant);
        List<PlanDuty> jslist = mplanService.getman(planDuty1);
        JSONArray jslst = new JSONArray();
        if(jslist.size()>0) {
            for (int i = 0; i < jslist.size(); i++) {
                Map re = new HashMap();
                PlanDuty planDuty ;
                planDuty = jslist.get(i);
                String takeman = planDuty.getWorker();
                re.put("takeman",takeman);
                jslst.add(re);
            }
        }
        return  jslst;
    }

    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
    public Map query1(HttpServletRequest request) throws UnsupportedEncodingException {
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
        if(request.getParameter("IsCl")!=null&&!"".equals(request.getParameter("IsCl").trim())){
            mplan.setIsCl(request.getParameter("IsCl"));
        }
        List jslist = mplanService.queryAsList(mplan);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        Mplan Rmplan;
        int n= 0;
        float allCLNumber = 0;
        float allConnectPlan = 0;
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {

                Map re = new HashMap();
                Rmplan = (Mplan) jslist.get(i);
                int id = Rmplan.getId();
                String dhorderno = Rmplan.getDhorderno();
                String PartDrawing = Rmplan.getPartDrawing();
                int F3 = Rmplan.getF3();
                String Descrip = Rmplan.getDescrip();
                String SendMouth = Rmplan.getSendMouth();
                String OrderLine = Rmplan.getOrderLine();
                String IsCl = Rmplan.getIsCl();
                String SAPSDOrder = Rmplan.getSAPSDOrder();
                String TakeOrder = Rmplan.getTakeOrder();
                String CompleteOrder = Rmplan.getCompleteOrder();
                String OrderTime="";
                if (Rmplan.getOrderTime()!=null&&!"".equals(Rmplan.getOrderTime().trim())){
                    OrderTime = Rmplan.getOrderTime().substring(0,10);
                }
                String Color = Rmplan.getColor();
                float CLNumber = Rmplan.getCLNumber();
                float ConnectPlan = Rmplan.getConnectPlan();
                float DayNum = Rmplan.getDayNum();
                float SumDayNum = Rmplan.getSumDayNum();
                float beginConnect = Rmplan.getBeginConnect();
                float number = Rmplan.getNumber();
                float DayInput = Rmplan.getDayInput();
                float SumDayInput = Rmplan.getSumDayInput();
                String ismix = Rmplan.getIsmix();
                String ischeck = Rmplan.getIscheck();
                String MillionF3 = Rmplan.getMillionF3();
                String nwx = Rmplan.getNwx();
                String WorkPart = Rmplan.getWorkPart();
                String MillionWight = Rmplan.getMillionWight();
                String fno = Rmplan.getFno();
                String fname = Rmplan.getFname();
                String meins = Rmplan.getMeins();
                String Dutyman = Rmplan.getDutyman();
                String MaterialDutyman = Rmplan.getMaterialDutyman();
                String plant = Rmplan.getPlant();
                String submitstate = Rmplan.getSubmitstate();
                String singleWeightOK = Rmplan.getSingleWeightOK();
                String period = Rmplan.getPeriod();
                String MachineKind = Rmplan.getMachineKind();
                String uyear = Rmplan.getUyear();
                String umouth = Rmplan.getUmouth();
                String OutputValue = Rmplan.getOutputValue();
                String Ftemp10 = Rmplan.getFtemp10();
                String GCXH = Rmplan.getGCXH();
                String ConnectValue = Rmplan.getConnectValue();
                String DayNumValue = Rmplan.getDayNumValue();
                String NumberValue = Rmplan.getNumberValue();
                String DayInputValue = Rmplan.getDayInputValue();
                String PoNo = Rmplan.getPoNo();
                String PoItem = Rmplan.getPoItem();
                if (("1".equals(selectState))||("2".equals(selectState)&&(CLNumber != ConnectPlan))||("3".equals(selectState)&&(SumDayNum != ConnectPlan))
                        ||("4".equals(selectState)&&(SumDayInput != number)))
                {
                    allCLNumber += CLNumber;
                    allConnectPlan += ConnectPlan;
                    re.put("id", id);
                        re.put("dhorderno", dhorderno);
                        re.put("PartDrawing", PartDrawing);
                        re.put("F3", F3);
                        re.put("Descrip", Descrip);
                        re.put("SendMouth", SendMouth);
                        re.put("OrderLine", OrderLine);
                        re.put("SAPSDOrder", SAPSDOrder);
                        re.put("TakeOrder", TakeOrder);
                        re.put("CompleteOrder", CompleteOrder);
                        re.put("IsCl", IsCl);
                        re.put("OrderTime", OrderTime);
                        re.put("Color", Color);
                        re.put("CLNumber", CLNumber);
                        re.put("ConnectPlan", ConnectPlan);
                        re.put("DayNum", DayNum);
                        re.put("SumDayNum", SumDayNum);
                        re.put("beginConnect", beginConnect);
                        re.put("number", number);
                        re.put("DayInput", DayInput);
                        re.put("SumDayInput", SumDayInput);
                        re.put("ismix", ismix);
                        re.put("ischeck", ischeck);
                        re.put("MillionF3", MillionF3);
                        re.put("nwx", nwx);
                        re.put("WorkPart", WorkPart);
                        re.put("MillionWight", MillionWight);
                        re.put("fno", fno);
                        re.put("fname", fname);
                        re.put("meins", meins);
                        re.put("Dutyman", Dutyman);
                        re.put("MaterialDutyman", MaterialDutyman);
                        re.put("plant", plant);
                        re.put("submitstate", submitstate);
                        re.put("singleWeightOK", singleWeightOK);
                        re.put("period", period);
                        re.put("MachineKind", MachineKind);
                        re.put("uyear", uyear);
                        re.put("umouth", umouth);
                        re.put("OutputValue", OutputValue);
                        re.put("Ftemp10", Ftemp10);
                        re.put("GCXH", GCXH);
                        re.put("ConnectValue", ConnectValue);
                        re.put("DayNumValue", DayNumValue);
                        re.put("NumberValue", NumberValue);
                        re.put("DayInputValue", DayInputValue);
                        re.put("PoNo", PoNo);
                        re.put("PoItem", PoItem);
                    jslst.add(re);
                    n=n+1;
                }
            }
        }
        Map r = new HashMap();
        r.put("PartDrawing","合计");
        r.put("CLNumber",allCLNumber);
        r.put("ConnectPlan",allConnectPlan);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(r);
        json.put("rows",jslst);
        json.put("total", n);
        json.put("footer",jslst2);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/updatekczt",method={RequestMethod.GET,RequestMethod.POST})
    public Map update(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String  id   = request.getParameter("id");
        String OrderLine   = request.getParameter("OrderLine");
        String CLNumber = request.getParameter("CLNumber");
        Mplan mplan = new Mplan();
        if (id !=null){
            mplan.setId(Integer.parseInt(id));
        }
        mplan.setCLNumber(Float.parseFloat(CLNumber));
        mplan.setOrderLine(OrderLine);
        int n = mplanService.update(mplan);
        Map json = new HashMap();
        json.put("num",n);

        return json;
    }

    @ResponseBody
    @RequestMapping(value="/updatekcth",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateth(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String  id   = request.getParameter("id");
        String CLNumber = request.getParameter("CLNumber");
        Mplan mplan = new Mplan();
        if (id !=null){
            mplan.setId(Integer.parseInt(id));
        }
        mplan.setCLNumber(Float.parseFloat(CLNumber));
        int n = mplanService.updateth(mplan);
        Map json = new HashMap();
        json.put("num",n);

        return json;
    }

    @ResponseBody
    @RequestMapping(value="/updatecz",method={RequestMethod.GET,RequestMethod.POST})
    public Map updatecz(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String  id   = request.getParameter("id");
        String SumDayNum = request.getParameter("SumDayNum");
        String num = request.getParameter("num");
        String orderline = request.getParameter("orderline");
        String fno = request.getParameter("fno");
        String plant = request.getParameter("plant");
        String uyear = request.getParameter("uyear");
        String umouth = request.getParameter("umouth");
        Mplan mplan = new Mplan();

        if (id !=null){
            mplan.setId(Integer.parseInt(id));
        }
        mplan.setSumDayNum(Float.parseFloat(SumDayNum));
        mplan.setOrderLine(orderline);
        mplan.setFno(fno);
        mplan.setPlant(plant);
        mplan.setUyear(uyear);//获取当前年月
        mplan.setUmouth(umouth);
        int n = 0;
        if(num.equals("1")){
            n= mplanService.updatecz(mplan);
        }else{
            n = mplanService.updateczqx(mplan);
        }

        Map json = new HashMap();
        json.put("num",n);

        return json;
    }
    @ResponseBody
    @RequestMapping(value="/canupdatecz",method={RequestMethod.GET,RequestMethod.POST})
    public Map canupdatecz(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        int  id   = 0;
        Float DayNum = Float.parseFloat(request.getParameter("SumDayNum"));
        Mplan mplan = new Mplan();

        if (request.getParameter("id") !=null){
            id = Integer.parseInt(request.getParameter("id"));
        }
        mplan = mplanService.selectByPrimaryKey(id);
        Float SumDayNum = mplan.getSumDayNum();
        Float ConnectPlan = mplan.getConnectPlan();
        int n = 0;
        if(SumDayNum+DayNum > ConnectPlan){
            n=0;
        }else{
            n=1;
        }

        Map json = new HashMap();
        json.put("num",n);

        return json;
    }
    @ResponseBody
    @RequestMapping(value="/updateruku",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateruku(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String  id   = request.getParameter("id");
        String SumDayInput = request.getParameter("SumDayInput");
        String num = request.getParameter("num");
        String orderline = request.getParameter("orderline");
        String fno = request.getParameter("fno");
        String plant = request.getParameter("plant");
        String uyear = request.getParameter("uyear");
        String umouth = request.getParameter("umouth");
        Mplan mplan = new Mplan();
        Mplan Rmplan ;
        Date date=new Date();
        DateFormat format=new SimpleDateFormat("yyyy-MM-dd");
        String time=format.format(date);

        if (id !=null){
            mplan.setId(Integer.parseInt(id));
        }
        mplan.setSumDayInput(Float.parseFloat(SumDayInput));
        mplan.setOrderLine(orderline);
        mplan.setFno(fno);
        mplan.setPlant(plant);
        mplan.setUyear(uyear);
        mplan.setUmouth(umouth);
        int n = 0;
        if(num.equals("1")){
            n= mplanService.updateruku(mplan);
        }else if(num.equals("2")){
            n = mplanService.updaterukuqx(mplan);
        }else if(num.equals("3")){
            mplan.setCompleteOrder(time);
            List jslist = mplanService.queryNum(mplan);
            if(jslist.size()>0){
                Rmplan = (Mplan) jslist.get(0);
                if(Rmplan.getSumDayNum() >= Rmplan.getNumber()){

                    n=mplanService.updatetime(mplan);
                }
            }
        }else{
            mplan.setCompleteOrder("");
            n=mplanService.updatetime(mplan);
        }

        Map json = new HashMap();
        json.put("num",n);

        return json;
    }

    @ResponseBody
    @RequestMapping(value="/updateCZRK",method={RequestMethod.GET,RequestMethod.POST})
    public Map updateCZRK(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String  vid   = request.getParameter("id");
        int id=0;
        if (vid !=null){
            id = Integer.parseInt(vid);
        }


        double FormInputnumN = Double.parseDouble(request.getParameter("FormInputnumN"));
        double OldInputnum = Double.parseDouble(request.getParameter("OldInputnum"));
        double changenum = FormInputnumN-OldInputnum;

        int n = mplanService.updateCZRK(id,changenum);
        Map json = new HashMap();
        json.put("num",n);

        return json;
    }
}
