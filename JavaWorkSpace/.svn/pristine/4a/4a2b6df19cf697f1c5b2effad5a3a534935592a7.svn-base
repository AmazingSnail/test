package com.dhchain.business.type.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.code.service.CodeManageService;
import com.dhchain.business.code.vo.CodeManageType;
import com.dhchain.business.exp.service.ExptypeService;
import com.dhchain.business.exp.vo.Exptype;
import com.dhchain.business.type.service.TypeDetailService;

import com.dhchain.business.type.service.TypeKindService;
import com.dhchain.business.type.vo.TypeDetail;
import com.dhchain.business.type.vo.TypeKind;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
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
 * Created by zhenglb on 2017-09-28.
 */
@Controller
@RequestMapping("/typedetail")
public class TypeDetailController   extends com.dhchain.config.base.BaseController{
    @Autowired
    private TypeDetailService typeDetailService;
    @Autowired
    private TypeKindService typeKindService;
    @Autowired
    private CodeManageService codeManageService;
    @Autowired
    private ExptypeService exptypeService;

    @ResponseBody
    @RequestMapping(value = "Query", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typeid = request.getParameter("typeid");
        String typeno = request.getParameter("typeno");
        String typename = request.getParameter("typename");
        TypeDetail typeDetail = new TypeDetail();
        if(typeid!=null){
            typeDetail.setTypeid(Integer.parseInt(typeid));
        }

        typeDetail.setTypeno(typeno);
        typeDetail.setTypename(typename);
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<TypeDetail> jslist =  typeDetailService.query(typeDetail);
        JSONArray jslst = new JSONArray();
        TypeDetail typeDetailShow;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                typeDetailShow = jslist.get(i);
                re1.put("id",typeDetailShow.getId());
                re1.put("typeno",typeDetailShow.getTypeno());
                re1.put("typename",typeDetailShow.getTypename());
                re1.put("kindno",typeDetailShow.getKindno());
                re1.put("kindnum",typeDetailShow.getKindnum());
                re1.put("fid",typeDetailShow.getFid());
                re1.put("islocked",typeDetailShow.getIsdelete()==0?"否":"是");
                re1.put("inputman",typeDetailShow.getInputman());
                re1.put("inputdate",typeDetailShow.getInputdate()==null?"":sdf.format(typeDetailShow.getInputdate()));
                if(typeDetailShow.getFid()!=0) {
                    re1.put("_parentId", typeDetailShow.getFid());
                }
                jslst.add(re1);
            }
        }
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(int id) {
        TypeDetail typeDetail = typeDetailService.selectById(id);
        boolean status = typeDetailService.selectChild(id);
        if(status){
            return renderSuccess("有子节点无法删除，请先删除子节点！");
        }else{
            Exptype exptype = exptypeService.selectByTypedetailid(id);
            CodeManageType codeManageType = codeManageService.selectByTypeno(typeDetail.getTypeno());
            if(exptype!=null){
                return renderSuccess("已配置模板,请先删除模板！");
            }else if(codeManageType!=null){
                return renderSuccess("已配置编码规则,请先删除编码规则！");
            }else{
                boolean flag = typeDetailService.deleteById(id);
                if(flag){
                    return renderSuccess("删除成功！");
                }else{
                    return renderSuccess("删除失败！");
                }
            }

        }


    }

//    @RequestMapping("/add")
//    @ResponseBody
//    public Object add(@Valid TypeDetail typeDetail) {
//        typeDetail.setInputdate(new Date());
//        typeDetail.setIsdelete(0);
//        TypeDetail parent = null;
//        String kindno = typeDetail.getKindno();
//        TypeKind typeKind = typeKindService.selectByKindno(kindno);
//        typeDetail.setKindid(typeKind.getId());
//        typeDetail.setKindnum(typeKind.getKindnum());
//        boolean flag = typeDetailService.insert(typeDetail);
//
//        if(flag){
//            int i = typeDetailService.selectNewId();
//            TypeDetail typeDetail2 = typeDetailService.selectById(i);
//            if(typeDetail2.getFid()==0){
//                typeDetail2.setFlag(";"+typeDetail2.getId()+"-"+1);
//                typeDetailService.updateById(typeDetail2);
//            }
//            else
//            {
//                parent = typeDetailService.selectById(typeDetail2.getFid());
//                typeDetail2.setFlag(parent.getFlag()+"-"+typeDetail2.getId());
//                typeDetailService.updateById(typeDetail2);
//            }
//
//            return renderSuccess("添加成功！");
//
//        }else{
//            return renderSuccess("添加失败！");
//        }
//
//    }

    /**
     * 查询所有的菜单
     */
    @RequestMapping("/Tree")
    @ResponseBody
    public Object allMenu(HttpServletRequest request) {
        String typeid = request.getParameter("typeid");
        return typeDetailService.selectTree(Integer.parseInt(typeid));
    }


    /**
     * 编辑页
     * @param id
     * @return
     */
    @PostMapping(value = "/editPage")
    @ResponseBody
    public Object editPage(int id) {
        TypeDetail typeDetail = typeDetailService.selectById(id);
        return  typeDetail;
    }


