package com.dhchain.business.partpunchingworkshop.dao;

import com.dhchain.business.partpunchingworkshop.vo.CraftFile;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProcessDocumentMapper {
    int insertfile(CraftFile record);//上传文件。
    int updatefile(CraftFile record);//修改文件．
    int deleteid(CraftFile record);//删除数据
    List<CraftFile> selectid(CraftFile record);//查询文件名
    List<CraftFile> selectAll(CraftFile record);//查询所有数据
}
