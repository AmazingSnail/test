package com.dhchain.business.exp.service.impl;

import com.dhchain.business.exp.dao.ExpApplMapper;
import com.dhchain.business.exp.service.ExpApplService;
import com.dhchain.business.exp.vo.ExpAppl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhenglb on 2017-10-25.
 */
@Service("expApplService")
public class ExpApplServiceImpl implements ExpApplService {
    @Autowired
    private ExpApplMapper expApplMapper;
    @Override
    public String selectTodayMaxApplyno() {
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");
        String timeStr=dateFormat.format(new Date());
        String returnNo="";
        String a = "E"+timeStr;
        String maxApplyno = expApplMapper.selectTodayMaxApplyno(a);
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
    public int add(ExpAppl expAppl) {
        int n = expApplMapper.insert(expAppl);
        return n;
    }

    @Override
    public int selectNewId() {
        return expApplMapper.selectNewId();
    }

    @Override
    public ExpAppl findByApplyno(String applyno) {
        return expApplMapper.findByApplyno(applyno);
    }

    @Override
    public int update(ExpAppl expAppl) {
        return expApplMapper.update(expAppl);
    }

    @Override
    public ExpAppl getExpApplByTaskId(String processInstanceId) {
        return expApplMapper.getExpApplByTaskId(processInstanceId);
    }

    @Override
    public List<ExpAppl> select(ExpAppl expAppl) {
        return expApplMapper.select(expAppl);
    }
}
