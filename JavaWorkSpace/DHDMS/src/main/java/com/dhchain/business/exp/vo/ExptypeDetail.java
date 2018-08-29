package com.dhchain.business.exp.vo;

import java.util.Date;

/**
 * Created by zhenglb on 2017-10-14.
 */
public class ExptypeDetail {
    private int id;
    private int Exptypeid;
    private String exptypeno;
    private String exptypename;
    private int expattrkindid;
    private String expattrkind;
    private String expattrele;
    private String attrno;
    private String attrname;
    private int attrid;
    private String attrnore;
    private String attrnamere;
    private int attrreid;
    private int islocked;
    private int isdelete;
    private String inputman;
    private Date inputdate;
    private String modifyman;
    private Date modifydate;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getExptypeid() {
        return Exptypeid;
    }

    public void setExptypeid(int exptypeid) {
        Exptypeid = exptypeid;
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

    public int getExpattrkindid() {
        return expattrkindid;
    }

    public void setExpattrkindid(int expattrkindid) {
        this.expattrkindid = expattrkindid;
    }

    public String getExpattrkind() {
        return expattrkind;
    }

    public void setExpattrkind(String expattrkind) {
        this.expattrkind = expattrkind;
    }

    public int getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(int isdelete) {
        this.isdelete = isdelete;
    }

    public String getExpattrele() {
        return expattrele;
    }

    public void setExpattrele(String expattrele) {
        this.expattrele = expattrele;
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

    public int getAttrid() {
        return attrid;
    }

    public void setAttrid(int attrid) {
        this.attrid = attrid;
    }

    public String getAttrnore() {
        return attrnore;
    }

    public void setAttrnore(String attrnore) {
        this.attrnore = attrnore;
    }

    public String getAttrnamere() {
        return attrnamere;
    }

    public void setAttrnamere(String attrnamere) {
        this.attrnamere = attrnamere;
    }

    public int getAttrreid() {
        return attrreid;
    }

    public void setAttrreid(int attrreid) {
        this.attrreid = attrreid;
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
}
