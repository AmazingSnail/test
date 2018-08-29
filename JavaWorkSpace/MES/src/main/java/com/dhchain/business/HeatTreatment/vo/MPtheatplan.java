package com.dhchain.business.HeatTreatment.vo;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * Created by ct on 2018/7/5.
 */
public class MPtheatplan {
    /**
     * 主键
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
   private  int  id ;
   private  String         plant;
    private  String   fno;
    private  String            fname;
    private  String      partdrawing;
    private  String             workcentre;
    private  String     material;
    private  String              processnode;
    private  String       inputman;
    private  String            inputdate;
    private  String    modifyman;
    private  String            modifytime;
    private String surface;
    private  String department;
    private String partname;

    public String getPartname() {
        return partname;
    }

    public void setPartname(String partname) {
        this.partname = partname;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getSurface() {
        return surface;
    }

    public void setSurface(String surface) {
        this.surface = surface;
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

    public String getPartdrawing() {
        return partdrawing;
    }

    public void setPartdrawing(String partdrawing) {
        this.partdrawing = partdrawing;
    }

    public String getWorkcentre() {
        return workcentre;
    }

    public void setWorkcentre(String workcentre) {
        this.workcentre = workcentre;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getProcessnode() {
        return processnode;
    }

    public void setProcessnode(String processnode) {
        this.processnode = processnode;
    }

    public String getInputman() {
        return inputman;
    }

    public void setInputman(String inputman) {
        this.inputman = inputman;
    }

    public String getInputdate() {
        return inputdate;
    }

    public void setInputdate(String inputdate) {
        this.inputdate = inputdate;
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
