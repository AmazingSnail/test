package com.dhchain.business.colddigitalworkshop.service.impl;

import com.dhchain.business.colddigitalworkshop.dao.MaterialtakeinMapper;
import com.dhchain.business.colddigitalworkshop.service.MaterialtakeinService;
import com.dhchain.business.colddigitalworkshop.vo.Base;
import com.dhchain.business.colddigitalworkshop.vo.ColdMaterialIn;
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

@Service("MaterialtakeinService")
public class MaterialtakeinServiceImpl implements MaterialtakeinService {
    @Autowired
    private MaterialtakeinMapper materialtakeinMapper;
    @Override
    public List<ColdMaterialIn> selectColdmaterlin(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.selectColdmaterlin(coldmaterialin);
    }

    @Override
    public List<ColdMaterialIn> selectColdmaterlinSap(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.selectColdmaterlinSap(coldmaterialin);
    }

    @Override
    public List<ColdMaterialIn> selectColdmaterlinNeed(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.selectColdmaterlinNeed(coldmaterialin);
    }

    @Override
    public String getPlantIn(String plant) {
        Base base = new Base();
        List<Base> list= materialtakeinMapper.getPlantIn(plant);
        base.setFno("");
        if (list.size()>0){
            base = list.get(0);
        }
        return base.getFno();
    }

    @Override
    public String getLGORTIn(String plant,String UserName) {
        Base Rbase = new Base();
        List<Base> list= materialtakeinMapper.getLGORTIn(plant,UserName);
        Rbase.setFremark("");
        if (list.size()>0){
            Rbase = list.get(0);
        }
        return Rbase.getFremark();
    }

    @Override
    public int insertColdmsg(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.insertColdmsg(coldmaterialin);
    }

    @Override
    public List<ColdMaterialIn> getSeId(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.getSeId(coldmaterialin);
    }

    @Override
    public int deletecoldmsg(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.deletecoldmsg(coldmaterialin);
    }

    @Override
    public int updatecoldmsg(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.updatecoldmsg(coldmaterialin);
    }

    @Override
    public int updatecoldmsgFXZ(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.updatecoldmsgFXZ(coldmaterialin);
    }

    @Override
    public int updatecoldmsgBack(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.updatecoldmsgBack(coldmaterialin);
    }

    @Override
    public int insertPoAgainstRecord(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.insertPoAgainstRecord(coldmaterialin);
    }

    @Override
    public int updateCutting(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.updateCutting(coldmaterialin);
    }

    @Override
    public int updateUsed(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.updateUsed(coldmaterialin);
    }

    @Override
    public int updateColdTakenFail(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.updateColdTakenFail(coldmaterialin);
    }

    @Override
    public int updateColdTakenBack(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.updateColdTakenBack(coldmaterialin);
    }

    @Override
    public int updateColdTakenInSap(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.updateColdTakenInSap(coldmaterialin);
    }

    @Override
    public int insertColdSapMess(HaginstRecord haginstRecord) {
        return materialtakeinMapper.insertColdSapMess(haginstRecord);
    }

    @Override
    public int insertColdSapMessBack(HaginstRecord haginstRecord) {
        return materialtakeinMapper.insertColdSapMessBack(haginstRecord);
    }

    @Override
    public int updateUsedforDailyplanBack(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.updateUsedforDailyplanBack(coldmaterialin);
    }

    @Override
    public List<ColdMaterialIn> selectcoldMsgById(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.selectcoldMsgById(coldmaterialin);
    }

    @Override
    public List<ColdMaterialIn> selectColdmaterlinBydate(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.selectColdmaterlinBydate(coldmaterialin);
    }

    @Override
    public List<ColdMaterialIn> selectcoldmaoliaolocation(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.selectcoldmaoliaolocation(coldmaterialin);
    }

    @Override
    public List<ColdMaterialIn> selectcoldCutByReelnum(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.selectcoldCutByReelnum(coldmaterialin);
    }

    @Override
    public List<ColdMaterialIn> selectcoldMsgByBatchno(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.selectcoldMsgByBatchno(coldmaterialin);
    }

