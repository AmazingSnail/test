package com.dhchain.business.colddigitalworkshop.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.colddigitalworkshop.service.ColdOutService;
import com.dhchain.business.colddigitalworkshop.service.MaterialtakeinService;
import com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn;
import com.dhchain.business.colddigitalworkshop.vo.ColdOut;
import com.dhchain.business.colddigitalworkshop.vo.HaginstRecord;
import com.dhchain.util.SAPConn;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoParameterList;
import com.sap.conn.jco.JCoTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/ColdSapRFC")
public class ColdSapRFCController {
    @Autowired
    private MaterialtakeinService materialtakeinService;
    @Autowired
    private ColdOutService coldOutService;
    @ResponseBody
    @RequestMapping(value = "/ColdTakeInSap", method = {RequestMethod.GET, RequestMethod.POST})
    public Map ColdTakeInSap(HttpServletRequest request, HttpServletResponse response)throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JCoFunction function = null;
        JCoDestination destination = SAPConn.connect();
        String result="";//调用接口返回状态
        String message="";//调用接口返回信息
        String PlantOut = "";//需传入接口的事业部
        String PlantIn = "";//需传入接口的事业部
        Map json = new HashMap();
        try {
            //调用ZEP_O_019函数
            function = destination.getRepository().getFunction("ZPP_O_001");
            JCoParameterList input = function.getImportParameterList();


            input.getStructure("GDSMT_CODE").setValue(0,"04");
//            //调用接口模块
            input.setValue("SMODEL", 3);
//            //04表示MB1B


            String fromadd = request.getParameter("FromAdd");
            String toadd = request.getParameter("ToAdd");
            PlantOut = "1"+fromadd.substring(0,1)+fromadd.substring(1,2)+"0";

            PlantIn = "1"+toadd.substring(0,1)+toadd.substring(1,2)+"0";
            System.out.println(PlantOut+"-----"+PlantIn);
            //获取传入表参数GDSMT_ITEM
            JCoTable GDSMT_ITEM = function.getTableParameterList().getTable("GDSMT_ITEM");
            GDSMT_ITEM.appendRow();//增加一行
            //给表参数中的字段赋值，
            //货物移动
            GDSMT_ITEM.setValue("MATERIAL", request.getParameter("p_MATNR"));
            GDSMT_ITEM.setValue("PLANT", PlantOut);
            GDSMT_ITEM.setValue("STGE_LOC", request.getParameter("FromAdd"));
            GDSMT_ITEM.setValue("MOVE_PLANT",PlantIn );
            GDSMT_ITEM.setValue("MOVE_STLOC", request.getParameter("ToAdd"));
            GDSMT_ITEM.setValue("MOVE_TYPE", request.getParameter("MoveType"));
            GDSMT_ITEM.setValue("ENTRY_QNT", request.getParameter("PPNum"));
            GDSMT_ITEM.setValue("ENTRY_UOM", request.getParameter("MDW"));
            GDSMT_ITEM.setValue("WITHDRAWN", "X");
            GDSMT_ITEM.setValue("BATCH", "OWN");
            if("true".equals(request.getParameter("isback"))){
                GDSMT_ITEM.setValue("XSTOB","X");
            }
            function.execute(destination);
            result= function.getExportParameterList().getString("MESS");//调用接口返回参数
            message= function.getExportParameterList().getString("BGSL");//调用接口返回信息
            json.put("result",result);
            System.out.println("报工返回参数--->"+result+";基本数量--->"+message);
            GDSMT_ITEM.clear();//清空本次条件，如果要继续传入值去或者还要循环，那得将之前的条件清空
        }catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/insertSapMessFail", method = {RequestMethod.GET, RequestMethod.POST})
    public Map insertSapMessFail(HttpServletRequest request,HttpServletResponse response)throws UnsupportedEncodingException{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        int id = 0;
        if (request.getParameter("id")!=null){
            id =Integer.parseInt(request.getParameter("id"));
        }
        String moveman = request.getParameter("UserName");
        ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
        coldMaterialIn.setMoveman(moveman);
        coldMaterialIn.setId(id);
        int m = materialtakeinService.updateColdTakenFail(coldMaterialIn);
        Map json = new HashMap();
        json.put("Num",m);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/insertSapMess", method = {RequestMethod.GET, RequestMethod.POST})
    public Map insertSapMess(HttpServletRequest request,HttpServletResponse response)throws UnsupportedEncodingException{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        Map json = new HashMap();
        String fno = request.getParameter("fno");
        int id = 0;
        if (request.getParameter("id")!=null){
            id =Integer.parseInt(request.getParameter("id"));
        }
        String serialno = request.getParameter("serialno");
        String uyear = request.getParameter("uyear");
        String umonth = request.getParameter("umonth");
        String againstNumber = request.getParameter("TakeNumber");
        String againstMan = request.getParameter("UserName");
        String plant = request.getParameter("plant");
        String TakeMan = request.getParameter("TakeMan");
        String TakeDate = request.getParameter("TakeDate");
        boolean isMove = true;
        String moveman = request.getParameter("UserName");
        String fname = request.getParameter("fname");
        String againstkind = request.getParameter("againstkind");
        String state = request.getParameter("state");
        String OutAdd = request.getParameter("OutAdd");
        String OutPutMan = request.getParameter("OutPutMan");
        String OutPutDate = request.getParameter("OutPutDate");

        ColdMaterialIn coldMaterialIn = new ColdMaterialIn();
        coldMaterialIn.setMoveman(moveman);
        coldMaterialIn.setId(id);
        ColdOut coldOut = new ColdOut();
        coldOut.setMoveman(moveman);
        coldOut.setId(id);
        int m = 0;


        HaginstRecord haginstRecord = new HaginstRecord();
        haginstRecord.setFno(fno);
        haginstRecord.setSerialno(serialno);
        haginstRecord.setUyear(uyear);
        haginstRecord.setUmonth(umonth);
        haginstRecord.setAgainstkind(againstkind);
        haginstRecord.setAgainstnumber(againstNumber);
        haginstRecord.setAgainstman(againstMan);
        haginstRecord.setPlant(plant);


        haginstRecord.setIsmove(isMove);
        haginstRecord.setMoveman(moveman);
        haginstRecord.setFname(fname);


        int n =0;
        if ("1".equals(state)){
            haginstRecord.setTakeman(TakeMan);
            haginstRecord.setTakedate(TakeDate);
            m= materialtakeinService.updateColdTakenInSap(coldMaterialIn);
            n = materialtakeinService.insertColdSapMess(haginstRecord);
        }else if("2".equals(state)){
            haginstRecord.setTakeman(TakeMan);
            haginstRecord.setTakedate(TakeDate);
            m= materialtakeinService.updateColdTakenBack(coldMaterialIn);
            n = materialtakeinService.insertColdSapMessBack(haginstRecord);
        }else if("3".equals(state)){
            haginstRecord.setOutadd(OutAdd);
            haginstRecord.setOutputman(OutPutMan);
            haginstRecord.setOutputdate(OutPutDate);
            coldOut.setIsmove(true);
            m= coldOutService.updateByPrimaryKeySelective(coldOut);
            n = coldOutService.insertSapOutMess(haginstRecord);
        }else if("4".equals(state)){
            haginstRecord.setOutadd(OutAdd);
            haginstRecord.setOutputman(OutPutMan);
            haginstRecord.setOutputdate(OutPutDate);
            coldOut.setIsmove(false);
            m= coldOutService.updateByPrimaryKeySelective(coldOut);
            n = coldOutService.insertSapMessOutBack(haginstRecord);
        }

        int mn = 0;
        if (m>0 && n>0){
            mn = 1;
        }
        if (n==0 && m==0){
            mn = 2;
        }
        json.put("Num",mn);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/ColdTakeOutCreateSap", method = {RequestMethod.GET, RequestMethod.POST})
    public Map ColdTakeOutCreateSap(HttpServletRequest request, HttpServletResponse response)throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JCoFunction function = null;
        JCoDestination destination = SAPConn.connect();
        String result="";//调用接口返回状态
        String message="";//调用接口返回信息
        String pono = "";
        String poitem = "";
        String takenumber = "";
        String entities = request.getParameter("entities");
        entities = entities.replace("}{", "},{");
        entities = "[" + entities.toString() + "]";
        JSONArray jsonArray = JSONArray.parseArray(entities);
        Map re = new HashMap();
        String VBELN = "";
        String POSNR = "";
        String EBELN = "";
        String EBELP = "";

        try {
            //调用ZEP_O_019函数
            function = destination.getRepository().getFunction("ZMM_I_001");
            JCoParameterList input = function.getImportParameterList();


            //获取传入表参数GDSMT_ITEM
            JCoTable TAB_CG_MENGE = function.getTableParameterList().getTable("TAB_CG_MENGE");
            for (int i=0;i<jsonArray.size();i++) {
                JSONObject row = jsonArray.getJSONObject(i);
                pono = row.getString("cgvbeln");
                poitem = row.getString("cgposnr");
                takenumber = row.getString("outnumber");
                TAB_CG_MENGE.appendRow();//增加一行
                //给表参数中的字段赋值，
                //货物移动
                TAB_CG_MENGE.setValue("EBELN",pono);
                TAB_CG_MENGE.setValue("EBELP", poitem);
                TAB_CG_MENGE.setValue("MENGE", takenumber);
            }


            function.execute(destination);
            result= function.getExportParameterList().getString("EX_MESTYP");//调用接口返回参数
            message= function.getExportParameterList().getString("EX_MESSAGE");//调用接口返回信息
            JCoTable TAB_RETURN = function.getTableParameterList().getTable("TAB_RETURN");
            System.out.println(TAB_RETURN.getNumRows());
            JSONArray jslst = new JSONArray();
            if(TAB_RETURN.getNumRows()>0){
                for(int num = 0;num<TAB_RETURN.getNumRows();num++){
                    Map json = new HashMap();
                    TAB_RETURN.setRow(num);

                     VBELN = TAB_RETURN.getString("VBELN");
                     POSNR = TAB_RETURN.getString("POSNR");
                    EBELN = TAB_RETURN.getString("EBELN");
                    EBELP = TAB_RETURN.getString("EBELP");
                    for (int number = 0;number<jsonArray.size();number++){
                        JSONObject rownuw = jsonArray.getJSONObject(number);
                        if(EBELN.equals(rownuw.getString("cgvbeln")) && EBELP.equals("000"+rownuw.getString("cgposnr"))){
                            Integer id = Integer.parseInt(rownuw.getString("id"));
                            ColdOut coldOut = new ColdOut();
                            coldOut.setVbeln(VBELN);
                            coldOut.setPosnr(POSNR);
                            coldOut.setId(id);
                            int m = coldOutService.updateByPrimaryKeySelective(coldOut);
                            json.put("VBELN",VBELN);
                            json.put("POSNR",POSNR);

                            jslst.add(json);
                        }

                    }

                }
            }
            re.put("returns",result);
            re.put("VBELN",VBELN);
            System.out.println("报工返回参数--->"+result+";基本数量--->"+message);
            TAB_CG_MENGE.clear();//清空本次条件，如果要继续传入值去或者还要循环，那得将之前的条件清空
        }catch (Exception e) {
            e.printStackTrace();
        }
        return re;
    }
    @ResponseBody
    @RequestMapping(value = "/ColdTakeOutSaveSap", method = {RequestMethod.GET, RequestMethod.POST})
    public Map ColdTakeOutSaveSap(HttpServletRequest request, HttpServletResponse response)throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JCoFunction function = null;
        JCoDestination destination = SAPConn.connect();
        String result="";//调用接口返回状态
        String message="";//调用接口返回信息
        String VBELN = "";
        String POSNR = "";
        String LGORT = "";

        String User = request.getParameter("User");

        String entities = request.getParameter("entities");
        entities = entities.replace("}{", "},{");
        entities = "[" + entities.toString() + "]";
        JSONArray jsonArray = JSONArray.parseArray(entities);

        Map json = new HashMap();
        try {
            //调用ZEP_O_019函数
            function = destination.getRepository().getFunction("ZMM_I_002");
            JCoParameterList input = function.getImportParameterList();

            JSONObject rowfisrt = jsonArray.getJSONObject(0);
            VBELN = rowfisrt.getString("vbeln");

            input.setValue("IM_VBELN",VBELN);
            //获取传入表参数GDSMT_ITEM
            JCoTable TAB_LGORT = function.getTableParameterList().getTable("TAB_LGORT");
            for (int i=0;i<jsonArray.size();i++) {
                JSONObject row = jsonArray.getJSONObject(i);
                TAB_LGORT.appendRow();//增加一行
                //给表参数中的字段赋值，
                //货物移动

                POSNR = row.getString("posnr");
                LGORT = "2501";
                TAB_LGORT.setValue("POSNR",POSNR);
                TAB_LGORT.setValue("LGORT", LGORT);
            }

            function.execute(destination);
            result= function.getExportParameterList().getString("EX_MESTYP");//调用接口返回参数
            message= function.getExportParameterList().getString("EX_MESSAGE");//调用接口返回信息
            json.put("returns",result);
            System.out.println("报工返回参数--->"+result+";基本数量--->"+message);
            TAB_LGORT.clear();//清空本次条件，如果要继续传入值去或者还要循环，那得将之前的条件清空
            if(result.equals("S")){
                for (int i=0;i<jsonArray.size();i++) {
                    Date now = new Date();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                    String hehe = dateFormat.format( now );
                    JSONObject row = jsonArray.getJSONObject(i);
                    ColdOut coldOut = new ColdOut();
                    Integer id = Integer.parseInt(row.getString("id"));
                    coldOut.setId(id);
                    coldOut.setIsmove(true);
                    coldOut.setMoveman(User);
                    coldOut.setMovedate(hehe);
                    int  m= coldOutService.updateByPrimaryKeySelective(coldOut);
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

}
