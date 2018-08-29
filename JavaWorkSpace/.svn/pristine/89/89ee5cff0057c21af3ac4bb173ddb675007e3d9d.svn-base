package com.dhchain.business.colddigitalworkshop.service.impl;

import com.dhchain.business.colddigitalworkshop.dao.ColdOutMapper;
import com.dhchain.business.colddigitalworkshop.service.ColdOutService;
import com.dhchain.business.colddigitalworkshop.vo.ColdOut;
import com.dhchain.business.colddigitalworkshop.vo.HaginstRecord;
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

@Service("ColdOutService")
public class ColdOutServiceImpl implements ColdOutService {
    @Autowired
    private ColdOutMapper coldOutMapper;
    @Override
    public int deleteByPrimaryKey(Integer id) {
        return coldOutMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(ColdOut record) {
        return coldOutMapper.insert(record);
    }

    @Override
    public int insertSelective(ColdOut record) {
        return coldOutMapper.insertSelective(record);
    }

    @Override
    public ColdOut selectByPrimaryKey(Integer id) {
        return coldOutMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ColdOut record) {
        return coldOutMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(ColdOut record) {
        return coldOutMapper.updateByPrimaryKey(record);
    }

    @Override
    public int insertSapOutMess(HaginstRecord haginstRecord) {
        return coldOutMapper.insertSapOutMess(haginstRecord);
    }

    @Override
    public int insertSapMessOutBack(HaginstRecord haginstRecord) {
        return coldOutMapper.insertSapMessOutBack(haginstRecord);
    }

    @Override
    public List<ColdOut> selectColdOutToday(ColdOut record) {
        return coldOutMapper.selectColdOutToday(record);
    }

    @Override
    public List<ColdOut> getSeId(ColdOut record) {
        return coldOutMapper.getSeId(record);
    }

    @Override
    public List<ColdOut> selectColdOutBydate(ColdOut record) {
        return coldOutMapper.selectColdOutBydate(record);
    }

    @Override
    public HSSFWorkbook Out_exportExcelInfo(ColdOut record) {
        //根据条件查询数据，把数据装载到一个list中
        List<ColdOut> list = coldOutMapper.selectColdOutBydate(record);
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        HSSFWorkbook xssfWorkbook=null;
        //设置标题栏
        excel.add(new ExcelBean("序号","id",0));
        excel.add(new ExcelBean("编号","serialno",0));
        excel.add(new ExcelBean("物料编码","fno",0));
        excel.add(new ExcelBean("物料描述","fname",0));
        excel.add(new ExcelBean("出库数量","outnumber",0));
        excel.add(new ExcelBean("事业部","plant",0));
        excel.add(new ExcelBean("出库地点","outadd",0));
        excel.add(new ExcelBean("出库地点","outaddname",0));
        excel.add(new ExcelBean("出库人","outputman",0));
        excel.add(new ExcelBean("出库时间","outputdate",0));
        excel.add(new ExcelBean("SAP移库","ismove",0));
        excel.add(new ExcelBean("移库人","moveman",0));
        excel.add(new ExcelBean("移库时间","movedate",0));
        excel.add(new ExcelBean("年份","year",0));
        excel.add(new ExcelBean("月份","month",0));
        excel.add(new ExcelBean("移库成功","moveok",0));
        excel.add(new ExcelBean("移库冲销","moveback",0));
        excel.add(new ExcelBean("冲销人","movebackman",0));
        excel.add(new ExcelBean("冲销时间","movebackdate",0));
        excel.add(new ExcelBean("接收","istake",0));
        excel.add(new ExcelBean("接收人","takeman",0));
        excel.add(new ExcelBean("接收时间","takedate",0));
        excel.add(new ExcelBean("出库库位","location",0));
        excel.add(new ExcelBean("手机出库","isapp",0));
        excel.add(new ExcelBean("删除标识","isdelete",0));
        map.put(0, excel);
        String sheetName = "发出明细报表";
        //调用ExcelUtil的方法
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(ColdOut.class, list, map, sheetName);
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
