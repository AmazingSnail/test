package com.dhchain.business.HeatTreatment.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.HeatTreatment.service.*;
import com.dhchain.business.HeatTreatment.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ASUS on 2018/7/5.
 */
@Controller
@RequestMapping("/ProductionDetail")
public class ProductionDetailController {
    @Autowired
    private ProductionDetailService productionDetailService;
    @Autowired
    private MChkresultATService mChkresultATService;
    @Autowired
    private MChkresulthmService mChkresulthmService;
    @Autowired
    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET, RequestMethod.POST})
    public Map Query (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        request.setCharacterEncoding("utf-8");
        String fname = request.getParameter("fname");
        String fno = request.getParameter("fno");
        String equid = request.getParameter("equid");
        String SCPC = request.getParameter("SCPC");
        String starttime = request.getParameter("starttime");
        String endtime = request.getParameter("endtime");
        String plant = request.getParameter("plant");
        Example example = new Example(MPtheatfinish.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(starttime)&&StringUtil.isNotEmpty(endtime)) {
            String startime1 = starttime + " 00:00:00";
            String endtime1 = endtime + " 23:59:59";
            criteria.andGreaterThanOrEqualTo("begintime",startime1);
            criteria.andLessThanOrEqualTo("begintime",endtime1);
        }
        if (StringUtil.isNotEmpty(fno)) {
            criteria.andLike("fno","%" +fno.trim()+"%");
        }
        if (StringUtil.isNotEmpty(SCPC)) {
            criteria.andLike("batchnum","%" +SCPC.trim()+"%");
        }
        if (StringUtil.isNotEmpty(fname)) {
            criteria.andLike("fname","%" +fname.trim()+"%");
        }
        if (StringUtil.isNotEmpty(equid)) {
            criteria.andEqualTo("equipid",equid.trim());
        }
        if (StringUtil.isNotEmpty(plant)) {
            criteria.andEqualTo("plant",plant.trim());
        }
        List<MPtheatfinish> list = productionDetailService.selectByExample(example);
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/getequid",method={RequestMethod.GET, RequestMethod.POST})
    public JSON GetEquid (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        JSONArray jslist = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        MPtheatfinish mPtheatfinish = new MPtheatfinish();
        mPtheatfinish.setPlant(plant);
        List<MPtheatfinish> list = productionDetailService.getEquid(mPtheatfinish);
        if(list.size()>0){
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                MPtheatfinish mPtheatfinish1;
                mPtheatfinish1 = list.get(i);
                String equid = mPtheatfinish1.getEquipid();
                re.put("equid",equid);
                jslist.add(re);
            }
        }
        return  jslist;
    }
    @ResponseBody
    @RequestMapping(value="/Type",method={RequestMethod.GET, RequestMethod.POST})
    public JSON Type (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        JSONArray jslist = new JSONArray();
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        MCraftfault mCraftfault = new MCraftfault();
        mCraftfault.setPlant(plant);
        List<MCraftfault> list = productionDetailService.getType(mCraftfault);
        if(list.size()>0){
            for (int i = 0; i < list.size(); i++) {
                Map re = new HashMap();
                 MCraftfault mCraftfault1 =  list.get(i);
                String type = mCraftfault1.getFaulttypes();
                re.put("type",type);
                jslist.add(re);
            }
        }
        return  jslist;
    }
    @ResponseBody
    @RequestMapping(value="/jilian",method={RequestMethod.GET, RequestMethod.POST})
    public Map Jilian (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        request.setCharacterEncoding("utf-8");
        String equipid = request.getParameter("equipid");
        String plant = request.getParameter("plant");
        String begintime = request.getParameter("begintime");
        String endtime = request.getParameter("endtime");
        Example example = new Example(MChkresultat.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(begintime)&&StringUtil.isNotEmpty(endtime)) {
            String startime1 = begintime;
            String endtime1 = endtime ;
            criteria.andGreaterThanOrEqualTo("recordtime",startime1);
            criteria.andLessThanOrEqualTo("recordtime",endtime1);
        }
        if (StringUtil.isNotEmpty(equipid)) {
            criteria.andEqualTo("equipid",equipid.trim());
        }
        if (StringUtil.isNotEmpty(plant)) {
            criteria.andEqualTo("plant",plant.trim());
        }
        List<MChkresultat> list = mChkresultATService.selectByExample(example);
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
    @ResponseBody
    @RequestMapping(value="/jilianHM",method={RequestMethod.GET, RequestMethod.POST})
    public Map JilianHM (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        request.setCharacterEncoding("utf-8");
        String equipid = request.getParameter("equipid");
        String plant = request.getParameter("plant");
        String prodnum = request.getParameter("prodnum");
        Example example = new Example(MChkresulthm.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(prodnum)) {
            criteria.andEqualTo("prodnum",prodnum.trim());
        }
        if (StringUtil.isNotEmpty(equipid)) {
            criteria.andEqualTo("equipid",equipid.trim());
        }
        if (StringUtil.isNotEmpty(plant)) {
            criteria.andEqualTo("plant",plant.trim());
        }
        List<MChkresulthm> list = mChkresulthmService.selectByExample(example);
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
}
