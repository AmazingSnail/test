package com.dhchain.business.partpunchingworkshop.dao;

import com.dhchain.business.partpunchingworkshop.vo.*;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface MonthPlanMapper  {
    List<Syb> getSyb();
    List<BaseUser> getUsername();
    List<BaseStatus> FindFname();//获取Fname
    List<PTMaterial> getUsername1();

    List<PTPlan> selectByAllKey(PTPlan record);//查询月度计划信息
    List<PTPlan> getAll(PTPlan record);//查询月度计划信息
    List<PTOrderPlan> selectptOrderPlan(PTOrderPlan record);//查询合同计划
    List<PTOrderPlan> selectByfno(PTOrderPlan record);//查询相同物料编码的合同计划
    int updateALLfinish(PTOrderPlan record);//更新这个物料的isfinish
    List<PTOrderPlan> selectByid(PTOrderPlan record);//查询合同计划根据月度计划--id
    List<PTPlan> selectByFno(PTPlan record);//查询相同物料编码的月度计划
    List<PTOrderPlan> selectByFno1(PTOrderPlan record);//查询相同物料编码的合同计划
    int updateFinsh(PTOrderPlan record);
    int deleteid(PTOrderPlan record);//删除数据
    int deleteid1(PTPlan record);//删除数据
    int updatePlan(PTPlan record);//更新数据
    List<BaseCapacity> getFtemp2(BaseCapacity record);//查询图号
    List<BaseCapacity> getCapacity(BaseCapacity record);//查询图号是否存在
    List<CraftFile> getCraftFile(CraftFile record);//查询文档
    List<BaseChkStd> getBaseChkStd(BaseChkStd record);//查询检验标准是否存在
    int updateByPOrdertime(PTOrderPlan record);//gengxin 相同的厂编合同
    int updateByfno(PTPlan record);//gengxin 相同的零件编码
    int insertorderplan(PTOrderPlan record);//daoru数据合同
    int insertplan(PTPlan record);//daoru数据月度

    List<PTOrderPlan> selectByOrdertime(PTOrderPlan record);//查询厂编合同号
}
