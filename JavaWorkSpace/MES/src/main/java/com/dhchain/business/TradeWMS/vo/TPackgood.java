package com.dhchain.business.TradeWMS.vo;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;

public class TPackgood implements Serializable {
    /**
     * 主键
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String serialno;

    private String boxnum;

    private String boxnumfid;

    private String fno;

    private String fname;

    private Integer numberweight;

    private String dhorderno;

    private String erpsysno;

    private String lineid;

    private String plant;

    private String location;

    private String oldlocation;

    private Integer sapSdf;

    private String sapSdfdesc;

    private String sapXsbm;

    private String sapXsbmdesc;

    private String doxtbh;

    private Integer packid;

    private String inputman;

    private Date inputdate;

    private Boolean isinsap;

    private String insapman;

    private Date insapdate;

    private Integer insapok;

    private String outputman;

    private Date outputdate;

    private Boolean isoutsap;

    private String outsapman;

    private Date outsapdate;

    private Integer outsapok;

    private String dono;

    private String doitem;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSerialno() {
        return serialno;
    }

    public void setSerialno(String serialno) {
        this.serialno = serialno;
    }

    public String getBoxnum() {
        return boxnum;
    }

    public void setBoxnum(String boxnum) {
        this.boxnum = boxnum == null ? null : boxnum.trim();
    }

    public String getBoxnumfid() {
        return boxnumfid;
    }

    public void setBoxnumfid(String boxnumfid) {
        this.boxnumfid = boxnumfid == null ? null : boxnumfid.trim();
    }

    public String getFno() {
        return fno;
    }

    public void setFno(String fno) {
        this.fno = fno == null ? null : fno.trim();
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public Integer getNumberweight() {
        return numberweight;
    }

    public void setNumberweight(Integer numberweight) {
        this.numberweight = numberweight;
    }

    public String getDhorderno() {
        return dhorderno;
    }

    public void setDhorderno(String dhorderno) {
        this.dhorderno = dhorderno == null ? null : dhorderno.trim();
    }

    public String getErpsysno() {
        return erpsysno;
    }

    public void setErpsysno(String erpsysno) {
        this.erpsysno = erpsysno == null ? null : erpsysno.trim();
    }

    public String getLineid() {
        return lineid;
    }

    public void setLineid(String lineid) {
        this.lineid = lineid == null ? null : lineid.trim();
    }

    public String getPlant() {
        return plant;
    }

    public void setPlant(String plant) {
        this.plant = plant == null ? null : plant.trim();
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location == null ? null : location.trim();
    }

    public String getOldlocation() {
        return oldlocation;
    }

    public void setOldlocation(String oldlocation) {
        this.oldlocation = oldlocation;
    }

    public Integer getSapSdf() {
        return sapSdf;
    }

    public void setSapSdf(Integer sapSdf) {
        this.sapSdf = sapSdf;
    }

    public String getSapSdfdesc() {
        return sapSdfdesc;
    }

    public void setSapSdfdesc(String sapSdfdesc) {
        this.sapSdfdesc = sapSdfdesc;
    }

    public String getSapXsbm() {
        return sapXsbm;
    }

    public void setSapXsbm(String sapXsbm) {
        this.sapXsbm = sapXsbm == null ? null : sapXsbm.trim();
    }

    public String getSapXsbmdesc() {
        return sapXsbmdesc;
    }

    public void setSapXsbmdesc(String sapXsbmdesc) {
        this.sapXsbmdesc = sapXsbmdesc == null ? null : sapXsbmdesc.trim();
    }

    public String getDoxtbh() {
        return doxtbh;
    }

    public void setDoxtbh(String doxtbh) {
        this.doxtbh = doxtbh == null ? null : doxtbh.trim();
    }

    public Integer getPackid() {
        return packid;
    }

    public void setPackid(Integer packid) {
        this.packid = packid;
    }

    public String getInputman() {
        return inputman;
    }

    public void setInputman(String inputman) {
        this.inputman = inputman == null ? null : inputman.trim();
    }

    public Date getInputdate() {
        return inputdate;
    }

    public void setInputdate(Date inputdate) {
        this.inputdate = inputdate;
    }

    public Boolean getIsinsap() {
        return isinsap;
    }

    public void setIsinsap(Boolean isinsap) {
        this.isinsap = isinsap;
    }

    public String getInsapman() {
        return insapman;
    }

    public void setInsapman(String insapman) {
        this.insapman = insapman == null ? null : insapman.trim();
    }

    public Date getInsapdate() {
        return insapdate;
    }

    public void setInsapdate(Date insapdate) {
        this.insapdate = insapdate;
    }

    public Integer getInsapok() {
        return insapok;
    }

    public void setInsapok(Integer insapok) {
        this.insapok = insapok;
    }

    public String getOutputman() {
        return outputman;
    }

    public void setOutputman(String outputman) {
        this.outputman = outputman == null ? null : outputman.trim();
    }

    public Date getOutputdate() {
        return outputdate;
    }

    public void setOutputdate(Date outputdate) {
        this.outputdate = outputdate;
    }

    public Boolean getIsoutsap() {
        return isoutsap;
    }

    public void setIsoutsap(Boolean isoutsap) {
        this.isoutsap = isoutsap;
    }

    public String getOutsapman() {
        return outsapman;
    }

    public void setOutsapman(String outsapman) {
        this.outsapman = outsapman == null ? null : outsapman.trim();
    }

    public Date getOutsapdate() {
        return outsapdate;
    }

    public void setOutsapdate(Date outsapdate) {
        this.outsapdate = outsapdate;
    }

    public Integer getOutsapok() {
        return outsapok;
    }

    public void setOutsapok(Integer outsapok) {
        this.outsapok = outsapok;
    }

    public String getDono() {
        return dono;
    }

    public void setDono(String dono) {
        this.dono = dono == null ? null : dono.trim();
    }

    public String getDoitem() {
        return doitem;
    }

    public void setDoitem(String doitem) {
        this.doitem = doitem == null ? null : doitem.trim();
    }
}