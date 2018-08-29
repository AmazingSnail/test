package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.vo.*;
import com.dhchain.business.partpunchingworkshop.dao.MonthPlanMapper;
import com.dhchain.business.partpunchingworkshop.service.MonthPlanService;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import com.dhchain.config.vo.ExcelBean;
import com.dhchain.config.vo.ExcelUtil;
import com.dhchain.util.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.beans.IntrospectionException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("MonthPlanService")
public class MonthPlanServiceImpl implements MonthPlanService {
    @Autowired
    private MonthPlanMapper monthPlanMapper;

    @Override
    public List<BaseStatus> FindFname() {
        return monthPlanMapper.FindFname();
    }

    @Override
    public List<Syb> queryplant() {
        List<Syb> list = monthPlanMapper.getSyb();
        return list;
    }

    @Override
    public List<BaseUser> getUsername() {
        return monthPlanMapper.getUsername();
    }
    @Override
    public List<PTMaterial> getUsername1() {
        return monthPlanMapper.getUsername1();
    }

    @Override
    public List<PTPlan> selectByAllKey(PTPlan record) {
        return monthPlanMapper.selectByAllKey(record);
    }
    @Override
    public List<PTPlan> getAll(PTPlan record) {
        return monthPlanMapper.getAll(record);
    }

    @Override
    public List<PTOrderPlan> selectptOrderPlan(PTOrderPlan record) {
        return monthPlanMapper.selectptOrderPlan(record);
    }

    @Override
    public String importExcelInfo(InputStream in, MultipartFile file,  String User, Integer month, Integer year,String plant,String time) throws Exception {
            String OK = "";
            String NO = "";
            String Err = "";
            int n =0;
        int A = 0;
        int B = 0;
        String insertInfoBatch = "";
            List<List<Object>> listob = ExcelUtil.getBankListByExcel(in, file.getOriginalFilename());
            List list = new ArrayList<PTOrderPlan>();
            //遍历listob数据，把数据放到List中
            for (int i = 1; i < listob.size()-1; i++) {
                List<Object> ob = listob.get(i);
                if(ob.get(0) != null&&ob.get(0) != ""){
                    PTOrderPlan ptOrderPlan = new PTOrderPlan();
                    PTOrderPlan ptOrderPlan1 = new PTOrderPlan();
                    //切换数据库
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                    ptOrderPlan.setOrderLine(String.valueOf(ob.get(0)));
                    ptOrderPlan.setFno(String.valueOf(ob.get(1)));
                    ptOrderPlan.setFname(String.valueOf(ob.get(2)));
                    ptOrderPlan.setWorkCentre(String.valueOf(ob.get(3)));
                    ptOrderPlan.setPartDrawing(String.valueOf(ob.get(4)));
                    ptOrderPlan.setPlanNum(String.valueOf(ob.get(5)));
                    ptOrderPlan.setOrderTime(String.valueOf(ob.get(6)));
                    ptOrderPlan.setWorkprocedure(String.valueOf(ob.get(7)));
                    ptOrderPlan.setUyear(Integer.parseInt(String.valueOf(ob.get(8))));
                    System.out.println(Integer.parseInt(String.valueOf(ob.get(8))));
                    System.out.println(Integer.parseInt(String.valueOf(ob.get(9))));
                    ptOrderPlan.setUmouth(Integer.parseInt(String.valueOf(ob.get(9))));
                    ptOrderPlan.setPlant(plant);
                    ptOrderPlan.setDepartMent("零件车间");
                    ptOrderPlan.setInputMan(User);
                    ptOrderPlan.setInputTime(time);
                    ptOrderPlan1.setOrderLine(String.valueOf(ob.get(0)));
                    ptOrderPlan1.setFno(String.valueOf(ob.get(1)));
                    ptOrderPlan1.setPlant(plant);
                    ptOrderPlan1.setUyear(Integer.parseInt(String.valueOf(ob.get(8))));
                    ptOrderPlan1.setUmouth(Integer.parseInt(String.valueOf(ob.get(9))));
                    DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
                    List<PTOrderPlan> list1 = monthPlanMapper.selectByOrdertime(ptOrderPlan1);
                    DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
                    if(String.valueOf(ob.get(0))!=null){
                        if(list1.size()>0){
                            DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
                            n = monthPlanMapper.updateByPOrdertime(ptOrderPlan);
                            DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
                            A++;
                        }else {
                            DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
                            n = monthPlanMapper.insertorderplan(ptOrderPlan);
                            DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
                            A++;
                        }
                    }else {
                        B++;
                    }


                }else{
                    break;
                }
                insertInfoBatch = "成功"+A+"条，失败"+B+"条！";

            }

            return insertInfoBatch;
    }

