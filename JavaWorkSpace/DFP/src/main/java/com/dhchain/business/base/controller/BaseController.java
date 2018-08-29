package com.dhchain.business.base.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.base.service.BaseService;
import com.dhchain.business.base.vo.Base;
import com.dhchain.config.vo.ExcelUtil;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by zhenglb on 2017-10-06.
 */
@Controller
@RequestMapping("/base")
public class BaseController extends com.dhchain.config.base.BaseController {
    @Autowired
    private BaseService baseService;
    @ResponseBody
    @RequestMapping(value = "Query", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject select(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String baseno = request.getParameter("baseno");
        String basename =  request.getParameter("basename");
        Base base = new Base();
        base.setBaseno(baseno);
        base.setBasename(basename);
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Base> jslist =  baseService.query(base);

        JSONArray jslst = new JSONArray();
        Base base1;
        if(jslist.size()>1) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                base1 = jslist.get(i);
                String rebaseids = base1.getRebaseids();
                String rebaseitems = base1.getRebaseitems();
                String renaseidstr = "";
                String rebaseitemstr = "";
                if(rebaseids!=null&&!rebaseids.equals("")){
                    String[] rebaseidArr = rebaseids.split(",");
                    for (String rebaseid : rebaseidArr ){
                        renaseidstr+=baseService.selectById(Integer.parseInt(rebaseid)).getBasename()+";";
                    }
                    renaseidstr = renaseidstr.substring(0,renaseidstr.length()-1);
                }

                if(rebaseitems!=null&&!rebaseitems.equals("")){
                    String[] rebaseitemsArr = rebaseitems.split(",");
                    for (String rebaseitemsid : rebaseitemsArr ){
                        rebaseitemstr+=baseService.selectById(Integer.parseInt(rebaseitemsid)).getBasename()+";";
                    }
                    rebaseitemstr = rebaseitemstr.substring(0,rebaseitemstr.length()-1);
                }
                re1.put("id",base1.getId());
                re1.put("basename",base1.getBasename());
                re1.put("baseno",base1.getBaseno());
                re1.put("rebase",renaseidstr);
                re1.put("rebaseitem",rebaseitemstr);
                re1.put("remark",base1.getRemark());
                re1.put("iscode",base1.getIscode()==0?"是":"否");
                re1.put("fid",base1.getFid());
                re1.put("islocked",base1.getIslocked()==0?"否":"是");
                re1.put("inputman",base1.getInputman());
                re1.put("inputdate",base1.getInputdate()==null?"":sdf.format(base1.getInputdate()));
                re1.put("modifyman",base1.getModifyman());
                re1.put("modifydate",base1.getModifydate()==null?"":sdf.format(base1.getModifydate()));
                if(base1.getFid()!=0) {
                    re1.put("_parentId", base1.getFid());
                }
                jslst.add(re1);
            }
            re.put("rows",jslst);
            re.put("total",jslst.size());
        }else if(jslist.size()==0){
            re.put("rows",jslst);
            re.put("total",0);
        }else{
            base1 = jslist.get(0);
            String flag = base1.getFlag();
            List<Base> jslist2 = baseService.selectByFlag(flag);
            Base base2;
            if(jslist2.size()>0) {
                for (int i=0;i<jslist2.size();i++){
                    JSONObject re1 = new JSONObject();
                    base2 = jslist2.get(i);
                    re1.put("id",base2.getId());
                    re1.put("basename",base2.getBasename());
                    re1.put("baseno",base2.getBaseno());
                    String rebaseids = base2.getRebaseids();
                    String rebaseitems = base2.getRebaseitems();
                    String renaseidstr = "";
                    String rebaseitemstr = "";
                    if(rebaseids!=null&&!rebaseids.equals("")){
                        String[] rebaseidArr = rebaseids.split(",");
                        for (String rebaseid : rebaseidArr ){
                            renaseidstr+=baseService.selectById(Integer.parseInt(rebaseid)).getBasename()+";";
                        }
                        renaseidstr = renaseidstr.substring(0,renaseidstr.length()-1);
                    }

                    if(rebaseitems!=null&&!rebaseitems.equals("")){
                        String[] rebaseitemsArr = rebaseitems.split(",");
                        for (String rebaseitemsid : rebaseitemsArr ){
                            rebaseitemstr+=baseService.selectById(Integer.parseInt(rebaseitemsid)).getBasename()+";";
                        }
                        rebaseitemstr = rebaseitemstr.substring(0,rebaseitemstr.length()-1);
                    }
                    re1.put("remark",base2.getRemark());
                    re1.put("iscode",base2.getIscode()==0?"否":"是");
                    re1.put("fid",base2.getFid());
                    re1.put("islocked",base2.getIslocked()==0?"否":"是");
                    re1.put("inputman",base2.getInputman());
                    re1.put("inputdate",base2.getInputdate()==null?"":sdf.format(base2.getInputdate()));
                    re1.put("modifyman",base2.getModifyman());
                    re1.put("modifydate",base2.getModifydate()==null?"":sdf.format(base2.getModifydate()));
                    re1.put("rebase",renaseidstr);
                    re1.put("rebaseitem",rebaseitemstr);
                    if(base2.getId()!=base1.getId()) {

                        re1.put("_parentId", base2.getFid());
                    }
                    jslst.add(re1);
                }
                re.put("rows",jslst);
                re.put("total",jslst.size());
            }
        }

