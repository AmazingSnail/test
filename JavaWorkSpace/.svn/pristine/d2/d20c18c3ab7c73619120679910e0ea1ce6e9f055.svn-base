package com.dhchain.business.HeatTreatment.service.impl;

import com.dhchain.business.HeatTreatment.dao.PMissionIssuedMapper;
import com.dhchain.business.HeatTreatment.service.PMissionIssuedService;
import com.dhchain.business.HeatTreatment.vo.MPtheatplan;
import com.dhchain.business.HeatTreatment.vo.MPtheatprint;
import com.dhchain.business.HeatTreatment.vo.MPtheattake;
import com.dhchain.config.vo.ExcelBean;
import com.dhchain.config.vo.ExcelUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ASUS on 2018/7/5.
 */
@Service("PMissionIssuedService")
public class PMissionIssuedServiceImpl extends BaseService<MPtheattake> implements PMissionIssuedService {
    @Autowired
    private PMissionIssuedMapper pMissionIssuedMapper;
    @Autowired
    private PMissionIssuedService pMissionIssuedService;
    @Override
    public List<MPtheattake> getPlanid(MPtheattake record) {
        return pMissionIssuedMapper.getPlanid(record);
    }

    @Override
    public List<MPtheatprint> getPrint(MPtheatprint record) {
        return pMissionIssuedMapper.getPrint(record);
    }

    @Override
    public HSSFWorkbook exportExce(String umouth, String uyear, String plant, String Status, String EquipID, String fno, String fname) {
        HSSFWorkbook xssfWorkbook=null;
        Example example = new Example(MPtheattake.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(uyear)) {
            criteria.andEqualTo("uyear",uyear.trim());
        }
        if (StringUtil.isNotEmpty(plant)) {
            criteria.andEqualTo("plant",plant.trim());
        }
        if (StringUtil.isNotEmpty(umouth)) {
            criteria.andEqualTo("umouth",umouth.trim());
        }
        if (StringUtil.isNotEmpty(Status)) {
            criteria.andEqualTo("status",Status.trim());
        }
        if (StringUtil.isNotEmpty(EquipID)) {
            criteria.andEqualTo("equipid",EquipID.trim());
        }
        if (StringUtil.isNotEmpty(fno)) {
            criteria.andLike("fno","%" +fno.trim()+"%");
        }
        if (StringUtil.isNotEmpty(fname)) {
            criteria.andLike("fname","%" +fname.trim()+"%");
        }
        List<MPtheattake> list = pMissionIssuedService.selectByExample(example);
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        //设置标题栏
        excel.add(new ExcelBean("计划编号","planid",0));
        excel.add(new ExcelBean("物料描述","fname",0));
        excel.add(new ExcelBean("设备编号","equipid",0));
        excel.add(new ExcelBean("冲制工","productman",0));
        excel.add(new ExcelBean("下达数量","productnum",0));
        excel.add(new ExcelBean("物料编码","fno",0));
        excel.add(new ExcelBean("下达人","inputman",0));
        excel.add(new ExcelBean("下达时间","inputdate",0));
        excel.add(new ExcelBean("生产状态","status",0));
        excel.add(new ExcelBean("计划开始时间","begintime",0));
        excel.add(new ExcelBean("计划结束时间","endtime",0));
        excel.add(new ExcelBean("年度","uyear",0));
        excel.add(new ExcelBean("月度","umouth",0));
        map.put(0, excel);
        String sheetName = "数据查询";
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(MPtheattake.class,list, map, sheetName);
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

    @Override
    public List<MPtheattake> GetEquip(MPtheattake rrecord) {
        return pMissionIssuedMapper.GetEquip(rrecord);
    }
}
