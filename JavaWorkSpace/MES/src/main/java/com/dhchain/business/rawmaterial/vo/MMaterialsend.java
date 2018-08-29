package com.dhchain.business.rawmaterial.vo;

/**
 * Created by ASUS on 2018/8/3.
 */

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 材料发出
 *
 * @author ct
 * @date 2018-08-06
 */
public class MMaterialsend {
    /**
     * 主键
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
   private int id;
    private String        serialno;
    private String  plant;
    private String         department;
    private String   pono;
    private String          fno;
    private String  fname;
    private String          outputnum;
    private String  item;
    private String           norms;
    private String  heatno;
    private String          material;
    private String  supporname;
    private String          receivedate;
    private String   outputman;
    private String           outputtime;
    private String   modifyman;
    private String           modifytime;
    private String    inserialno;
    private String           inid;
    private String deliveryplant;

    public String getDeliveryplant() {
        return deliveryplant;
    }

    public void setDeliveryplant(String deliveryplant) {
        this.deliveryplant = deliveryplant;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSerialno() {
        return serialno;
    }

    public void setSerialno(String serialno) {
        this.serialno = serialno;
    }

    public String getPlant() {
        return plant;
    }

    public void setPlant(String plant) {
        this.plant = plant;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPono() {
        return pono;
    }

    public void setPono(String pono) {
        this.pono = pono;
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

    public String getOutputnum() {
        return outputnum;
    }

    public void setOutputnum(String outputnum) {
        this.outputnum = outputnum;
    }

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public String getNorms() {
        return norms;
    }

    public void setNorms(String norms) {
        this.norms = norms;
    }

    public String getHeatno() {
        return heatno;
    }

    public void setHeatno(String heatno) {
        this.heatno = heatno;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getSupporname() {
        return supporname;
    }

    public void setSupporname(String supporname) {
        this.supporname = supporname;
    }

    public String getReceivedate() {
        return receivedate;
    }

    public void setReceivedate(String receivedate) {
        this.receivedate = receivedate;
    }

    public String getOutputman() {
        return outputman;
    }

    public void setOutputman(String outputman) {
        this.outputman = outputman;
    }

    public String getOutputtime() {
        return outputtime;
    }

    public void setOutputtime(String outputtime) {
        this.outputtime = outputtime;
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

    public String getInserialno() {
        return inserialno;
    }

    public void setInserialno(String inserialno) {
        this.inserialno = inserialno;
    }

    public String getInid() {
        return inid;
    }

    public void setInid(String inid) {
        this.inid = inid;
    }
}
