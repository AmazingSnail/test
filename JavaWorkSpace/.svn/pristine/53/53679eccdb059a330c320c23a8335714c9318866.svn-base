package com.dhchain.business.assembleplan.service;

import com.dhchain.business.assembleplan.vo.PlanProduct;
import com.dhchain.business.assembleplan.vo.Plant;
import com.dhchain.business.assembleplan.vo.check;
import com.dhchain.config.annotation.DataSource;
import com.dhchain.config.annotation.Type;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;

/**
 * Created by xieyj on 2017-7-18.
 */
@Service("PlanProductService")
public interface PlanProductService {
    /**
     * 分页查询menu
     * @param    query    查询条件
     * @param plant
     * @param umouth
     * @param DHorder
     * @param Des
     * @param uyear
     * @param fname
     * */
    @DataSource(Type.SQL_MDM)
    List<PlanProduct> getListPP(PlanProduct query, String plant, String umouth, String DHorder, String Des, String fname, String uyear);
    /**
     * 分页查询menu
     * @param	query	查询条件
     * @return	PageResult<Menu>
     * */
    @DataSource(Type.SQL_MDM)
    List<Plant> getPlant(Plant query);
    /**
     * 修改menu
     * @param	query
     * @return	List<PlanProduct>
     * */
    @DataSource(Type.SQL_MDM)
    int updataPlanProduct(PlanProduct query);
    @DataSource(Type.SQL_MDM)
    int aprefrashmix(PlanProduct query);

    @DataSource(Type.SQL_EPPRD)
    String importExcelInfo(InputStream in, MultipartFile file, String plant, String User, String mpupinst, String umouth, String uyear)throws Exception;

    @DataSource(Type.SQL_MDM)
    HSSFWorkbook exportExcelInfo(PlanProduct query, String plant, String umouth, String DHorder, String Des, String fname, String uyear);

    @DataSource(Type.SQL_MDM)
    List<check> fnocheck(check query);
    List<check> planstate(String plant, String umouth, String uyear, int submitstate);
    @DataSource(Type.SQL_MDM)
    int APdelete(PlanProduct planProduct);


}
