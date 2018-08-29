package com.dhchain.business.code.service.impl;

import com.dhchain.business.attr.vo.Attr;
import com.dhchain.business.code.dao.CodeApplMapper;
import com.dhchain.business.code.dao.CodeMapper;
import com.dhchain.business.code.service.CodeApplService;
import com.dhchain.business.code.service.CodeService;
import com.dhchain.business.code.vo.Code;
import com.dhchain.business.code.vo.CodeAppl;
import com.dhchain.business.code.vo.CodeApplDetail;
import com.dhchain.business.code.vo.CodeType;
import com.dhchain.business.exp.dao.ExpMapper;
import com.dhchain.business.exp.vo.Exp;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhenglb on 2017-10-20.
 */
@Service("codeApplService")
public class CodeApplServiceImpl implements CodeApplService{
    @Autowired
    private CodeApplMapper codeApplMapper;

    @Override
    public List<Code> select(Code code) {
        return codeApplMapper.select(code);
    }
    @Override
    public List<Code> getCodeData(Code code) {
        return codeApplMapper.select(code);
    }

    @Override
    public CodeAppl selectById(int id) {
        return codeApplMapper.selectById(id);
    }

    @Override
    public List<CodeAppl> query(CodeAppl codeAppl) {
        return codeApplMapper.query(codeAppl);
    }

    @Override
    public boolean iscontain(String codeno) {
        boolean flag = false;

        return flag;
    }

    @Override
    public Code selectByCodeno(String codeno) {
        return codeApplMapper.selectByCodeno(codeno);
    }

    @Override
    public List<CodeType> selectByTypeno(String typeno) {
        return codeApplMapper.selectByTypeno(typeno);
    }
    @Override
    public List<Attr> getAttrList(String fieldName) {
        return codeApplMapper.getAttrList(fieldName);
    }
    @Override
    public int codeApplDetailSave(CodeApplDetail codeApplDetail) {
        return codeApplMapper.codeApplDetailSave(codeApplDetail);
    }

    @Override
    public Map selectMaxserialNumber(String typedetailno, int begin, int end, int length) {
        String  n = codeApplMapper.selectMaxserialNumber(typedetailno);
        String returnNo="";
        int serialnumber = 0;
        NumberFormat nf = NumberFormat.getInstance();
        nf.setMaximumIntegerDigits(length);
        nf.setMinimumIntegerDigits(length);
        if(n==null){
            serialnumber = begin;
            returnNo = nf.format(begin);
        }else {
            int max = Integer.parseInt(n);
            if(max<end){

                serialnumber = max + 1;
                returnNo = nf.format(serialnumber);
            }
        }
        Map map = new HashMap();
        map.put("serialnumber",serialnumber);
        map.put("returnNo",returnNo.replace(",",""));
        return map;
    }

    @Override
    public List<CodeApplDetail> selectExistDetail(CodeApplDetail codeApplDetail) {
        return codeApplMapper.selectExistDetail(codeApplDetail);
    }

    @Override
    public HSSFWorkbook exportExcelInfo(Map map) {
        //初始一个workbook
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFCellStyle fontStyle;
        HSSFCellStyle fontStyle2;
        HSSFCellStyle fontStyle3;
        // 表头
        fontStyle = workbook.createCellStyle();
        HSSFFont font1 = workbook.createFont();
        font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        font1.setFontName("黑体");
        font1.setFontHeightInPoints((short) 14);// 设置字体大小
        fontStyle.setFont(font1);
        fontStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 下边框
        fontStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);// 左边框
        fontStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);// 上边框
        fontStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);// 右边框
        fontStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
        fontStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);//设置前景填充样式
        fontStyle.setFillForegroundColor(HSSFColor.DARK_RED.index);//前景填充色
        // 内容
        fontStyle2=workbook.createCellStyle();
        HSSFFont font2 = workbook.createFont();
        font2.setFontName("宋体");
        font2.setFontHeightInPoints((short) 10);// 设置字体大小
        fontStyle2.setFont(font2);
        fontStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 下边框
        fontStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);// 左边框
        fontStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);// 上边框
        fontStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);// 右边框
        fontStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
//        fontStyle2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);//设置前景填充样式
//        fontStyle2.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);//前景填充色

//获取第一张
        HSSFSheet sheet = workbook.createSheet("出口链条装箱单");
        sheet.setColumnWidth(1, 4000);
        sheet.setColumnWidth(2, 5500);
        sheet.setColumnWidth(3, 5500);
        sheet.setColumnWidth(4, 7700);
        sheet.setColumnWidth(6, 2500);
        sheet.setColumnWidth(9, 5500);
        sheet.setColumnWidth(15, 6000);
        sheet.setColumnWidth(16, 3000);
        sheet.setColumnWidth(17, 5000);
        sheet.setColumnWidth(18, 2500);
        HSSFCellStyle style = workbook.createCellStyle();
        style.setFillBackgroundColor(HSSFCellStyle.LEAST_DOTS);
        style.setFillPattern(HSSFCellStyle.LEAST_DOTS);

