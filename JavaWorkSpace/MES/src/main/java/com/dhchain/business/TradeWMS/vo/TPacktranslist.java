package com.dhchain.business.TradeWMS.vo;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;

public class TPacktranslist implements Serializable {
    /**
     * 主键
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Integer packagelistid;

    private String doxtbh;

    private String dono;

    private String doitem;

    private Boolean issap;

    private Boolean moveok;

    private String sapman;

    private Date sapdate;

    private Boolean isout;

    private Date outtime;

    private String serialno;

    private String boxnum;

    private String dhorderno;

    private String location;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPackagelistid() {
        return packagelistid;
    }

    public void setPackagelistid(Integer packagelistid) {
        this.packagelistid = packagelistid;
    }

    public String getDoxtbh() {
        return doxtbh;
    }

    public void setDoxtbh(String doxtbh) {
        this.doxtbh = doxtbh == null ? null : doxtbh.trim();
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

    public Boolean getIssap() {
        return issap;
    }

    public void setIssap(Boolean issap) {
        this.issap = issap;
    }

    public Boolean getMoveok() {
        return moveok;
    }

    public void setMoveok(Boolean moveok) {
        this.moveok = moveok;
    }

    public String getSapman() {
        return sapman;
    }

    public void setSapman(String sapman) {
        this.sapman = sapman == null ? null : sapman.trim();
    }

    public Date getSapdate() {
        return sapdate;
    }

    public void setSapdate(Date sapdate) {
        this.sapdate = sapdate;
    }

    public Boolean getIsout() {
        return isout;
    }

    public void setIsout(Boolean isout) {
        this.isout = isout;
    }

    public Date getOuttime() {
        return outtime;
    }

    public void setOuttime(Date outtime) {
        this.outtime = outtime;
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
        this.boxnum = boxnum;
    }

    public String getDhorderno() {
        return dhorderno;
    }

    public void setDhorderno(String dhorderno) {
        this.dhorderno = dhorderno;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}