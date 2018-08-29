package com.dhchain.system.controller;


import java.text.DecimalFormat;
import java.util.*;

import com.alibaba.fastjson.JSONObject;
import com.dhchain.system.entity.User;
import com.dhchain.system.service.PlantSalesSendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;

@Controller
@RequestMapping("/PlantSalesSend")
public class PlantSalesSendController {
    @Autowired
    private PlantSalesSendService plantSalesSendService;

    @ResponseBody
    @RequestMapping(value = "/plantSalesSend")
    public JSONObject test3(User user) {
        JSONObject re = new JSONObject();
        Example example = new Example(User.class);

        String nwx = user.getPassword();
        String Hour = user.getPhone();
        List<User> list1 = new ArrayList<User>();
        if (Hour.equals("2")) {
            String day = user.getName();
            String[] str = user.getName().split("-");
            String year = str[0];
            String month = str[1];
            list1 = plantSalesSendService.getlistDay1(year, month, day, nwx);//当天数据
        } else if (Hour.equals("1")) {
            String day = user.getName();
            String[] str = user.getName().split("-");
            String year = str[0];
            String month = str[1];
            list1 = plantSalesSendService.getlist1(year, month, nwx);
        } else if (Hour.equals("3")) {
            String day = user.getName();
            String[] str = user.getName().split("-");
            String year = str[0];

            list1 = plantSalesSendService.getlistYear1(year, nwx);//年数据
        }

        List list3 = new ArrayList();
        List list5 = new ArrayList();
        Map re2 = new HashMap();
        Double sum = 0.0;
        Double B = 0.0;
        String B1;
        Double C = 0.0;
        String C1;
        Double B2 = 0.0;
        Double C2 = 0.0;
        String B3;
        String C3;

        if (nwx.equals("1")) {
            if (list1.size() > 0) {
                for (int i = 0; i < list1.size(); i++) {
                    DecimalFormat df = new DecimalFormat("######0.00");
                    Map re3 = new HashMap();
                    Map re4 = new HashMap();
                    User user1;
                    user1 = list1.get(i);
                    if (user1.getM().equals("不锈钢")) {
                        if (user1.getB() != null) {
                            B = B + Double.parseDouble(user1.getB()) / 10;
                        }
                        if (user1.getC() != null) {
                            C = C + Double.parseDouble(user1.getC()) / 10;
                        }

                    } else if (user1.getM().equals("摩托车链")) {

                        if (user1.getB() != null) {
                            B2 = B2 + Double.parseDouble(user1.getB()) / 10;
                        }
                        if (user1.getC() != null) {
                            C2 = C2 + Double.parseDouble(user1.getC()) / 10;
                        }
                    } else if (user1.getM().equals("兴化传动链")) {

                        B1 = df.format(B);
                        C1 = df.format(C);
                        re2.put("L", "不锈钢");
                        re2.put("Y", B1);
                        re2.put("P", C1);
                        if (C == 0) {
                            re2.put("M", "");
                        } else {
                            re2.put("M", df.format((B / C) * 100));
                        }
                        list3.add(re2);

                        double BX = Double.parseDouble(user1.getB()) / 10;
                        double CX = Double.parseDouble(user1.getC()) / 10;
                        double num2 = BX / CX * 100;

                        if (user1.getB() != null && user1.getC() != null) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (user1.getB() == null && user1.getC() != null) {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (user1.getC() == null && user1.getB() != null) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        } else {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        }


                    } else if (user1.getM().equals("兴化工程链")) {

                        B3 = df.format(B2);
                        C3 = df.format(C2);
                        re4.put("L", "摩托车链");
                        re4.put("Y", B3);
                        re4.put("P", C3);
                        if (C2 == 0) {
                            re4.put("M", "");
                        } else {
                            re4.put("M", df.format((B2 / C2) * 100));
                        }
                        list3.add(re4);

                        double BX = Double.parseDouble(user1.getB()) / 10;
                        double CX = Double.parseDouble(user1.getC()) / 10;
                        double num2 = BX / CX * 100;

                        if (user1.getB() != null && user1.getC() != null) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (user1.getB() == null && user1.getC() != null) {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (user1.getC() == null && user1.getB() != null) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        } else {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        }

                    } else {
                        double BX = Double.parseDouble(user1.getB()) / 10;
                        double CX = Double.parseDouble(user1.getC()) / 10;
                        double num2 = BX / CX * 100;
                        if (user1.getB() != null && user1.getC() != null) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (user1.getB() == null && user1.getC() != null) {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (user1.getC() == null && user1.getB() != null) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        } else {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        }
                    }
                }
            }
        } else if (nwx.equals("2")) {
            if (list1.size() > 0) {
                for (int i = 0; i < list1.size(); i++) {
                    DecimalFormat df = new DecimalFormat("######0.00");
                    User user1;
                    user1 = list1.get(i);
                    Map re3 = new HashMap();
                    double BX = Double.parseDouble(user1.getB()) / 10;
                    double CX = Double.parseDouble(user1.getC()) / 10;
                    double num2 = BX / CX * 100;
                    if (user1.getB() != null && user1.getC() != null) {
                        re3.put("L", user1.getM());
                        re3.put("Y", df.format(BX));
                        re3.put("P", df.format(CX));
                        re3.put("M", df.format(num2));
                        list3.add(re3);
                    } else if (user1.getB() == null && user1.getC() != null) {
                        re3.put("L", user1.getM());
                        re3.put("Y", "0.00");
                        re3.put("P", df.format(CX));
                        re3.put("M", df.format(num2));
                        list3.add(re3);
                    } else if (user1.getC() == null && user1.getB() != null) {
                        re3.put("L", user1.getM());
                        re3.put("Y", df.format(BX));
                        re3.put("P", "0.00");
                        re3.put("M", "0.00");
                        list3.add(re3);
                    } else {
                        re3.put("L", user1.getM());
                        re3.put("Y", "0.00");
                        re3.put("P", "0.00");
                        re3.put("M", "0.00");
                        list3.add(re3);
                    }
                }
            }
        } else if (nwx.equals("3")) {
            if (list1.size() > 0) {
                for (int i = 0; i < list1.size(); i++) {
                    DecimalFormat df = new DecimalFormat("######0.00");
                    Map re3 = new HashMap();
                    Map re4 = new HashMap();
                    User user1;
                    user1 = list1.get(i);
                    if (user1.getM().equals("不锈钢")) {
                        if (user1.getH() != null) {
                            B = B + Double.parseDouble(user1.getH()) / 10;
                        }
                        if (user1.getJ() != null) {
                            B = B + Double.parseDouble(user1.getJ()) / 10;
                        }
                        if (user1.getK() != null) {
                            B = B + Double.parseDouble(user1.getK()) / 10;
                        }

                        if (user1.getG() != null) {
                            C = C + Double.parseDouble(user1.getG()) / 10;
                        }
                        if (user1.getI() != null) {
                            C = C + Double.parseDouble(user1.getI()) / 10;
                        }
                        if (user1.getL() != null) {
                            C = C + Double.parseDouble(user1.getL()) / 10;
                        }
                    } else if (user1.getM().equals("摩托车链")) {
                        if (user1.getH() != null) {
                            B2 = B2 + Double.parseDouble(user1.getH()) / 10;
                        }
                        if (user1.getJ() != null) {
                            B2 = B2 + Double.parseDouble(user1.getJ()) / 10;
                        }
                        if (user1.getK() != null) {
                            B2 = B2 + Double.parseDouble(user1.getK()) / 10;
                        }

                        if (user1.getG() != null) {
                            C2 = C2 + Double.parseDouble(user1.getG()) / 10;
                        }
                        if (user1.getI() != null) {
                            C2 = C2 + Double.parseDouble(user1.getI()) / 10;
                        }
                        if (user1.getL() != null) {
                            C2 = C2 + Double.parseDouble(user1.getL()) / 10;
                        }
                    } else if (user1.getM().equals("兴化传动链")) {

                        B1 = df.format(B);
                        C1 = df.format(C);
                        re2.put("L", "不锈钢");
                        re2.put("Y", B1);
                        re2.put("P", C1);
                        if (C == 0) {
                            re2.put("M", "");
                        } else {
                            re2.put("M", df.format((B / C) * 100));
                        }
                        list3.add(re2);

                        double BX = 0;
                        double CX = 0;
                        if (user1.getH() != null) {
                            BX += Double.parseDouble(user1.getH()) / 10;
                        }
                        if (user1.getJ() != null) {
                            BX += Double.parseDouble(user1.getJ()) / 10;
                        }
                        if (user1.getK() != null) {
                            BX += Double.parseDouble(user1.getK()) / 10;
                        }

                        if (user1.getG() != null) {
                            CX += Double.parseDouble(user1.getG()) / 10;
                        }
                        if (user1.getI() != null) {
                            CX += Double.parseDouble(user1.getI()) / 10;
                        }
                        if (user1.getL() != null) {
                            CX += Double.parseDouble(user1.getL()) / 10;
                        }
                        double num2 = BX / CX * 100;

                        if (BX != 0 && CX != 0) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (BX == 0 && CX != 0) {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (CX == 0 && BX != 0) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        } else {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        }


                    } else if (user1.getM().equals("兴化工程链")) {

                        B3 = df.format(B2);
                        C3 = df.format(C2);
                        re4.put("L", "摩托车链");
                        re4.put("Y", B3);
                        re4.put("P", C3);
                        if (C2 == 0) {
                            re4.put("M", "");
                        } else {
                            re4.put("M", df.format((B2 / C2) * 100));
                        }
                        list3.add(re4);

                        double BX = 0;
                        double CX = 0;
                        if (user1.getH() != null) {
                            BX += Double.parseDouble(user1.getH()) / 10;
                        }
                        if (user1.getJ() != null) {
                            BX += Double.parseDouble(user1.getJ()) / 10;
                        }
                        if (user1.getK() != null) {
                            BX += Double.parseDouble(user1.getK()) / 10;
                        }

                        if (user1.getG() != null) {
                            CX += Double.parseDouble(user1.getG()) / 10;
                        }
                        if (user1.getI() != null) {
                            CX += Double.parseDouble(user1.getI()) / 10;
                        }
                        if (user1.getL() != null) {
                            CX += Double.parseDouble(user1.getL()) / 10;
                        }
                        double num2 = BX / CX * 100;

                        if (BX != 0 && CX != 0) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (BX == 0 && CX != 0) {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (CX == 0 && BX != 0) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        } else {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        }

                    } else {
                        double BX = 0;
                        double CX = 0;
                        if (user1.getH() != null) {
                            BX += Double.parseDouble(user1.getH()) / 10;
                        }
                        if (user1.getJ() != null) {
                            BX += Double.parseDouble(user1.getJ()) / 10;
                        }
                        if (user1.getK() != null) {
                            BX += Double.parseDouble(user1.getK()) / 10;
                        }

                        if (user1.getG() != null) {
                            CX += Double.parseDouble(user1.getG()) / 10;
                        }
                        if (user1.getI() != null) {
                            CX += Double.parseDouble(user1.getI()) / 10;
                        }
                        if (user1.getL() != null) {
                            CX += Double.parseDouble(user1.getL()) / 10;
                        }
                        double num2 = BX / CX * 100;
                        if (BX != 0 && CX != 0) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (BX == 0 && CX != 0) {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", df.format(CX));
                            re3.put("M", df.format(num2));
                            list3.add(re3);
                        } else if (CX == 0 && BX != 0) {
                            re3.put("L", user1.getM());
                            re3.put("Y", df.format(BX));
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        } else {
                            re3.put("L", user1.getM());
                            re3.put("Y", "0.00");
                            re3.put("P", "0.00");
                            re3.put("M", "0.00");
                            list3.add(re3);
                        }
                    }
                }
            }
        }
        re.put("List", list3);
        return re;
    }
}