        return re;
    }

    @ResponseBody
    @RequestMapping(value = "selectDatabse", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject selectDatabse(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String baseno = request.getParameter("baseno");
        String basename = request.getParameter("basename");
        Base base = new Base();

        JSONArray jslst = new JSONArray();
        Base base1;base.setBaseno(baseno);
        base.setBasename(basename);
        JSONObject re = new JSONObject();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Base> jslist =  baseService.selectDatabse(base);

        if(jslist.size()>0 ){
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                base1 = jslist.get(i);
                re1.put("id",base1.getId());
                re1.put("basename",base1.getBasename());
                re1.put("baseno",base1.getBaseno());
                re1.put("remark",base1.getRemark());
                re1.put("iscode",base1.getIscode()==0?"是":"否");
                re1.put("fid",base1.getFid()==0?"否":"是");
                re1.put("islocked",base1.getIslocked()==0?"否":"是");
                re1.put("inputman",base1.getInputman());
                re1.put("inputdate",base1.getInputdate()==null?"":sdf.format(base1.getInputdate()));
                re1.put("modifyman",base1.getModifyman());
                re1.put("modifydate",base1.getModifydate()==null?"":sdf.format(base1.getModifydate()));
                if(base1.getFid()!=0) {
                    re1.put("_parentId", base1.getFid());
                }
                jslst.add(re1);
            }
            re.put("rows",jslst);
            re.put("total",jslst.size());
        }
        return re;
    }

    @ResponseBody
    @RequestMapping(value = "selectsxgl", method = {RequestMethod.GET, RequestMethod.POST})
    public JSON selectsxgl(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Base base = baseService.selectSXGL();
        List<Base> jslist = baseService.selectSXGLList(base.getId());
        JSONArray jslst = new JSONArray();

        Base base1;
        JSONObject re2 = new JSONObject();
        re2.put("typeid","");
        re2.put("typename","请选择主数据类型");
        jslst.add(re2);
        if(jslist.size()>0) {

            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                base1 = (Base)jslist.get(i);
                re1.put("baseid",base1.getId());
                re1.put("basename",base1.getBasename());

                jslst.add(re1);
            }
        }

        return jslst;
    }

    /**
     * 资源管理列表
     *
     * @return
     */
    @PostMapping("/select")
    @ResponseBody
    public Object treeGrid(HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String baseno = request.getParameter("baseno");
        String basename = request.getParameter("basename");
        Base base = new Base();
        base.setBaseno(baseno);
        base.setBasename(basename);
        return baseService.query(base);
    }

    /**
     * 查询所有的菜单
     */
    @RequestMapping("/allTree")
    @ResponseBody
    public Object allMenu() {
        return baseService.selectAllMenu();
    }

    @RequestMapping("/add")
    @ResponseBody
    public Object add(@Valid Base base) {
        base.setInputdate(new Date());
        base.setIsdelete(0);
        Base parent = null;

        boolean flag = baseService.insert(base);

        if(flag){
            int i = baseService.selectNewId();
            Base base2 = baseService.selectById(i);
            if(base2.getFid()==0){
                base2.setFlag(";"+base2.getId()+"-"+1);
                baseService.updateById(base2);
            }else {
                parent = baseService.selectById(base2.getFid());
                base2.setFlag(parent.getFlag()+"-"+base2.getId());
                baseService.updateById(base2);
            }

            return renderSuccess("添加成功！");
            
        }else{
            return renderSuccess("添加失败！");
        }

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
        boolean status = baseService.selectChild(id);
        if(status){
            return renderSuccess("有子节点无法删除，请先删除子节点！");
        }else{
            boolean flag = baseService.deleteById(id);
            if(flag){
                return renderSuccess("删除成功！");
            }else{
                return renderSuccess("删除失败！");
            }
        }


    }

    /**
     * 编辑页
     * @param id
     * @return
     */
    @PostMapping(value = "/editPage")
    @ResponseBody
    public Object editPage(int id) {
        Base base = baseService.selectById(id);
        return  base;
    }

    /**
     * 编辑
     *
     * @param base
     * @return
     */
    @RequestMapping(value = "/edit")
    @ResponseBody
    public Object edit(@Valid Base base) {

        base.setModifydate(new Date());
        Base parent = null;
        if(base.getFid()==0){
            base.setFlag(";"+base.getId()+"-"+1);
        }else {
            parent = baseService.selectById(base.getFid());
            base.setFlag(parent.getFlag()+"-"+base.getId());

        }
        boolean flag = baseService.updateById(base);
        if(flag){
            return renderSuccess("编辑成功！");
        }else{
            return renderSuccess("编辑失败！");
        }

    }
    @ResponseBody
    @RequestMapping(value = "download", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject download(HttpServletRequest request) throws UnsupportedEncodingException {
        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("Sheet0");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        HSSFCell cell = row.createCell((short) 0);
        cell.setCellValue("属性名称");
        cell.setCellStyle(style);
        cell = row.createCell((short) 1);
        cell.setCellValue("属性编码");
        cell.setCellStyle(style);
        cell = row.createCell((short) 2);
        cell.setCellValue("父属性名称");
        cell.setCellStyle(style);
        cell = row.createCell((short) 3);
        cell.setCellValue("父属性编码");
        cell.setCellStyle(style);
        cell = row.createCell((short) 4);
        cell.setCellValue("参与编码(0.是,1.否)");
        cell.setCellStyle(style);
        cell = row.createCell((short) 5);
        cell.setCellValue("层级关系(0.是,1.否)");
        cell.setCellStyle(style);
        cell = row.createCell((short) 6);
        cell.setCellValue("冻结(0.否,1.是)");
        cell.setCellStyle(style);
        cell = row.createCell((short) 7);
        cell.setCellValue("备注");
        cell.setCellStyle(style);
        // 第六步，将文件存到指定位置
        Date date = new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        String name = "D:/Downloads/基础数据创建"+sdf.format(date)+".xls";
        JSONObject re = new JSONObject();
        boolean flag = true ;
        try
        {
            FileOutputStream fout = new FileOutputStream(name);
            wb.write(fout);
            fout.close();
        }
        catch (Exception e)
        {
            flag = false;
            re.put("success",false);
            re.put("message","模板下载失败");
            e.printStackTrace();
        }
        if(flag){
            re.put("success",true);
            re.put("message","模板下载成功，位置为"+name);
        }
        return  re;
    }


    @ResponseBody
    @RequestMapping(value="/import",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject impotr(HttpServletRequest request, @RequestParam(value = "baseuploadExcel", required = false) MultipartFile file) throws Exception {
        MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
        String inputman = request.getParameter("inputman");
        MultipartFile file1 = multipart.getFile("baseuploadExcel");
        InputStream in = file1.getInputStream();
        List<List<Object>> listob = ExcelUtil.getBankListByExcel(in,file1.getOriginalFilename());
        JSONObject check = impotrcheck(listob);
        boolean flag = (boolean) check.get("success");
        if(!flag){
            return check;
        }else{
            for (int i = 0; i < listob.size(); i++) {
                List<Object> ob = listob.get(i);
                String basename = (String) ob.get(0);
                String baseno = (String) ob.get(1);
                String fbasename = (String) ob.get(2);
                String fbaseno = (String) ob.get(3);
                String iscode = (String) ob.get(4);
                String isrelate = (String) ob.get(5);
                String islocked = (String) ob.get(6);
                String remark = (String) ob.get(7);
                Base fbase = new Base();
                fbase.setBasename(fbasename);
                fbase.setBaseno(fbaseno);
                List<Base> fbases = baseService.query(fbase);
                int fid = fbases.get(0).getId();
                Date date = new Date();
                Base base = new Base();
                base.setBaseno(baseno);
                base.setBasename(basename);
                base.setFid(fid);
                base.setIscode(Integer.parseInt(iscode));
                base.setIsrelate(Integer.parseInt(isrelate));
                base.setIslocked(Integer.parseInt(islocked));
                base.setRemark(remark);
                base.setInputdate(date);
                base.setInputman(inputman);
                baseService.insert(base);
                int newid = baseService.selectNewId();
                Base newBase = baseService.selectById(newid);
                String flag2 = fbases.get(0).getFlag()+"-"+newid;
                newBase.setFlag(flag2);
                baseService.updateById(newBase);
            }
            JSONObject re = new JSONObject();
            re.put("total",listob.size());
            re.put("success",true);
            re.put("message","导入成功");
            return  re;
        }
    }

    public JSONObject impotrcheck(List<List<Object>> listob)throws Exception{
        JSONObject re = new JSONObject();
        JSONArray jslst = new JSONArray();
        if(listob==null||listob.size()==0){
            JSONObject re1 = new JSONObject();
            re1.put("itemno","");
            re1.put("reason","文件为空");
            jslst.add(re1);
            re.put("rows",jslst);
        }else {

            for (int i = 1; i < listob.size(); i++) {
                int j = i+1;
                List<Object> ob = listob.get(i);
                String basename = (String) ob.get(0);
                String baseno = (String) ob.get(1);
                String fbasename = (String) ob.get(2);
                String fbaseno = (String) ob.get(3);
                String iscode = (String) ob.get(4);
                String isrelate = (String) ob.get(5);
                String isdelete = (String) ob.get(6);
                String remark = (String) ob.get(7);
                if(basename.equals("")||baseno.equals("")||((!iscode.equals("1"))&&(!iscode.equals("0")))||((!isrelate.equals("1"))&&(!isrelate.equals("0")))||((!isdelete.equals("1"))&&(!isdelete.equals("0")))){
                    JSONObject re1 = new JSONObject();
                    re1.put("itemno",j);
                    re1.put("reason","信息未填完整");
                    jslst.add(re1);
                }else{
                    if((!fbasename.equals(""))&&(!fbaseno.equals(""))){
                        Base base = new Base();
                        base.setBasename(fbasename);
                        base.setBaseno(fbaseno);
                        List<Base> bases = baseService.query(base);
                        if(bases==null||bases.size()==0){
                            JSONObject re1 = new JSONObject();
                            re1.put("itemno",j);
                            re1.put("reason","父级不存在");
                            jslst.add(re1);

                        }

                    }

                }
            }

        }
        if(jslst.size()>0){
            JSONObject re1 = new JSONObject();
            re1.put("rows",jslst);
            re1.put("total",jslst.size());
            re.put("success",false);
            re.put("grid",re1);


        }else{
            re.put("success",true);
        }
        return  re;
    }
    /**
     * 查询所有的资源tree
     */
    @RequestMapping("/allTrees")
    @ResponseBody
    public Object allTree() {
        return baseService.selectAllTree();
    }

    /**
     * 授权页面页面根据角色查询资源
     *
     * @param id
     * @return
     */
    @RequestMapping("/findRebasesById")
    @ResponseBody
    public Object findRebasesById(int id) {
        String rebases = baseService.selectRebasesById(id);
        String[] rebaseidsStr = rebases.split(",");
        List<Long> rebaseids = new ArrayList<Long>();
        for (String re:rebaseidsStr){
            rebaseids.add(Long.parseLong(re));
        }
        return renderSuccess(rebaseids);
    }
}
