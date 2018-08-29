package com.dhchain.system.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.system.entity.OutputValue;
import com.dhchain.system.entity.ZWQ;
import com.dhchain.system.service.OutputValueService;
import com.dhchain.system.service.ZWQService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangq on 2018/5/24.
 */

@Controller
@RequestMapping("/ZWQ")
public class ZWQController {
    @Autowired
    private ZWQService zWQService;
    @ResponseBody
    @RequestMapping(value = "/test")
    public JSONObject getOutputValue(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String year = "2018";
        String monat = "06";
        String nwx = "3";
        JSONObject re = new JSONObject();
        List<ZWQ> jslist = new ArrayList<ZWQ>();
        jslist =  zWQService.getZWQValue(year,monat,nwx);
        return null;
    }
}
