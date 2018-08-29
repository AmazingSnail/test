package com.dhchain.business.HeatTreatment.service.impl;

import com.dhchain.business.HeatTreatment.dao.PlanningManagementMapper;
import com.dhchain.business.HeatTreatment.service.PlanningManagementService;
import com.dhchain.business.HeatTreatment.vo.MPtheatplan;
import com.dhchain.business.HeatTreatment.vo.MaterialCoding;
import com.dhchain.business.partpunchingworkshop.vo.PTOrderPlan;
import com.dhchain.business.partpunchingworkshop.vo.PTPlan;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import com.dhchain.config.vo.ExcelBean;
import com.dhchain.config.vo.ExcelUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;

import java.beans.IntrospectionException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ASUS on 2018/7/5.
 */
@Service("PlanningManagementService")
public class PlanningManagementServiceImpl extends BaseService<MPtheatplan> implements PlanningManagementService {
    @Autowired
    private PlanningManagementMapper planningManagementMapper;
    @Override
    public List<MaterialCoding> getFno(MaterialCoding record) {
        return planningManagementMapper.getFno(record);
    }
    @Override
    public List<MaterialCoding> getInfo(MaterialCoding record) {
        return planningManagementMapper.getInfo(record);
    }
    @Override
    public List<MaterialCoding> getFno1(MaterialCoding record) {
        return planningManagementMapper.getFno1(record);
    }
    @Autowired
    private PlanningManagementService planningManagementService;
    @Override
    public String importExcelInfo(InputStream in, MultipartFile file, String time,String user) throws Exception {
        String OK = "";
        String NO = "";
        String Err = "";
        List list = new ArrayList<MPtheatplan>();
        int n =0;
        int A = 0;
        int B = 0;
        String insertInfoBatch = "";
        List<List<Object>> listob = ExcelUtil.getBankListByExcel(in, file.getOriginalFilename());
        //遍历listob数据，把数据放到List中
        for (int i = 1; i < listob.size(); i++) {
            List<Object> ob = listob.get(i);
            if(ob.get(0) != null&&ob.get(0) != ""){
                //切换数据库
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                MPtheatplan mPtheatplan = new MPtheatplan();
                mPtheatplan.setFno(String.valueOf(ob.get(0)));
                mPtheatplan.setPlant(String.valueOf(ob.get(1)));
                Example example = new Example(MPtheatplan.class);
                Example.Criteria criteria = example.createCriteria();
                if (StringUtil.isNotEmpty(String.valueOf(ob.get(0)))) {
                    criteria.andEqualTo("fno",String.valueOf(ob.get(0)));
                }
                List<MPtheatplan> list2 = planningManagementService.selectByExample(example);
                if(list2.size()>0){
                  break;
                }else {
                    MaterialCoding materialCoding =  new MaterialCoding();
                    materialCoding.setFno(String.valueOf(ob.get(0)));
                    DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
                    List<MaterialCoding> list3 = planningManagementService.getFno1(materialCoding);
                    DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
                    MaterialCoding materialCoding1 = list3.get(0);
                    MPtheatplan mPtheatplan1 = new MPtheatplan();
                    mPtheatplan.setDepartment("热处理车间");
                    mPtheatplan.setFname(materialCoding1.getFname());
                    mPtheatplan.setPartdrawing(materialCoding1.getFtemp2());
                    mPtheatplan.setPartname(materialCoding1.getFtemp3());
                    mPtheatplan.setMaterial(materialCoding1.getFtemp4());
                    mPtheatplan.setWorkcentre(materialCoding1.getWorkcentre2());
                    mPtheatplan.setFno(materialCoding1.getFno());
                    mPtheatplan.setProcessnode(materialCoding1.getF1());
                    mPtheatplan.setSurface(materialCoding1.getF5());
                    mPtheatplan.setPlant(String.valueOf(ob.get(1)));
                    mPtheatplan.setInputman(user);
                    mPtheatplan.setInputdate(time);
                    n = planningManagementService.InsertUseGeneratedKeysMapper(mPtheatplan);
                    A++;

                }
            }else{
                break;
            }
            insertInfoBatch = "成功"+A+"条，失败"+B+"条！";

        }

        return insertInfoBatch;
    }

    @Override
    public HSSFWorkbook exportExcel(String fno, String fname, String AxleNum3, String ProcessNode, String pmiPlant, String WorkCentre) {
        HSSFWorkbook xssfWorkbook=null;
        Example example = new Example(MPtheatplan.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtil.isNotEmpty(fno)) {
            criteria.andLike("fno","%" +fno.trim()+"%");
        }
        if (StringUtil.isNotEmpty(fname)) {
            criteria.andLike("fname","%" +fname.trim()+"%");
        }
        if (StringUtil.isNotEmpty(ProcessNode)) {
            criteria.andEqualTo("processnode",ProcessNode.trim());
        }
        if (StringUtil.isNotEmpty(pmiPlant)) {
            criteria.andEqualTo("plant",pmiPlant.trim());
        }
        if (StringUtil.isNotEmpty(WorkCentre)) {
            criteria.andLike("workcentre","%" +WorkCentre.trim()+"%");
        }
        List<MPtheatplan> list = planningManagementService.selectByExample(example);
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        //设置标题栏
        excel.add(new ExcelBean("物料编码","fno",0));
        excel.add(new ExcelBean("物料描述","fname",0));
        excel.add(new ExcelBean("打印标记","workcentre",0));
        excel.add(new ExcelBean("节点工序","processnode",0));
        excel.add(new ExcelBean("表面处理","surface",0));
        excel.add(new ExcelBean("车间","department",0));
        excel.add(new ExcelBean("所属工厂","plant",0));

        map.put(0, excel);
        String sheetName = "数据查询";
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(MPtheatplan.class,list, map, sheetName);
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
