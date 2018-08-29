package com.dhchain.business.partpunchingworkshop.vo;

public class EQPStatus {
    private  int ID;
    private String         EquipID;
    private String  PlanID;
    private String         ColdID;
    private String  EquipStatus;
    private String        DatePower;
    private String  RunTime;
    private String        Date;
    private String  Time;
    private String          EqPause;
    private String Plant;
    private String FactNum;
    private String StatusName;

    public String getStatusName() {
        return StatusName;
    }

    public void setStatusName(String statusName) {
        StatusName = statusName;
    }

    public String getPlant() {
        return Plant;
    }

    public void setPlant(String plant) {
        Plant = plant;
    }

    public String getFactNum() {
        return FactNum;
    }

    public void setFactNum(String factNum) {
        FactNum = factNum;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getEquipID() {
        return EquipID;
    }

    public void setEquipID(String equipID) {
        EquipID = equipID;
    }

    public String getPlanID() {
        return PlanID;
    }

    public void setPlanID(String planID) {
        PlanID = planID;
    }

    public String getColdID() {
        return ColdID;
    }

    public void setColdID(String coldID) {
        ColdID = coldID;
    }

    public String getEquipStatus() {
        return EquipStatus;
    }

    public void setEquipStatus(String equipStatus) {
        EquipStatus = equipStatus;
    }

    public String getDatePower() {
        return DatePower;
    }

    public void setDatePower(String datePower) {
        DatePower = datePower;
    }

    public String getRunTime() {
        return RunTime;
    }

    public void setRunTime(String runTime) {
        RunTime = runTime;
    }

    public String getDate() {
        return Date;
    }

    public void setDate(String date) {
        Date = date;
    }

    public String getTime() {
        return Time;
    }

    public void setTime(String time) {
        Time = time;
    }

    public String getEqPause() {
        return EqPause;
    }

    public void setEqPause(String eqPause) {
        EqPause = eqPause;
    }
}