//    /**
//     * 编辑
//     *
//     * @param typeDetail
//     * @return
//     */
//    @RequestMapping(value = "/edit")
//    @ResponseBody
//    public Object edit(@Valid TypeDetail typeDetail) {
//        boolean status = typeDetailService.selectChild(typeDetail.getId());
//        TypeDetail old = typeDetailService.selectById(typeDetail.getId());
//        String msg = "";
//        if(status&&(old.getFid()!=typeDetail.getFid())){
//
//            msg = "有子节点无法改变上级节点！";
//
//        }else{
//            typeDetail.setModifydate(new Date());
//            String kindno = typeDetail.getKindno();
//            TypeKind typeKind =  typeKindService.selectByKindno(kindno);
//            typeDetail.setKindid(typeKind.getId());
//            typeDetail.setKindnum(typeKind.getKindnum());
//            TypeDetail parent = null;
//            if(typeDetail.getFid()==0){
//                typeDetail.setFlag(";"+typeDetail.getId()+"-"+1);
//            }else {
//                parent = typeDetailService.selectById(typeDetail.getFid());
//                typeDetail.setFlag(parent.getFlag()+"-"+typeDetail.getId());
//
//            }
//            boolean flag = typeDetailService.updateById(typeDetail);
//            if(flag){
//                msg = "编辑成功！";
//
//            }else{
//                msg = "编辑失败！";
//
//            }
//        }
//        return renderSuccess(msg);
//
//
//    }


    @RequestMapping("/edit")
    @ResponseBody
    public JSONObject edit(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String msg = "";
        int num;
        TypeDetail typeDetail = typeDetailService.selectById(Integer.parseInt(id));
        boolean status = typeDetailService.selectChild(typeDetail.getId());
        String typeno = request.getParameter("typeno");
        String typename = request.getParameter("typename");
        String typeid = request.getParameter("typeid");
        String kindid = request.getParameter("kindid");
        String kindno = request.getParameter("kindno");
        String kindnum = request.getParameter("kindnum");
        String islocked = request.getParameter("islocked");
        String fid = request.getParameter("fid");
        String modifyman = request.getParameter("modifyman");
        Date date = new Date();
        if(status){
            msg = "有子节点无法修改！";
            num = 0;
        }else{
            TypeDetail parent ;
            typeDetail.setFid(Integer.parseInt(fid));
            typeDetail.setTypename(typename);
            typeDetail.setTypeno(typeno);
            typeDetail.setTypeid(Integer.parseInt(typeid));
            typeDetail.setKindid(Integer.parseInt(kindid));
            typeDetail.setModifydate(date);
            typeDetail.setModifyman(modifyman);
            typeDetail.setKindno(kindno);
            typeDetail.setKindnum(Integer.parseInt(kindnum));
            typeDetail.setIslocked(Integer.parseInt(islocked));

            if(fid.equals("0")){
                typeDetail.setFlag(";"+typeDetail.getId()+"-"+1);

            }else {
                parent = typeDetailService.selectById(Integer.parseInt(fid));
                typeDetail.setFlag(parent.getFlag()+"-"+typeDetail.getId());

            }
            boolean flag =typeDetailService.updateById(typeDetail);
            if(flag){
                msg = "编辑成功！";
                num = 1;
            }else{
                msg = "编辑失败！";
                num = 0;
            }
        }
        JSONObject re = new JSONObject();
        re.put("msg",msg);
        re.put("num",num);
        return re;
    }


    @RequestMapping("/add")
    @ResponseBody
    public JSONObject add(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String typeno = request.getParameter("typeno");
        String typename = request.getParameter("typename");
        String typeid = request.getParameter("typeid");
        String kindid = request.getParameter("kindid");
        String kindno = request.getParameter("kindno");
        String kindnum = request.getParameter("kindnum");
        String islocked = request.getParameter("islocked");
        String fid = request.getParameter("fid");
        String inputman = request.getParameter("inputman");
        Date date = new Date();
        TypeDetail typeDetail = new TypeDetail();
        TypeDetail parent ;
        JSONObject re = new JSONObject();
        typeDetail.setTypeno(typeno);
        typeDetail.setTypeid(Integer.parseInt(typeid));
        List<TypeDetail> list=typeDetailService.query(typeDetail);
        if(list!=null&&list.size()>0){
            re.put("num",0);
            re.put("message","分类代码已经存在,添加失败");
        }else{
            typeDetail.setTypename(typename);
            if(!fid.equals("")) {
                typeDetail.setFid(Integer.parseInt(fid));
            }
            else
            {
                typeDetail.setFid(0);
            }
            typeDetail.setKindid(Integer.parseInt(kindid));
            typeDetail.setInputdate(date);
            typeDetail.setInputman(inputman);
            typeDetail.setKindno(kindno);
            typeDetail.setKindnum(Integer.parseInt(kindnum));
            typeDetail.setIslocked(Integer.parseInt(islocked));
            typeDetail.setIsdelete(0);

            boolean flag = typeDetailService.insert(typeDetail);

            if(flag){
                int newid = typeDetailService.selectNewId();
                TypeDetail typeDetail1 = typeDetailService.selectById(newid);
                if(fid.equals("0")||fid.equals("")){
                    typeDetail1.setFlag(";"+typeDetail1.getId()+"-"+1);

                }else {
                    parent = typeDetailService.selectById(Integer.parseInt(fid));
                    typeDetail1.setFlag(parent.getFlag()+"-"+typeDetail1.getId());

                }
                typeDetailService.updateById(typeDetail1);

                re.put("num",1);
                re.put("message","添加成功");
            }else {
                re.put("num",0);
                re.put("message","添加失败");
            }
        }


        return re;
    }


    @ResponseBody
    @RequestMapping(value = "selectdl", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject expApplycolumndata(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
//        TypeKind typeKind = typeKindService.selectByKindno("1");
        TypeDetail typeDetail = new TypeDetail();
        List<TypeDetail> typeDetails = typeDetailService.query(typeDetail);
        JSONObject re = new JSONObject();
        JSONArray jslst = new JSONArray();
        JSONObject r = new JSONObject();
        r.put("name","");
        r.put("value","");
        jslst.add(r);
        if(typeDetails.size()>0){
            for (int i=0;i<typeDetails.size();i++){
                JSONObject re1 = new JSONObject();
                re1.put("name",typeDetails.get(i).getTypename());
                re1.put("value",typeDetails.get(i).getId());
                jslst.add(re1);
            }

        }
        re.put("rows",jslst);
        return re;
    }

    @ResponseBody
    @RequestMapping(value = "selectkindno", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectkindno(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String codemanegeid = request.getParameter("codemanegeid");
        CodeManageType codeManageType = codeManageService.selectById(Integer.parseInt(codemanegeid));
        String typeno = codeManageType.getTypeno();
        TypeDetail typeDetail = typeDetailService.selectByNo(typeno);
        String kindno = typeDetail.getKindno();
        int typeid = typeDetail.getTypeid();
        TypeKind typeKind1 = new TypeKind();
        typeKind1.setKindno(Integer.parseInt(kindno));
        typeKind1.setTypeid(typeid);
        typeKind1.setKindnum(typeDetail.getKindnum());
        TypeKind typeKind = typeKindService.selectByKindno(typeKind1);
        JSONObject re = new JSONObject();
        re.put("kindno",kindno);
        re.put("kindnum",typeKind.getKindnum());
        return re;
    }


    /**
     * 根据id查
     *
     */
    @RequestMapping("/selectById")
    @ResponseBody
    public JSONObject selectById(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        TypeDetail typeDetail =  typeDetailService.selectById(Integer.parseInt(id));
        int fid = typeDetail.getFid();
        TypeDetail father = typeDetailService.selectById(fid);
        String fatypeno;
        int fakindnum;
        if(father!=null){
            fatypeno = father.getTypeno();
            fakindnum = father.getKindnum();
        }else{
            fatypeno = "";
            fakindnum = 0;
        }

        String typeno = typeDetail.getTypeno();
        typeno = typeno.substring(fatypeno.length());
        JSONObject re = new JSONObject();
        re.put("fatypeno",fatypeno);
        re.put("fakindnum",fakindnum);
        re.put("typeno",typeno);
        re.put("typename",typeDetail.getTypename());
        re.put("fid",typeDetail.getFid());
        re.put("kindno",typeDetail.getKindno());
        re.put("kindnum",typeDetail.getKindnum());
        re.put("islocked",typeDetail.getIslocked());
        re.put("kindid",typeDetail.getKindid());
        return  re;
    }




    /**
     * 根据id查
     *

     */
    @RequestMapping("/selectFkindnum")
    @ResponseBody
    public JSONObject selectFkindnum(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        TypeDetail typeDetail =  typeDetailService.selectById(Integer.parseInt(id));
        JSONObject re = new JSONObject();

            re.put("kindnum",typeDetail.getKindnum());
            re.put("typeno",typeDetail.getTypeno());


        return  re;
    }

    /**
     * 根据id查
     *

     */
    @RequestMapping("/check")
    @ResponseBody
    public JSONObject check(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String fid = request.getParameter("fid");
        String typeno = request.getParameter("typeno");
        String typeid = request.getParameter("typeid");
        TypeDetail typeDetail = new TypeDetail();
        typeDetail.setFid(Integer.parseInt(fid));
        typeDetail.setTypeid(Integer.parseInt(typeid));
        typeDetail.setTypeno(typeno);
        List<TypeDetail> typeDetails = typeDetailService.query(typeDetail);
        JSONObject re = new JSONObject();
        if(typeDetails==null||typeDetails.size()==0){
            re.put("success",true);
        }else {
            re.put("success",false);
        }
        return  re;
    }

}
