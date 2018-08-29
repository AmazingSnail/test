package com.dhchain.business.Tractor.service.Impl;

import com.dhchain.business.Tractor.dao.TBasedateMappre;
import com.dhchain.business.Tractor.service.TBasedateService;
import com.dhchain.business.Tractor.vo.TBasedate;
import com.dhchain.business.Tractor.vo.TBasestatus;
import com.dhchain.business.Tractor.vo.Uuser;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import com.dhchain.config.vo.ExcelUtil;
import com.dhchain.util.StringUtils;
import org.bouncycastle.crypto.paddings.TBCPadding;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("TBasedateService")
public class TBasedateServiceImpl extends  BaseService<TBasedate> implements TBasedateService {
    @Autowired
    private TBasedateMappre tBasedateMappre;
    @Autowired
    private TBasedateService tBasedateService;
    @Override
    public List<TBasedate> getZJ(TBasedate record) {
        return tBasedateMappre.getZJ(record);
    }
    @Override
    public List<TBasedate> getZJType(TBasedate record) {
        return tBasedateMappre.getZJType(record);
    }
    @Override
    public List<TBasedate> getSize(TBasedate record) {
        return tBasedateMappre.getSize(record);
    }
    @Override
    public List<TBasedate> getUse(TBasedate record) {
        return tBasedateMappre.getUse(record);
    }
    @Override
    public List<TBasedate> getForce(TBasedate record) {
        return tBasedateMappre.getForce(record);
    }
   @Override
    public List<TBasedate> getBZ(TBasedate record) {
        return tBasedateMappre.getBZ(record);
    }

    @Override
    public List<TBasestatus> getStauts( ) {
        return tBasedateMappre.getStauts( );
    }
 @Override
    public List<Uuser> getUser( Uuser record) {
        return tBasedateMappre.getUser( record);
    }

    @Override
    public String importExcelInfo1(InputStream in, MultipartFile file, String User, String time) throws Exception {
        String OK = "";
        String NO = "";
        String Err = "";
        List list = new ArrayList<TBasedate>();

        int n =0;
        int A = 0;
        int B = 0;
        String insertInfoBatch = "";
        List<List<Object>> listob = ExcelUtil.getBankListByExcel(in, file.getOriginalFilename());
        //遍历listob数据，把数据放到List中
        for (int i = 1; i < listob.size(); i++) {
            List<Object> ob = listob.get(i);
            if(ob.get(0) != null&&ob.get(0) != ""){
                TBasedate tBasedate = new TBasedate();
                Date day = new Date();
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                tBasedate.setZmach(String.valueOf(ob.get(0)));
                tBasedate.setType(String.valueOf(ob.get(1)));
                tBasedate.setModel(String.valueOf(ob.get(2)));
                tBasedate.setWheelbase(String.valueOf(ob.get(3)));
                tBasedate.setOutsize(String.valueOf(ob.get(4)));
                tBasedate.setDemarcatedforce(String.valueOf(ob.get(5)));
                tBasedate.setMinuse(String.valueOf(ob.get(6)));
                tBasedate.setExecstd(String.valueOf(ob.get(7)));
                tBasedate.setPlant(String.valueOf(ob.get(8)));
                tBasedate.setInputman(User);
                tBasedate.setInputtime(df.format(day));
                n = tBasedateService.InsertUseGeneratedKeysMapper(tBasedate);
                if(n>0){
                    A++;
                }else {
                    B++;
                }
            }else{
                break;
            }

            insertInfoBatch = "成功"+A+"条，失败"+B+"条！"+Err;
        }



        return insertInfoBatch;
    }
}
