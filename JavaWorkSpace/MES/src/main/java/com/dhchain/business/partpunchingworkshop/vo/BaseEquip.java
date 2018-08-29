package com.dhchain.business.partpunchingworkshop.vo;

public class BaseEquip {
    private int  ID;

    private  String        EquipID;
    private  String   EquipDHID;
    private  String           EquipName;
    private  String   EquipType;
    private  String          Manufacturer;
    private  String   MachineID;
    private  String         InputMan;
    private  String   InputTime;
    private  String        ModifyMan;
    private  String   ModifyTime;
    private  String         DepartMent;
    private  String  Plant;
    private  String  IP;
    private  String IPNO;
    private  String EquipMan;

    public String getEquipMan() {
        return EquipMan;
    }

    public void setEquipMan(String equipMan) {
        EquipMan = equipMan;
    }

    public String getIP() {
        return IP;
    }

    public void setIP(String IP) {
        this.IP = IP;
    }

    public String getIPNO() {
        return IPNO;
    }

    public void setIPNO(String IPNO) {
        this.IPNO = IPNO;
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

    public String getEquipDHID() {
        return EquipDHID;
    }

    public void setEquipDHID(String equipDHID) {
        EquipDHID = equipDHID;
    }

    public String getEquipName() {
        return EquipName;
    }

    public void setEquipName(String equipName) {
        EquipName = equipName;
    }

    public String getEquipType() {
        return EquipType;
    }

    public void setEquipType(String equipType) {
        EquipType = equipType;
    }

    public String getManufacturer() {
        return Manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        Manufacturer = manufacturer;
    }

    public String getMachineID() {
        return MachineID;
    }

    public void setMachineID(String machineID) {
        MachineID = machineID;
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

    public String getDepartMent() {
        return DepartMent;
    }

    public void setDepartMent(String departMent) {
        DepartMent = departMent;
    }

    public String getPlant() {
        return Plant;
    }

    public void setPlant(String plant) {
        Plant = plant;
    }
}
