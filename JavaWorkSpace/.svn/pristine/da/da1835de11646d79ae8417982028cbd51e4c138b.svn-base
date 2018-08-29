package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.dao.ElementDetailMapper;
import com.dhchain.business.partpunchingworkshop.service.ElementDetailService;
import com.dhchain.business.partpunchingworkshop.vo.ColdDailyPlan;
import com.dhchain.business.partpunchingworkshop.vo.PTFinish;
import com.dhchain.business.partpunchingworkshop.vo.PTPlan;
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
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service("ElementDetailService")
public class ElementDetailServiceImpl implements ElementDetailService{
@Autowired
private ElementDetailMapper elementDetailMapper;

    @Override
    public int updatenum(PTFinish record) {
        return elementDetailMapper.updatenum(record);
    }

    @Override
    public List<PTFinish> selectbyall(PTFinish record) {
        return elementDetailMapper.selectbyall(record);
    }

    @Override
    public List<PTFinish> selectbycoldid(PTFinish record) {
        return elementDetailMapper.selectbycoldid(record);
    }

    @Override
    public List<ColdDailyPlan> selectByReelnum(ColdDailyPlan record) {
        return elementDetailMapper.selectByReelnum(record);
    }

    @Override
    public HSSFWorkbook exportExcel(String plant, String uyear, String umouth, String planID, String fno, String reelnum, String equipID, String partDrawing, String productMan, String starttime, String endtime, String state) {
        HSSFWorkbook xssfWorkbook=null;
        PTFinish ptFinish = new PTFinish();
        ptFinish.setPlant(plant);
        String starttime1 = starttime + " 00:00:00";
        ptFinish.setProductTime(starttime1);
        String endtime1 = endtime +" 23:59:59";
        ptFinish.setProductTime1(endtime1);
        ptFinish.setEquipID(equipID);
        ptFinish.setPlanID(planID);
        ptFinish.setFno(fno);
        ptFinish.setReelnum(reelnum);
        ptFinish.setPartDrawing(partDrawing.replaceAll(" ", ""));
        ptFinish.setProductMan(productMan.replaceAll(" ", ""));
        ptFinish.setUmouth(Integer.parseInt(umouth));
        ptFinish.setUyear(Integer.parseInt(uyear));
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<PTFinish> list2 = elementDetailMapper.selectbyall(ptFinish);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        List<PTFinish> list = new ArrayList();
        if(list2.size()>0){
            if (Integer.parseInt(state) == 3) {
                for (int i = 0; i < list2.size(); i++) {
                    PTFinish ptFinish1;
                    ptFinish1 = list2.get(i);
                    list.add(ptFinish1);
                }
            } else if (Integer.parseInt(state) == 2) {
                for (int i = 0; i < list2.size(); i++) {
                    PTFinish ptFinish1;
                    ptFinish1 = list2.get(i);
                    if (!(ptFinish1.getWeightNum() != null)) {
                        list.add(ptFinish1);
                    }
                }
            } else {
                for (int i = 0; i < list2.size(); i++) {
                    PTFinish ptFinish1;
                    ptFinish1 = list2.get(i);
                    if (ptFinish1.getWeightNum() != null) {
                        list.add(ptFinish1);
                    }
                }
            }
        }

        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        //设置标题栏
        excel.add(new ExcelBean("计划编号","PlanID",0));
        excel.add(new ExcelBean("开卡编号","serialno",0));
        excel.add(new ExcelBean("规格","PartDrawing",0));
        excel.add(new ExcelBean("零件编码","Fno",0));
        excel.add(new ExcelBean("零件描述","Fname",0));
        excel.add(new ExcelBean("设备编号","EquipID",0));
        excel.add(new ExcelBean("原料编码","fatherfno",0));
        excel.add(new ExcelBean("原料描述","fatherfname",0));
        excel.add(new ExcelBean("炉批号","Reelnum",0));
        excel.add(new ExcelBean("冲制工","ProductMan",0));
        excel.add(new ExcelBean("冲制时间","ProductTime",0));
        excel.add(new ExcelBean("重量","WeightNum",0));
        excel.add(new ExcelBean("称重人","WeighMan",0));
        excel.add(new ExcelBean("称重时间","WeighTime",0));
        excel.add(new ExcelBean("年度","Uyear",0));
        excel.add(new ExcelBean("月度","Umouth",0));
        excel.add(new ExcelBean("事业部","Plant",0));

        map.put(0, excel);
        String sheetName = "数据查询";
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(PTFinish.class,list, map, sheetName);
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
