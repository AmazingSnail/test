package com.dhchain.business.partpunchingworkshop.service.Impl;

import com.dhchain.business.partpunchingworkshop.dao.ProcessDocumentMapper;
import com.dhchain.business.partpunchingworkshop.service.ProcessDocumentService;
import com.dhchain.business.partpunchingworkshop.vo.CraftFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("/ProcessDocumentService")
public class ProcessDocumentServiceImpl implements ProcessDocumentService {
    @Autowired
    private ProcessDocumentMapper processDocumentMapper;

    @Override
    public int insertfile(CraftFile record) {
        return processDocumentMapper.insertfile(record);
    }

    @Override
    public int updatefile(CraftFile record) {
        return processDocumentMapper.updatefile(record);
    }

    @Override
    public int deleteid(CraftFile record) {
        return processDocumentMapper.deleteid(record);
    }

    @Override
    public List<CraftFile> selectid(CraftFile record) {
        return processDocumentMapper.selectid(record);
    }


    @Override
    public List<CraftFile> selectAll(CraftFile record) {
        return processDocumentMapper.selectAll(record);
    }
}
