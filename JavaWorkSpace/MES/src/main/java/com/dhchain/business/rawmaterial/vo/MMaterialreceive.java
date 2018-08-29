package com.dhchain.business.rawmaterial.vo;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * Created by ASUS on 2018/8/3.
 */
/**
 * 材料接收表（不含receivedate1）
 *
 * @author ct
 * @date 2018-08-06
 */
public class MMaterialreceive {
    /**
     * 主键
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
   private int id;
    private  String        serialno;
    private  String    plant;
    private  String          department;
    private  String   pono;
    private  String           fno;
    private  String    fname;
    private  String          norms;
    private  String   heatno;
    private  String           material;
    private  String   supporname;
    private  String           receivedate;
    private  String   receivenum;
    private  String           item;
    private  String   leavenum;
    private  String           receiveman;
    private  String    receivetime;
    private  String          modifyman;
    private  String   modifytime;
    private  String           ischeck;
    private  String   checkman;
    private  String           checktime;
    private  String   isprint;
    private  String           printman;
    private  String    printtime;
    private String uyear;
    private String umonth;

    public String getUyear() {
        return uyear;
    }

    public void setUyear(String uyear) {
        this.uyear = uyear;
    }

    public String getUmonth() {
        return umonth;
    }

    public void setUmonth(String umonth) {
        this.umonth = umonth;
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

    public String getReceivenum() {
        return receivenum;
    }

    public void setReceivenum(String receivenum) {
        this.receivenum = receivenum;
    }

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public String getLeavenum() {
        return leavenum;
    }

    public void setLeavenum(String leavenum) {
        this.leavenum = leavenum;
    }

    public String getReceiveman() {
        return receiveman;
    }

    public void setReceiveman(String receiveman) {
        this.receiveman = receiveman;
    }

    public String getReceivetime() {
        return receivetime;
    }

    public void setReceivetime(String receivetime) {
        this.receivetime = receivetime;
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

    public String getIscheck() {
        return ischeck;
    }

    public void setIscheck(String ischeck) {
        this.ischeck = ischeck;
    }

    public String getCheckman() {
        return checkman;
    }

    public void setCheckman(String checkman) {
        this.checkman = checkman;
    }

    public String getChecktime() {
        return checktime;
    }

    public void setChecktime(String checktime) {
        this.checktime = checktime;
    }

    public String getIsprint() {
        return isprint;
    }

    public void setIsprint(String isprint) {
        this.isprint = isprint;
    }

    public String getPrintman() {
        return printman;
    }

    public void setPrintman(String printman) {
        this.printman = printman;
    }

    public String getPrinttime() {
        return printtime;
    }

    public void setPrinttime(String printtime) {
        this.printtime = printtime;
    }
}