    @Override
    public String importExcelInfo1(InputStream in, MultipartFile file, String User, Integer month, Integer uyear,String plant,String time) throws Exception {
        String OK = "";
        String NO = "";
        String Err = "";
        List list = new ArrayList<PTPlan>();

        int n =0;
        int A = 0;
        int B = 0;
        String insertInfoBatch = "";
        List<List<Object>> listob = ExcelUtil.getBankListByExcel(in, file.getOriginalFilename());
        //遍历listob数据，把数据放到List中
        for (int i = 1; i < listob.size(); i++) {
            List<Object> ob = listob.get(i);
            PTPlan ptPlan = new PTPlan();
            PTOrderPlan ptOrderPlan1 = new PTOrderPlan();
            //切换数据库
            Date day = new Date();
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            ptPlan.setWorkProcedure(String.valueOf(ob.get(0)));
            ptPlan.setPartDrawing(String.valueOf(ob.get(1)));
            ptPlan.setPartName(String.valueOf(ob.get(2)));
            ptPlan.setFno(String.valueOf(ob.get(3)));
            ptPlan.setFname(String.valueOf(ob.get(4)));
            ptPlan.setWorkCentre(String.valueOf(ob.get(5)));
            if(StringUtils.isEmpty(ob.get(6))){
                ptPlan.setLastRemainNum(0f);
            }else {
                ptPlan.setLastRemainNum(Float.parseFloat(String.valueOf(ob.get(6))));
            }
            if(StringUtils.isEmpty(ob.get(7))){
                ptPlan.setPlanNum(0f);
            }else {
                ptPlan.setPlanNum(Float.parseFloat(String.valueOf(ob.get(7))));
            }
            System.out.println("ob.get(8):"+ob.get(8));
            if(StringUtils.isEmpty(ob.get(8))){
                ptPlan.setPatchPlan(0f);
            }else {
                ptPlan.setPatchPlan(Float.parseFloat(String.valueOf(ob.get(8))));
            }
            System.out.println("ob.get(10):"+ob.get(10));
            if(StringUtils.isEmpty(ob.get(10))){

            }else {
                ptPlan.setUyear(Integer.parseInt(String.valueOf(ob.get(10))));
            }
            System.out.println("ob.get(11):"+ob.get(11));
            if(StringUtils.isEmpty(ob.get(11))){

            }else {
                ptPlan.setUmouth(Integer.parseInt(String.valueOf(ob.get(11))));
            }

            ptPlan.setOrderTime(String.valueOf(ob.get(9)));
            ptPlan.setInputMan(User);
            ptPlan.setInputDate(df.format(day));
           // ptPlan.setUyear(Integer.parseInt(String.valueOf(ob.get(10))));
           // ptPlan.setUmouth(Integer.parseInt(String.valueOf(ob.get(11))));
            ptPlan.setPlant(plant);
            ptPlan.setDepartMent("零件车间");
            PTPlan ptPlan1 = new PTPlan();
            ptPlan1.setFno(String.valueOf(ob.get(3)));
            PTOrderPlan ptOrderPlan = new PTOrderPlan();
            ptOrderPlan.setFno(String.valueOf(ob.get(3)));
            DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
            List<PTOrderPlan> list2 = monthPlanMapper.selectByFno1(ptOrderPlan);//合同计划
            DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
            list.add(ptPlan);
        }
        System.out.println(list.size());
        if ("".equals(Err)) {
            if (list.size() > 0) {
                for (int i = 0; i<list.size();i++){
                    PTPlan ptPlan = (PTPlan) list.get(i);
                    PTPlan ptPlan1 =  new PTPlan();
                    String fno = ptPlan.getFno();
                    int year = ptPlan.getUyear();
                    int month1 = ptPlan.getUmouth();
                    ptPlan1.setFno(fno);
                    ptPlan1.setPlant(plant);
                    ptPlan1.setUyear(year);
                    ptPlan1.setUmouth(month1);
                    DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
                    List<PTPlan> list1 = monthPlanMapper.selectByFno(ptPlan1);//月度计划
                    DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
                    if(list1.size()>0){
                        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
                            n = monthPlanMapper.updateByfno(ptPlan);
                            DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
                            A++;
                    }else{
                        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
                        n = monthPlanMapper.insertplan(ptPlan);
                        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
                        A++;
                    }
                }
            }
        }
//            if(String.valueOf(ob.get(0))!=null){
//                if(list1.size()>0){
//                    DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
//                    n = monthPlanMapper.updateByPrdertime(ptOrderPlan);
//                    DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
//                    A++;
//                }else {
//                    DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
//                    n = monthPlanMapper.insertorderplan(ptOrderPlan);
//                    DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
//                    A++;
//                }
//            }else {
//                B++;
//            }
//
//
//        }

        insertInfoBatch = "成功"+A+"条，失败"+B+"条！"+Err;

        return insertInfoBatch;
    }

