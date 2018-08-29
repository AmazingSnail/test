package com.dhchain.business.partpunchingworkshop.vo;

public class BaseSupplier {
   private int ID;
  private  String  Supplier;
    private  String  MeterType;
    private  String  InputMan;
    private  String  InputTime;
    private  String   ModifyMan;
    private  String   ModifyTime;
    private String Ftemp1;
    private String Plant;
    private String Department;

    public String getPlant() {
        return Plant;
    }

    public void setPlant(String plant) {
        Plant = plant;
    }

    public String getDepartment() {
        return Department;
    }

    public void setDepartment(String department) {
        Department = department;
    }

    public String getFtemp1() {
        return Ftemp1;
    }

    public void setFtemp1(String ftemp1) {
        Ftemp1 = ftemp1;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getSupplier() {
        return Supplier;
    }

    public void setSupplier(String supplier) {
        Supplier = supplier;
    }

    public String getMeterType() {
        return MeterType;
    }

    public void setMeterType(String meterType) {
        MeterType = meterType;
    }

    public String getInputMan() {
        return InputMan;
    }

    public void setInputMan(String inputMan) {
        InputMan = inputMan;
    }

    public String getInputTime() {
        return InputTime;
    }

    public void setInputTime(String inputTime) {
        InputTime = inputTime;
    }

    public String getModifyMan() {
        return ModifyMan;
    }

    public void setModifyMan(String modifyMan) {
        ModifyMan = modifyMan;
    }

    public String getModifyTime() {
        return ModifyTime;
    }

    public void setModifyTime(String modifyTime) {
        ModifyTime = modifyTime;
    }
}
