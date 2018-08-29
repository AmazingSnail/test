package com.dhchain.business.attr.vo;

import java.util.Date;

/**
 * Created by zhenglb on 2017-10-10.
 */
public class Attr {
    private int id;
    private String attrno;
    private String attrname;
    private String remark;
    private int iscode;
    private int isrelate;
    private int fid;
    private String inputman;
    private Date inputdate;
    private String modifyman;
    private Date modifydate;
    private int islocked;
    private String flag;

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAttrno() {
        return attrno;
    }

    public void setAttrno(String attrno) {
        this.attrno = attrno;
    }

    public String getAttrname() {
        return attrname;
    }

    public void setAttrname(String attrname) {
        this.attrname = attrname;
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

    public int getIslocked() {
        return islocked;
    }

    public void setIslocked(int islocked) {
        this.islocked = islocked;
    }
}
