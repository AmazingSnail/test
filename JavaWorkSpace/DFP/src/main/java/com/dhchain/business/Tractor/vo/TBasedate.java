package com.dhchain.business.Tractor.vo;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

public class TBasedate {
    /**
     * 主键
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
  private  int  id;
   private String zmach;
   private String type;
   private String model;
   private String wheelbase;
   private String outsize;
   private String demarcatedforce;
   private String minuse;
   private String execstd;
   private  String inputman;
   private String inputtime;
   private String modifyman;
   private  String modifytime;
    private String plant;

    public String getPlant() {
        return plant;
    }

    public void setPlant(String plant) {
        this.plant = plant;
    }
    public String getInputman() {
        return inputman;
    }

    public void setInputman(String inputman) {
        this.inputman = inputman;
    }

    public String getInputtime() {
        return inputtime;
    }

    public void setInputtime(String inputtime) {
        this.inputtime = inputtime;
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getZmach() {
        return zmach;
    }

    public void setZmach(String zmach) {
        this.zmach = zmach;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getWheelbase() {
        return wheelbase;
    }

    public void setWheelbase(String wheelbase) {
        this.wheelbase = wheelbase;
    }

    public String getOutsize() {
        return outsize;
    }

    public void setOutsize(String outsize) {
        this.outsize = outsize;
    }

    public String getDemarcatedforce() {
        return demarcatedforce;
    }

    public void setDemarcatedforce(String demarcatedforce) {
        this.demarcatedforce = demarcatedforce;
    }

    public String getMinuse() {
        return minuse;
    }

    public void setMinuse(String minuse) {
        this.minuse = minuse;
    }

    public String getExecstd() {
        return execstd;
    }

    public void setExecstd(String execstd) {
        this.execstd = execstd;
    }
}
