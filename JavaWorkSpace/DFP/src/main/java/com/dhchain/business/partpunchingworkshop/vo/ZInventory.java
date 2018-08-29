package com.dhchain.business.partpunchingworkshop.vo;

import java.io.Serializable;
import java.util.Date;

public class ZInventory implements Serializable {
    private Integer id;

    private String werks;

    private String lgort;

    private String matnr;

    private String mbwbest;

    private String kgsl;

    private String pcsl;

    private String basme;

    private Date letztbew;

    private String vprsv;

    private String verpr;

    private String stprs;

    private Double peinh;

    private String zje;

    private String maktx;

    private String zbjnrx;

    private Date letztzug;

    private Date letztabg;

    private Date letztver;

    private String kaln1;

    private String remark1;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getWerks() {
        return werks;
    }

    public void setWerks(String werks) {
        this.werks = werks == null ? null : werks.trim();
    }

    public String getLgort() {
        return lgort;
    }

    public void setLgort(String lgort) {
        this.lgort = lgort == null ? null : lgort.trim();
    }

    public String getMatnr() {
        return matnr;
    }

    public void setMatnr(String matnr) {
        this.matnr = matnr == null ? null : matnr.trim();
    }

    public String getMbwbest() {
        return mbwbest;
    }

    public void setMbwbest(String mbwbest) {
        this.mbwbest = mbwbest == null ? null : mbwbest.trim();
    }

    public String getKgsl() {
        return kgsl;
    }

    public void setKgsl(String kgsl) {
        this.kgsl = kgsl == null ? null : kgsl.trim();
    }

    public String getPcsl() {
        return pcsl;
    }

    public void setPcsl(String pcsl) {
        this.pcsl = pcsl == null ? null : pcsl.trim();
    }

    public String getBasme() {
        return basme;
    }

    public void setBasme(String basme) {
        this.basme = basme == null ? null : basme.trim();
    }

    public Date getLetztbew() {
        return letztbew;
    }

    public void setLetztbew(Date letztbew) {
        this.letztbew = letztbew;
    }

    public String getVprsv() {
        return vprsv;
    }

    public void setVprsv(String vprsv) {
        this.vprsv = vprsv == null ? null : vprsv.trim();
    }

    public String getVerpr() {
        return verpr;
    }

    public void setVerpr(String verpr) {
        this.verpr = verpr == null ? null : verpr.trim();
    }

    public String getStprs() {
        return stprs;
    }

    public void setStprs(String stprs) {
        this.stprs = stprs == null ? null : stprs.trim();
    }

    public Double getPeinh() {
        return peinh;
    }

    public void setPeinh(Double peinh) {
        this.peinh = peinh;
    }

    public String getZje() {
        return zje;
    }

    public void setZje(String zje) {
        this.zje = zje == null ? null : zje.trim();
    }

    public String getMaktx() {
        return maktx;
    }

    public void setMaktx(String maktx) {
        this.maktx = maktx == null ? null : maktx.trim();
    }

    public String getZbjnrx() {
        return zbjnrx;
    }

    public void setZbjnrx(String zbjnrx) {
        this.zbjnrx = zbjnrx == null ? null : zbjnrx.trim();
    }

    public Date getLetztzug() {
        return letztzug;
    }

    public void setLetztzug(Date letztzug) {
        this.letztzug = letztzug;
    }

    public Date getLetztabg() {
        return letztabg;
    }

    public void setLetztabg(Date letztabg) {
        this.letztabg = letztabg;
    }

    public Date getLetztver() {
        return letztver;
    }

    public void setLetztver(Date letztver) {
        this.letztver = letztver;
    }

    public String getKaln1() {
        return kaln1;
    }

    public void setKaln1(String kaln1) {
        this.kaln1 = kaln1 == null ? null : kaln1.trim();
    }

    public String getRemark1() {
        return remark1;
    }

    public void setRemark1(String remark1) {
        this.remark1 = remark1 == null ? null : remark1.trim();
    }
}