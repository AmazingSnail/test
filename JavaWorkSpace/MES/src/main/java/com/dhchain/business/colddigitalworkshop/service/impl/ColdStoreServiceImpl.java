package com.dhchain.business.colddigitalworkshop.service.impl;

import com.dhchain.business.colddigitalworkshop.dao.ColdStoreMapper;
import com.dhchain.business.colddigitalworkshop.service.ColdStoreService;
import com.dhchain.business.colddigitalworkshop.vo.*;
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

@Service("ColdStoreService")
public class ColdStoreServiceImpl implements ColdStoreService{
    @Autowired
    private ColdStoreMapper coldStoreMapper;
    @Override
    public int deleteByPrimaryKey(ColdStoreKey key) {
        return coldStoreMapper.deleteByPrimaryKey(key);
    }

    @Override
    public int insert(ColdStore record) {
        return coldStoreMapper.insert(record);
    }

    @Override
    public int insertSelective(ColdStore record) {
        return coldStoreMapper.insertSelective(record);
    }

    @Override
    public ColdStore selectByPrimaryKey(ColdStoreKey key) {
        return coldStoreMapper.selectByPrimaryKey(key);
    }

    @Override
    public int updateByPrimaryKeySelective(ColdStore record) {
        return coldStoreMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(ColdStore record) {
        return coldStoreMapper.updateByPrimaryKey(record);
    }

    @Override
    public int updateColdStoreIn(ColdMaterialIn record) {
        return coldStoreMapper.updateColdStoreIn(record);
    }

    @Override
    public int updateColdStoreOut(ColdOut record) {
        return coldStoreMapper.updateColdStoreOut(record);
    }

    @Override
    public int updateColdStoreOutBack(ColdOut record) {
        return coldStoreMapper.updateColdStoreOutBack(record);
    }

    @Override
    public int updateColdStoreBack(ColdMaterialIn record) {
        return coldStoreMapper.updateColdStoreBack(record);
    }

    @Override
    public List<ColdStore> selectColdStore(ColdStoreKey record) {
        return coldStoreMapper.selectColdStore(record);
    }

    @Override
    public List<ColdStore> selectColdStoreList(ColdStore record) {
        return coldStoreMapper.selectColdStoreList(record);
    }

    @Override
    public List<ColdLocationStore> selectColdStoreLocationExport(ColdStore record) {
        return coldStoreMapper.selectColdStoreLocationExport(record);
    }

    @Override
    public List<ColdLocationStore> selectColdStoreLocation(ColdLocationStore record) {
        return coldStoreMapper.selectColdStoreLocation(record);
    }
    @Override
    public HSSFWorkbook Y_exportExcelInfo(ColdLocationStore coldLocationStore) {
        //根据条件查询数据，把数据装载到一个list中
        ColdStore coldStore = new ColdStore();
        coldStore.setState(1);
        List<ColdLocationStore> list = coldStoreMapper.selectColdStoreLocationExport(coldStore);
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        HSSFWorkbook xssfWorkbook=null;
        //设置标题栏
        excel.add(new ExcelBean("物料编码","fno",0));
        excel.add(new ExcelBean("库位库存","leavenumber",0));
        excel.add(new ExcelBean("库位","location",0));
        excel.add(new ExcelBean("事业部","plant",0));
        excel.add(new ExcelBean("物料描述","fname",0));
        excel.add(new ExcelBean("总库存","sapstore",0));
        map.put(0, excel);
        String sheetName = "原材料库存报表";
        //调用ExcelUtil的方法
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(ColdLocationStore.class, list, map, sheetName);
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
    public HSSFWorkbook C_exportExcelInfo(ColdLocationStore coldLocationStore) {
        //根据条件查询数据，把数据装载到一个list中
        ColdStore coldStore = new ColdStore();
        coldStore.setState(2);
//        ColdLocationStore coldLocationStore= new ColdLocationStore();
        List<ColdLocationStore> list = coldStoreMapper.selectColdStoreLocationExport(coldStore);
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        HSSFWorkbook xssfWorkbook=null;
        //设置标题栏
        excel.add(new ExcelBean("物料编码","fno",0));
        excel.add(new ExcelBean("库位库存","leavenumber",0));
        excel.add(new ExcelBean("库位","location",0));
        excel.add(new ExcelBean("事业部","plant",0));
        excel.add(new ExcelBean("物料描述","fname",0));
        excel.add(new ExcelBean("总库存","sapstore",0));
        map.put(0, excel);
        String sheetName = "成品库存报表";
        //调用ExcelUtil的方法
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(ColdLocationStore.class, list, map, sheetName);
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
