package com.dhchain.business.partpunchingworkshop.vo;

public class BaseStatus {
   private int ID;
    private  String        StatusID;
    private  String     StatusName;
    private  String         DepartMent;
    private  String  InputMan;
    private  String         InputTime;
    private  String   ModifyMan;
    private  String         ModifyTime;

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getStatusID() {
        return StatusID;
    }

    public void setStatusID(String statusID) {
        StatusID = statusID;
    }

    public String getStatusName() {
        return StatusName;
    }

    public void setStatusName(String statusName) {
        StatusName = statusName;
    }

    public String getDepartMent() {
        return DepartMent;
    }

    public void setDepartMent(String departMent) {
        DepartMent = departMent;
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
