package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.dao.MouldManageMapper;
import com.dhchain.business.partpunchingworkshop.service.MouldManageService;
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
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service("MouldManageService")
public class MouldManageServiceImpl implements MouldManageService{
    @Autowired
    private MouldManageMapper mouldManageMapper;
    @Override
    public List<MoldStore> selectByDepartment() {
        return mouldManageMapper.selectByDepartment();
    }

    @Override
    public List<BaseUser> getDepartment(BaseUser record) {
        return mouldManageMapper.getDepartment(record);
    }

    @Override
    public List<BaseStatus> selectByNwx() {
        return mouldManageMapper.selectByNwx();
    }

    @Override
    public List<MoldStore> selectAll(MoldStore record) {
        return mouldManageMapper.selectAll(record);
    }

    @Override
    public List<MoldReplace> selecttime(MoldReplace record) {
        return mouldManageMapper.selecttime(record);
    }

    @Override
    public List<MoldStore> selectbymouldid(MoldStore record) {
        return mouldManageMapper.selectbymouldid(record);
    }

    @Override
    public List<MoldStore> querypartDrawing(String partDrawing) {
        return mouldManageMapper.querypartDrawing(partDrawing);
    }
    @Override
    public List<MoldStore> querypartDrawing1(String partDrawing) {
        return mouldManageMapper.querypartDrawing1(partDrawing);
    }

    @Override
    public List<BaseCapacity> queryfno(String fno) {
        return mouldManageMapper.queryfno(fno);
    }

    @Override
    public List<MoldStore> queryMouldID1(String MouldID1) {
        return mouldManageMapper.queryMouldID1(MouldID1);
    }

    @Override
    public int updateStatus(MoldStore record) {
        return mouldManageMapper.updateStatus(record);
    }

    @Override
    public int out(MoldStore record) {
        return mouldManageMapper.out(record);
    }

    @Override
    public int outMoldOutput(MoldOutput record) {
        return mouldManageMapper.outMoldOutput(record);
    }

    @Override
    public int delete(MoldStore record) {
        return mouldManageMapper.delete(record);
    }

    @Override
    public int insertMoldStore(MoldStore record) {
        return mouldManageMapper.insertMoldStore(record);
    }

    @Override
    public int insertMoldInput(MoldInput record) {
        return mouldManageMapper.insertMoldInput(record);
    }

    @Override
    public int updateMould(MoldStore record) {
        return mouldManageMapper.updateMould(record);
    }

    @Override
    public HSSFWorkbook exportExce(String plant,
      String department, String MouldID, String Tonnage, String MouldName, String Location, String nwx) {
        HSSFWorkbook xssfWorkbook=null;
        MoldStore moldStore =  new MoldStore();
        moldStore.setDepartMent(department);
        moldStore.setPlant(plant);
        moldStore.setMouldID(MouldID.trim());
        moldStore.setTonnage(Tonnage.trim());
        moldStore.setMouldName(MouldName.trim());
        moldStore.setLocation(Location.trim());
        moldStore.setStatus(nwx.trim());
        DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
        List<MoldStore> list2 = mouldManageMapper.selectAll(moldStore);
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        List<MoldStore> list = new ArrayList();
        if(list2.size()>0){
            for(int i = 0 ;i<list2.size();i++){
                MoldStore moldStore1;
                moldStore1 = list2.get(i);
                String a = moldStore1.getMouldID();
                MoldReplace moldReplace = new MoldReplace();
                moldReplace.setMoldID(a);
                DataSourceHolder.setDataSourceName(Type.SQL_DHBI.getName());
                List<MoldReplace> list1 = mouldManageMapper.selecttime(moldReplace);
                DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());

                String b;
                if(list1.size()>0){for(int j =0;j<list1.size();j++){
                    MoldReplace moldReplace1 ;
                    moldReplace1 = list1.get(0);
                    b = moldReplace1.getMoldRpBegTime();
                    moldStore1.setMoldRpBegTime(b);
                }
                }
                list.add(moldStore1);
            }
        }
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        //设置标题栏
        excel.add(new ExcelBean("模具编码","MouldID",0));
        excel.add(new ExcelBean("模具规格名称","MouldName",0));
        excel.add(new ExcelBean("吨位","Tonnage",0));
        excel.add(new ExcelBean("库位","Location",0));
        excel.add(new ExcelBean("颗/次","Nunber",0));
        excel.add(new ExcelBean("接收人","InputMan",0));
        excel.add(new ExcelBean("接收时间","InputDate",0));
        excel.add(new ExcelBean("状态","Status",0));
        excel.add(new ExcelBean("设备使用编号","EquipID",0));
        excel.add(new ExcelBean("外借部门","LDepartment",0));
        excel.add(new ExcelBean("使用时间","MoldRpBegTime",0));
        excel.add(new ExcelBean("外借时间","LoanTime",0));
        excel.add(new ExcelBean("部门","DepartMent",0));
        excel.add(new ExcelBean("事业部","Plant",0));
        map.put(0, excel);
        String sheetName = "数据查询";
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(MoldStore.class,list, map, sheetName);
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
