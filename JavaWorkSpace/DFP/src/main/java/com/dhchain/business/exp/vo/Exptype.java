package com.dhchain.business.exp.vo;

import java.util.Date;
import java.util.List;

/**
 * Created by zhenglb on 2017-10-06.
 */
public class Exptype {
    private int id;
    private String exptypeno;
    private String exptypename;
    private int typeid;
    private String inputman;
    private Date inputdate;
    private String modifyman;
    private Date modifydate;
    private int islocked;
    private int isdelete;
    private String typedetailid;
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getExptypeno() {
        return exptypeno;
    }

    public void setExptypeno(String exptypeno) {
        this.exptypeno = exptypeno;
    }

    public String getExptypename() {
        return exptypename;
    }

    public void setExptypename(String exptypename) {
        this.exptypename = exptypename;
    }

    public int getTypeid() {
        return typeid;
    }

    public void setTypeid(int typeid) {
        this.typeid = typeid;
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

    public int getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(int isdelete) {
        this.isdelete = isdelete;
    }

    public String getTypedetailid() {
        return typedetailid;
    }

    public void setTypedetailid(String typedetailid) {
        this.typedetailid = typedetailid;
    }
}
