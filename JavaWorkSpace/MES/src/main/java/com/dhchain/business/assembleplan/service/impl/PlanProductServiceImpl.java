package com.dhchain.business.assembleplan.service.impl;

import com.dhchain.business.assembleplan.dao.PlanProductMapper;
import com.dhchain.business.assembleplan.service.PlanProductService;
import com.dhchain.business.assembleplan.vo.PlanProduct;
import com.dhchain.business.assembleplan.vo.Plant;
import com.dhchain.business.assembleplan.vo.check;
import com.dhchain.config.annotation.DataSource;
import com.dhchain.config.annotation.Type;
import com.dhchain.config.datasource.DataSourceHolder;
import com.dhchain.config.vo.ExcelBean;
import com.dhchain.config.vo.ExcelUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.beans.IntrospectionException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by xieyj on 2017-7-18.
 */
@Service("PlanProductService")
public class PlanProductServiceImpl implements PlanProductService {
    @Autowired
    private PlanProductMapper planProuductMapper;
    @Override
    @DataSource(Type.SQL_MDM)
//    @Transactional(propagation= Propagation.REQUIRED,rollbackFor=Exception.class)//当方法抛出异常用来回滚事务
    public List<PlanProduct> getListPP(PlanProduct query, String plant, String umouth, String uyear, String DHorder, String Des, String fname) {
        List<PlanProduct> list = planProuductMapper.getListPP(query,plant,umouth,uyear,DHorder,Des,fname);
        return list;
    }

    @Override
    @DataSource(Type.SQL_MDM)
//    @Transactional(propagation= Propagation.REQUIRED,rollbackFor=Exception.class)//当方法抛出异常用来回滚事务
    public List<Plant> getPlant(Plant query) {
        List<Plant> list = planProuductMapper.getPlant(query);

        return list;
    }
    @Override
    @DataSource(Type.SQL_MDM)//默认是读库，使用该注解强制该方法使用写库
//    @Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//当方法抛出异常用来回滚事务
    public int updataPlanProduct(PlanProduct query) {
        int R = planProuductMapper.updataPlanProduct(query);

        return R;
    }

    @Override
    @DataSource(Type.SQL_MDM)//默认是读库，使用该注解强制该方法使用写库
//    @Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//当方法抛出异常用来回滚事务
    public int aprefrashmix(PlanProduct query) {
        int R = planProuductMapper.aprefrashmix(query);

        return R;
    }


