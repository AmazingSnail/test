package com.dhchain.business.colddigitalworkshop.service;

import com.dhchain.business.colddigitalworkshop.vo.ColdRshipMaintenance;
import com.dhchain.business.colddigitalworkshop.vo.ColdRshipMaintenanceKey;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;

public interface ColdRshipMaintenanceService {
    int deleteByPrimaryKey(ColdRshipMaintenanceKey key);

    int insert(ColdRshipMaintenance record);

    int insertSelective(ColdRshipMaintenance record);

    ColdRshipMaintenance selectByPrimaryKey(ColdRshipMaintenanceKey key);

    int updateByPrimaryKeySelective(ColdRshipMaintenance record);

    int updateByPrimaryKey(ColdRshipMaintenance record);

    List<ColdRshipMaintenance> selectALL(ColdRshipMaintenance record);

    String importExcelInfo(InputStream in, MultipartFile file, String User, String mpupinst, String month, String uyear)throws Exception;
}
