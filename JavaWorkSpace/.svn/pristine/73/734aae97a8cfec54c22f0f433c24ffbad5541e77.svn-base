package com.dhchain.business.colddigitalworkshop.service.impl;

import com.dhchain.business.colddigitalworkshop.dao.ColdRshipMaintenanceMapper;
import com.dhchain.business.colddigitalworkshop.service.ColdRshipMaintenanceService;
import com.dhchain.business.colddigitalworkshop.vo.ColdMonthPlan;
import com.dhchain.business.colddigitalworkshop.vo.ColdRshipMaintenance;
import com.dhchain.business.colddigitalworkshop.vo.ColdRshipMaintenanceKey;
import com.dhchain.config.vo.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("ColdRshipMaintenanceService")
public class ColdRshipMaintenanceServiceImpl implements ColdRshipMaintenanceService {
    @Autowired
    private ColdRshipMaintenanceMapper coldRshipMaintenanceMapper;
    @Override
    public int deleteByPrimaryKey(ColdRshipMaintenanceKey key) {
        return coldRshipMaintenanceMapper.deleteByPrimaryKey(key);
    }

    @Override
    public int insert(ColdRshipMaintenance record) {
        return coldRshipMaintenanceMapper.insert(record);
    }

    @Override
    public int insertSelective(ColdRshipMaintenance record) {
        return coldRshipMaintenanceMapper.insertSelective(record);
    }

    @Override
    public ColdRshipMaintenance selectByPrimaryKey(ColdRshipMaintenanceKey key) {
        return coldRshipMaintenanceMapper.selectByPrimaryKey(key);
    }

    @Override
    public int updateByPrimaryKeySelective(ColdRshipMaintenance record) {
        return coldRshipMaintenanceMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(ColdRshipMaintenance record) {
        return coldRshipMaintenanceMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<ColdRshipMaintenance> selectALL(ColdRshipMaintenance record) {
        return coldRshipMaintenanceMapper.selectALL(record);
    }

    @Override
    public String importExcelInfo(InputStream in, MultipartFile file, String User, String mpupinst, String month, String year) throws Exception {
        String OK = "";
        String NO = "";
        String Err = "";
        List<List<Object>> listob = ExcelUtil.getBankListByExcel(in, file.getOriginalFilename());
        List list = new ArrayList<ColdMonthPlan>();
        //遍历listob数据，把数据放到List中
        for (int i = 1; i < listob.size(); i++) {
            SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");
            List<Object> ob = listob.get(i);
            ColdRshipMaintenance coldRshipMaintenance = new ColdRshipMaintenance();
            //切换数据库
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
            coldRshipMaintenance.setInputdate(df.format(new Date()));
            coldRshipMaintenance.setInputman(User);
            coldRshipMaintenance.setReelnum(String.valueOf(ob.get(0)));
            coldRshipMaintenance.setFreelnum(String.valueOf(ob.get(3)));
            coldRshipMaintenance.setWeight(Double.parseDouble(ob.get(5).toString()));
            coldRshipMaintenance.setSpecification(ob.get(4).toString());
            coldRshipMaintenance.setVbeln(ob.get(9).toString());
//            coldRshipMaintenance.setNote(ob.get(6).toString());
            coldRshipMaintenance.setRspecification(ob.get(1).toString());
            coldRshipMaintenance.setRweight(ob.get(2).toString());
            coldRshipMaintenance.setMaterialtype(ob.get(8).toString());
            coldRshipMaintenance.setSteelworks(ob.get(7).toString());
            coldRshipMaintenance.setQualitybrand(ob.get(6).toString());
                list.add(coldRshipMaintenance);
        }
        String insertInfoBatch = "";
//        System.out.println(list.size());
        if ("".equals(Err)){
            if(list.size()>0){
                int A = 0;
                int B = 0;
                for (int i = 0; i<list.size();i++){
                    ColdRshipMaintenance IcoldRshipMaintenance = (ColdRshipMaintenance) list.get(i);
                    ColdRshipMaintenance UcoldRshipMaintenance = (ColdRshipMaintenance) list.get(i);
                    List<ColdRshipMaintenance> selectList = coldRshipMaintenanceMapper.selectColdRshipMaintenanceByReelnum(UcoldRshipMaintenance);
                    if (selectList.size()>0){
                        if (selectList.size() ==1){
                            ColdRshipMaintenance RcoldRshipMaintenance = selectList.get(0);
                            UcoldRshipMaintenance.setId(RcoldRshipMaintenance.getId());
                            int num = coldRshipMaintenanceMapper.updateByPrimaryKeySelective(UcoldRshipMaintenance);
                            if (num>0){
                                A++;
                            }else{
                                B++;
                            }
                        }else{
                            B++;
                        }
                    }else{
                        int num = coldRshipMaintenanceMapper.insertSelective(IcoldRshipMaintenance);
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
}