    @Override
//    @DataSource//默认是读库，使用该注解强制该方法使用写库
//    @Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//当方法抛出异常用来回滚事务
    public String importExcelInfo(InputStream in, MultipartFile file, String plant,String User,String mpupinst,String umouth,String uyear) throws Exception{
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        String OK="";
        String NO="";
        String Err="";
        List<List<Object>> listob = ExcelUtil.getBankListByExcel(in,file.getOriginalFilename());//调用Excel解析类
        List list = new ArrayList<PlanProduct>();
        //遍历listob数据，把数据放到List中
        for (int i = 1; i < listob.size(); i++) {
            String Errmark="";
            SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd");
            List<Object> ob = listob.get(i);
            if(String.valueOf(ob.get(0)).equals("")){
                break;
            }else{
            for (int a = 0; a < 23; a++){
                if(a==8||a==13||a==10||a==11||a==12||a==20||a==22||a==21||a==23||a==17){
                a++;
            }if(a !=21&&a !=23&&a !=11){
                    if(String.valueOf(ob.get(a)).equals("")){
                        int b=a+1;
                        int c = i+2;
                        Err=Err+ "错误：第"+c+"行，第"+b+"列为空白格！";
                        Errmark=Errmark+"错误：第"+c+"行，第"+b+"列为空白格！";
                    }
                }

            }
            if(String.valueOf(ob.get(6)).length()>199){
                int c = i+2;
                Err =Err+"错误：第"+c+"行，打印标记字段过长！";
                Errmark=Errmark+"错误：第"+c+"行，打印标记字段过长！";
            }
            PlanProduct salarymanage = new PlanProduct();
            //设置编号
            if(!String.valueOf(ob.get(14)).equals("W")&&!String.valueOf(ob.get(14)).equals("N")){
                int c = i+2;
                Err =Err+"错误：第"+c+"行，内外销必须为W或N！";
                Errmark=Errmark+"错误：第"+c+"行，内外销必须为W或N！";
            }
            /////判断厂编
            if (String.valueOf(ob.get(19)).length()>15){
                String Order = String.valueOf(ob.get(19)).split("/")[1];
                for (int b=0; b<Order.length(); b++) {
                    if (Character.isDigit(Order.charAt(b))==false) {
                        int c = i+2;
                        Err =Err+"错误:第"+c+"行，行号必须为数字！";
                        Errmark=Errmark+"错误:第"+c+"行，行号必须为数字！";
                    }
                }
            }
                if (String.valueOf(ob.get(6)).length()>100){
                    int c = i+2;
                    Err=Err+"错误:第"+c+"行，描述（打印标记等）过长！";
                    Errmark=Errmark+"错误:第"+c+"行，描述（打印标记等）过长！";
                }
            String Pass="";
           if(String.valueOf(ob.get(19)).length()>0){
               Pass=String.valueOf(ob.get(19)).substring(0,String.valueOf(ob.get(19)).indexOf("/"));
               String DH =String.valueOf(ob.get(19)).substring(0,1);
               String DJH =String.valueOf(ob.get(19)).substring(0,3);
               if(!DH.equals("W")&&!DH.equals("N")&&!DH.equals("Q")&&!DH.equals("B")&&!DH.equals("F")&&!DH.equals("J")&&!DH.equals("S")&&!DH.equals("X")
                       &&!DH.equals("G")&&!DH.equals("M")&&!DJH.equals("大计划")){
                   int c = i+2;
                   Err =Err+"错误:第"+c+"行，厂编合同及行号必须已W、N、Q、B、F、J、M或大计划开头！";
                   Errmark =Errmark+"错误:第"+c+"行，厂编合同及行号必须已W、N、Q、B、F、J、M或大计划开头！";
               }
               if(!DJH.equals("大计划")&&Pass.length()!=13&&Pass.length()!=16){
                   int c = i+2;
                   Err=Err+"错误:第"+c+"行，厂编合同及行号,厂编合同部分必须为13或16位！";
                   Errmark=Errmark+"错误:第"+c+"行，厂编合同及行号,厂编合同部分必须为13或16位！";
               }
           }
            //校验外销订单号
            DataSourceHolder.setDataSourceName(Type.SQL_EPPRD.getName());
            List<check> SAPOrder = this.check(Pass);
            check checkerp;
            String  Erpsysno="";
            if(SAPOrder.size()>0){
                checkerp = (check) SAPOrder.get(0);
                Erpsysno =checkerp.getErpsysno();
            }
                //切换数据库
                DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
            if((Erpsysno.equals("")||Erpsysno.equals(null))&&String.valueOf(ob.get(14)).equals("W")) {
                int c = i+2;
                Err = Err + "错误：第"+c+"行，外销计划厂编对应销售订单不存在！";
                Errmark = Errmark + "错误：第"+c+"行，外销计划厂编对应销售订单不存在！";
            }
            if (Err.contains("错误")){
                int d =i+1;
//                Err="excel第"+d+"行，"+Err+"";
//                return Err;
                continue;
            }
            //切换数据库
            DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
            salarymanage.setInputdate(df.format(new Date()));
            salarymanage.setInputman(User);
            salarymanage.setDhorderno(String.valueOf(ob.get(0)));
            salarymanage.setTakeOrder(time.format(time.parse(ob.get(1).toString())));
            salarymanage.setOrderTime(time.format(time.parse(ob.get(2).toString())));
            salarymanage.setPartDrawing(String.valueOf(ob.get(3)));
            salarymanage.setF3(Float.parseFloat(String.valueOf(ob.get(4))));
            salarymanage.setColor(String.valueOf(ob.get(5)));
            salarymanage.setDescrip(String.valueOf(ob.get(6)));
            if(String.valueOf(ob.get(7)).equals("")){
                salarymanage.setConnectPlan(0);
            }else{
                salarymanage.setConnectPlan(Float.parseFloat(String.valueOf(ob.get(7))));
            }
            if(String.valueOf(ob.get(8)).equals("")){
                salarymanage.setSumDayNum(0);
            }else{
                salarymanage.setSumDayNum(Float.parseFloat(String.valueOf(ob.get(8))));
            }
            salarymanage.setNumber(String.valueOf(ob.get(9)));
            if(String.valueOf(ob.get(10)).equals("")){
                salarymanage.setSumDayInput("0");
            }else{
                salarymanage.setSumDayInput(String.valueOf(ob.get(10)));
            }
            if(String.valueOf(ob.get(11)).equals("")){
                salarymanage.setIsCheck("0");
            }else{
                salarymanage.setIsCheck(String.valueOf(ob.get(11)));
            }
            if(plant.equals("传动链")){
                if(String.valueOf(ob.get(12)).equals("是")){
                    salarymanage.setIsCl("1");
                }else{
                    salarymanage.setIsCl("0");
                }
            }else{
                salarymanage.setIsCl("0");
            }


            if(String.valueOf(ob.get(13)).equals(null)||String.valueOf(ob.get(13)).equals("")){
                salarymanage.setMillionF3(0);
            }else{
                salarymanage.setMillionF3(Float.parseFloat(String.valueOf(ob.get(13))));
            }
            if(String.valueOf(ob.get(19)).substring(0,1).equals("W")){
                salarymanage.setNwx("W");
            }else{
                salarymanage.setNwx("N");
            }
            salarymanage.setWorkPart(String.valueOf(ob.get(15)));
            salarymanage.setSendMouth(String.valueOf(ob.get(16)));
            salarymanage.setMillionWight(String.valueOf(ob.get(17)));
            salarymanage.setFno(String.valueOf(ob.get(18)));
            check check1 = new check();
            check1.setFno( String.valueOf(ob.get(18)));
            List<check> list2=planProuductMapper.check(check1);
            String ismix="";
            check check2;
            String FNAME1="";
            if(list2.size()>0) {
                for (int a=0;a<list2.size();a++){
                    check2 = (check) list2.get(a);
                    ismix = check2.getF9();
                    FNAME1 = check2.getFname();
                if(ismix.contains("配")){
                    salarymanage.setIsmix("需配");
                }else{
                    salarymanage.setIsmix("不配");
                }
            }}
            salarymanage.setFname(FNAME1);
            salarymanage.setSAPSDOrder(Erpsysno);
            salarymanage.setOrderLine(String.valueOf(ob.get(19)));
            salarymanage.setDutyman(String.valueOf(ob.get(20)));
//            salarymanage.setMaterialDutyman(String.valueOf(ob.get(21)));
                if(!plant.equals("汽摩链")&&!plant.equals("农机链")&&!plant.equals("工程链")){
                    if(ob.get(22) !=null){
                        salarymanage.setMachineKind(String.valueOf(ob.get(22)));
                    }
                    if(String.valueOf(ob.get(23)).equals("")){
                        salarymanage.setPeriod(0);
                    }else{
                        if(ob.get(23) !=null){
                            salarymanage.setPeriod(Integer.parseInt(String.valueOf(ob.get(23))));
                        }
                    }
                }else{
                    salarymanage.setMachineKind("");
                    salarymanage.setPeriod(0);
                }

            Calendar now = Calendar.getInstance();
            int month = now.get(Calendar.MONTH)+1;
            salarymanage.setUmouth(umouth);
            salarymanage.setUyear(uyear);
            salarymanage.setPlant(plant);
            //通过遍历实现把每一列封装成一个model中，再把所有的model用List集合装载
            list.add(salarymanage);
                if(mpupinst.equals("1")){
                    if (i ==1){
                        PlanProduct planProduct2 = new PlanProduct();
                        planProduct2.setPlant(plant);
                        planProduct2.setUmouth(umouth);
                        planProduct2.setUyear(uyear);
                        planProuductMapper.Deletemp(planProduct2);
                    }
                }
            if(Errmark.contains("错误")){
               continue;

            }else{
                if(mpupinst.equals("0")){
                if(!String.valueOf(ob.get(19)).equals("")){
                    check planProduct1 = new check();
                    planProduct1.setOrderLine(String.valueOf(ob.get(19)));
                    List<check> checklist = planProuductMapper.plancheck(planProduct1);
                    if(checklist.size()>0){
                        PlanProduct planProduct2 = new PlanProduct();
                        planProduct2.setPlant(plant);
                        planProduct2.setUmouth(umouth);
                        planProduct2.setUyear(uyear);
                        planProduct2.setOrderLine(String.valueOf(ob.get(19)));
                        planProuductMapper.Deletemp(planProduct2);
                    }
                }
            }
//                if (i%50 ==0){
//                    //批量插入
                    int A =0;
                    A=planProuductMapper.insertInfoBatch(list);//单条导入

                    if(A>0){
                        list.clear();
                    }
//                    if(A>0){
//                        OK="OK";
//                        list.clear();
//                    }else{
//                        NO="NO";
//                    }
//                }
}
            }
        }
        //切换数据库
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        if(Err.contains("错误")){
            return Err;
        }else{
            OK="OK";
        }
        DataSourceHolder.setDataSourceName(Type.SQL_MDM.getName());
        //批量插入
//        int A =0;
//        A=planProuductMapper.insertInfoBatch(list);
//        if(A>0){
//            OK="OK";
//        }else{
//            NO="NO";
//        }
        String insertInfoBatch="";
if(!NO.equals("")){
    insertInfoBatch=NO;
}else{
    insertInfoBatch =OK;
}
        return insertInfoBatch;
    }

