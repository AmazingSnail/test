package com.dhchain.business.colddigitalworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhchain.business.colddigitalworkshop.service.SplitMaintenanceService;
import com.dhchain.business.colddigitalworkshop.vo.Smaintenance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/SplitMaintenance")
public class SplitMaintenanceController {
    @Autowired
    private SplitMaintenanceService splitMaintenanceService;
    @ResponseBody
    @RequestMapping(value = "/selectSmaintebabce", method = {RequestMethod.GET, RequestMethod.POST})
    public Map selectSmaintebabce(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Smaintenance smaintenance = new Smaintenance();
        String fno = request.getParameter("fno");
        String name = request.getParameter("name");
        smaintenance.setFno(fno);
        smaintenance.setName(name);
        List<Smaintenance> list = splitMaintenanceService.selectByAll(smaintenance);
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
    @RequestMapping(value="/selectSplitMaoLiao",method={RequestMethod.GET,RequestMethod.POST})
    public JSON selectSplitMaoLiao(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        List<Smaintenance> jslist = splitMaintenanceService.selectSplitMaoLiaoFno();
        Map json = new HashMap();
        JSONArray jslst = new JSONArray();
        Smaintenance smaintenance;
        //System.out.println(plant);
        if(jslist.size()>0){
            for(int i = 0;i<jslist.size();i++) {

                Map re = new HashMap();
                smaintenance =  jslist.get(i);
                String Fname = smaintenance.getName();
                String Fno = smaintenance.getFno();

                re.put("fno", Fno);
                re.put("fname", Fname);
                jslst.add(re);

            }
        }
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value = "/insertChild", method = {RequestMethod.GET, RequestMethod.POST})
    public Map insertChild(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Smaintenance smaintenance = new Smaintenance();
        String fno = request.getParameter("fno");
        String name = request.getParameter("name");
        String matec = request.getParameter("matec");
        String fnoname = request.getParameter("fnoname");
        String fparentid = null;
        smaintenance.setFno(fno);
        smaintenance.setFnoname(fnoname);
        if (request.getParameter("fparentid")!=null){
            smaintenance.setFparentid(request.getParameter("fparentid"));
        }else{
            smaintenance.setFparentid(fparentid);
        }
        smaintenance.setMatec(matec);
        smaintenance.setName(name);
        List<Smaintenance> list = splitMaintenanceService.selectChildIsHave(smaintenance);
        int n = 0;
        if (list.size()>0){
            n = 0;
        }else{
            n = splitMaintenanceService.insertSelective(smaintenance);
        }
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteChild", method = {RequestMethod.GET, RequestMethod.POST})
    public Map deleteChild(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Integer id = 0;
        if(request.getParameter("id")!=null){
            id = Integer.parseInt(request.getParameter("id"));
        }
        int n =splitMaintenanceService.deleteByPrimaryKey(id);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteParent", method = {RequestMethod.GET, RequestMethod.POST})
    public Map deleteParent(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Integer id = 0;
        if(request.getParameter("id")!=null){
            id = Integer.parseInt(request.getParameter("id"));
        }
        Map json = new HashMap();
        int n =splitMaintenanceService.deleteByFparentIdAndId(id);
        json.put("num",n);
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/insertParent", method = {RequestMethod.GET, RequestMethod.POST})
    public Map insertParent(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Smaintenance smaintenance = new Smaintenance();
        String matec = request.getParameter("matec");
        String fnoname = request.getParameter("fnoname");
        String fno = request.getParameter("fno");
        String name = request.getParameter("name");
        smaintenance.setFno(fno);
        smaintenance.setFnoname(fnoname);
        smaintenance.setMatec(matec);
        smaintenance.setName(name);
        List<Smaintenance> list = splitMaintenanceService.selectParentIsHave(smaintenance);
        int n = 0;
        if(list.size()>0){
            n=0;
        }else{
            n = splitMaintenanceService.insertSelective(smaintenance);
        }
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/update", method = {RequestMethod.GET, RequestMethod.POST})
    public Map update(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Smaintenance smaintenance = new Smaintenance();
        Integer id = Integer.parseInt(request.getParameter("id"));
        String matec = request.getParameter("matec");
        String fnoname = request.getParameter("fnoname");
        String fno = request.getParameter("fno");
        String name = request.getParameter("name");
        String fparentid = request.getParameter("fparentid");
        smaintenance.setId(id);
        smaintenance.setFno(fno);
        smaintenance.setFnoname(fnoname);
        smaintenance.setMatec(matec);
        smaintenance.setName(name);
        smaintenance.setFparentid(fparentid);
        int n = splitMaintenanceService.updateByPrimaryKeySelective(smaintenance);
        Map json = new HashMap();
        json.put("num",n);
        return json;
    }
}