//设置Excel中的边框(表头的边框)
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
        style.setBottomBorderColor(HSSFColor.BLACK.index);
        style.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
        style.setLeftBorderColor(HSSFColor.BLACK.index);
        style.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
        style.setRightBorderColor(HSSFColor.BLACK.index);
        style.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
        style.setTopBorderColor(HSSFColor.BLACK.index);


        HSSFCellStyle cellStyle1 = workbook.createCellStyle();
        cellStyle1.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平布局：居中
        HSSFRow rowTitle = sheet.createRow(0);
        rowTitle.setHeightInPoints(30);
        HSSFCell ctitle = rowTitle.createCell(6);
        ctitle.setCellValue("齐套性检查");
        // 设置字体
        HSSFFont font = workbook.createFont();
        font.setFontHeightInPoints((short) 20); //字体高度
        cellStyle1.setFont(font);
        ctitle.setCellStyle(cellStyle1);
        HSSFCellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
        HSSFCellStyle cellStyle2 = workbook.createCellStyle();
        cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平布局：居中
        cellStyle2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
        cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        cellStyle2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);//设置前景填充样式
        cellStyle2.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);//前景填充色

        //箱样式
        HSSFCellStyle cellStyle3 = workbook.createCellStyle();
        cellStyle3.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平布局：居中
        cellStyle3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
        cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框

        // 箱样式
        HSSFCellStyle cellStyle4 = workbook.createCellStyle();
        cellStyle4.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平布局：居中
        cellStyle4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
        cellStyle4.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        cellStyle4.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        cellStyle4.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        cellStyle4.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        cellStyle4.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);//设置前景填充样式
        cellStyle4.setFillForegroundColor(HSSFColor.RED.index);//前景填充色
        // 出库样式
        HSSFCellStyle cellStyle5 = workbook.createCellStyle();
        cellStyle5.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平布局：居中
        cellStyle5.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
        cellStyle5.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        cellStyle5.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        cellStyle5.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        cellStyle5.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        cellStyle5.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);//设置前景填充样式
        cellStyle5.setFillForegroundColor(HSSFColor.LIME.index);//前景填充色
        return workbook;
    }


    @Override
    public String selectTodayMaxApplyno() {
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyMMdd");
        String timeStr=dateFormat.format(new Date());
        String returnNo="";
        String a = "C"+timeStr;
        String maxApplyno = codeApplMapper.selectTodayMaxApplyno(a);
        if(maxApplyno==null||maxApplyno.equals("")){
            returnNo = a + "001";
        }else{
            String c=maxApplyno.substring(maxApplyno.length()-3);
            BigDecimal bigDecimal=new BigDecimal(c);
            BigDecimal rs=bigDecimal.add(new BigDecimal("1"));
            String end=rs.toString();
            if(end.length()==1){
                end="00"+end;
            }else if(end.length()==2){
                end="0"+end;
            }
            returnNo=a+end;
        }
        return returnNo;
    }

    @Override
    public int getMaxItemno(String applyno) {
        return codeApplMapper.getMaxItemno(applyno);
    }

    @Override
    public int add(CodeAppl codeAppl) {
        int n = codeApplMapper.add(codeAppl);
        return n;
    }

    @Override
    public int update(CodeAppl codeAppl) {
        return codeApplMapper.update(codeAppl);
    }

    @Override
    public int insertDetail(CodeApplDetail codeApplDetail) {
        return codeApplMapper.codeApplDetailSave(codeApplDetail);
    }

    @Override
    public int selectNewId() {
        return codeApplMapper.selectNewId();
    }

    @Override
    public int selectNewDetailId() {
        return codeApplMapper.selectNewDetailId();
    }

    @Override
    public int updateCodeApplDetail(CodeApplDetail codeApplDetail) {
        return codeApplMapper.updateCodeApplDetail(codeApplDetail);
    }

    @Override
    public int deletecodeappldetail(int id) {
        return codeApplMapper.deletecodeappldetail(id);
    }

    @Override
    public CodeApplDetail selectByDetailId(int id) {
        return codeApplMapper.selectByDetailId(id);
    }

    @Override
    public CodeAppl getCodeApplByTaskId(String processInstanceId) {
        return codeApplMapper.getCodeApplByTaskId(processInstanceId);
    }

    @Override
    public CodeAppl selectByApplyno(String applyno) {
        return codeApplMapper.selectByApplyno(applyno);
    }

    @Override
    public List<CodeApplDetail> selectDetailByApplyno(String applyno) {
        return codeApplMapper.selectDetailByApplyno(applyno);
    }


}