    @Override
    public HSSFWorkbook exportExcel(String plant, String uyear, String umonth, String fname, String WorkCentre, String OrderLine, String fno, String state) {
        HSSFWorkbook xssfWorkbook=null;
        if(Integer.parseInt(state)==3){
            PTOrderPlan ptOrderPlan = new PTOrderPlan();
            ptOrderPlan.setUyear(Integer.parseInt(uyear));
            ptOrderPlan.setUmouth(Integer.parseInt(umonth));
            ptOrderPlan.setPlant(plant);
            ptOrderPlan.setFno(fno.trim());
            ptOrderPlan.setFname(fname.trim());
            ptOrderPlan.setWorkCentre(WorkCentre.trim());
            ptOrderPlan.setOrderLine(OrderLine.trim());
            DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
            List<PTOrderPlan> list = monthPlanMapper.selectptOrderPlan(ptOrderPlan);
            DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
            List<ExcelBean> excel=new ArrayList<>();
            Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
            //设置标题栏
            excel.add(new ExcelBean("厂编合同号","OrderLine",0));
            excel.add(new ExcelBean("规格","PartDrawing",0));
            excel.add(new ExcelBean("零件编码","Fno",0));
            excel.add(new ExcelBean("零件描述","Fname",0));
            excel.add(new ExcelBean("标记描述","WorkCentre",0));
            excel.add(new ExcelBean("计划数量","PlanNum",0));
            excel.add(new ExcelBean("年度","Uyear",0));
            excel.add(new ExcelBean("月度","Umouth",0));
            excel.add(new ExcelBean("工序","Workprocedure",0));
            excel.add(new ExcelBean("交货期","OrderTime",0));
            excel.add(new ExcelBean("事业部","Plant",0));
            map.put(0, excel);
            String sheetName = "数据查询";
            try {
                xssfWorkbook = ExcelUtil.createExcelFile(PTOrderPlan.class,list, map, sheetName);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (IntrospectionException e) {
                e.printStackTrace();
            } catch (ParseException e) {
                e.printStackTrace();
            }
            return xssfWorkbook;

        }
        return xssfWorkbook;
    }

    @Override
    public HSSFWorkbook exportExce2(String plant, String uyear, String umouth, String fname, String WorkProcedure, String Fno, String PartDrawing, String PartName, String state) {
        HSSFWorkbook xssfWorkbook=null;
        if(Integer.parseInt(state)==3){
            PTPlan ptPlan = new PTPlan();
            ptPlan.setUyear(Integer.parseInt(uyear));
            ptPlan.setUmouth(Integer.parseInt(umouth));
            ptPlan.setPlant(plant);
            ptPlan.setFname(fname.trim());
            ptPlan.setFno(Fno.trim());
            ptPlan.setPartName(PartName);
            ptPlan.setWorkProcedure(WorkProcedure.trim());
            ptPlan.setPartDrawing(PartDrawing.trim());
            DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
            List<PTPlan> list = monthPlanMapper.selectByAllKey(ptPlan);
            DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
            List<ExcelBean> excel=new ArrayList<>();
            Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
            //设置标题栏
            excel.add(new ExcelBean("工序名称","WorkProcedure",0));
            excel.add(new ExcelBean("零件规格","PartDrawing",0));
            excel.add(new ExcelBean("零件名称","PartName",0));
            excel.add(new ExcelBean("零件编码","Fno",0));
            excel.add(new ExcelBean("零件描述","Fname",0));
            excel.add(new ExcelBean("打印标记","WorkCentre",0));
            excel.add(new ExcelBean("总计划数","MastPlanNum",0));
            excel.add(new ExcelBean("上月计划","LastRemainNum",0));
            excel.add(new ExcelBean("大计划数","PlanNum",0));
            excel.add(new ExcelBean("临时计划","PatchPlan",0));
            excel.add(new ExcelBean("本日产出","OutputNum",0));
            excel.add(new ExcelBean("累计产出","AccOutputNum",0));
            excel.add(new ExcelBean("剩余计划","RemainNum",0));
            excel.add(new ExcelBean("交货期","OrderTime",0));
            excel.add(new ExcelBean("导入人","InputMan",0));
            excel.add(new ExcelBean("导入时间","InputDate",0));
            excel.add(new ExcelBean("部门","DepartMent",0));
            excel.add(new ExcelBean("事业部","Plant",0));
            excel.add(new ExcelBean("工艺文档","CraftFile",0));
            excel.add(new ExcelBean("产能","Capacity",0));
            excel.add(new ExcelBean("检验标准","ChkStd",0));
            excel.add(new ExcelBean("合同","OrderPlan",0));

            map.put(0, excel);
            String sheetName = "数据查询";
            try {
                xssfWorkbook = ExcelUtil.createExcelFile(PTPlan.class,list, map, sheetName);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (IntrospectionException e) {
                e.printStackTrace();
            } catch (ParseException e) {
                e.printStackTrace();
            }
            return xssfWorkbook;

        }
        return xssfWorkbook;
    }

    @Override
    public List<PTOrderPlan> selectByfno(PTOrderPlan record) {
        return monthPlanMapper.selectByfno(record);
    }

    @Override
    public int updateALLfinish(PTOrderPlan record) {
        return monthPlanMapper.updateALLfinish(record);
    }

    @Override
    public List<PTOrderPlan> selectByid(PTOrderPlan record) {
        return monthPlanMapper.selectByid(record);
    }

    @Override
    public  int updateFinsh(PTOrderPlan record){
        return  monthPlanMapper.updateFinsh(record);
    }

    @Override
    public int deleteid(PTOrderPlan record) {
        return monthPlanMapper.deleteid(record);
    }

    @Override
    public List<BaseCapacity> getFtemp2(BaseCapacity record) {
        return monthPlanMapper.getFtemp2(record);
    }
    @Override
    public List<BaseCapacity> getCapacity(BaseCapacity record) {
        return monthPlanMapper.getCapacity(record);
    }

    @Override
    public List<CraftFile> getCraftFile(CraftFile record) {
        return monthPlanMapper.getCraftFile(record);
    }
    @Override
    public List<BaseChkStd> getBaseChkStd(BaseChkStd record) {
        return monthPlanMapper.getBaseChkStd(record);
    }

    @Override
    public List<PTOrderPlan> selectByFno1(PTOrderPlan record) {
        return monthPlanMapper.selectByFno1(record);
    }

    @Override
    public int deleteid1(PTPlan record) {
        return monthPlanMapper.deleteid1(record);
    }
    @Override
    public int updatePlan(PTPlan record) {
        return monthPlanMapper.updatePlan(record);
    }
}
