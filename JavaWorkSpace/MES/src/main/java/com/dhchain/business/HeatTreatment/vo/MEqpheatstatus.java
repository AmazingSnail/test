package com.dhchain.business.HeatTreatment.vo;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * Created by ASUS on 2018/7/24.
 */
public class MEqpheatstatus {
    /**
     * 主键
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  int id;
     private String       equipid;
    private String    eqstatus;
    private String          quenchtemp1;
    private String   quenchtemp2;
    private String         quenchtemp3;
    private String     quenchtemp4;
    private String            quenchtemp5;
    private String    quenchtime;
    private String           cooltemp;
    private String     carpotential;
    private String           tempertemp1;
    private String   tempertemp2;
    private String            tempertemp3;
    private String   tempertime;
    private String          scantime;
    private String   modifyman;
    private String          modifytime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEquipid() {
        return equipid;
    }

    public void setEquipid(String equipid) {
        this.equipid = equipid;
    }

    public String getEqstatus() {
        return eqstatus;
    }

    public void setEqstatus(String eqstatus) {
        this.eqstatus = eqstatus;
    }

    public String getQuenchtemp1() {
        return quenchtemp1;
    }

    public void setQuenchtemp1(String quenchtemp1) {
        this.quenchtemp1 = quenchtemp1;
    }

    public String getQuenchtemp2() {
        return quenchtemp2;
    }

    public void setQuenchtemp2(String quenchtemp2) {
        this.quenchtemp2 = quenchtemp2;
    }

    public String getQuenchtemp3() {
        return quenchtemp3;
    }

    public void setQuenchtemp3(String quenchtemp3) {
        this.quenchtemp3 = quenchtemp3;
    }

    public String getQuenchtemp4() {
        return quenchtemp4;
    }

    public void setQuenchtemp4(String quenchtemp4) {
        this.quenchtemp4 = quenchtemp4;
    }

    public String getQuenchtemp5() {
        return quenchtemp5;
    }

    public void setQuenchtemp5(String quenchtemp5) {
        this.quenchtemp5 = quenchtemp5;
    }

    public String getQuenchtime() {
        return quenchtime;
    }

    public void setQuenchtime(String quenchtime) {
        this.quenchtime = quenchtime;
    }

    public String getCooltemp() {
        return cooltemp;
    }

    public void setCooltemp(String cooltemp) {
        this.cooltemp = cooltemp;
    }

    public String getCarpotential() {
        return carpotential;
    }

    public void setCarpotential(String carpotential) {
        this.carpotential = carpotential;
    }

    public String getTempertemp1() {
        return tempertemp1;
    }

    public void setTempertemp1(String tempertemp1) {
        this.tempertemp1 = tempertemp1;
    }

    public String getTempertemp2() {
        return tempertemp2;
    }

    public void setTempertemp2(String tempertemp2) {
        this.tempertemp2 = tempertemp2;
    }

    public String getTempertemp3() {
        return tempertemp3;
    }

    public void setTempertemp3(String tempertemp3) {
        this.tempertemp3 = tempertemp3;
    }

    public String getTempertime() {
        return tempertime;
    }

    public void setTempertime(String tempertime) {
        this.tempertime = tempertime;
    }

    public String getScantime() {
        return scantime;
    }

    public void setScantime(String scantime) {
        this.scantime = scantime;
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
