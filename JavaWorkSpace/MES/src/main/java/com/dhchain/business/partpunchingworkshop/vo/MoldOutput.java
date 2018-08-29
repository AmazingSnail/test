package com.dhchain.business.partpunchingworkshop.vo;

public class MoldOutput {
    private int ID;
    private  String        MouldID;
    private  String  Remark;
    private  String         OutputTypes;
    private  String  LDepartment;
    private  String          EquipID;
    private  String   OutputMan;
    private  String          OutputTime;
    private  String   Location;

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getMouldID() {
        return MouldID;
    }

    public void setMouldID(String mouldID) {
        MouldID = mouldID;
    }

    public String getRemark() {
        return Remark;
    }

    public void setRemark(String remark) {
        Remark = remark;
    }

    public String getOutputTypes() {
        return OutputTypes;
    }

    public void setOutputTypes(String outputTypes) {
        OutputTypes = outputTypes;
    }

    public String getLDepartment() {
        return LDepartment;
    }

    public void setLDepartment(String LDepartment) {
        this.LDepartment = LDepartment;
    }

    public String getEquipID() {
        return EquipID;
    }

    public void setEquipID(String equipID) {
        EquipID = equipID;
    }

    public String getOutputMan() {
        return OutputMan;
    }

    public void setOutputMan(String outputMan) {
        OutputMan = outputMan;
    }

    public String getOutputTime() {
        return OutputTime;
    }

    public void setOutputTime(String outputTime) {
        OutputTime = outputTime;
    }

    public String getLocation() {
        return Location;
    }

    public void setLocation(String location) {
        Location = location;
    }
}
