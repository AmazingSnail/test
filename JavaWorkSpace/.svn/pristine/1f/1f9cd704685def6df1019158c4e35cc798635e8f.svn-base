package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.mapper.BaseDataMapper;
import com.dhchain.business.partpunchingworkshop.service.BasicDataService;
import com.dhchain.business.partpunchingworkshop.vo.MaterialCoding;
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

@Service("BasicDataService")
public class BasicDataServiceImpl extends BaseService<MaterialCoding> implements BasicDataService {
    @Autowired
    private BaseDataMapper baseDataMapper;

    @Override
    public List<MaterialCoding> selectSame1(MaterialCoding record) {
        return baseDataMapper.selectSame1(record);
    }

    @Override
    public List<MaterialCoding> getJudge() {
        return baseDataMapper.getJudge();
    }

    @Override
    public HSSFWorkbook exportExce(String maktx, String matnr) {
        HSSFWorkbook xssfWorkbook = null;
        MaterialCoding materialCoding = new MaterialCoding();
        materialCoding.setMaktx(maktx);
        materialCoding.setMatnr(matnr);
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<MaterialCoding> list = baseDataMapper.selectSame1(materialCoding);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        List<ExcelBean> excel = new ArrayList<>();
        Map<Integer, List<ExcelBean>> map = new LinkedHashMap<>();
        //设置标题栏
        excel.add(new ExcelBean("物料编码", "matnr", 0));
        excel.add(new ExcelBean("物料描述", "maktx", 0));
        excel.add(new ExcelBean("标记描述", "zbjnrx", 0));
        excel.add(new ExcelBean("节数", "f3", 0));
        excel.add(new ExcelBean("基本单位", "basme", 0));
        excel.add(new ExcelBean("现库存结存", "mbwbest", 0));
        excel.add(new ExcelBean("节点工序", "f1", 0));
        excel.add(new ExcelBean("部件特征", "f2", 0));
        excel.add(new ExcelBean("套筒", "f4", 0));
        excel.add(new ExcelBean("表面处理", "f5", 0));
        excel.add(new ExcelBean("打印方式", "f6", 0));
        excel.add(new ExcelBean("LOGO标示程序号", "f7", 0));
        excel.add(new ExcelBean("打印比例", "f8", 0));
        excel.add(new ExcelBean("连接装配方式", "f9", 0));
        excel.add(new ExcelBean("铆头方式", "f10", 0));
        excel.add(new ExcelBean("部件特征二", "f11", 0));
        excel.add(new ExcelBean("指定供应商", "f12", 0));
        map.put(0, excel);
        String sheetName = "数据查询";
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(MaterialCoding.class, list, map, sheetName);
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
    public List<MaterialCoding> getF2() {
        return baseDataMapper.getF2();
    }
    @Override
    public List<MaterialCoding> getF4() {
        return baseDataMapper.getF4();
    }
    @Override
    public List<MaterialCoding> getF5() {
        return baseDataMapper.getF5();
    }

    @Override
    public List<MaterialCoding> getF6() {
        return baseDataMapper.getF6();
    }

    @Override
    public List<MaterialCoding> getF9() {
        return baseDataMapper.getF9();
    }

    @Override
    public List<MaterialCoding> getF10() {
        return baseDataMapper.getF10();
    }

    @Override
    public List<MaterialCoding> getF11() {
        return baseDataMapper.getF11();
    }
}

