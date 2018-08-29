package com.dhchain.business.HeatTreatment.vo;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * Created by ASUS on 2018/7/5.
 */
public class MPtheatfinish {
    /**
     * 主键
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
   private int id;
    private  String        plant;
    private  String prodnum;
    private  String equipid;
    private  String         planid;
    private  String   batchnum;
    private  String         fno;
    private  String fname;
    private  Float         weightnum;
    private  String  productman;
    private  String         heatno;
    private  String supplier;
    private  String factorytime;
    private  String   workcentre;
    private  String        serialno;
    private  String  begintime;
    private  String          endtime;
    private  String   expecttime;
    private  String          modifyman;
    private  String  modifytime;

    public String getProdnum() {
        return prodnum;
    }

    public void setProdnum(String prodnum) {
        this.prodnum = prodnum;
    }

    public String getBegintime() {
        return begintime;
    }

    public void setBegintime(String begintime) {
        this.begintime = begintime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public String getFactorytime() {
        return factorytime;
    }

    public void setFactorytime(String factorytime) {
        this.factorytime = factorytime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPlant() {
        return plant;
    }

    public void setPlant(String plant) {
        this.plant = plant;
    }

    public String getEquipid() {
        return equipid;
    }

    public void setEquipid(String equipid) {
        this.equipid = equipid;
    }

    public String getPlanid() {
        return planid;
    }

    public void setPlanid(String planid) {
        this.planid = planid;
    }

    public String getBatchnum() {
        return batchnum;
    }

    public void setBatchnum(String batchnum) {
        this.batchnum = batchnum;
    }

    public String getFno() {
        return fno;
    }

    public void setFno(String fno) {
        this.fno = fno;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public Float getWeightnum() {
        return weightnum;
    }

    public void setWeightnum(Float weightnum) {
        this.weightnum = weightnum;
    }

    public String getProductman() {
        return productman;
    }

    public void setProductman(String productman) {
        this.productman = productman;
    }

    public String getHeatno() {
        return heatno;
    }

    public void setHeatno(String heatno) {
        this.heatno = heatno;
    }

    public String getWorkcentre() {
        return workcentre;
    }

    public void setWorkcentre(String workcentre) {
        this.workcentre = workcentre;
    }

    public String getSerialno() {
        return serialno;
    }

    public void setSerialno(String serialno) {
        this.serialno = serialno;
    }


    public String getExpecttime() {
        return expecttime;
    }

    public void setExpecttime(String expecttime) {
        this.expecttime = expecttime;
    }

    public String getModifyman() {
        return modifyman;
    }

    public void setModifyman(String modifyman) {
        this.modifyman = modifyman;
    }

    public String getModifytime() {
        return modifytime;
    }

    public void setModifytime(String modifytime) {
        this.modifytime = modifytime;
    }
}