    @Override
    @DataSource(Type.SQL_MDM)
//    @Transactional(propagation= Propagation.REQUIRED,rollbackFor=Exception.class)//当方法抛出异常用来回滚事务
    public HSSFWorkbook exportExcelInfo(PlanProduct query, String plant, String umouth, String uyear, String DHorder, String Des, String fname)  {
        //根据条件查询数据，把数据装载到一个list中
        List<PlanProduct> list = planProuductMapper.getListPP(query,plant,umouth,uyear,DHorder,Des,fname);
        List<ExcelBean> excel=new ArrayList<>();
        Map<Integer,List<ExcelBean>> map=new LinkedHashMap<>();
        HSSFWorkbook xssfWorkbook=null;
        //设置标题栏
        excel.add(new ExcelBean("内外销","nwx",0));
        excel.add(new ExcelBean("物料编码","fno",0));
        excel.add(new ExcelBean("物料描述","fname",0));
        excel.add(new ExcelBean("合同号及行号","OrderLine",0));
        excel.add(new ExcelBean("厂编合同号","dhorderno",0));
        excel.add(new ExcelBean("SAP订单号","SAPSDOrder",0));
        excel.add(new ExcelBean("接单","TakeOrder",0));
        excel.add(new ExcelBean("完成","CompleteOrder",0));
        excel.add(new ExcelBean("交货期","OrderTime",0));
        excel.add(new ExcelBean("规格","PartDrawing",0));
        excel.add(new ExcelBean("节数","F3",0));
        excel.add(new ExcelBean("颜色","Color",0));
        excel.add(new ExcelBean("描述（打印标记等）","Descrip",0));
        excel.add(new ExcelBean("本月计划|本月开卡数","CLNumber",0));
        excel.add(new ExcelBean("本月计划|计划串装数","ConnectPlan",0));
        excel.add(new ExcelBean("本日串装","DayNum",0));
        excel.add(new ExcelBean("累计串装","SumDayNum",0));
        excel.add(new ExcelBean("期初补卡","beginConnect",0));
        excel.add(new ExcelBean("本月计划|计划入库数","number",0));
        excel.add(new ExcelBean("本日入库","DayInput",0));
        excel.add(new ExcelBean("累计入库","SumDayInput",0));
        excel.add(new ExcelBean("是否验货","IsCheck",0));
        excel.add(new ExcelBean("是否组合件","IsCl",0));
        excel.add(new ExcelBean("配组合件","ismix",0));
        excel.add(new ExcelBean("责任人|责任班长","Dutyman",0));
        excel.add(new ExcelBean("单节重差","singleWeightOK",0));
        excel.add(new ExcelBean("工程兴化","GCXH",0));
        map.put(0, excel);
        String sheetName = "月度计划";
        //调用ExcelUtil的方法
        try {
            xssfWorkbook = ExcelUtil.createExcelFile(PlanProduct.class, list, map, sheetName);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IntrospectionException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return xssfWorkbook;
    }

    @DataSource(Type.SQL_EPPRD)
//    @Transactional(propagation= Propagation.REQUIRED,rollbackFor=Exception.class)//当方法抛出异常用来回滚事务
    public List<check> check(String  query) {
        List<check> list = planProuductMapper.EPcheck(query);
        return list;
    }
    @DataSource(Type.SQL_MDM)
    @Transactional(propagation= Propagation.REQUIRED,rollbackFor=Exception.class)
    //当方法抛出异常用来回滚事务
    public List<check> fnocheck(check query){
        List<check> list = planProuductMapper.check(query);
        return list;
    }
    @DataSource(Type.SQL_MDM)
    @Transactional(propagation= Propagation.REQUIRED,rollbackFor=Exception.class)
    //当方法抛出异常用来回滚事务
    public List<check> planstate(String plant,String umouth,String uyear,int submitstate){
        List<check> list = planProuductMapper.planstate(plant,umouth,uyear,submitstate);
        return list;
    }
    @DataSource(Type.SQL_MDM)
    @Transactional(propagation= Propagation.REQUIRED,rollbackFor=Exception.class)
    //当方法抛出异常用来回滚事务
    public int APdelete(PlanProduct planProduct){
        int A = planProuductMapper.Deletemp(planProduct);
        return A;
    }
}
