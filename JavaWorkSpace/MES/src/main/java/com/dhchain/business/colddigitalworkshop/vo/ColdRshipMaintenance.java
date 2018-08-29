package com.dhchain.business.colddigitalworkshop.vo;

import java.io.Serializable;

public class ColdRshipMaintenance extends ColdRshipMaintenanceKey implements Serializable {
    private String freelnum;

    private String vbeln;

    private Double weight;

    private String specification;

    private String note;

    private String year;

    private String month;

    private  String inputman;

    private String inputdate;

    private String rspecification;

    private String rweight;

    private String materialtype;

    private String steelworks;

    private String qualitybrand;

    public String getMaterialtype() {
        return materialtype;
    }

    public void setMaterialtype(String materialtype) {
        this.materialtype = materialtype;
    }

    public String getSteelworks() {
        return steelworks;
    }

    public void setSteelworks(String steelworks) {
        this.steelworks = steelworks;
    }

    public String getQualitybrand() {
        return qualitybrand;
    }

    public void setQualitybrand(String qualitybrand) {
        this.qualitybrand = qualitybrand;
    }

    public String getRspecification() {
        return rspecification;
    }

    public void setRspecification(String rspecification) {
        this.rspecification = rspecification;
    }

    public String getRweight() {
        return rweight;
    }

    public void setRweight(String rweight) {
        this.rweight = rweight;
    }

    public String getInputdate() {
        return inputdate;
    }

    public void setInputdate(String inputdate) {
        this.inputdate = inputdate;
    }

    public String getInputman() {
        return inputman;
    }

    public void setInputman(String inputman) {
        this.inputman = inputman;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    private static final long serialVersionUID = 1L;

    public String getFreelnum() {
        return freelnum;
    }

    public void setFreelnum(String freelnum) {
        this.freelnum = freelnum == null ? null : freelnum.trim();
    }

    public String getVbeln() {
        return vbeln;
    }

    public void setVbeln(String vbeln) {
        this.vbeln = vbeln == null ? null : vbeln.trim();
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification == null ? null : specification.trim();
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note == null ? null : note.trim();
    }
}