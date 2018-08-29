package com.dhchain.business.Tractor.service.Impl;

import com.dhchain.business.Tractor.dao.TBasetyreMapper;
import com.dhchain.business.Tractor.service.TBasetyreService;
import com.dhchain.business.Tractor.vo.TBasedate;
import com.dhchain.business.Tractor.vo.TBasetyre;
import com.dhchain.config.vo.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("TBasetyreService")
public class TBasetyreServiceImpl extends BaseService<TBasetyre> implements TBasetyreService {
    @Autowired
    private TBasetyreMapper tBasetyreMapper;
    @Autowired
    private TBasetyreService tBasetyreService;
    @Override
    public List<TBasetyre> getQL(TBasetyre reocrd) {
        return tBasetyreMapper.getQL(reocrd);
    }
    @Override
    public List<TBasetyre> getZJ(TBasetyre reocrd) {
        return tBasetyreMapper.getZJ(reocrd);
    }
    @Override
    public List<TBasetyre> getZJ1(TBasetyre reocrd) {
        return tBasetyreMapper.getZJ1(reocrd);
    }
   @Override
    public List<TBasetyre> getTireSpect(TBasetyre reocrd) {
        return tBasetyreMapper.getTireSpect(reocrd);
    }
    @Override
    public List<TBasetyre> getTireSpect1(TBasetyre reocrd) {
        return tBasetyreMapper.getTireSpect1(reocrd);
    }

    @Override
    public List<TBasetyre> getHL(TBasetyre reocrd) {
        return tBasetyreMapper.getHL(reocrd);
    }

    @Override
    public List<TBasetyre> getsprect(TBasetyre reocrd) {
        return tBasetyreMapper.getsprect(reocrd);
    }
    @Override
    public List<TBasetyre> getsprect1(TBasetyre reocrd) {
        return tBasetyreMapper.getsprect1(reocrd);
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
                TBasetyre tBasetyre = new TBasetyre();
                Date day = new Date();
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                tBasetyre.setZmach(String.valueOf(ob.get(0)));
                tBasetyre.setTyresize(String.valueOf(ob.get(1)));
                tBasetyre.setWheelsize(String.valueOf(ob.get(3)));
                tBasetyre.setTirespect(String.valueOf(ob.get(2)));
                tBasetyre.setPlant(String.valueOf(ob.get(4)));
                tBasetyre.setInputman(User);
                tBasetyre.setInputtime(df.format(day));
                n = tBasetyreService.InsertUseGeneratedKeysMapper(tBasetyre);
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
