package com.dhchain.business.assembletrans.dao;

import com.dhchain.business.assembletrans.vo.Mplan;
import com.dhchain.business.assembletrans.vo.PlanDuty;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by tongc on 2017-7-20.
 */
@Repository
public interface MplanMapper {
    List<Mplan> getMplan(Mplan mplan);
    List<PlanDuty> getman(PlanDuty record);
    List<Mplan> getNum(Mplan mplan);
    List<Mplan> queryYS(Mplan mplan);
    int update(Mplan mplan);
    int updateth(Mplan mplan);
    int updatecz(Mplan mplan);
    int updateczqx(Mplan mplan);
    int updateruku(Mplan mplan);
    int updaterukuqx(Mplan mplan);
    int updatetime(Mplan mplan);
    int updateCZRK(
            @Param("id") int id,
            @Param("changenum") double changenum
    );
    Mplan selectByPrimaryKey(Integer id);
}
