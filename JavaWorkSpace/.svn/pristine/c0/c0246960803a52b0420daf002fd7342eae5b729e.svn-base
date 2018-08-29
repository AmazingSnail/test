package com.dhchain.business.colddigitalworkshop.service.impl;

import com.dhchain.business.colddigitalworkshop.dao.ColdMonthPlanMapper;
import com.dhchain.business.colddigitalworkshop.dao.SplitMaintenanceMapper;
import com.dhchain.business.colddigitalworkshop.service.ColdMonthPlanServivce;
import com.dhchain.business.colddigitalworkshop.vo.ColdDailyPrint;
import com.dhchain.business.colddigitalworkshop.vo.ColdMonthPlan;
import com.dhchain.business.colddigitalworkshop.vo.Smaintenance;
import com.dhchain.config.vo.ExcelBean;
import com.dhchain.config.vo.ExcelUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.beans.IntrospectionException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("ColdMonthPlanServivce")
public class ColdMonthPlanServiceImpl implements ColdMonthPlanServivce {
    @Autowired
    private ColdMonthPlanMapper coldMonthPlanMapper;
    @Autowired
    private SplitMaintenanceMapper splitMaintenanceMapper;
    @Override
    public int deleteByPrimaryKey(Integer id) {
        return coldMonthPlanMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteByFparentIdAndId(Integer id) {
        return coldMonthPlanMapper.deleteByFparentIdAndId(id);
    }

    @Override
    public int insert(ColdMonthPlan record) {
        return coldMonthPlanMapper.insert(record);
    }

    @Override
    public int insertSelective(ColdMonthPlan record) {
        return coldMonthPlanMapper.insertSelective(record);
    }

    @Override
    public ColdMonthPlan selectByPrimaryKey(Integer id) {
        return coldMonthPlanMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ColdMonthPlan record) {
        return coldMonthPlanMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(ColdMonthPlan record) {
        return coldMonthPlanMapper.updateByPrimaryKey(record);
    }

    @Override
    public String importExcelInfo(InputStream in, MultipartFile file,  String User, String mpupinst, Integer month, Integer year) throws Exception {
        String OK = "";
        String NO = "";
        String Err = "";
        List<List<Object>> listob = ExcelUtil.getBankListByExcel(in, file.getOriginalFilename());
        List list = new ArrayList<ColdMonthPlan>();
        //遍历listob数据，把数据放到List中
        for (int i = 0; i < listob.size(); i++) {
            SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");
            List<Object> ob = listob.get(i);
            ColdMonthPlan coldMonthPlan = new ColdMonthPlan();
            Smaintenance smaintenance = new Smaintenance();
            //切换数据库
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
            coldMonthPlan.setPlandate(df.format(new Date()));
            coldMonthPlan.setPlanman(User);
            coldMonthPlan.setFno(String.valueOf(ob.get(1)));
            coldMonthPlan.setPlanweidgt(Double.valueOf(ob.get(2).toString()));
            coldMonthPlan.setSsl(ob.get(3).toString());
            coldMonthPlan.setQcl(ob.get(4).toString());
            coldMonthPlan.setNjl(ob.get(5).toString());
            coldMonthPlan.setCdl(ob.get(6).toString());
            coldMonthPlan.setGclzb(ob.get(7).toString());
            coldMonthPlan.setBsl(ob.get(8).toString());
            coldMonthPlan.setFtl(ob.get(9).toString());
            coldMonthPlan.setGclxh(ob.get(10).toString());
            coldMonthPlan.setMtcl(ob.get(11).toString());
            coldMonthPlan.setXmb(ob.get(12).toString());
            coldMonthPlan.setDp(ob.get(13).toString());
            coldMonthPlan.setYear(Integer.valueOf(ob.get(14).toString()));
            coldMonthPlan.setMonth(Integer.valueOf(ob.get(15).toString()));
            coldMonthPlan.setPlant("材料零件");
            if(String.valueOf(ob.get(16)).equals("")){
                coldMonthPlan.setFparentid(null);
                smaintenance.setFparentid("");
            }else{
                coldMonthPlan.setFparentid(String.valueOf(ob.get(16)));
                smaintenance.setFparentid(String.valueOf(ob.get(16)));
            }
            smaintenance.setFno(String.valueOf(ob.get(1)));

            List<Smaintenance> splitList = splitMaintenanceMapper.selectsplitByfparentid(smaintenance);
            if (splitList.size()>0){//校验关系
                Smaintenance smaintenance1;
                smaintenance1 = splitList.get(0);
                String fname = smaintenance1.getName();
                coldMonthPlan.setFname(fname);
                list.add(coldMonthPlan);
            }else{
                int y = i+1;
                Err = Err+"第"+y+"行的物料在基础表里不存在对应关系；";
            }
        }
        String insertInfoBatch = "";
        System.out.println(list.size());
        if ("".equals(Err)){
            if(list.size()>0){
                int A = 0;
                int B = 0;
                for (int i = 0; i<list.size();i++){
                    ColdMonthPlan IcoldMonthPlan = (ColdMonthPlan) list.get(i);
                    ColdMonthPlan UcoldMonthPlan = (ColdMonthPlan) list.get(i);
                    if(UcoldMonthPlan.getFparentid()==null){
                        UcoldMonthPlan.setFparentid("");
                    }
                    List<ColdMonthPlan> selectList = coldMonthPlanMapper.selectmonthplanByDaoRu(UcoldMonthPlan);
                    if (selectList.size()>0){
                        if (selectList.size() ==1){
                            Double s= UcoldMonthPlan.getPlanweidgt();
                            ColdMonthPlan RcoldMonthPlan = selectList.get(0);
                            Double s1 =RcoldMonthPlan.getPlanweidgt();
                            Double sum = s + s1;
                            UcoldMonthPlan.setId(RcoldMonthPlan.getId());
                            UcoldMonthPlan.setPlanweidgt(sum);
                            int num = coldMonthPlanMapper.updateByPrimaryKeySelective(UcoldMonthPlan);
                            if (num>0){
                                A++;
                            }else{
                                B++;
                            }
                        }else{
                            B++;
                        }
                    }else{
                        int num = coldMonthPlanMapper.insertSelective(IcoldMonthPlan);
                        if (num>0){
                            A++;
                        }else{
                            B++;
                        }
                    }
                }
                //批量插入
                insertInfoBatch = "成功"+A+"条，失败"+B+"条！";
//                A = coldMonthPlanMapper.insertSelectiveList(list);
//                if (A > 0) {
//                    OK = "OK";
//                } else {
//                    NO = "NO";
//                }
//                if (!NO.equals("")) {
//                    insertInfoBatch = NO;
//                } else {
//                    insertInfoBatch = OK;
//                }

            }
        }else{
            insertInfoBatch = insertInfoBatch+Err;
        }
        return insertInfoBatch;
    }
    @Override
    public HSSFWorkbook exportExcelInfo(ColdMonthPlan record) {
        //根据条件查询数据，把数据装载到一个list中
        List<ColdMonthPlan> list = coldMonthPlanMapper.selectByAllKey(record);
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        HSSFWorkbook xssfWorkbook=null;
        //设置标题栏
        excel.add(new ExcelBean("序号","id",0));
        excel.add(new ExcelBean("物料编码","fno",0));
        excel.add(new ExcelBean("物料描述","fname",0));
        excel.add(new ExcelBean("计划重量","planweidgt",0));
        excel.add(new ExcelBean("已排重量","takeweidgt",0));
        excel.add(new ExcelBean("输送链","ssl",0));
        excel.add(new ExcelBean("汽车链","qcl",0));
        excel.add(new ExcelBean("农机链","njl",0));
        excel.add(new ExcelBean("传动链","cdl",0));
        excel.add(new ExcelBean("工程链总部","gclzb",0));
        excel.add(new ExcelBean("板式链","bsl",0));
        excel.add(new ExcelBean("扶梯链","ftl",0));
        excel.add(new ExcelBean("工程链兴化","gclxh",0));
        excel.add(new ExcelBean("摩托车链","mtcl",0));
        excel.add(new ExcelBean("项目部","xmb",0));
        excel.add(new ExcelBean("盾牌","dp",0));
        excel.add(new ExcelBean("计划人员","planman",0));
        excel.add(new ExcelBean("计划时间","plandate",0));
        excel.add(new ExcelBean("年份","year",0));
        excel.add(new ExcelBean("月份","month",0));
        excel.add(new ExcelBean("上级物料","fparentid",0));
        excel.add(new ExcelBean("删除标识","isdelete",0));
        map.put(0, excel);
        String sheetName = "冷轧月度计划";
        //调用ExcelUtil的方法
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(ColdMonthPlan.class, list, map, sheetName);
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
    public List<ColdMonthPlan> selectByAllKey(ColdMonthPlan record) {
        return coldMonthPlanMapper.selectByAllKey(record);
    }

    @Override
    public List<ColdMonthPlan> selectOnlyParent(ColdMonthPlan record) {
        return coldMonthPlanMapper.selectOnlyParent(record);
    }

    @Override
    public List<ColdMonthPlan> selectOnlyChilds(ColdMonthPlan record) {
        return coldMonthPlanMapper.selectOnlyChilds(record);
    }

    @Override
    public List<ColdMonthPlan> selectmonthplanByDaoRu(ColdMonthPlan record) {
        return coldMonthPlanMapper.selectmonthplanByDaoRu(record);
    }

    @Override
    public int updateByFidChangeNum(ColdDailyPrint record) {
        return coldMonthPlanMapper.updateByFidChangeNum(record);
    }

    @Override
    public int updateMonthPlanTakenumGo(ColdMonthPlan record) {
        return coldMonthPlanMapper.updateMonthPlanTakenumGo(record);
    }

    @Override
    public int updateMonthPlanTakenumBack(ColdMonthPlan record) {
        return coldMonthPlanMapper.updateMonthPlanTakenumBack(record);
    }
}
