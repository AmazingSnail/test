package com.dhchain.business.HeatTreatment.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.HeatTreatment.service.PMissionIssuedService;
import com.dhchain.business.HeatTreatment.vo.MPtheatplan;
import com.dhchain.business.HeatTreatment.vo.MPtheatprint;
import com.dhchain.business.HeatTreatment.vo.MPtheattake;
import com.dhchain.business.partpunchingworkshop.vo.ColdDailyPlan;
import com.dhchain.business.partpunchingworkshop.vo.PTFinish;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ASUS on 2018/7/5.
 */
@Controller
@RequestMapping(value = "/PMissionIssued")
public class PMissionIssuedController {
    @Autowired
    private PMissionIssuedService pMissionIssuedService;
    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET, RequestMethod.POST})
    public Map Query (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        Example example = new Example(MPtheattake.class);
        Example.Criteria criteria = example.createCriteria();
        String inputdata = request.getParameter("time");
        if (StringUtil.isNotEmpty(inputdata)) {
            String startime = inputdata + " 00:00:00";
            String endtime = inputdata + " 23:59:59";
            criteria.andGreaterThanOrEqualTo("inputdate",startime);
            criteria.andLessThanOrEqualTo("inputdate",endtime);
        }
        List<MPtheattake> list = pMissionIssuedService.selectByExample(example);
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/GetEquip",method={RequestMethod.GET, RequestMethod.POST})
    public JSON GetEquip (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray re = new JSONArray();
        String plant = request.getParameter("plant");
        MPtheattake mPtheattake = new MPtheattake();
        mPtheattake.setDepartment(plant);
        List<MPtheattake> list = pMissionIssuedService.GetEquip(mPtheattake);
        if (list.size()>0){
            for(int i = 0 ;i<list.size();i++){
                Map re1 = new HashMap();
                MPtheattake mPtheattake1 = list.get(i);
                String EquipID = mPtheattake1.getEquipid();
                re1.put("EquipID",EquipID);
                re.add(re1);
            }
        }
        return  re;
    }
    @ResponseBody
    @RequestMapping(value="/query1",method={RequestMethod.GET, RequestMethod.POST})
    public Map Query1 (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        Example example = new Example(MPtheattake.class);
        Example.Criteria criteria = example.createCriteria();
        String uyear = request.getParameter("uyear");
        String umouth = request.getParameter("umouth");
        String plant = request.getParameter("plant");
        String Status = request.getParameter("Status");
        String EquipID = request.getParameter("EquipID");
        String fno = request.getParameter("fno");
        String fname = request.getParameter("fname");
        if (StringUtil.isNotEmpty(uyear)) {
            criteria.andEqualTo("uyear",uyear.trim());
        }
        if (StringUtil.isNotEmpty(plant)) {
            criteria.andEqualTo("department",plant.trim());
        }
        if (StringUtil.isNotEmpty(umouth)) {
            criteria.andEqualTo("umouth",umouth.trim());
        }
        if (StringUtil.isNotEmpty(Status)) {
            criteria.andEqualTo("status",Status.trim());
        }
        if (StringUtil.isNotEmpty(EquipID)) {
            criteria.andEqualTo("equipid",EquipID.trim());
        }
        if (StringUtil.isNotEmpty(fno)) {
            criteria.andLike("fno","%" +fno.trim()+"%");
        }
        if (StringUtil.isNotEmpty(fname)) {
            criteria.andLike("fname","%" +fname.trim()+"%");
        }
        List<MPtheattake> list = pMissionIssuedService.selectByExample(example);
        List<MPtheattake> list2 = new ArrayList<>();
        DecimalFormat   fnum  =   new  DecimalFormat("##0.00");
        if(list.size()>0){
            for(MPtheattake i  : list){
                String PlanID = i.getPlanid();
                String plant1 = i.getDepartment();
                Float s = i.getProductnum();
                MPtheatprint mPtheatprint =  new MPtheatprint();
                mPtheatprint.setPlanid(PlanID);
                mPtheatprint.setPlant(plant1);
                List<MPtheatprint> list1 = pMissionIssuedService.getPrint(mPtheatprint);
                Float sum = 0f;
                if(list1.size()>0){
                    for(int j =0;j<list1.size();j++){
                        MPtheatprint mPtheatprint1 ;
                        mPtheatprint1 = list1.get(j);
                        Float a  = mPtheatprint1.getWeightnum();
                        sum = a + sum;
                    }
                }
                Float progress = (sum/s *100);
                i.setProgress(fnum.format(progress));
                list2.add(i);
            }

            json.put("rows",list2);
            json.put("total",list.size());
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/insertTake",method={RequestMethod.GET, RequestMethod.POST})
    public Map Insert (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json =new HashMap();
        String  fno = request.getParameter("fno");
        String  equipid = request.getParameter("equipid");
        String [] v = equipid.split("-");
        String equipid1 = v[0];
        String  productman = request.getParameter("productman");
        String  productnum = request.getParameter("productnum");
        String  fname = request.getParameter("fname");
        String  plant = request.getParameter("plant");
        String  department = request.getParameter("department");
        String  inputdate = request.getParameter("inputdate");
        String  beginman = request.getParameter("beginman");
        String  uyear = request.getParameter("uyear");
        String  umonth = request.getParameter("umonth");
        String  WorkCentre = request.getParameter("WorkCentre");
        String  Material = request.getParameter("Material");
        String  ProcessNode = request.getParameter("ProcessNode");
        MPtheattake mPtheattake1 =  new MPtheattake();
        mPtheattake1.setUyear(uyear);
        mPtheattake1.setUmouth(umonth);
        mPtheattake1.setDepartment(plant);
        String planid;
        String id;
        String a;
        String b;
        int  id1;
        String month;
        List<MPtheattake> list = pMissionIssuedService.getPlanid(mPtheattake1);
        if(list.size()>0){
            MPtheattake mPtheattake2 = list.get(0);
            id = mPtheattake2.getPlanid();//C318030002
            id1 = Integer.parseInt(id.substring(6,10));
            a = id.substring(0,6);
            id1 = id1 +1;
            b =   String.format("%04d",id1);
            planid = a + b;
        }else {
            int month1 = Integer.parseInt(umonth);
            month =   String.format("%02d",month1);
            planid = "C4"+uyear.substring(2,4)+month+"0001";
        }
        MPtheattake mPtheattake =  new MPtheattake();
        mPtheattake.setFno(fno);
        mPtheattake.setFname(fname);
        mPtheattake.setPlant(department);
        mPtheattake.setDepartment(plant);
        mPtheattake.setEquipid(equipid1);
        mPtheattake.setStatus("SC01");
        mPtheattake.setProductman(productman);
        mPtheattake.setProductnum(Float.parseFloat(productnum));
        mPtheattake.setInputman(beginman);
        mPtheattake.setInputdate(inputdate);
        mPtheattake.setUyear(uyear);
        mPtheattake.setUmouth(umonth);
        mPtheattake.setWorkcentre(WorkCentre);
        mPtheattake.setMaterial(Material);
        mPtheattake.setProcessnode(ProcessNode);
        mPtheattake.setPlanid(planid);
        int n = pMissionIssuedService.InsertUseGeneratedKeysMapper(mPtheattake);
        if(n>0){
            json.put("num",n);
        }else {
            json.put("num",-1);
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/deleteTake",method={RequestMethod.GET, RequestMethod.POST})
    public Map DeleteTake (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String id = request.getParameter("id");
        int n = pMissionIssuedService.deleteByPrimaryKey(Integer.parseInt(id));
        if(n>0){
            json.put("num",n);
        }else {
            json.put("num",-1);
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/jilian",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject jilian (HttpServletRequest request) throws UnsupportedEncodingException {
        JSONArray jslst = new JSONArray();
        JSONObject re = new JSONObject();
        request.setCharacterEncoding("utf-8");
        String planID = request.getParameter("planID");
        String plant = request.getParameter("plant");
        MPtheatprint mPtheatprint =  new MPtheatprint();
        mPtheatprint.setPlanid(planID);
        mPtheatprint.setPlant(plant);
        List<MPtheatprint> list = pMissionIssuedService.getPrint(mPtheatprint);
        Float sum = 0f;
        if(list.size()>0){
            for(int i =0;i<list.size();i++){
                MPtheatprint mPtheatprint1 ;
                mPtheatprint1 = list.get(i);
                Float a  = mPtheatprint1.getWeightnum();
                sum = a + sum;
            }
        }
        Map r = new HashMap();
        r.put("planid","合计");
        r.put("weightnum",sum);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(r);
        re.put("rows",list);
        re.put("total",list.size());
        re.put("footer",jslst2);
        return  re;
    }
}
