package com.dhchain.business.rout.service.impl;

import com.dhchain.business.exp.vo.ExpAppl;
import com.dhchain.business.rout.dao.RoutApplMapper;
import com.dhchain.business.rout.service.RoutApplService;
import com.dhchain.business.rout.vo.RoutAppl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhenglb on 2017-10-31.
 */
@Service("routApplService")
public class RoutApplServiceImpl implements RoutApplService{
    @Autowired
    private RoutApplMapper routApplMapper;
    @Override
    public String selectTodayMaxApplyno() {
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");
        String timeStr=dateFormat.format(new Date());
        String returnNo="";
        String a = "T"+timeStr;
        String maxApplyno = routApplMapper.selectTodayMaxApplyno(a);
        if(maxApplyno==null||maxApplyno.equals("")){
            returnNo = a + "001";
        }else{
            String c=maxApplyno.substring(maxApplyno.length()-3);
            BigDecimal bigDecimal=new BigDecimal(c);
            BigDecimal rs=bigDecimal.add(new BigDecimal("1"));
            String end=rs.toString();
            if(end.length()==1){
                end="00"+end;
            }else if(end.length()==2){
                end="0"+end;
            }
            returnNo=a+end;
        }
        return returnNo;
    }

    @Override
    public int add(RoutAppl routAppl) {
        int n = routApplMapper.insert(routAppl);
        return n;
    }

    @Override
    public int selectNewId() {
        return routApplMapper.selectNewId();
    }

    @Override
    public int update(RoutAppl routAppl) {
        return routApplMapper.update(routAppl);
    }

    @Override
    public RoutAppl findByApplyno(String applyno) {
        return routApplMapper.findByApplyno(applyno);
    }

    @Override
    public RoutAppl getExpApplByTaskId(String processInstanceId) {
        return routApplMapper.getExpApplByTaskId(processInstanceId);
    }

    @Override
    public List<RoutAppl> select(RoutAppl routAppl) {
        return routApplMapper.select(routAppl);
    }
}
