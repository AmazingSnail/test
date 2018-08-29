package com.dhchain.business.base.vo;

import java.util.Date;

/**
 * Created by zhenglb on 2017-10-06.
 */
public class Base {
    private int id;
    private String baseno;
    private String  basename;
    private String remark;
    private int iscode;
    private int isrelate;
    private int fid;
    private int isdelete;
    private int islocked;
    private String inputman;
    private Date inputdate;
    private String modifyman;
    private Date modifydate;
    private String flag;
    private String rebaseids;
    private String rebaseitems;
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBaseno() {
        return baseno;
    }

    public void setBaseno(String baseno) {
        this.baseno = baseno;
    }

    public String getBasename() {
        return basename;
    }

    public void setBasename(String basename) {
        this.basename = basename;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getIscode() {
        return iscode;
    }

    public void setIscode(int iscode) {
        this.iscode = iscode;
    }

    public int getIsrelate() {
        return isrelate;
    }

    public void setIsrelate(int isrelate) {
        this.isrelate = isrelate;
    }

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
    }

    public int getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(int isdelete) {
        this.isdelete = isdelete;
    }

    public int getIslocked() {
        return islocked;
    }

    public void setIslocked(int islocked) {
        this.islocked = islocked;
    }

    public String getInputman() {
        return inputman;
    }

    public void setInputman(String inputman) {
        this.inputman = inputman;
    }

    public Date getInputdate() {
        return inputdate;
    }

    public void setInputdate(Date inputdate) {
        this.inputdate = inputdate;
    }

    public String getModifyman() {
        return modifyman;
    }

    public void setModifyman(String modifyman) {
        this.modifyman = modifyman;
    }

    public Date getModifydate() {
        return modifydate;
    }

    public void setModifydate(Date modifydate) {
        this.modifydate = modifydate;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getRebaseids() {
        return rebaseids;
    }

    public void setRebaseids(String rebaseids) {
        this.rebaseids = rebaseids;
    }

    public String getRebaseitems() {
        return rebaseitems;
    }

    public void setRebaseitems(String rebaseitems) {
        this.rebaseitems = rebaseitems;
    }
}
