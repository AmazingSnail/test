package com.dhchain.business.Tractor.service.Impl;

import com.dhchain.business.Tractor.service.TractorService;
import com.dhchain.business.Tractor.vo.TCerttractor;
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

@Service("TractorService")
public class TractorServiceImpl extends BaseService<TCerttractor> implements TractorService {
    @Autowired
    private TractorService tractorService;
    @Override
    public HSSFWorkbook exportExcel(String ProductID, String serialID, String OrderID, String WERKS, String starttime, String endtime) {
        HSSFWorkbook xssfWorkbook=null;
        TCerttractor tCerttractor = new TCerttractor();
        Example example = new Example(TCerttractor.class);
        Example.Criteria criteria = example.createCriteria();
        String startime1 = starttime + " 00:00:00";
        String endtime1 = endtime + " 23:59:59";
        criteria.andGreaterThanOrEqualTo("inspectiondate",startime1);
        criteria.andLessThanOrEqualTo("inspectiondate",endtime1);
        if (StringUtil.isNotEmpty(ProductID)) {
            criteria.andLike("productid","%" +ProductID.trim()+"%");
        }
        if(StringUtil.isNotEmpty(serialID)){
            criteria.andLike("serialid","%" +serialID.trim()+"%");
        }
        if(StringUtil.isNotEmpty(OrderID)){
            criteria.andLike("orderid","%" + OrderID.trim()+"%");
        }
        if (StringUtil.isNotEmpty(WERKS) ) {
            criteria.andEqualTo("plant",WERKS);
        }
        List<TCerttractor> list = tractorService.selectByExample(example);
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        //设置标题栏
        excel.add(new ExcelBean("工厂","plant",0));
        excel.add(new ExcelBean("工厂描述","plantins",0));
        excel.add(new ExcelBean("订单号","orderid",0));
        excel.add(new ExcelBean("序列号","serialid",0));
        excel.add(new ExcelBean("检验日期","inspectiondate",0));
        excel.add(new ExcelBean("产品料号","productid",0));
        excel.add(new ExcelBean("合格证编号","certid",0));
        excel.add(new ExcelBean("发证日期","certdate",0));
        excel.add(new ExcelBean("生产企业名称","companyname",0));
        excel.add(new ExcelBean("品牌","brand",0));
        excel.add(new ExcelBean("类型","type",0));
        excel.add(new ExcelBean("型号名称","zcpxh",0));
        excel.add(new ExcelBean("发动机型号","zchyj",0));
        excel.add(new ExcelBean("发动机号码","zfdjh",0));
        excel.add(new ExcelBean("厂内机型","zmach",0));
        excel.add(new ExcelBean("功率/kW","power",0));
        excel.add(new ExcelBean("排放标准号及排放阶段","emissionstd",0));
        excel.add(new ExcelBean("出厂编号","factoryid",0));
        excel.add(new ExcelBean("底盘号","zseri",0));
        excel.add(new ExcelBean("机身颜色","bodycolor",0));
        excel.add(new ExcelBean("转向操纵方式","controlmode",0));
        excel.add(new ExcelBean("准乘人数","number",0));
        excel.add(new ExcelBean("轮轴数","axlenum",0));
        excel.add(new ExcelBean("轴距/mm","wheelbase",0));
        excel.add(new ExcelBean("轮胎数","tiresnum",0));
        excel.add(new ExcelBean("轮胎规格","tirespect",0));
        excel.add(new ExcelBean("轮距（前/后）/mm","wheelsize",0));
        excel.add(new ExcelBean("履带数","tracknumber",0));
        excel.add(new ExcelBean("履带规格","tracktype",0));
        excel.add(new ExcelBean("轨距/mm","gauge",0));
        excel.add(new ExcelBean("外廓尺寸/mm","outlinesize",0));
        excel.add(new ExcelBean("标定牵引力/n","demarcatedforce",0));
        excel.add(new ExcelBean("最小使用质量/kg","minuse",0));
        excel.add(new ExcelBean("最大允许载质量/kg","maxload",0));
        excel.add(new ExcelBean("生产日期","manufacturedate",0));
        excel.add(new ExcelBean("执行标准/企标","execstd",0));
        excel.add(new ExcelBean("检验日期","checkdate",0));
        map.put(0, excel);
        String sheetName = "数据查询";
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(TCerttractor.class,list, map, sheetName);
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
