package com.dhchain.business.partpunchingworkshop.vo;

public class MoldReplace {
 private int   ID;

 private  String            MoldID;
    private  String    MoldRpMan;
    private  String           MoldRpBegTime;
    private  String    MoldRpEndTime;
    private  String           OldMoldID;
    private  String    OldLocation;

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getMoldID() {
        return MoldID;
    }

    public void setMoldID(String moldID) {
        MoldID = moldID;
    }

    public String getMoldRpMan() {
        return MoldRpMan;
    }

    public void setMoldRpMan(String moldRpMan) {
        MoldRpMan = moldRpMan;
    }

    public String getMoldRpBegTime() {
        return MoldRpBegTime;
    }

    public void setMoldRpBegTime(String moldRpBegTime) {
        MoldRpBegTime = moldRpBegTime;
    }

    public String getMoldRpEndTime() {
        return MoldRpEndTime;
    }

    public void setMoldRpEndTime(String moldRpEndTime) {
        MoldRpEndTime = moldRpEndTime;
    }

    public String getOldMoldID() {
        return OldMoldID;
    }

    public void setOldMoldID(String oldMoldID) {
        OldMoldID = oldMoldID;
    }

    public String getOldLocation() {
        return OldLocation;
    }

    public void setOldLocation(String oldLocation) {
        OldLocation = oldLocation;
    }
}
