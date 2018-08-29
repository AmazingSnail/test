package com.dhchain.system.service.impl;

import com.dhchain.system.dao.base.OutputValueDao;
import com.dhchain.system.dao.mdm.TestDao;
import com.dhchain.system.entity.OutputValue;
import com.dhchain.system.entity.ZWQ;
import com.dhchain.system.service.OutputValueService;
import com.dhchain.system.service.ZWQService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ZWQServiceImpl extends BaseService<ZWQ> implements ZWQService {
     @Autowired
     private TestDao testDao;

    @Override
    public List<ZWQ> getZWQValue(String year, String month, String nwx) {
        return testDao.getOutputValue(year,month,nwx);
    }

}
