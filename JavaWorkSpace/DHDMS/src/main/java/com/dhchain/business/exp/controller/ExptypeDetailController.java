package com.dhchain.business.exp.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.base.service.BaseService;
import com.dhchain.business.base.vo.Base;
import com.dhchain.business.exp.service.ExptypeDetailService;

import com.dhchain.business.exp.vo.ExptypeDetail;
import com.dhchain.business.type.vo.Type;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2017-10-14.
 */
@Controller
@RequestMapping("/exptypeDetail")
public class ExptypeDetailController extends com.dhchain.config.base.BaseController {
    @Autowired
    private ExptypeDetailService exptypeDetailService;
    @Autowired
    private BaseService baseService;
    @ResponseBody
    @RequestMapping(value = "selectByExptypeId", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectByExptypeId(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String exptypeId = request.getParameter("exptypeId");
        ExptypeDetail exptypeDetail = new ExptypeDetail();
        if(!exptypeId.equals("")){
            exptypeDetail.setExptypeid(Integer.parseInt(exptypeId));
        }
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<ExptypeDetail> jslist =  exptypeDetailService.selectByExptypeId(exptypeDetail);
        JSONArray jslst = new JSONArray();
        ExptypeDetail exptypeDetail1;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                exptypeDetail1 = (ExptypeDetail)jslist.get(i);
                re1.put("id",exptypeDetail1.getId());
                re1.put("exptypeid",exptypeDetail1.getExptypeid());
                re1.put("exptypeno",exptypeDetail1.getExptypeno());
                re1.put("exptypename",exptypeDetail1.getExptypename());
                re1.put("expattrkindid",exptypeDetail1.getExpattrkindid());
                re1.put("expattrkind",exptypeDetail1.getExpattrkind());
                re1.put("expattrele",exptypeDetail1.getExpattrele().equals("0")?"基本视图":"采购视图");
                re1.put("attrid",exptypeDetail1.getAttrid());
                re1.put("attrno",exptypeDetail1.getAttrno());
                re1.put("attrname",exptypeDetail1.getAttrname());
                re1.put("attrreid",exptypeDetail1.getAttrreid());
                re1.put("attrnore",exptypeDetail1.getAttrnore());
                re1.put("attrnamere",exptypeDetail1.getAttrnamere());
                re1.put("islocked",exptypeDetail1.getIslocked()==0?"否":"是");
                re1.put("inputman",exptypeDetail1.getInputman());
                re1.put("inputdate",exptypeDetail1.getInputdate()==null?"":sdf.format(exptypeDetail1.getInputdate()));
                re1.put("modifyman",exptypeDetail1.getModifyman());
                re1.put("modifydate",exptypeDetail1.getModifydate()==null?"":sdf.format(exptypeDetail1.getModifydate()));

                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }


    @ResponseBody
    @RequestMapping(value = "selectST", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectST(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<ExptypeDetail> jslist =  exptypeDetailService.selectST();
        JSONArray jslst = new JSONArray();
        ExptypeDetail exptypeDetail1;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                exptypeDetail1 = (ExptypeDetail)jslist.get(i);
                re1.put("id",exptypeDetail1.getId());
                re1.put("exptypeid",exptypeDetail1.getExptypeid());
                re1.put("exptypeno",exptypeDetail1.getExptypeno());
                re1.put("exptypename",exptypeDetail1.getExptypename());
                re1.put("expattrkindid",exptypeDetail1.getExpattrkindid());
                re1.put("expattrkind",exptypeDetail1.getExpattrkind());
                re1.put("expattrele",exptypeDetail1.getExpattrele().equals("0")?"基本视图":"采购视图");
                re1.put("attrid",exptypeDetail1.getAttrid());
                re1.put("attrno",exptypeDetail1.getAttrno());
                re1.put("attrname",exptypeDetail1.getAttrname());
                re1.put("attrreid",exptypeDetail1.getAttrreid());
                re1.put("attrnore",exptypeDetail1.getAttrnore());
                re1.put("attrnamere",exptypeDetail1.getAttrnamere());
                re1.put("islocked",exptypeDetail1.getIslocked()==0?"否":"是");
                re1.put("inputman",exptypeDetail1.getInputman());
                re1.put("inputdate",exptypeDetail1.getInputdate()==null?"":sdf.format(exptypeDetail1.getInputdate()));
                re1.put("modifyman",exptypeDetail1.getModifyman());
                re1.put("modifydate",exptypeDetail1.getModifydate()==null?"":sdf.format(exptypeDetail1.getModifydate()));

                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }

    @ResponseBody
    @RequestMapping(value = "selectById", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectById(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        ExptypeDetail exptypeDetail = exptypeDetailService.selectById(Integer.parseInt(id));
        JSONObject re1 = new JSONObject();
        re1.put("id",exptypeDetail.getId());
        re1.put("exptypeid",exptypeDetail.getExptypeid());
        re1.put("exptypeno",exptypeDetail.getExptypeno());
        re1.put("exptypename",exptypeDetail.getExptypename());
        re1.put("expattrkindid",exptypeDetail.getExpattrkindid());
        re1.put("expattrkind",exptypeDetail.getExpattrkind());
        re1.put("expattrele",exptypeDetail.getExpattrele());
        re1.put("attrid",exptypeDetail.getAttrid());
        re1.put("attrno",exptypeDetail.getAttrno());
        re1.put("attrname",exptypeDetail.getAttrname());
        re1.put("attrreid",exptypeDetail.getAttrreid());
        re1.put("attrnore",exptypeDetail.getAttrnore());
        re1.put("attrnamere",exptypeDetail.getAttrnamere());
        re1.put("islocked",exptypeDetail.getIslocked());
        return re1;
    }

    @RequestMapping("/add")
    @ResponseBody
    public Object add(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String exptypeid =request.getParameter("exptypeid");
        String exptypeno = request.getParameter("exptypeno");
        String exptypename = request.getParameter("exptypename");
        String attrid = request.getParameter("attrid");
        String attrno = request.getParameter("attrno");
        String attridre = request.getParameter("attridre");
        String attrnore = request.getParameter("attrnore");
        String attrname = request.getParameter("attrname");
        String attrrename = request.getParameter("attrrename");
        String islocked = request.getParameter("islocked");
        String inputman = request.getParameter("inputman");
        String expattrkindid = request.getParameter("expattrkindid");
        Base base = baseService.selectById(Integer.parseInt(expattrkindid));
        String expattrkind = base.getBasename();
        String expattrele = request.getParameter("expattrele");
        ExptypeDetail exptypeDetail = new ExptypeDetail();
        exptypeDetail.setExpattrkind(expattrkind);
        exptypeDetail.setExptypeid(Integer.parseInt(exptypeid));
        exptypeDetail.setExptypeno(exptypeno);
        exptypeDetail.setExptypename(exptypename);
        exptypeDetail.setAttrid(Integer.parseInt(attrid));
        exptypeDetail.setAttrno(attrno);
        exptypeDetail.setAttrreid(Integer.parseInt(attridre));
        exptypeDetail.setAttrnore(attrnore);
        exptypeDetail.setAttrname(attrname);
        exptypeDetail.setAttrnamere(attrrename);
        exptypeDetail.setIslocked(Integer.parseInt(islocked));
        exptypeDetail.setInputman(inputman);
        exptypeDetail.setInputdate(new Date());
        exptypeDetail.setExpattrkindid(Integer.parseInt(expattrkindid));
        exptypeDetail.setExpattrele(expattrele);
        exptypeDetail.setIsdelete(0);
        boolean flag = exptypeDetailService.insert(exptypeDetail);


        if(flag){
            return renderSuccess("添加成功！");

        }else{
            return renderSuccess("添加失败！");
        }


    }


    @RequestMapping("/edit")
    @ResponseBody
    public Object edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        ExptypeDetail exptypeDetail = exptypeDetailService.selectById(Integer.parseInt(id));
        String exptypeid =request.getParameter("exptypeid");
        String exptypeno = request.getParameter("exptypeno");
        String exptypename = request.getParameter("exptypename");
        String attrid = request.getParameter("attrid");
        String attrno = request.getParameter("attrno");
        String attridre = request.getParameter("attridre");
        String attrnore = request.getParameter("attrnore");
        String attrname = request.getParameter("attrname");
        String attrrename = request.getParameter("attrrename");
        String islocked = request.getParameter("islocked");
        String modifyman = request.getParameter("modifyman");
        String expattrkindid = request.getParameter("expattrkindid");
        Base base = baseService.selectById(Integer.parseInt(expattrkindid));
        String expattrkind = base.getBasename();
        String expattrele = request.getParameter("expattrele");
        exptypeDetail.setExpattrkind(expattrkind);
        exptypeDetail.setExptypeid(Integer.parseInt(exptypeid));
        exptypeDetail.setExptypeno(exptypeno);
        exptypeDetail.setExptypename(exptypename);
        exptypeDetail.setAttrid(Integer.parseInt(attrid));
        exptypeDetail.setAttrno(attrno);
        exptypeDetail.setAttrreid(Integer.parseInt(attridre));
        exptypeDetail.setAttrnore(attrnore);
        exptypeDetail.setAttrname(attrname);
        exptypeDetail.setAttrnamere(attrrename);
        exptypeDetail.setIslocked(Integer.parseInt(islocked));
        exptypeDetail.setModifyman(modifyman);
        exptypeDetail.setModifydate(new Date());
        exptypeDetail.setExpattrkindid(Integer.parseInt(expattrkindid));
        exptypeDetail.setExpattrele(expattrele);
        exptypeDetail.setIsdelete(0);
        boolean flag = exptypeDetailService.update(exptypeDetail);


        if(flag){
            return renderSuccess("添加成功！");

        }else{
            return renderSuccess("添加失败！");
        }


    }


    @ResponseBody
    @RequestMapping(value = "delete", method = {RequestMethod.GET, RequestMethod.POST})
    public Map delete(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String ids = request.getParameter("ids");
        String[] idArr = ids.split(",");
        int n = exptypeDetailService.delete(idArr);
        Map json = new HashMap();
        json.put("num",n);

        return json;
    }
}
