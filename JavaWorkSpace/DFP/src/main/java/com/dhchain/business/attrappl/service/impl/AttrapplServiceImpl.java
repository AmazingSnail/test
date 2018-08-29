package com.dhchain.business.attrappl.service.impl;

import com.dhchain.business.attrappl.dao.AttrapplMapper;
import com.dhchain.business.attrappl.service.AttrapplService;
import com.dhchain.business.attrappl.vo.AttrAppl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhenglb on 2017-10-11.
 */
@Service("attrapplService")
public class AttrapplServiceImpl implements AttrapplService {
    @Autowired
    private AttrapplMapper attrapplMapper;
    @Override
    public int add(AttrAppl attrAppl) {
        int n = attrapplMapper.insert(attrAppl);
        return n;
    }

    @Override
    public AttrAppl selectByApplyno(String applyno) {
        return attrapplMapper.selectByApplyno(applyno);
    }

    @Override
    public String selectTodayMaxApplyno() {
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");
        String timeStr=dateFormat.format(new Date());
        String returnNo="";
        String a = "A"+timeStr;
        String maxApplyno = attrapplMapper.selectTodayMaxApplyno(a);
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
    public List<AttrAppl> select(AttrAppl attrAppl) {
        return attrapplMapper.select(attrAppl);
    }

    @Override
    public int update(AttrAppl attrAppl) {
        int n = attrapplMapper.update(attrAppl);
        return n;
    }

    @Override
    public AttrAppl getAttrApplByTaskId(String processInstanceId) {
        return attrapplMapper.getAttrApplByTaskId(processInstanceId);
    }
}
