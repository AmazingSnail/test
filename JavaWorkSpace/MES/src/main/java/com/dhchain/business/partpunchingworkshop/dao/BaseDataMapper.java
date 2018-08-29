package com.dhchain.business.partpunchingworkshop.dao;

import com.dhchain.business.HeatTreatment.vo.MCraftmould;
import com.dhchain.business.partpunchingworkshop.vo.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BaseDataMapper {
    List<BaseFno> getFno(BaseFno record);//判断物料编码
    List<BaseSupplier> getMeterType();//下拉值
    List<BaseMaterial> getMFno(BaseMaterial record);//判断外购
    List<BaseChkStd> getList();//查询记录
    List<BaseStatus> getStatus();//查询基础资料
    List<BaseStatus> getDepartMentH();//查询事业部
    List<BaseStatus> getStautsA();//查询基础资料
    List<BaseStatus> getStauts1();//查询基础资料
    List<BaseStatus> getStatusID(BaseStatus record);//查询基础资料id
    List<BaseEquip> getEquipID(BaseEquip record);//查询基础资料id
    List<BaseCapacity> getList1();//查询记录
    List<BaseEquip> getList2();//查询记录
    List<BaseEquip> getListHE (BaseEquip record);//查询记录
    List<MCraftmould> getMould ();////获取工艺模板数据
    List<BaseFno> getList3();//查询报工记录;
    List<BaseMaterial> getList4();//查询外购记录；
    List<BaseSupplier> getList5(BaseSupplier record);//查询供货方信息;
    int insert(BaseChkStd record);//插入记录
    int update(BaseChkStd record);//更新记录
    int updateF(BaseFno record);//更新报工记录
    int updateM(BaseMaterial record);//更新外购记录
    int update1(BaseCapacity record);//更新产能记录
    int insert1(BaseCapacity record);//插入产能记录
    int updateS(BaseSupplier record);//更新供应商记录
    int insertF(BaseFno record);//插入报工记录
    int insertM(BaseMaterial record);//插入外购记录
    int insertS(BaseSupplier record);//插入供应商记录
    int insertEquip(BaseEquip record);//插入设备记录
    int insertEquipStatus(EQPStatus record);
    int updateEquip(BaseEquip record);//更新设备记录
    int delete(BaseChkStd record);//删除记录
    int delete1(BaseCapacity record);//删除产能记录
    int delete2(BaseEquip record);//删除设备记录
    int deleteF(BaseFno record);//删除报工记录
    int deleteM(BaseMaterial record);//删除采购记录
    int deleteS(BaseSupplier record);//删供应商记录
    int deleteMould(MCraftmould record);//删除工艺模板
    int delete3(EQPStatus record);//删除设备状态
}
