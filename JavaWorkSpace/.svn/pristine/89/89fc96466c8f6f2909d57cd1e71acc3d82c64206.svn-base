package com.dhchain.business.TradeWMS.controller;

import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.TradeWMS.service.OutputValueService;
import com.dhchain.business.TradeWMS.vo.TOutputvalue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * Created by wangq on 2018/5/24.
 */

@Controller
@RequestMapping("/OutputValue")
public class OutputValueController {
    @Autowired
    private OutputValueService outputValueService;
    @ResponseBody
    @RequestMapping(value = "/getOutputValue")
    public List<TOutputvalue> getOutputValue(TOutputvalue OutputValue) throws UnsupportedEncodingException {
        Example example = new Example(TOutputvalue.class);
        Example.Criteria criteria = example.createCriteria();
         criteria.andLike("checkname", "%1%");


        //分页查询
        List<TOutputvalue> TPackhalfList = outputValueService.selectByExample(example);
        return null;

    }
    @ResponseBody
    @RequestMapping(value = "/getOutputValueDay")
    public JSONObject getOutputValueDay(HttpServletRequest request) throws UnsupportedEncodingException {

        return null;
    }
}
