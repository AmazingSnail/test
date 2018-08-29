package com.dhchain.business.assembleplan.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.assembleplan.download.FileUtil;
import com.dhchain.business.assembleplan.service.PlanProductService;
import com.dhchain.business.assembleplan.vo.PlanProduct;
import com.dhchain.business.assembleplan.vo.Plant;
import com.dhchain.business.assembleplan.vo.check;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.IntrospectionException;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;


/**
 * Created by xieyj on 2017-7-18.
 */
@Controller
@RequestMapping(value = "/PlanProductController")
public class PlanProductController {
    @Autowired
    private PlanProductService planproductservice;
    @ResponseBody
    @RequestMapping(value="/YDJHquery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject query(PlanProduct query, String plant, String umouth,String uyear, String DHorder, String Des, String fname,  HttpServletRequest request) throws ParseException {
        plant = request.getParameter("Plant");
       String NY = request.getParameter("NY");
       if(!NY.equals("")&&!NY.equals(null)){
           uyear =NY.split("-")[0];
           umouth=NY.split("-")[1];
       }
        DHorder = request.getParameter("DHorder");
        Des = request.getParameter("Des");
        fname = request.getParameter("fname");
//        query.setUmouth(umouth);
//        query.setUyear(uyear);
//        query.setPlant(request.getParameter("NY"));
//        query.setPlant(request.getParameter("NY"));
        //BOM导入
        int BOMDR=0;
        int MYBOM=0;
        int CPJG=0;
        int STTJ=0;
        int GYLX=0;
        List check1= planproductservice.planstate(plant,umouth,uyear,2);
        if(check1.size()>0){
            BOMDR=check1.size();
        }
        //没有BOM
        List check2= planproductservice.planstate(plant,umouth,uyear,0);
        if(check2.size()>0){
            MYBOM=check2.size();
        }
        //产品结构提交
        List check3= planproductservice.planstate(plant,umouth,uyear,3);
        if(check3.size()>0){
            CPJG=check3.size();
        }
        //视图提交
        List check4= planproductservice.planstate(plant,umouth,uyear,4);
        if(check4.size()>0){
            STTJ=check4.size();
        }
        //工艺路线提交
        List check5= planproductservice.planstate(plant,umouth,uyear,5);
        if(check5.size()>0){
            GYLX=check5.size();
        }
        List jslist =  planproductservice.getListPP(query,plant,umouth,uyear,DHorder,Des,fname);
        JSONObject re = new JSONObject();
        JSONArray jslst = new JSONArray();
        PlanProduct planProduct;
        float SDayInputValue=0;
        float SNumberValue=0;
        float SDayNumValue=0;
        float SConnectValue=0;
        SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd");
       JSONArray jslst1 = new JSONArray();
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                planProduct = (PlanProduct) jslist.get(i);
                int id =planProduct.getId();
                String CLNumber = planProduct.getCLNumber();
                String SAPSDOrder = planProduct.getSAPSDOrder();
                String Dhorderno = planProduct.getDhorderno();
                String TakeOrder = planProduct.getTakeOrder();
                String CompleteOrder = planProduct.getCompleteOrder();
                String OrderTime = time.format(time.parse(planProduct.getOrderTime()));
                String PartDrawing = planProduct.getPartDrawing();
                float F3 = planProduct.getF3();
                String Color = planProduct.getColor();
                String Descrip = planProduct.getDescrip();
                float ConnectPlan = planProduct.getConnectPlan();
                float DayInput = planProduct.getDayInput();
                String SumDayInput = planProduct.getSumDayInput();
                float beginConnect = planProduct.getBeginConnect();
                String number = planProduct.getNumber();
                String IsCheck = planProduct.getIsCheck();
                String IsCl = planProduct.getIsCl();
                String ismix = planProduct.getIsmix();
                float MillionF3 = planProduct.getMillionF3();
                String nwx = planProduct.getNwx();
                String WorkPart = planProduct.getWorkPart();
                String SendMouth = planProduct.getSendMouth();
                String MillionWight = planProduct.getMillionWight();
                String fno = planProduct.getFno();
                String Fname = planProduct.getFname();
                String meins = planProduct.getMeins();
                String OrderLine = planProduct.getOrderLine();
                String Dutyman = planProduct.getDutyman();
                String MaterialDutyman = planProduct.getMaterialDutyman();
                String Plant = planProduct.getPlant();
                int submitstate = planProduct.getSubmitstate();
                Float singleWeightOK = planProduct.getSingleWeightOK();
                int period = planProduct.getPeriod();
                String MachineKind = planProduct.getMachineKind();
                String Uyear = planProduct.getUyear();
                String Umouth = planProduct.getUmouth();
                float OutputValue = planProduct.getOutputValue();
                String Ftemp10 = planProduct.getFtemp10();
                String GCXH = planProduct.getGCXH();
                float ConnectValue = planProduct.getConnectValue();
                float DayNumValue = planProduct.getDayNumValue();
                float NumberValue = planProduct.getNumberValue();
                float DayInputValue = planProduct.getDayInputValue();
                String PoNo = planProduct.getPoNo();
                String PoItem = planProduct.getPoItem();
                float DayNum = planProduct.getDayNum();
                float SumDayNum = planProduct.getSumDayNum();
//                float inputValue = planProduct.getInputValue();
//                float sureValue = planProduct.getSureValue();
//                float takeValue = planProduct.getTakeValue();
                SDayInputValue=SDayInputValue+DayInputValue;
                SNumberValue=SNumberValue+NumberValue;
                SDayNumValue=SDayNumValue+DayNumValue;
                SConnectValue=SConnectValue+ConnectValue;
                re1.put("id",id);
                re1.put("Dhorderno",Dhorderno);
                re1.put("TakeOrder",TakeOrder);
                re1.put("CompleteOrder",CompleteOrder);
                re1.put("PartDrawing",PartDrawing);
                re1.put("F3",F3);
                re1.put("Color",Color);
                re1.put("Descrip",Descrip);
                re1.put("ConnectPlan",ConnectPlan);
                re1.put("DayInput",DayInput);
                re1.put("SumDayInput",SumDayInput);
                re1.put("beginConnect",beginConnect);
                re1.put("number",number);
                re1.put("IsCheck",IsCheck);
                re1.put("IsCl",IsCl);
                re1.put("DayNum",DayNum);
                re1.put("SumDayNum",SumDayNum);
                re1.put("Ismix",ismix);
                re1.put("MillionF3",MillionF3);
                re1.put("nwx",nwx);
                re1.put("WorkPart",WorkPart);
                re1.put("OrderTime",OrderTime);
                re1.put("SendMouth",SendMouth);
                re1.put("MillionWight",MillionWight);
                re1.put("fno",fno);
                re1.put("Fname",Fname);
                re1.put("Meins",meins);
                re1.put("OrderLine",OrderLine);
                re1.put("Dutyman",Dutyman);
                re1.put("MaterialDutyman",MaterialDutyman);
                re1.put("Plant",Plant);
                re1.put("submitstate",submitstate);
                re1.put("SingleWeightOK",singleWeightOK);
                re1.put("period",period);
                re1.put("MachineKind",MachineKind);
                re1.put("Uyear",Uyear);
                re1.put("Umouth",Umouth);
                re1.put("OutputValue",OutputValue);
                re1.put("Ftemp10",Ftemp10);
                re1.put("GCXH",GCXH);
                re1.put("ConnectValue",ConnectValue);
                re1.put("DayNumValue",DayNumValue);
                re1.put("NumberValue",NumberValue);
                re1.put("DayInputValue",DayInputValue);
                re1.put("PoNo",PoNo);
                re1.put("PoItem",PoItem);
                re1.put("SAPSDOrder",SAPSDOrder);
                re1.put("CLNumber",CLNumber);
                float kaikalv=Float.valueOf(CLNumber)/ConnectPlan*100;
                float chuanzhuanglv=SumDayNum/ConnectPlan*100;
                float rukulv=Float.parseFloat(SumDayInput)/Float.parseFloat(number)*100;
                if(Float.valueOf(CLNumber)==0){
                    kaikalv=0;
                }if(Float.valueOf(SumDayNum)==0){
                    chuanzhuanglv=0;
                }if(Float.valueOf(SumDayInput)==0){
                    rukulv=0;
                }
                re1.put("kaikalv",kaikalv);
                re1.put("chuanzhuanglv",chuanzhuanglv);
                re1.put("rukulv",rukulv);
                jslst.add(re1);
            }
        }
        Map r = new HashMap();
        r.put("OrderLine","合计");
        r.put("Dutyman",jslist.size());
        r.put("DayInputValue",SDayInputValue);
        r.put("NumberValue",SNumberValue);
        r.put("DayNumValue",SDayNumValue);
        r.put("ConnectValue",SConnectValue);
        JSONArray jslst2 = new JSONArray();
        jslst2.add(r);
        re.put("BOMDR",BOMDR);
        re.put("MYBOM",MYBOM);
        re.put("CPJG",CPJG);
        re.put("STTJ",STTJ);
        re.put("GYLX",GYLX);
        re.put("footer",jslst2);
        re.put("rows",jslst);
        re.put("total",jslst.size());
        return re;
    }
    @ResponseBody
    @RequestMapping(value="/Plantquery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONArray Plantquery(Plant query,  HttpServletRequest request){
        String plant1 = request.getParameter("Department");
        List jslist =  planproductservice.getPlant(query);
        JSONObject re = new JSONObject();
        JSONArray jslst = new JSONArray();
        Plant plant;
        if(jslist.size()>0) {
            for (int i=0;i<jslist.size();i++){
                JSONObject re1 = new JSONObject();
                plant = (Plant) jslist.get(i);
                String Fname = plant.getFname();
                String remark = plant.getFremark();
                re1.put("Fname",Fname);
                re1.put("remark",remark);
                if (plant1.equals(Fname)){
                    re1.put("selected",true);
                }
                jslst.add(re1);
            }
        }
        return jslst;
    }
    @ResponseBody
    @RequestMapping(value="/aprefrashmix",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject aprefrashmix(PlanProduct query,  HttpServletRequest request){
        JSONObject re =new JSONObject();
        String plant1 = request.getParameter("Department");
        String NY = request.getParameter("NY");
        String uyear="";
        String umouth="";
        if(!NY.equals("")&&!NY.equals(null)){
            uyear =NY.split("-")[0];
            umouth=NY.split("-")[1];
        }
        query.setPlant(plant1);
        query.setUyear(uyear);
        query.setUmouth(umouth);
        int A =  planproductservice.aprefrashmix(query);
      if(A>0){
          re.put("OK","刷新成功！");
      }else {
            re.put("OK","未刷新任何数据！");
        }
        return re;
    }
    @ResponseBody
    @RequestMapping(value="/YDJHupdata",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject YDJHupdata(PlanProduct query,HttpServletRequest request) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        JSONObject re = new JSONObject();
        String checkfno = request.getParameter("checkfno");
        int id = Integer.parseInt(request.getParameter("id"));
        String dhorderno = request.getParameter("dhorderno");
        String Dutyman = request.getParameter("Dutyman");
        String Umouth = request.getParameter("Umouth");
        String Descrip = request.getParameter("Descrip");
        String SAPSDOrder = request.getParameter("SAPSDOrder");
        String TakeOrder = request.getParameter("TakeOrder");
        String CompleteOrder = request.getParameter("CompleteOrder");
        String OrderTime = request.getParameter("OrderTime");
        String CLNumber = request.getParameter("CLNumber");
        String APuyear = request.getParameter("APuyear");
        float ConnectPlan = Float.parseFloat(request.getParameter("ConnectPlan"));
        float SumDayNum = Float.parseFloat(request.getParameter("SumDayNum"));
        float beginConnect = Float.parseFloat(request.getParameter("beginConnect"));
        String number = request.getParameter("number");
        String ischeck = request.getParameter("ischeck");
        String GCXH = request.getParameter("GCXH");
        String SumDayInput = request.getParameter("SumDayInput");
        String OrderLine = request.getParameter("OrderLine");
        String Fno = request.getParameter("Fno");
        String apMillionF3 = request.getParameter("apMillionF3");
        String apSendMouth = request.getParameter("apSendMouth");
        String Fname="";
        if (checkfno.equals("1")){
            check check = new check();
            check.setFno(Fno);
            List jslist =  planproductservice.fnocheck(check);
            com.dhchain.business.assembleplan.vo.check check1;
            if(jslist.size()>0) {
                    check1 = (com.dhchain.business.assembleplan.vo.check) jslist.get(0);
                     Fname = check1.getFname();
                     re.put("Fname",Fname);
            }else{
                re.put("Fnocheck","NO");
                re.put("num","0");
                return re;
            }
        }
        if(!Fname.equals("")&&!Fname.equals(null)){
            query.setFname(Fname);
        }
        query.setUyear(APuyear);
        query.setUmouth(Umouth);
        query.setDutyman(Dutyman);
        query.setDescrip(Descrip);
        query.setId(id);
        query.setDhorderno(dhorderno);
        query.setSAPSDOrder(SAPSDOrder);
        query.setCompleteOrder(CompleteOrder);
        query.setTakeOrder(TakeOrder);
        query.setOrderTime(OrderTime);
        query.setCLNumber(CLNumber);
        query.setConnectPlan(ConnectPlan);
        query.setSumDayNum(SumDayNum);
        query.setBeginConnect(beginConnect);
        query.setNumber(number);
        query.setIsCheck(ischeck);
        query.setGCXH(GCXH);
        query.setSumDayInput(SumDayInput);
        query.setOrderLine(OrderLine);
        query.setFno(Fno);
        query.setSendMouth(apSendMouth);
        query.setMillionF3(Float.parseFloat(apMillionF3));
        int R =  planproductservice.updataPlanProduct(query);
        re.put("num",R);
        return re;
    }
    @ResponseBody
    @RequestMapping(value="/import",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject impotr(HttpServletRequest request, @RequestParam(value = "uploadFile", required = false) MultipartFile file) throws Exception {
        //获取上传的文件
        String User =request.getParameter("User");
        String u [] =request.getParameter("umouth").split("-");
        String umouth =u[1];
        String  uyear=u[0];
        String mpupinst = request.getParameter("mpupinst");
        String plant = request.getParameter("Plant");
        MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
        MultipartFile file1 = multipart.getFile("uploadFile");
        InputStream in = file1.getInputStream();
        //数据导入
        String  back =planproductservice.importExcelInfo(in,file,plant,User,mpupinst,umouth,uyear);
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
    @ResponseBody
    @RequestMapping("/export")
    public void export(PlanProduct query,String plant, String umouth,String uyear, String DHorder, String Des, String fname,HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IntrospectionException, IllegalAccessException, ParseException, InvocationTargetException, UnsupportedEncodingException
    {
        request.setCharacterEncoding("UTF-8");
        plant = request.getParameter("Plant");
        String NY = request.getParameter("NY");
        if(!NY.equals("")&&!NY.equals(null)){
            uyear =NY.split("-")[0];
            umouth=NY.split("-")[1];
        }
        DHorder = request.getParameter("DHorder");
        Des = new String(request.getParameter("Des").getBytes("ISO-8859-1") , "UTF-8");
        fname = new String(request.getParameter("fname").getBytes("ISO-8859-1") , "UTF-8");
        if(plant!=""){
            response.reset(); //清除buffer缓存
            Map<String,Object> map=new HashMap<String,Object>();
            // 指定下载的文件名
            String fileName="";
            try {
                 fileName = URLEncoder.encode("月度计划", "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename="+fileName+".xls");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            HSSFWorkbook workbook=null;
            //导出Excel对象
            workbook = planproductservice.exportExcelInfo(query,plant,umouth,uyear,DHorder,Des,fname);
            OutputStream output;
            try {
                output = response.getOutputStream();
                BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
                bufferedOutPut.flush();
                workbook.write(bufferedOutPut);
                bufferedOutPut.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    @ResponseBody
    @RequestMapping(value="/download",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject download(HttpServletRequest request,HttpServletResponse response) throws IOException {
        JSONObject re = new JSONObject();
        String json = "{success:false}";
        String logName = "月度计划导入.xls";
        try {

            String Agent = request.getHeader("User-Agent");
            StringTokenizer st = new StringTokenizer(Agent,";");
//            st.nextToken();
            //得到用户的浏览器名  MSIE  Firefox
            String userBrowser = st.nextToken();
            String path = null;

            path = "D:\\app\\mdm\\download" + logName;
            File source = new File(path);
            String name = source.getName();
            FileUtil.downType(response,name,userBrowser);
            response = FileUtil.copy(source, response);
            re.put("success","true");

        } catch (Exception e) {
            re.put("success","false");

        }

        return re;
    }
    @ResponseBody
    @RequestMapping(value="/APdelete",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject APdelete(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String Umouth = request.getParameter("Umouth");
        String Uyear = request.getParameter("Uyear");
        String OrderLine = request.getParameter("OrderLine");
        String Plant = request.getParameter("Plant");
        PlanProduct planProduct = new PlanProduct();
        planProduct.setUmouth(Umouth);
        planProduct.setUyear(Uyear);
        planProduct.setOrderLine(OrderLine);
        planProduct.setPlant(Plant);
        JSONObject re = new JSONObject();
        int A = planproductservice.APdelete(planProduct);
if(A>0){
    re.put("OK","OK");
}else
{
    re.put("OK","NO");
}
        return re;
    }

}
