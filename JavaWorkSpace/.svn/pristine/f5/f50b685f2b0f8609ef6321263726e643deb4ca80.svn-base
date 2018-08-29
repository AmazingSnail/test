package com.dhchain.business.TradeWMS.controller;


import com.dhchain.business.TradeWMS.service.*;
import com.dhchain.business.TradeWMS.vo.*;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import com.dhchain.config.vo.ExcelUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.IntrospectionException;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by zhenglb on 2018-03-31.
 */
@Controller
@RequestMapping(value = "/PackageCheck")
public class PackageCheck {
    @Autowired
    private PackageCheckService packageCheckService;
    @Autowired
    private TCheckbaseService tCheckbaseService;
    @Autowired
    private TCheckdetailService tCheckdetailService;
    @Autowired
    private TPackagestoreService tPackagestoreService;
    @Autowired
    private TPackageoutService packageoutService;
    @Autowired
    private TPackhalfstoreService tPackhalfstoreService;
    @Autowired
    private TPackgoodService tPackgoodService;
    @Autowired
    private TPacktranslistService tPacktranslistService;
    @Autowired
    private TPackgoodallotService tPackgoodallotService;
    private String page_list = "packagecheck";
    /**
     * 包装装箱校验查询
     * @param TPackhalf 参数
     * @return
     * @throws IntrospectionException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    @ResponseBody
    @RequestMapping(value="/packageCheckQuery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject packageCheckQuery(TPackhalf TPackhalf) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        Example example = new Example(TPackhalf.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(TPackhalf.getDhorderno())) {
            criteria.andLike("dhorderno", "%" + TPackhalf.getDhorderno() + "%");
        }
        if (StringUtil.isNotEmpty(TPackhalf.getBoxnum())) {
            criteria.andEqualTo("boxnum", TPackhalf.getBoxnum());
        }
        if (StringUtil.isNotEmpty(TPackhalf.getSerialno())) {
            criteria.andLike("serialno", TPackhalf.getSerialno());
        }
        if (StringUtil.isNotEmpty(TPackhalf.getLocation())) {
            criteria.andLike("location", TPackhalf.getLocation());
        }
        List<TPackhalf> TPackhalfList = packageCheckService.selectByExample(example);
        JSONObject re = new JSONObject();
        JSONArray json = new JSONArray();
        for (TPackhalf tPackhalf:TPackhalfList){
            JSONObject jsonObject = JSONObject.fromObject(tPackhalf);
            if(tPackhalf.getBoxnumfid()!=null){
                TPackhalf tPackhalf1 = new TPackhalf();
                tPackhalf1.setSerialno(tPackhalf.getSerialno());
                tPackhalf1.setBoxnum(tPackhalf.getBoxnumfid()+"");
                TPackhalf tPackhalf2 = packageCheckService.selectOne(tPackhalf1);
                jsonObject.put("_parentId",tPackhalf2.getId());
            }
            json.add(jsonObject);
        }
        re.put("rows",json);
        re.put("total",json.size());
        return re;
    }

    /**
     * 包装装箱查询
     * @param TPackhalf 参数
     * @return
     * @throws IntrospectionException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    @ResponseBody
    @RequestMapping(value="/packageselectQuery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject packageselectQuery(TPackhalf TPackhalf) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        Example example = new Example(TPackhalf.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(TPackhalf.getDhorderno())) {
            criteria.andLike("dhorderno", "%" + TPackhalf.getDhorderno() + "%");
        }
        if (StringUtil.isNotEmpty(TPackhalf.getBoxnum())) {
            criteria.andEqualTo("boxnum", TPackhalf.getBoxnum());
        }
        if (StringUtil.isNotEmpty(TPackhalf.getSerialno())) {
            criteria.andLike("serialno", TPackhalf.getSerialno());
        }
        if (StringUtil.isNotEmpty(TPackhalf.getLocation())) {
            criteria.andLike("location", TPackhalf.getLocation());
        }
        if (TPackhalf.getIscomplete()!=null) {
            criteria.andEqualTo("iscomplete", TPackhalf.getIscomplete());
        }
        if (TPackhalf.getIssap()!=null) {
            criteria.andEqualTo("issap", TPackhalf.getIssap());
        }
        List<TPackhalf> TPackhalfList = packageCheckService.selectByExample(example);
        JSONObject re = new JSONObject();
        JSONArray json = new JSONArray();
        for (TPackhalf tPackhalf:TPackhalfList){
            JSONObject jsonObject = JSONObject.fromObject(tPackhalf);
            if(tPackhalf.getBoxnumfid()!=null){
                TPackhalf tPackhalf1 = new TPackhalf();
                tPackhalf1.setSerialno(tPackhalf.getSerialno());
                tPackhalf1.setBoxnum(tPackhalf.getBoxnumfid()+"");
                TPackhalf tPackhalf2 = packageCheckService.selectOne(tPackhalf1);
                jsonObject.put("_parentId",tPackhalf2.getId());
            }
            json.add(jsonObject);
        }
        re.put("rows",json);
        re.put("total",json.size());
        return re;
    }


    /**
     * 成品入库查询
     * @param TPackhalf 参数
     * @return
     * @throws IntrospectionException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    @ResponseBody
    @RequestMapping(value="/packageInQuery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject packageInQuery(TPackhalf TPackhalf) throws IntrospectionException, InvocationTargetException, IllegalAccessException {
        Example example = new Example(TPackhalf.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(TPackhalf.getDhorderno())) {
            criteria.andLike("dhorderno", "%" + TPackhalf.getDhorderno() + "%");
        }
        if (StringUtil.isNotEmpty(TPackhalf.getBoxnum())) {
            criteria.andEqualTo("boxnum", TPackhalf.getBoxnum());
        }
        if (StringUtil.isNotEmpty(TPackhalf.getSerialno())) {
            criteria.andLike("serialno", TPackhalf.getSerialno());
        }
        List<TPackhalf> TPackhalfList = packageCheckService.selectByExample(example);
        JSONObject re = new JSONObject();
        JSONArray json = new JSONArray();
        for (TPackhalf tPackhalf:TPackhalfList){
            JSONObject jsonObject = JSONObject.fromObject(tPackhalf);
            if(tPackhalf.getBoxnumfid()!=null){
                TPackhalf tPackhalf1 = new TPackhalf();
                tPackhalf1.setSerialno(tPackhalf.getSerialno());
                tPackhalf1.setBoxnum(tPackhalf.getBoxnumfid()+"");
                TPackhalf tPackhalf2 = packageCheckService.selectOne(tPackhalf1);
                jsonObject.put("_parentId",tPackhalf2.getId());
            }
            json.add(jsonObject);
        }
        re.put("rows",json);
        re.put("total",json.size());
        return re;
    }

    /**
     * 检验问题查询
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/checkdetailQuery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject checkdetailQuery(HttpServletRequest request){
        String serialno = request.getParameter("serialno");
        String packhalfid = request.getParameter("packhalfid");
        Example example = new Example(TCheckdetail.class);
        example.createCriteria().andGreaterThan("packhalfid",packhalfid);
        List<TCheckdetail> tCheckdetails = tCheckdetailService.selectByExample(example);
        List<Integer> list = new ArrayList<Integer>();
        for (TCheckdetail tCheckdetail:tCheckdetails){
            list.add(tCheckdetail.getQmid());
        }
        List<TCheckbase> tCheckbases = tCheckbaseService.selectAll();
        JSONObject re = new JSONObject();
        JSONArray json = new JSONArray();
        for (TCheckbase TCheckbase:tCheckbases){
            JSONObject jsonObject = JSONObject.fromObject(TCheckbase);
            if(list.size()!=0&&list.contains(TCheckbase.getId())){
                jsonObject.put("checked",true);
            }else {
                jsonObject.put("checked",false);
            }
            jsonObject.put("serialno",serialno);
            json.add(jsonObject);
        }
        re.put("rows",json);
        re.put("total",json.size());
        return re;
    }

    /**
     *成品库存调拨查询
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/tPackhalfstoreQuery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject tPackhalfstoreQuery(HttpServletRequest request){
        String id = request.getParameter("id");
        JSONObject re = new JSONObject();
        JSONArray json = new JSONArray();

        TPackhalfstore tPackhalfstore = tPackhalfstoreService.selectByKey(Integer.parseInt(id));
        if(tPackhalfstore!=null){
            JSONObject jsonObject = JSONObject.fromObject(tPackhalfstore);
            json.add(jsonObject);
        }
        re.put("rows",json);
        re.put("total",json.size());
        return re;
    }

    /**
     * 调拨记录查询
     *
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/PackGoodAllotQuery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject PackGoodAllotQuery(HttpServletRequest request){
        String packgoodid = request.getParameter("packgoodid");
        JSONObject re = new JSONObject();
        Example example = new Example(TPackgoodallot.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(packgoodid)) {
            criteria.andEqualTo("packgoodid",Integer.parseInt(packgoodid));
        }
        List<TPackgoodallot> tPackgoodallotList = tPackgoodallotService.selectByExample(example);
        re.put("rows",JSONArray.fromObject(tPackgoodallotList));
        re.put("total",JSONArray.fromObject(tPackgoodallotList).size());
        return re;
    }

    /**
     *成品入库记录查询 查当天的
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/packgoodQuery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject packgoodQuery(HttpServletRequest request){
        Example example = new Example(TPackgood.class);
        Example.Criteria criteria = example.createCriteria();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        criteria.andEqualTo("inputdate",sdf.format(new Date()));
        JSONObject re = new JSONObject();
        List<TPackgood> tPackgoods   = tPackgoodService.selectByExample(example);
        JSONArray json = new JSONArray();
        for (TPackgood tPackgood:tPackgoods){
            if(tPackgood.getBoxnumfid()==null){
                JSONObject jsonObject = JSONObject.fromObject(tPackgood);
                json.add(jsonObject);
            }
        }
        re.put("rows",json);
        re.put("total",json.size());
        return re;
    }

    /**
     *
     *发出页面左边grid查询   select distinct doxtbh,OutTime from t_PackTransList where isout=0 and dhorderno is null
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/packageOutLeftquery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject packageOutLeftquery(TPacktranslist tPacktranslist){
        JSONObject re = new JSONObject();
        List<Map> maps   = tPacktranslistService.packageOutLeftquery(tPacktranslist);
        JSONArray json  =JSONArray.fromObject(maps);
        re.put("rows",json);
        re.put("total",json.size());
        return re;
    }
    /**
     *
     *发出页面右边grid查询

     * @return
     */
    @ResponseBody
    @RequestMapping(value="/packageOutRightquery",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject packageOutRightquery(TPacktranslist tPacktranslist){
        Example example = new Example(TPacktranslist.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("doxtbh",tPacktranslist.getDoxtbh());
        criteria.andIsNull("dhorderno");
        criteria.andEqualTo("isout",false);
        JSONObject re = new JSONObject();
        List<TPacktranslist> tPacktranslists   = tPacktranslistService.selectByExample(example);
        JSONArray json  =JSONArray.fromObject(tPacktranslists);
        re.put("rows",json);
        re.put("total",json.size());
        return re;
    }


    /**
     * 导入模板
     * @param request
     * @param response
     * @throws UnsupportedEncodingException
     */

    @ResponseBody
    @RequestMapping(value = "download", method = {RequestMethod.GET, RequestMethod.POST})
    public void download(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {


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
        cell.setCellValue("箱单号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 1);
        cell.setCellValue("箱号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 2);
        cell.setCellValue("父箱号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 3);
        cell.setCellValue("厂编合同");
        cell.setCellStyle(style);
        cell = row.createCell((short) 4);
        cell.setCellValue("物料编码");
        cell.setCellStyle(style);
        cell = row.createCell((short) 5);
        cell.setCellValue("物料描述");
        cell.setCellStyle(style);
        cell = row.createCell((short) 6);
        cell.setCellValue("应装数量");
        cell.setCellStyle(style);
        cell = row.createCell((short) 7);
        cell.setCellValue("SAP订单号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 8);
        cell.setCellValue("SAP订单行号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 9);
        cell.setCellValue("事业部");
        cell.setCellStyle(style);
        cell = row.createCell((short) 10);
        cell.setCellValue("库位号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 11);
        cell.setCellValue("售达方");
        cell.setCellStyle(style);
        cell = row.createCell((short) 12);
        cell.setCellValue("售达方描述");
        cell.setCellStyle(style);
        cell = row.createCell((short) 13);
        cell.setCellValue("销售部门");
        cell.setCellStyle(style);
        cell = row.createCell((short) 14);
        cell.setCellValue("销售部门描述");
        cell.setCellStyle(style);
        cell = row.createCell((short) 15);
        cell.setCellValue("实装数量");
        cell.setCellStyle(style);
        cell = row.createCell((short) 16);
        cell.setCellValue("装箱员");
        cell.setCellStyle(style);
        cell = row.createCell((short) 17);
        cell.setCellValue("完箱标识(1.完成 2.未完成)");
        cell.setCellStyle(style);
        cell = row.createCell((short) 18);
        cell.setCellValue("检验员");
        cell.setCellStyle(style);
        cell = row.createCell((short) 19);
        cell.setCellValue("检验数量");
        cell.setCellStyle(style);
        cell = row.createCell((short) 20);
        cell.setCellValue("检验结果(1.合格 2.不合格)");
        cell.setCellStyle(style);
        cell = row.createCell((short) 21);
        cell.setCellValue("盖重");
        cell.setCellStyle(style);
        cell = row.createCell((short) 22);
        cell.setCellValue("箱重");
        cell.setCellStyle(style);
        cell = row.createCell((short) 23);
        cell.setCellValue("实际重量");
        cell.setCellStyle(style);
        cell = row.createCell((short) 24);
        cell.setCellValue("称重人");
        cell.setCellStyle(style);
        cell = row.createCell((short) 24);
        cell.setCellValue("称重方式");
        cell.setCellStyle(style);
        cell = row.createCell((short) 25);
        cell.setCellValue("装箱单ID");
        cell.setCellStyle(style);
        // 第六步，将文件存到指定位置
        Date date = new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        String name = "期初导入"+sdf.format(date);
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+name+".xls");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        OutputStream output;
        try {
            output = response.getOutputStream();
            BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
            bufferedOutPut.flush();
            wb.write(bufferedOutPut);
            bufferedOutPut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

    /**
     * 入库 存储过程 在t_PackGood表中新增tpackhalf选中父级数据 t_PackGood表中新增tpackhalf的子级数据
     *              将tpackhalf选中的父级数据的IsRcv改为1 将tpackhalf选中的子级数据的IsRcv改为1 IsRcv为入库标记
     * @param request
     * @param response
     * @return
     * @throws UnsupportedEncodingException
     */
    @ResponseBody
    @RequestMapping(value = "ptgo", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject ptgo(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        int id = Integer.parseInt(request.getParameter("id"));
        packageCheckService.packagein(id);
        JSONObject re = new JSONObject();
        re.put("success",true);
        re.put("message","接收成功");

        return  re;
    }

    /**
     * 保存库位 更新t_PackGood库位
     * @param request
     * @param response
     * @return
     * @throws UnsupportedEncodingException
     */
    @ResponseBody
    @RequestMapping(value = "savelocation", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject savelocation(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        int id = Integer.parseInt(request.getParameter("id"));
        TPackgood tPackgood = tPackgoodService.selectByKey(id);
        tPackgood.setLocation(request.getParameter("location"));
        tPackgoodService.updateAll(tPackgood);
        JSONObject re = new JSONObject();
        re.put("success",true);
        re.put("message","接收成功");

        return  re;
    }

    /**
     * 删除入库记录 存储过程 ptgo的相反过程 删除t_PackGood中选中的数据 将对应的tpackhalf的数据IsRcv改为0
     * @param request
     * @param response
     * @return
     * @throws UnsupportedEncodingException
     */
    @ResponseBody
    @RequestMapping(value = "ptback", method = {RequestMethod.GET, RequestMethod.POST})
    public JSONObject ptback(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        int id = Integer.parseInt(request.getParameter("id"));
        packageCheckService.ptback(id);
        JSONObject re = new JSONObject();
        re.put("success",true);
        re.put("message","退回成功");

        return  re;
    }

    /**
     *发出  存储过程 1.将t_packGood中的对应的数据库位改为null 2.将t_PackTransList发运清单的库位改为null
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/ptoutgo",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject ptoutgo(HttpServletRequest request){
        String ids = request.getParameter("ids");

        String[] inarray = ids.split(",");
        for (String idstr:inarray){
            tPacktranslistService.ptoutgo(Integer.parseInt(idstr));
        }

        JSONObject re = new JSONObject();
        re.put("message","提交成功");
        re.put("succsess",true);
        return re;
    }

    /**
     * 导入
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value="/import",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject impotr(HttpServletRequest request, @RequestParam(value = "packageselect-uploadExcel", required = false) MultipartFile file) throws Exception {
        //获取上传的文件
        MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
        MultipartFile file1 = multipart.getFile("packageselect-uploadExcel");

        InputStream in = file1.getInputStream();
        List<List<Object>> listob = ExcelUtil.getBankListByExcel(in,file.getOriginalFilename());
        JSONArray jslst = new JSONArray();

        for (int i = 0; i < listob.size(); i++) {
            JSONObject re1 = new JSONObject();
            TPackhalf tPackhalf = new TPackhalf();
            List<Object> ob = listob.get(i);
            tPackhalf.setSerialno((String) ob.get(0));
            tPackhalf.setBoxnum((String) ob.get(1));
            tPackhalf.setBoxnumfid((Integer) ob.get(2));
            tPackhalf.setDhorderno((String) ob.get(3));
            tPackhalf.setFno((String) ob.get(4));
            tPackhalf.setFname((String) ob.get(5));
            tPackhalf.setNumberweight((Integer)ob.get(6));
            tPackhalf.setErpsysno((String) ob.get(7));
            tPackhalf.setLineid((String) ob.get(8));
            tPackhalf.setPlant((String) ob.get(9));
            tPackhalf.setLocation((String) ob.get(10));
            tPackhalf.setSapSdf((Integer) ob.get(11));
            tPackhalf.setSapSdfdesc((String) ob.get(12));
            tPackhalf.setSapXsbm((String) ob.get(13));
            tPackhalf.setSapXsbmdesc((String) ob.get(14));
            tPackhalf.setActualnum((Double) ob.get(15));
            tPackhalf.setPackman((String) ob.get(16));
            tPackhalf.setPackdate(new Date());
            tPackhalf.setIscomplete((Integer) ob.get(17)==1?true:false);
            tPackhalf.setCheckman((String) ob.get(18));
            tPackhalf.setChecknum((Double) ob.get(19));
            tPackhalf.setCheckresult((Integer) ob.get(20)==1?true:false);
            tPackhalf.setCheckdate(new Date());
            tPackhalf.setHeadweight((Double) ob.get(21));
            tPackhalf.setBoxweight((Double) ob.get(22));
            tPackhalf.setActualweight((Double) ob.get(23));
            tPackhalf.setWeightinputman((String) ob.get(24));
            tPackhalf.setWeightinputdate(new Date());
            tPackhalf.setWeightway((Integer) ob.get(25));
            tPackhalf.setPackagelistid((Integer) ob.get(26));
            packageCheckService.InsertUseGeneratedKeysMapper(tPackhalf);

        }

        JSONObject re = new JSONObject();
        re.put("success",true);
        re.put("message","导入成功");

        return  re;
    }

    /**
     * 包箱校验问题提交
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/checkdetailSubmit",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject checkdetailSubmit(HttpServletRequest request){
        String packhalfid = request.getParameter("packhalfid");
        String ids = request.getParameter("ids");
        tCheckdetailService.distribute(packhalfid,ids);
        JSONObject re = new JSONObject();
        re.put("message","提交成功");
        re.put("succsess",true);
        return re;
    }

    /**
     * sap移入 方法未完整还要与sap接口对接
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/sapMoveIn",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject sapMoveIn(HttpServletRequest request){
        String id = request.getParameter("id");
        TPackhalf tPackhalf = packageCheckService.selectByKey(Integer.parseInt(id));
        tPackhalf.setIscomplete(true);
        packageCheckService.updateNotNull(tPackhalf);
        Example example = new Example(TPackhalf.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("serialno", tPackhalf.getSerialno());
        criteria.andEqualTo("boxnumfid", tPackhalf.getBoxnum());
        List<TPackhalf> TPackhalfList = packageCheckService.selectByExample(example);
        for (TPackhalf tPackhalf1:TPackhalfList){
            tPackhalf1.setIscomplete(true);
            packageCheckService.updateNotNull(tPackhalf1);
        }
        JSONObject re = new JSONObject();
        re.put("message","移库成功");
        re.put("succsess",true);
        return re;
    }

    /**
     * 包装装箱校验没问题提交
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/sendOk",method={RequestMethod.GET,RequestMethod.POST})
    public JSONObject sendOk(HttpServletRequest request){
        String user = request.getParameter("user");
        String id = request.getParameter("id");
        TPackhalf tPackhalf = packageCheckService.selectByKey(Integer.parseInt(id));
        Example example = new Example(TPackhalf.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(tPackhalf.getBoxnum())) {
            criteria.andEqualTo("boxnumfid",tPackhalf.getBoxnum());
        }
        List<TPackhalf> list = packageCheckService.selectByExample(example);
        //切换数据库至SQL_MDM
        DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
        boolean flag = true;
        Map<Integer,Double[]> hashMap = new HashMap<Integer,Double[]>();
        for (TPackhalf tPackhalf1:list){
            String dhordernoLine = tPackhalf1.getDhorderno()+"/"+tPackhalf1.getLineid();
            Example example1 = new Example(TPackagestore.class);
            Example.Criteria criteria1 = example1.createCriteria();
            criteria1.andEqualTo("orderline",dhordernoLine);
            List<TPackagestore> tPackagestoreList = tPackagestoreService.selectByExample(example1);
            if(tPackagestoreList.size()==0){
                flag = false;
                break;
            }else{
                double outputstore =  tPackagestoreList.get(0).getOutputstore();
                double sapstore = tPackagestoreList.get(0).getSapstore();
                double removestore = tPackhalf1.getNumberweight();


                if(removestore>=sapstore){
                    flag = false;
                    break;
                }else {
                    Double[] doubles = new Double[]{outputstore+removestore,sapstore-removestore};
                    hashMap.put(tPackagestoreList.get(0).getId(),doubles) ;
                }
            }

        }
        JSONObject re = new JSONObject();
        if(flag){
            int i = 0;
            for (Integer key : hashMap.keySet()) {
                Double[] doubles = hashMap.get(key);
                TPackhalf tPackhalf1 = list.get(i);
                TPackagestore  tPackagestore = tPackagestoreService.selectByKey(key);
                tPackagestore.setOutputstore(doubles[0]);
                tPackagestore.setSapstore(doubles[1]);
                tPackagestoreService.updateAll(tPackagestore);
                TPackageout tPackageout = new TPackageout();
                tPackageout.setSerialno(Integer.parseInt(tPackhalf1.getSerialno()));
                tPackageout.setOrderline(tPackhalf1.getDhorderno()+"/"+tPackhalf1.getLineid());
                tPackageout.setFno(tPackhalf1.getFno());
                tPackageout.setFname(tPackhalf1.getFname());
                tPackageout.setOutnumber((double)tPackhalf1.getNumberweight());
//                tPackageout.setF3("56");//假
                tPackageout.setPlant(tPackhalf1.getPlant());
                tPackageout.setOutadd(tPackhalf1.getLocation());
                tPackageout.setOutputman(user);
                tPackageout.setOutputdate(new Date());
                tPackageout.setSapsdorder(tPackhalf1.getErpsysno());
                packageoutService.save(tPackageout);
                i=i+1;
            }
            tPackhalf.setIscomplete(true);
            tPackhalf.setCheckman(user);
            tPackhalf.setCheckdate(new Date());
            tPackhalf.setCheckresult(true);
            //切换数据库至SQL_MDM
            //DataSourceHolder.setDataSourceName(Type.SQL_PACKAGE.getName());
            packageCheckService.updateAll(tPackhalf);
            re.put("message","提交完成");
            re.put("succsess",true);
        }else{
            re.put("message","提交失败，数据库存不对");
            re.put("succsess",false);
        }


        return re;
    }

}
