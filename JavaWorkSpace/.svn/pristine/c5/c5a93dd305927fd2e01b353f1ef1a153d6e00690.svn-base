package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.dao.ProductionTaskMapper;
import com.dhchain.business.partpunchingworkshop.service.ProductionTaskService;
import com.dhchain.business.partpunchingworkshop.vo.*;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import com.dhchain.config.vo.ExcelBean;
import com.dhchain.config.vo.ExcelUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.util.*;

@Service("ProductionTaskService")
public class ProductionTaskServiceImpl implements ProductionTaskService {
    @Autowired
     private ProductionTaskMapper productionTaskMapper;
    @Override
    public List<PTProdTake> select(PTProdTake record) {
        return productionTaskMapper.select(record);
    }

    @Override
    public List<PTMaterial> getMaterial(PTMaterial record) {
        return productionTaskMapper.getMaterial(record);
    }

    @Override
    public List<PTFinish> getFinish(PTFinish record) {
        return productionTaskMapper.getFinish(record);
    }

    @Override
    public List<PTFinish> selectbyfno(PTFinish record) {
        return productionTaskMapper.selectbyfno(record);
    }

    @Override
    public List<ColdDailyPlan> selectbyid(ColdDailyPlan record) {
        return productionTaskMapper.selectbyid(record);
    }

    @Override
    public int updatebyplanid(PTProdTake record) {
        return productionTaskMapper.updatebyplanid(record);
    }
    @Override
    public int updatebyplanid1(PTProdTake record) {
        return productionTaskMapper.updatebyplanid1(record);
    }

    @Override
    public HSSFWorkbook exportExce(String umouth, String uyear, String plant, String MouldID, String PartDrawing, String ptmStatus, String state) {
        HSSFWorkbook xssfWorkbook=null;
        PTProdTake ptProdTake = new PTProdTake();
        ptProdTake.setMouldID(MouldID.trim());
        ptProdTake.setPartDrawing(PartDrawing.trim());
        ptProdTake.setPlant(plant);
        ptProdTake.setUyear(uyear);
        ptProdTake.setUmouth(umouth);
        ptProdTake.setStatus(ptmStatus.trim());
        String state1 = state;

        if(state1!=null){
            if(Integer.parseInt(state1)==2){
                ptProdTake.setLocaFinish(true);
            }else if(Integer.parseInt(state1)==1) {
                ptProdTake.setIsFinish(true);
            }
        }
        Map json = new HashMap();
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<PTProdTake> list = productionTaskMapper.select(ptProdTake);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        //设置标题栏
        excel.add(new ExcelBean("计划编号","PlanID",0));
        excel.add(new ExcelBean("零件规格","PartDrawing",0));
        excel.add(new ExcelBean("零件编码","Fno",0));
        excel.add(new ExcelBean("零件描述","Fname",0));
        excel.add(new ExcelBean("设备编号","EquipID",0));
        excel.add(new ExcelBean("模具编号","MouldID",0));
        excel.add(new ExcelBean("冲制工","ProductMan",0));
        excel.add(new ExcelBean("下达数量","ProductNum",0));
        excel.add(new ExcelBean("完成数量","FinishNum",0));
        excel.add(new ExcelBean("实际完成","RealFinishNum",0));
        excel.add(new ExcelBean("交付时间","OrderTime",0));
        excel.add(new ExcelBean("生产状态","Status",0));
        excel.add(new ExcelBean("现场完成确认","LocaFinish",0));
        excel.add(new ExcelBean("班长完成确认","IsFinish",0));
        excel.add(new ExcelBean("计划开始","BeginTime",0));
        excel.add(new ExcelBean("计划结束","EndTime",0));
        excel.add(new ExcelBean("检验合格率","QualRatio",0));
        excel.add(new ExcelBean("计划达成率","CompRatio",0));
        excel.add(new ExcelBean("年度","Uyear",0));
        excel.add(new ExcelBean("月度","Umouth",0));
        map.put(0, excel);
        String sheetName = "数据查询";
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(PTProdTake.class,list, map, sheetName);
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
}
