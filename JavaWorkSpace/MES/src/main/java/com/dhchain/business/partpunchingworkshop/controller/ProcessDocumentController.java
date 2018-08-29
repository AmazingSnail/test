package com.dhchain.business.partpunchingworkshop.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.partpunchingworkshop.service.ProcessDocumentService;
import com.dhchain.business.partpunchingworkshop.vo.CraftFile;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import org.apache.velocity.texen.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/ProcessDocument")
public class ProcessDocumentController {
    @Autowired
   private ProcessDocumentService processDocumentService;
    @ResponseBody
    @RequestMapping(value="/Query",method={RequestMethod.GET,RequestMethod.POST})
    public Map query (HttpServletRequest request) throws UnsupportedEncodingException {
        String PartDrawing = request.getParameter("PartDrawing");
        String PartName = request.getParameter("PartName");
        String CraftFileName = request.getParameter("CraftFileName");
        CraftFile  craftFile = new CraftFile();
        craftFile.setPartName(PartName);
        craftFile.setPartDrawing(PartDrawing);
        craftFile.setCraftFileName(CraftFileName);
        List<CraftFile>  list=   processDocumentService.selectAll(craftFile);
        Map json = new HashMap();
        List<CraftFile> list1 =  new ArrayList<>();
       if(list.size()>0){
           for(int i = 0 ;i<list.size();i++){
               CraftFile craftFile1 ;
               craftFile1 = list.get(i);
               String  filename = craftFile1.getCraftFileName();
               String [] name = filename.split(".pdf");
               String name1 = name[0];
               craftFile1.setCraftFileName(name1);
               list1.add(craftFile1);
           }
           json.put("rows",list1);
           json.put("total",list1.size());
       }
        return  json;

    }

    @ResponseBody
    @RequestMapping(value = "/upload",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject upload(HttpServletRequest request, @RequestParam(value = "uploadFile", required = false) MultipartFile file) throws Exception {
        JSONObject re = new JSONObject();
        try {
              String time = request.getParameter("time");
            String man = request.getParameter("name");
            String id = request.getParameter("id");
            String PartDrawing = request.getParameter("PartDrawing");
            String PartName = request.getParameter("PartName");
            String AddFileName =request.getParameter("AddFileName");
            String name[]= AddFileName.split("\\\\");
            AddFileName = name[2];
            MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
            MultipartFile file1 = multipart.getFile("uploadFile");
            InputStream in = file1.getInputStream();
            byte[] AddFile = this.inputStreamToByte(in);
            CraftFile craftFile = new CraftFile();
//            String extensionName = file.getOriginalFilename()
//                    .substring(file.getOriginalFilename().lastIndexOf("."));
//            BufferedReader bufferedReader;
//            String read;
//            // 初始化变量str用""
//            String str = "";
//            bufferedReader = new BufferedReader(new InputStreamReader(file.getInputStream()));
//            while ((read = bufferedReader.readLine()) != null) {
//                str += read;
//            }
            craftFile.setCraftFile(AddFile);
            craftFile.setCraftFileName(AddFileName);
            craftFile.setPartDrawing(PartDrawing);
            craftFile.setPartName(PartName);
            if(!"".toString().equals(id)){
                craftFile.setModifyMan(man);
                craftFile.setModifyTime(time);
                craftFile.setId(Integer.parseInt(id));
            }else {
                craftFile.setInputMan(man);
                craftFile.setInputTime(time);
            }

            //解析Excel，导入MySQL
            int  back = 1;
            if(!"".toString().equals(id)){
                back =   processDocumentService.updatefile(craftFile);//导入标志
                //  int  back=1;
            }else {
                back =   processDocumentService.insertfile(craftFile);//导入标志
                //  int  back=1;
            }

            int a = craftFile.getId();
            if(back>0){
                re.put("id",a);
                re.put("success","true");
                re.put("message","上传成功");
            }else
            {
                re.put("success", "false");
                re.put("message", "上传失败");
            }


        } catch (IOException e) {
            e.printStackTrace();
        }
        return re;
    }
    private byte[] inputStreamToByte(InputStream is) throws IOException {
        ByteArrayOutputStream bAOutputStream = new ByteArrayOutputStream();
        int ch;
        while((ch = is.read() ) != -1){
            bAOutputStream.write(ch);
        }
        byte data [] =bAOutputStream.toByteArray();
        bAOutputStream.close();
        return data;
    }

    @ResponseBody
    @RequestMapping(value = "/search",method={RequestMethod.GET,RequestMethod.POST})
    public Map Search (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        CraftFile craftFile = new CraftFile();
        craftFile.setId(Integer.parseInt(id));
        List<CraftFile> list=   processDocumentService.selectid(craftFile);//返回文件名
        JSONObject re = new JSONObject();
        if(list.size()>0){
            CraftFile craftFile1;
            craftFile1 = list.get(0);
            String craftFileName = craftFile1.getCraftFileName();
            re.put("craftFileName",craftFileName);
            re.put("num",list.size());
        }
        else {
            re.put("num",-1);
        }
        return re;
    }

    @ResponseBody
    @RequestMapping(value = "/Deleteid",method = {RequestMethod.GET,RequestMethod.POST})
    public  Map Deleteid (HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Map json = new HashMap();
        String id = request.getParameter("id");
        CraftFile craftFile = new CraftFile();
        craftFile.setId(Integer.parseInt(id));
       int n =   processDocumentService.deleteid(craftFile);//返回文件名
        if(n>0){
            json.put("num",n);
        }else {
            json.put("num",-1);
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/looking",method = {RequestMethod.GET,RequestMethod.POST})
    public  Map Looking (HttpServletRequest request, HttpServletResponse response)throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        JSONObject re = new JSONObject();
        String id = request.getParameter("id");
        CraftFile craftFile = new CraftFile();
        craftFile.setId(Integer.parseInt(id));
        List<CraftFile> rs =   processDocumentService.selectid(craftFile);//查看文件
        byte[] aa =null;
        String filename="";
        if(rs.size()>0){
            for(int i=0;i<rs.size();i++){
               CraftFile craftFile1 = (CraftFile) rs.get(0);
                aa = craftFile1.getCraftFile();
                filename = craftFile1.getCraftFileName();
            }
        }
        if(filename.equals("0")||rs.size()==0){
            HttpSession session = request.getSession();
            //将数据存储到session中
            session.setAttribute("file", "NO");
            re.put("OK","NO");
            return null;
        }
//        try {
//            File file = new File("D://MDM_WEB/src/main/webapp/static/AddFile/"+filename);
//            FileOutputStream fout = null;
//            re.put("OK","D://MDM_WEB/src/main/webapp/static/AddFile/"+filename);
//            fout = new FileOutputStream(file);
//            fout.write(aa);
//            fout.close();
//        }
//        catch (IOException ex) {
//            ex.printStackTrace();
//        }
        response.reset(); //清除buffer缓存
        Map<String,Object> map=new HashMap<String,Object>();
        // 指定下载的文件名
        String fileName="";
        try {
            fileName = URLEncoder.encode(filename, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+"");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        OutputStream output;
        try {
//            FileOutputStream fout = null;
//            re.put("OK","D://MDM_WEB/src/main/webapp/static/AddFile/"+filename);
//            fout = new FileOutputStream(file);
//            fout.write(aa);
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            bufferedOutPut.write(aa);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return re;

    }

    }
