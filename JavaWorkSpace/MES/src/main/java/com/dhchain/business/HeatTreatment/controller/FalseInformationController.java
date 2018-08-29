package com.dhchain.business.HeatTreatment.controller;

import com.dhchain.business.HeatTreatment.service.FalseInformationService;
import com.dhchain.business.HeatTreatment.vo.MCraftfault;
import com.dhchain.business.HeatTreatment.vo.MPtheatplan;
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
 * Created by ASUS on 2018/7/6.
 */
@Controller
@RequestMapping(value = "/FalseInformation")
public class FalseInformationController {
    @Autowired
    private FalseInformationService falseInformationService;
    @ResponseBody
    @RequestMapping(value="/query",method={RequestMethod.GET, RequestMethod.POST})
    public Map Query (HttpServletRequest request) throws UnsupportedEncodingException {
        Map json = new HashMap();
        request.setCharacterEncoding("utf-8");
        String plant = request.getParameter("plant");
        String equipid = request.getParameter("equipid");
        String type = request.getParameter("type");
        String starttime = request.getParameter("starttime");
        String endtime = request.getParameter("endtime");
        Example example = new Example(MCraftfault.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(starttime)&&StringUtil.isNotEmpty(endtime)) {
            String startime1 = starttime + " 00:00:00";
            String endtime1 = endtime + " 23:59:59";
            criteria.andGreaterThanOrEqualTo("begintime",startime1);
            criteria.andLessThanOrEqualTo("begintime",endtime1);
        }
        if (StringUtil.isNotEmpty(equipid)) {
            criteria.andEqualTo("equipid",equipid.trim());
        }
        if (StringUtil.isNotEmpty(type)) {
            criteria.andEqualTo("faulttypes",type.trim());
        }
        if (StringUtil.isNotEmpty(plant)) {
            criteria.andEqualTo("plant",plant.trim());
        }
        List<MCraftfault> list = falseInformationService.selectByExample(example);
        if(list.size()>0){
            json.put("rows",list);
            json.put("total",list.size());
        }
        return  json;
    }
}
