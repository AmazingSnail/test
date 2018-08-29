package com.dhchain.business.attrappl.vo;

/**
 * Created by zhenglb on 2017-10-10.
 */
public class AttrApplDetail {
    private int id;
    private int Fattrid;
    private String applyno;
    private String itemno;
    private String rowtype;// i增加 m修改
    private String attrno;
    private String attrname;
    private String fattrno;
    private String fattrname;
    private String Mattrname;
    private String Mattrno;
    private int iscode;
    private int isrelate;
    private int islocked;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFattrid() {
        return Fattrid;
    }

    public void setFattrid(int fattrid) {
        Fattrid = fattrid;
    }

    public String getApplyno() {
        return applyno;
    }

    public void setApplyno(String applyno) {
        this.applyno = applyno;
    }

    public String getItemno() {
        return itemno;
    }

    public void setItemno(String itemno) {
        this.itemno = itemno;
    }

    public String getRowtype() {
        return rowtype;
    }

    public void setRowtype(String rowtype) {
        this.rowtype = rowtype;
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

    public String getFattrno() {
        return fattrno;
    }

    public void setFattrno(String fattrno) {
        this.fattrno = fattrno;
    }

    public String getFattrname() {
        return fattrname;
    }

    public void setFattrname(String fattrname) {
        this.fattrname = fattrname;
    }

    public String getMattrname() {
        return Mattrname;
    }

    public void setMattrname(String mattrname) {
        Mattrname = mattrname;
    }

    public String getMattrno() {
        return Mattrno;
    }

    public void setMattrno(String mattrno) {
        Mattrno = mattrno;
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

    public int getIslocked() {
        return islocked;
    }

    public void setIslocked(int islocked) {
        this.islocked = islocked;
    }
}
