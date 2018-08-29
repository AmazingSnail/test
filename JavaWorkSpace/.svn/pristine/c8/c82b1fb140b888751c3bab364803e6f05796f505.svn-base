package com.dhchain.business.Tractor.service.Impl;

import com.dhchain.business.Tractor.dao.TBaseengineMapper;
import com.dhchain.business.Tractor.service.TBaseengineService;
import com.dhchain.business.Tractor.vo.TBasedate;
import com.dhchain.business.Tractor.vo.TBaseengine;
import com.dhchain.config.vo.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("TBaseengineService")
public class TBaseengineServiceImpl extends BaseService<TBaseengine> implements TBaseengineService {
    @Autowired
    private TBaseengineMapper tBaseengineMapper;
    @Autowired
    private TBaseengineService tBaseengineService;
    @Override
    public List<TBaseengine> getDHJ(TBaseengine record) {
        return tBaseengineMapper.getDHJ(record);
    }

    @Override
    public List<TBaseengine> getDL(TBaseengine record) {
        return tBaseengineMapper.getDL(record);
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
                TBaseengine tBaseengine = new TBaseengine();
                Date day = new Date();
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                tBaseengine.setZmach(String.valueOf(ob.get(0)));
                tBaseengine.setZchyj(String.valueOf(ob.get(1)));
                tBaseengine.setPower(String.valueOf(ob.get(2)));
                tBaseengine.setPlant(String.valueOf(ob.get(3)));
                tBaseengine.setInputman(User);
                tBaseengine.setInputtime(df.format(day));
                n = tBaseengineService.InsertUseGeneratedKeysMapper(tBaseengine);
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
