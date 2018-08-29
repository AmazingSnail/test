package com.dhchain.business.colddigitalworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.colddigitalworkshop.service.ColdRshipMaintenanceService;
import com.dhchain.business.colddigitalworkshop.vo.ColdRshipMaintenance;
import com.dhchain.business.colddigitalworkshop.vo.Smaintenance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/RshipMaintenanceController")
public class RshipMaintenanceController {
    @Autowired
    private ColdRshipMaintenanceService coldRshipMaintenanceService;
    @ResponseBody
    @RequestMapping(value = "/selectALL", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectSmaintebabce(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String reelnum = request.getParameter("reelnum");
        String freelnum = request.getParameter("freelnum");
        ColdRshipMaintenance coldRshipMaintenance = new ColdRshipMaintenance();
        coldRshipMaintenance.setReelnum(reelnum);
        coldRshipMaintenance.setFreelnum(freelnum);
        List<ColdRshipMaintenance> list = coldRshipMaintenanceService.selectALL(coldRshipMaintenance);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        Smaintenance Rsmaintenance = new Smaintenance();
        if (list.size()>0) {
            //System.out.println(list);
            json.put("rows", list);
            json.put("total", list.size());
        }
        //System.out.println(json);
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/selectbyfreelnum", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectbyfreelnum(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
//        String reelnum = request.getParameter("reelnum");
        String freelnum = request.getParameter("freelnum");
        ColdRshipMaintenance coldRshipMaintenance = new ColdRshipMaintenance();
//        coldRshipMaintenance.setReelnum(reelnum);
        coldRshipMaintenance.setFreelnum(freelnum);
        List<ColdRshipMaintenance> list = coldRshipMaintenanceService.selectALL(coldRshipMaintenance);
        JSONArray jslst = new JSONArray();
        Map json = new HashMap();
        ColdRshipMaintenance RcoldRshipMaintenance = new ColdRshipMaintenance();
        if (list.size()>0) {
            RcoldRshipMaintenance = list.get(0);
            //System.out.println(list);
            json.put("reelnum", RcoldRshipMaintenance.getReelnum());
            json.put("vbeln", RcoldRshipMaintenance.getVbeln());
            json.put("weight", RcoldRshipMaintenance.getWeight());
            json.put("specification", RcoldRshipMaintenance.getSpecification());
            json.put("materialtype", RcoldRshipMaintenance.getMaterialtype());
            json.put("steelworks", RcoldRshipMaintenance.getSteelworks());
        }
        //System.out.println(json);
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/selectALLSelect", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON selectALLSelect(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdRshipMaintenance coldRshipMaintenance = new ColdRshipMaintenance();
        List<ColdRshipMaintenance> list = coldRshipMaintenanceService.selectALL(coldRshipMaintenance);
        JSONArray jslst = new JSONArray();

        ColdRshipMaintenance RcoldRshipMaintenance = new ColdRshipMaintenance();
        if (list.size()>0) {
            for(int i = 0;i<list.size();i++) {
                //System.out.println(list);
                Map json = new HashMap();
                RcoldRshipMaintenance = list.get(i);
                String reelnum = RcoldRshipMaintenance.getReelnum();
                String freelnum = RcoldRshipMaintenance.getFreelnum();
                json.put("reelnum", reelnum);
                json.put("freelnum", freelnum);
//                System.out.println(json);
                jslst.add(json);
            }
        }
        //System.out.println(json);
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/update", method = {RequestMethod.GET, RequestMethod.POST})
    public Map update(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdRshipMaintenance coldRshipMaintenance = new ColdRshipMaintenance();
        Integer id = Integer.parseInt(request.getParameter("id"));
        String reelnum = request.getParameter("reelnum");
        String freelnum = request.getParameter("freelnum");
        String vbeln = request.getParameter("vbeln");
        Double weight =  Double.parseDouble(request.getParameter("weight"));
        String specification = request.getParameter("specification");
        String note = request.getParameter("note");
        String materialtype = request.getParameter("materialtype");
        String steelworks = request.getParameter("steelworks");
        String qualitybrand = request.getParameter("qualitybrand");
        coldRshipMaintenance.setId(id);
        coldRshipMaintenance.setReelnum(reelnum);
        coldRshipMaintenance.setFreelnum(freelnum);
        coldRshipMaintenance.setVbeln(vbeln);
        coldRshipMaintenance.setWeight(weight);
        coldRshipMaintenance.setSpecification(specification);
        coldRshipMaintenance.setNote(note);
        coldRshipMaintenance.setMaterialtype(materialtype);
        coldRshipMaintenance.setSteelworks(steelworks);
        coldRshipMaintenance.setQualitybrand(qualitybrand);
        int n = coldRshipMaintenanceService.updateByPrimaryKeySelective(coldRshipMaintenance);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/insert", method = {RequestMethod.GET, RequestMethod.POST})
    public Map insert(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ColdRshipMaintenance coldRshipMaintenance = new ColdRshipMaintenance();
//        Integer id = Integer.parseInt(request.getParameter("id"));
        String reelnum = request.getParameter("reelnum");
        Double weight =  Double.parseDouble(request.getParameter("weight"));
        String specification = request.getParameter("specification");
        String freelnum = request.getParameter("freelnum");
        String vbeln = request.getParameter("vbeln");

        String note = request.getParameter("note");
        String materialtype = request.getParameter("materialtype");
        String steelworks = request.getParameter("steelworks");
        String qualitybrand = request.getParameter("qualitybrand");
        Calendar c = Calendar.getInstance();
        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH);
//        coldRshipMaintenance.setId(id);
        coldRshipMaintenance.setReelnum(reelnum);
        coldRshipMaintenance.setFreelnum(freelnum);
        coldRshipMaintenance.setVbeln(vbeln);
        coldRshipMaintenance.setWeight(weight);
        coldRshipMaintenance.setSpecification(specification);
        coldRshipMaintenance.setNote(note);
        coldRshipMaintenance.setMaterialtype(materialtype);
        coldRshipMaintenance.setSteelworks(steelworks);
        coldRshipMaintenance.setQualitybrand(qualitybrand);
        int n = coldRshipMaintenanceService.insertSelective(coldRshipMaintenance);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value="/import",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject impotr(HttpServletRequest request, @RequestParam(value = "uploadFile", required = false) MultipartFile file) throws Exception {
        //获取上传的文件
        String User =request.getParameter("User");
        String  year  =request.getParameter("year");
        String  month=request.getParameter("month");
        String mpupinst = request.getParameter("mpupinst");
        MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
        MultipartFile file1 = multipart.getFile("uploadFile");
        InputStream in = file1.getInputStream();
        //数据导入
        String  back = coldRshipMaintenanceService.importExcelInfo(in,file,User,mpupinst,month,year);
//        in.close();
        JSONObject re = new JSONObject();
        if(back.equals("OK")){
            re.put("success","true");
            re.put("message","导入成功");
        }else
        {
            re.put("success", "false");
            re.put("message", back);
        }
        return  re;
    }
}
