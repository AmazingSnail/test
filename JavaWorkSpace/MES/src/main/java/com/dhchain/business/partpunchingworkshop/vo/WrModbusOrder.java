package com.dhchain.business.partpunchingworkshop.vo;

public class WrModbusOrder {
    private int ID;
    private  String EquipID;
    private  String WriOrder;
    private  String Types;
    private String Mark;
    private  String OrderName;
    private  String FieType;

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

    public String getWriOrder() {
        return WriOrder;
    }

    public void setWriOrder(String wriOrder) {
        WriOrder = wriOrder;
    }

    public String getTypes() {
        return Types;
    }

    public void setTypes(String types) {
        Types = types;
    }

    public String getMark() {
        return Mark;
    }

    public void setMark(String mark) {
        Mark = mark;
    }

    public String getOrderName() {
        return OrderName;
    }

    public void setOrderName(String orderName) {
        OrderName = orderName;
    }

    public String getFieType() {
        return FieType;
    }

    public void setFieType(String fieType) {
        FieType = fieType;
    }
}
