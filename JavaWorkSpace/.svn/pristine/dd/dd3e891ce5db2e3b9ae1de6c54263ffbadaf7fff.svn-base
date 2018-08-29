package com.dhchain.business.colddigitalworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.colddigitalworkshop.service.ColdDailyPlanService;
import com.dhchain.business.colddigitalworkshop.service.ColdMonthPlanServivce;
import com.dhchain.business.colddigitalworkshop.service.ColdPlantLgortService;
import com.dhchain.business.colddigitalworkshop.service.MaterialtakeinService;
import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPlan;
import com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn;
import com.dhchain.business.colddigitalworkshop.vo.ColdMonthPlan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/PlanScheduling")
public class PlanSchedulingController {
    @Autowired
    private ColdMonthPlanServivce coldMonthPlanServivce;
    @Autowired
    private ColdDailyPlanService coldDailyPlanService;
    @Autowired
    private MaterialtakeinService materialtakeinService;
    @Autowired
    private ColdPlantLgortService coldPlantLgortService;
    @ResponseBody
    @RequestMapping(value = "/selectOnlyParent", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectOnlyParent(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        Integer year = 0;
        Integer month = 0;
        if(request.getParameter("year")!=null){
            year = Integer.parseInt(request.getParameter("year"));
        }
        if(request.getParameter("month")!=null){
            month = Integer.parseInt(request.getParameter("month"));
        }
        ColdMonthPlan coldMonthPlan = new ColdMonthPlan();
        coldMonthPlan.setFno(fno);
        coldMonthPlan.setFname(fname);
        coldMonthPlan.setYear(year);
        coldMonthPlan.setMonth(month);
        List<ColdMonthPlan> list = coldMonthPlanServivce.selectOnlyParent(coldMonthPlan);
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        List<ColdMonthPlan> list2 = new ArrayList<>();
        Map json = new HashMap();
//        if(list.size()>0){
//            for (int i =0 ;i<list.size();i++){
//
//                ColdMonthPlan coldMonthPlan1 = new ColdMonthPlan();
//                coldMonthPlan1 = list.get(i);
//               Double progress1 = coldMonthPlan1.getTakeweidgt()/coldMonthPlan1.getPlanweidgt()*100;
//                DecimalFormat decimalFormat = new DecimalFormat(".#");
//               Double progress=Double.parseDouble(decimalFormat.format(progress1)) ;
//               coldMonthPlan1.setProgress(progress.toString());
//               list2.add(coldMonthPlan1);
//
//            }
//            json.put("rows", list2);
//            json.put("total", list2.size());
//        }
        if (list.size() > 0) {
            for (int i =0 ;i<list.size();i++){
                JSONObject re1 = new JSONObject();
                ColdMonthPlan coldMonthPlan1 = new ColdMonthPlan();
                coldMonthPlan1 = list.get(i);
                Double progress1 = coldMonthPlan1.getTakeweidgt()/coldMonthPlan1.getPlanweidgt()*100;
                DecimalFormat decimalFormat = new DecimalFormat(".#");
                Double progress2=Double.parseDouble(decimalFormat.format(progress1)) ;
                Double progress;
                if(progress2>100){
                    progress = 100.0;
                }else{
                    progress = progress2;
                }
                int id = coldMonthPlan1.getId();
                String zfno = coldMonthPlan1.getFno();
                String zfname = coldMonthPlan1.getFname();
                Double takeweidgt = coldMonthPlan1.getTakeweidgt();
                Double planweidgt = coldMonthPlan1.getPlanweidgt();
                String planman = coldMonthPlan1.getPlanman();
                String plandate = coldMonthPlan1.getPlandate();
                String zyear = coldMonthPlan1.getYear().toString();
                String zmonth = coldMonthPlan1.getMonth().toString();
                String zplant = coldMonthPlan1.getPlant();
                String fparentid = coldMonthPlan1.getFparentid();
                String isdelete = coldMonthPlan1.getIsdelete().toString();
                re1.put("id",id);
                re1.put("fno",zfno);
                re1.put("progress",progress);
                re1.put("fname",zfname);
                re1.put("takeweidgt",takeweidgt);
                re1.put("planweidgt",planweidgt);
                re1.put("planman",planman);
                re1.put("plandate",plandate);
                re1.put("year",zyear);
                re1.put("month",zmonth);
                re1.put("plant",zplant);
                re1.put("fparentid",fparentid);
                re1.put("isdelete",isdelete);
                jslst.add(re1);


            }
            re.put("rows", jslst);
            re.put("total", jslst.size());
        }
        return re;
        //return json;
    }

    @ResponseBody
    @RequestMapping(value = "/selectOnlyOneParentAndChilds", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectOnlyOneParentAndChilds(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Integer id = Integer.parseInt(request.getParameter("id"));
        Integer year = Integer.parseInt(request.getParameter("year"));
        Integer month = Integer.parseInt(request.getParameter("month"));
        ColdMonthPlan coldMonthPlan = new ColdMonthPlan();
        coldMonthPlan.setId(id);
        coldMonthPlan.setYear(year);
        coldMonthPlan.setMonth(month);
        List<ColdMonthPlan> list = coldMonthPlanServivce.selectByAllKey(coldMonthPlan);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        if (list.size() > 0) {
            //System.out.println(list);
            json.put("rows", list);
            json.put("total", list.size());
        }
        //System.out.println(json);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/selectOnlyChilds", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectOnlyChilds(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Integer id = Integer.parseInt(request.getParameter("id"));
        Integer year = Integer.parseInt(request.getParameter("year"));
        Integer month =  Integer.parseInt(request.getParameter("month"));
        ColdMonthPlan coldMonthPlan = new ColdMonthPlan();
        coldMonthPlan.setId(id);
        coldMonthPlan.setYear(year);
        coldMonthPlan.setMonth(month);
        List<ColdMonthPlan> list = coldMonthPlanServivce.selectOnlyChilds(coldMonthPlan);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        if (list.size() > 0) {
            //System.out.println(list);
            json.put("rows", list);
            json.put("total", list.size());
        }
        //System.out.println(json);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/insertFrom", method = {RequestMethod.GET, RequestMethod.POST})
    public Map insertFrom(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String params ="";
        int OkNum = 0;
        int NoNum = 0;
        String entities = request.getParameter("entities");
        entities = entities.replace("}{", "},{");
        entities = "[" + entities.toString() + "]";//table表数据
        JSONArray jsonArray = JSONArray.parseArray(entities);//放入到数组
        String User = request.getParameter("username");
        String fnofather = request.getParameter("fnofather");
        String fnamefather = request.getParameter("fnamefather");
        String yearfather = request.getParameter("yearfather");
        String monthfather = request.getParameter("monthfather");
        String plantfather = request.getParameter("plantfather");
        String planstartdate = request.getParameter("planstartdate");
        String fid = request.getParameter("fid");
        String reelnum = request.getParameter("reelnum");
        String fparentlocation =request.getParameter("fparentlocation");
        Date now = new Date();
        ColdMaterialIn coldMaterialInY = new ColdMaterialIn();
        coldMaterialInY.setBatchno(reelnum);
        String materialtype = "";
        String steelworks = "";
        List<ColdMaterialIn> listY = materialtakeinService.selectcoldMsgByBatchno(coldMaterialInY);
        if(listY.size()>0){
            materialtype = listY.get(0).getMaterialtype();
            steelworks = listY.get(0).getSteelworks();
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = dateFormat.format( now );
        Calendar nowdate = Calendar.getInstance();
        int month = (nowdate.get(Calendar.MONTH) + 1);
        int year = nowdate.get(Calendar.YEAR);
        System.out.println("paramsNum:"+params+"paramsFromNum"+jsonArray);
        Map json = new HashMap();
        //System.out.println(json);
        ColdMonthPlan coldMonthPlanFather = new ColdMonthPlan();
        coldMonthPlanFather.setYear(Integer.parseInt(yearfather));
        coldMonthPlanFather.setMonth(Integer.parseInt(monthfather));
        coldMonthPlanFather.setFno(fnofather);
        coldMonthPlanFather.setPlant(plantfather);
        coldMonthPlanFather.setFparentid("");
//        coldMonthPlanFather.setTakenum(1d);

//        if (fathernum>0){
            for (int i=0;i<jsonArray.size();i++){//循环得出表记录
                ColdDailyPlan coldDailyPlan = new ColdDailyPlan();
                JSONObject row =  jsonArray.getJSONObject(i);
                String fno = row.getString("fno");
                String fname = row.getString("fname");
                String plannum = row.getString("plannum");
                Integer takenum = Integer.parseInt(row.getString("takenum"));
                String fnoname = row.getString("fnoname");
                for (int n = 0;n<takenum;n++){//排产条数
                    coldDailyPlan.setFno(fno);
                    coldDailyPlan.setFname(fname);
                    coldDailyPlan.setTakeman(User);
                    coldDailyPlan.setFnofather(fnofather);
                    coldDailyPlan.setFnamefather(fnamefather);
                    coldDailyPlan.setTakedate(date);
                    coldDailyPlan.setYear(year);
                    coldDailyPlan.setMonth(month);
                    coldDailyPlan.setPlant(plantfather);
                    coldDailyPlan.setFid(fid);
                    coldDailyPlan.setFparentlocaton(fparentlocation);
                    coldDailyPlan.setPlanstartdate(planstartdate);
                    coldDailyPlan.setReelnum(reelnum);
                    coldDailyPlan.setMaterialtype(materialtype);
                    coldDailyPlan.setSteelworks(steelworks);
                    coldDailyPlan.setFnoname(fnoname);
                    List<ColdDailyPlan> list = coldDailyPlanService.getSeId(coldDailyPlan);
                    ColdDailyPlan RcoldDailyPlan = new ColdDailyPlan();
                    if(list.size()>0) {
                        RcoldDailyPlan = (ColdDailyPlan)list.get(0);
                        int Serialno = Integer.parseInt(RcoldDailyPlan.getSerialno())+1;
                        coldDailyPlan.setSerialno(Serialno+"");
                    }else{
                        String Serialno = month+"00001";
                        coldDailyPlan.setSerialno(Serialno);
                    }
                    List<ColdDailyPlan> listFid = coldDailyPlanService.getSelectFId(coldDailyPlan);
                    ColdDailyPlan FidcoldDailyPlan = new ColdDailyPlan();
                    if (listFid.size()>0){
                        FidcoldDailyPlan = listFid.get(0);
                        int fparentidandnum = FidcoldDailyPlan.getFparentidandnum();
                        coldDailyPlan.setFparentidandnum(fparentidandnum);
                    }else{
                        int fparentidandnum = 1;
                        coldDailyPlan.setFparentidandnum(fparentidandnum);
                    }
                    int num = coldDailyPlanService.insertSelective(coldDailyPlan);//插入记录

                    if(num>0){//修改详细信息的数据
                        OkNum++;
                        ColdMonthPlan coldMonthPlanChild = new ColdMonthPlan();
                        coldMonthPlanChild.setFno(fno);
                        coldMonthPlanChild.setPlant(plantfather);
//                        coldMonthPlanChild.setTakenum(1d);
                        coldMonthPlanChild.setYear(Integer.parseInt(yearfather));
                        coldMonthPlanChild.setMonth(Integer.parseInt(monthfather));
                        coldMonthPlanChild.setFparentid(fnofather);
//                        int updatenum = coldMonthPlanServivce.updateMonthPlanTakenumGo(coldMonthPlanChild);
                    }else{
                        NoNum++;
                    }
                }
            }
            if (OkNum>0){//开卡成功，表示原材料已使用，状态修改（reelnum）；
                ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
                coldMaterialIn.setBatchno(reelnum);//reelnum炉批号
                Double takeNumber = materialtakeinService.selectColdmaterlinInNumber(coldMaterialIn);
                int UsedNum = materialtakeinService.updateUsed(coldMaterialIn);
                coldMonthPlanFather.setTakeweidgt(takeNumber);
                int fathernum = coldMonthPlanServivce.updateMonthPlanTakenumGo(coldMonthPlanFather);
                System.out.println(takeNumber);
            }
//        }else{
//            NoNum = jsonArray.size();
//        }

        json.put("isOk",OkNum);
        json.put("isNo",NoNum);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/selectDailyPlan", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectDailyPlan(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String date = dateFormat.format( now );
        ColdDailyPlan coldDailyPlan = new ColdDailyPlan();
        coldDailyPlan.setTakedate(date);
        List<ColdDailyPlan> list = coldDailyPlanService.selectDailyPlanToday(coldDailyPlan);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        if (list.size() > 0) {
            //System.out.println(list);
            json.put("rows", list);
            json.put("total", list.size());
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/selectDailyPlanReport", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectDailyPlanReport(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String reelnums = request.getParameter("reelnums");
        String type = request.getParameter("type");
        ColdDailyPlan coldDailyPlan = new ColdDailyPlan();
        coldDailyPlan.setStarttime(startTime);
        coldDailyPlan.setEndtime(endTime);
        coldDailyPlan.setReelnum(reelnums);
        List<ColdDailyPlan> list = new ArrayList<>();
        if("3".equals(type)){
            list = coldDailyPlanService.selectDailyPlanReportByStart(coldDailyPlan);
        }else{
            list = coldDailyPlanService.selectDailyPlanReportByTake(coldDailyPlan);
        }
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        if (list.size() > 0) {
            //System.out.println(list);
            json.put("rows", list);
            json.put("total", list.size());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteDailyPlan", method = {RequestMethod.GET, RequestMethod.POST})
    public Map deleteDailyPlan(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id2 = request.getParameter("id");
        String [] id1 = id2.split(",");
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        for(int i = 0;i<id1.length;i++){
            String id = id1[i];
            int ids = Integer.parseInt(id);
            ColdDailyPlan coldDailyPlan =  new ColdDailyPlan();
            coldDailyPlan.setId(Integer.parseInt(id));
            List<ColdDailyPlan> list1 = coldDailyPlanService.selectColdDailyPlanByid(coldDailyPlan);
            if(list1.size()>0){
                ColdDailyPlan coldDailyPlan1;
                coldDailyPlan1 = list1.get(0);
                String plant = coldDailyPlan1.getPlant();
                String fno = coldDailyPlan1.getFno();
                String fnofather = coldDailyPlan1.getFnofather();
                String year = coldDailyPlan1.getYear().toString();
                String month = coldDailyPlan1.getMonth().toString();
                String fid = coldDailyPlan1.getFid();
                String fparentidandnum = coldDailyPlan1.getFparentidandnum().toString();
                String reelnum = coldDailyPlan1.getReelnum();
                int num = coldDailyPlanService.deleteByPrimaryKey(ids);
                ColdDailyPlan fcoldMonthPlan = new ColdDailyPlan();
                fcoldMonthPlan.setReelnum(reelnum);
                List<ColdDailyPlan> list = coldDailyPlanService.selectColdDailyPlanByFid(fcoldMonthPlan);
                ColdMonthPlan coldMonthPlan =new ColdMonthPlan();
                if (num>0){
                    coldMonthPlan.setFno(fno);
                    coldMonthPlan.setFparentid(fnofather);
                    coldMonthPlan.setPlant(plant);
                    coldMonthPlan.setYear(Integer.parseInt(year));
                    coldMonthPlan.setMonth(Integer.parseInt(month));
//            coldMonthPlan.setTakenum(1d);
//            int numpplan = coldMonthPlanServivce.updateMonthPlanTakenumBack(coldMonthPlan);
                    ColdMonthPlan coldMonthPlanFather = new ColdMonthPlan();
                    if (list.size()==0){
                        coldMonthPlanFather.setFno(fnofather);
                        coldMonthPlanFather.setFparentid("");
                        coldMonthPlanFather.setPlant(plant);
                        coldMonthPlanFather.setYear(Integer.parseInt(year));
                        coldMonthPlanFather.setMonth(Integer.parseInt(month));
//                coldMonthPlanFather.setTakenum(1d);
                        ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
                        coldMaterialIn.setBatchno(reelnum);
                        coldMaterialIn.setUsed(false);
                        Double takeNumber = materialtakeinService.selectColdmaterlinInNumber(coldMaterialIn);
                        int numupdate = materialtakeinService.updateUsedforDailyplanBack(coldMaterialIn);
                        coldMonthPlanFather.setTakeweidgt(takeNumber);
                        coldMonthPlanFather.setFparentid("");
                        int numpplanfather = coldMonthPlanServivce.updateMonthPlanTakenumBack(coldMonthPlanFather);
                    }
                }
                json.put("num", num);
            }

        }


        return json;
    }
    @ResponseBody
    @RequestMapping(value="/selectcoldCutByReelnum",method={RequestMethod.GET,RequestMethod.POST})
    public Map selectcoldCutByReelnum(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
        String reelnum1 = request.getParameter("reelnum");
        String [] str = reelnum1.split(",");
        String reelnum = str[0];
        coldMaterialIn.setBatchno(reelnum);
        List<ColdMaterialIn> n = materialtakeinService.selectcoldCutByReelnum(coldMaterialIn);
        Map json = new HashMap();
        json.put("num",n.size());
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/selectmaoliaoLocation",method={RequestMethod.GET,RequestMethod.POST})
    public JSON selectmaoliaoLocation(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
        String fno = request.getParameter("fno");
        coldMaterialIn.setFno(fno);
        List<ColdMaterialIn> jslist = materialtakeinService.selectcoldmaoliaolocation(coldMaterialIn);
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        ColdMaterialIn RcoldMaterialIn;
        //System.out.println(plant);
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {

                Map re = new HashMap();
                RcoldMaterialIn =  jslist.get(i);
                String location = RcoldMaterialIn.getLocation();
                String batchno = RcoldMaterialIn.getBatchno();
                re.put("location", location);
                re.put("batchno", batchno);
                jslst.add(re);

            }
        }
        return jslst;
    }

}