    @Override
    public HSSFWorkbook In_exportExcelInfo(ColdMaterialIn record) {
        //根据条件查询数据，把数据装载到一个list中
        List<ColdMaterialIn> list = materialtakeinMapper.selectColdmaterlinBydate(record);
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        HSSFWorkbook xssfWorkbook=null;
        //设置标题栏
        excel.add(new ExcelBean("序号","id",0));
        excel.add(new ExcelBean("编号","serialno",0));
        excel.add(new ExcelBean("采购订单号","pono",0));
        excel.add(new ExcelBean("采购订单行项目","poitem",0));
        excel.add(new ExcelBean("物料编码","fno",0));
        excel.add(new ExcelBean("物料描述","fname",0));
        excel.add(new ExcelBean("收货数量","number",0));
        excel.add(new ExcelBean("订单数量","ponumber",0));
        excel.add(new ExcelBean("已收数量","takenumber",0));
        excel.add(new ExcelBean("剩余数量","leftnumber",0));
        excel.add(new ExcelBean("确认收货","isok",0));
        excel.add(new ExcelBean("收货地点","lgort",0));
        excel.add(new ExcelBean("单位","unit",0));
        excel.add(new ExcelBean("录入人","inputman",0));
        excel.add(new ExcelBean("录入时间","inputdate",0));
        excel.add(new ExcelBean("SAP移库","ismove",0));
        excel.add(new ExcelBean("SAP移库人","moveman",0));
        excel.add(new ExcelBean("SAP移库时间","movedate",0));
        excel.add(new ExcelBean("事业部","plant",0));
        excel.add(new ExcelBean("过量限度","uplimit",0));
        excel.add(new ExcelBean("不足限度","downlimit",0));
        excel.add(new ExcelBean("收货完成","isdone",0));
        excel.add(new ExcelBean("年度","uyear",0));
        excel.add(new ExcelBean("月度","umonth",0));
        excel.add(new ExcelBean("供应商编码","supportno",0));
        excel.add(new ExcelBean("供应商名称","supportname",0));
        excel.add(new ExcelBean("采购组织","ekorg",0));
        excel.add(new ExcelBean("采购组织描述","ekorgname",0));
        excel.add(new ExcelBean("采购组","ekgrp",0));
        excel.add(new ExcelBean("采购组描述","ekgrpname",0));
        excel.add(new ExcelBean("采购订单创建时间","pocreattime",0));
        excel.add(new ExcelBean("公司代码","bukrs",0));
        excel.add(new ExcelBean("移库失败","moveok",0));
        excel.add(new ExcelBean("退货失败","returnok",0));
        excel.add(new ExcelBean("库存状态","stocktype",0));
        excel.add(new ExcelBean("物料凭证","materialdoc",0));
        excel.add(new ExcelBean("凭证年度","materialdocyear",0));
        excel.add(new ExcelBean("凭证行","materialdocitem",0));
        excel.add(new ExcelBean("炉批号","batchno",0));
        excel.add(new ExcelBean("质检至非限制","istrans",0));
        excel.add(new ExcelBean("质检转换人","transman",0));
        excel.add(new ExcelBean("质检转换时间","transdate",0));
        excel.add(new ExcelBean("估价标示","moneystate",0));
        excel.add(new ExcelBean("净价","netpr",0));
        excel.add(new ExcelBean("价格单位","peinh",0));
        excel.add(new ExcelBean("价格总和","zsum",0));
        excel.add(new ExcelBean("库位","location",0));
        map.put(0, excel);
        String sheetName = "接收明细报表";
        //调用ExcelUtil的方法
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(ColdMaterialIn.class, list, map, sheetName);
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
    public Double selectColdmaterlinLeaveNumber(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.selectColdmaterlinLeaveNumber(coldmaterialin);
    }

    @Override
    public Double selectColdmaterlinInNumber(ColdMaterialIn coldmaterialin) {
        return materialtakeinMapper.selectColdmaterlinInNumber(coldmaterialin);
    }

}
