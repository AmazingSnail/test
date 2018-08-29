package com.dhchain.business.partpunchingworkshop.vo;
//工艺文档
public class CraftFile {
    private  int id;
    private String        PartDrawing;
    private String   PartName;
    private String          CraftFileName;
    private   byte[]  CraftFile;
    private String          InputMan;
    private String   InputTime;
    private String         ModifyMan;
    private String    ModifyTime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPartDrawing() {
        return PartDrawing;
    }

    public void setPartDrawing(String partDrawing) {
        PartDrawing = partDrawing;
    }

    public String getPartName() {
        return PartName;
    }

    public void setPartName(String partName) {
        PartName = partName;
    }

    public String getCraftFileName() {
        return CraftFileName;
    }

    public void setCraftFileName(String craftFileName) {
        CraftFileName = craftFileName;
    }

    public byte[] getCraftFile() {
        return CraftFile;
    }

    public void setCraftFile(byte[] craftFile) {
        CraftFile = craftFile;
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
