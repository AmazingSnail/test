package com.dhchain.business.assembleplan.dao;

import com.dhchain.business.assembleplan.vo.PlanProduct;
import com.dhchain.business.assembleplan.vo.Plant;
import com.dhchain.business.assembleplan.vo.check;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by xieyj on 2017-7-18.
 */
@Repository
public interface PlanProductMapper {
    List<PlanProduct> getListPP(PlanProduct query,
                                @Param("plant") String plant,
                                @Param("umouth") String umouth,
                                @Param("uyear") String uyear,
                                @Param("DHorder") String DHorder,
                                @Param("Des") String Des,
                                @Param("fname") String fname);
    List<Plant> getPlant(Plant query);
    int updataPlanProduct(PlanProduct query);
    int aprefrashmix(PlanProduct query);
     int insertInfoBatch(List<PlanProduct> list);
     List<check> check(check query);
     List<check> planstate(@Param("plant") String plant,
                           @Param("umouth") String umouth,
                           @Param("uyear") String uyear, @Param("submitstate") int submitstate);
    List<check> EPcheck(@Param("dhorderno") String query);
    List<check> plancheck(check query);
    int Deletemp(PlanProduct query);
}
