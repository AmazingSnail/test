package com.dhchain.system.controller;


import java.text.DecimalFormat;
import java.util.*;

import com.alibaba.fastjson.JSONObject;
import com.dhchain.system.entity.User;
import com.dhchain.system.service.SalesSingleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;

@Controller
@RequestMapping("/SalesSingle")
public class SalesSingleController {
	@Autowired
	private SalesSingleService salesSingleService;

	@ResponseBody
	@RequestMapping(value = "/salesSingle")
	public JSONObject test2(User user){
		JSONObject re = new JSONObject();
		Example example = new Example(User.class);

		String nwx = user.getPassword();
		String Hour = user.getPhone();
		List<User> list = new ArrayList<User>();
		if(Hour.equals("2")){
			String day = user.getName();
			String [] str = user.getName().split("-");
			String year = str[0];
			String month = str[1];
			list = salesSingleService.getlistDay(year,day,nwx);//当天数据
		}else if(Hour.equals("1")){
			String day = user.getName();
			String [] str = user.getName().split("-");
			String year = str[0];
			String month = str[1];
			list = salesSingleService.getlist(year,month,nwx);
		}else if(Hour.equals("3")){
			String day = user.getName();
			String [] str = user.getName().split("-");
			String year = str[0];
			list = salesSingleService.getlistYear(year,nwx);//年数据
		}

		List list3 =new ArrayList();
		List list5 = new ArrayList();
		Map re2 =  new HashMap();
		Double sum = 0.0;
		Double Y=0.0;
		String Y1;
		Double P=0.0;
		String P1;
		Double M=0.0;
		String M1;
		Double Y2=0.0;
		Double P2=0.0;
		String P3;
		Double M2=0.0;
		String M3;
		String Y3;
		if(nwx.equals("1")){
			if(list.size()>0){
				for(int i = 0;i<list.size();i++){
					DecimalFormat df   = new DecimalFormat("######0.00");
					Map re3 =  new HashMap();
					Map re5 = new HashMap();
					User user1;
					user1 = list.get(i);
					if(user1.getL().equals("内销")){
						if(user1.getY()!=null){
							Y = Y +Double.parseDouble(user1.getY());
						}
						if(user1.getP()!=null){
							P = P +Double.parseDouble(user1.getP());
						}
//						if(user1.getM()!=null){
//							M = M +Double.parseDouble(user1.getM());
//						}
					}else if(user1.getL().equals("汽车链")){

						if(user1.getY()!=null){
							Y2 = Y2 +Double.parseDouble(user1.getY());
						}
						if(user1.getP()!=null){
							P2 = P2 +Double.parseDouble(user1.getP());
						}
//						if(user1.getM()!=null){
//							M2 = M2 +Double.parseDouble(user1.getM());
//						}
					}else if(user1.getL().equals("扶梯链销售")){

						if(user1.getY()!=null&&user1.getP()!=null){
							re3.put("L","扶梯链");
							re3.put("Y",user1.getY());
							re3.put("P",user1.getP());
//							re3.put("M",user1.getM());
							list3.add(re3);
						}else if(user1.getY()==null&&user1.getP()!=null){
							re3.put("L","扶梯链");
							re3.put("Y","0.00");
							re3.put("P",user1.getP());
//							re3.put("M",user1.getM());
							list3.add(re3);
						}else if(user1.getP()==null&&user1.getY()!=null){
							re3.put("L","扶梯链");
							re3.put("Y",user1.getY());
							re3.put("P","0.00");
//							re3.put("M",user1.getM());
							list3.add(re3);
						}else {
							re3.put("L","扶梯链");
							re3.put("Y","0.00");
							re3.put("P","0.00");
//							re3.put("M",user1.getM());
							list3.add(re3);
						}
					}else if(user1.getL().equals("摩托车链")){
						P1 = df.format(P);
//						M1 = df.format(M);
						Y1 = df.format(Y);
						re2.put("L","国内市场部");
						re2.put("Y",Y1);
						re2.put("P",P1);
//						re2.put("M",M1);
						list3.add(re2);
						Map re4  = new HashMap();
						P3 = df.format(P2);
//						M3 = df.format(M2);
						Y3 = df.format(Y2);
						re4.put("L","汽车链");
						re4.put("Y",Y3);
						re4.put("P",P3);
//						re4.put("M",M3);
						list3.add(re4);
						if(user1.getY()!=null&&user1.getP()!=null){
							Double sy = Double.parseDouble(user1.getY());
							Double sp = Double.parseDouble(user1.getP());
//							Double sm = Double.parseDouble(user1.getM());
							String sY = df.format(sy);
							String sP = df.format(sp);
//							String sM = df.format(sm);
							re3.put("L",user1.getL());
							re3.put("Y",sY);
							re3.put("P",sP);
//							re3.put("M",sM);
							list3.add(re3);
						}else if(user1.getY()==null&&user1.getP()!=null){
							re3.put("L",user1.getL());
							re3.put("Y","0.00");
							re3.put("P",user1.getP());
//							re3.put("M",user1.getM());
							list3.add(re3);
						}else if(user1.getP()==null&&user1.getY()!=null){
							re3.put("L",user1.getL());
							re3.put("Y",user1.getY());
							re3.put("P","0.00");
//							re3.put("M",user1.getM());
							list3.add(re3);
						}else {
							re3.put("L",user1.getL());
							re3.put("Y","0.00");
							re3.put("P","0.00");
//							re3.put("M",user1.getM());
							list3.add(re3);
						}

					}else {
						if(user1.getY()!=null&&user1.getP()!=null){
							Double sy = Double.parseDouble(user1.getY());
							Double sp = Double.parseDouble(user1.getP());
//							Double sm = Double.parseDouble(user1.getM());
							String sY = df.format(sy);
							String sP = df.format(sp);
//							String sM = df.format(sm);
							re3.put("L",user1.getL());
							re3.put("Y",sY);
							re3.put("P",sP);
//							re3.put("M",sM);
							list3.add(re3);
						}else if(user1.getY()==null&&user1.getP()!=null){
							re3.put("L",user1.getL());
							re3.put("Y","0.00");
							re3.put("P",user1.getP());
//							re3.put("M",user1.getM());
							list3.add(re3);
						}else if(user1.getP()==null&&user1.getY()!=null){
							re3.put("L",user1.getL());
							re3.put("Y",user1.getY());
							re3.put("P","0.00");
//							re3.put("M",user1.getM());
							list3.add(re3);
						}else {
							re3.put("L",user1.getL());
							re3.put("Y","0.00");
							re3.put("P","0.00");
//							re3.put("M",user1.getM());
							list3.add(re3);
						}
					}

				}


			}
		}else if(nwx.equals("2")){
			if(list.size()>0) {
				for (int i = 0; i < list.size(); i++) {
					DecimalFormat df = new DecimalFormat("######0.00");
					User user1;
					user1 = list.get(i);
					Map re3 =  new HashMap();
					if(user1.getY()!=null&&user1.getP()!=null){
						re3.put("L",user1.getX());
						re3.put("Y",user1.getY());
						re3.put("P",user1.getP());
//						re3.put("M",user1.getM());
						list3.add(re3);
					}else if(user1.getY()==null&&user1.getP()!=null){
						re3.put("L",user1.getX());
						re3.put("Y","0.00");
						re3.put("P",user1.getP());
//						re3.put("M",user1.getM());
						list3.add(re3);
					}else if(user1.getP()==null&&user1.getY()!=null){
						re3.put("L",user1.getX());
						re3.put("Y",user1.getY());
						re3.put("P","0.00");
//						re3.put("M",user1.getM());
						list3.add(re3);
					}else {
						re3.put("L",user1.getX());
						re3.put("Y","0.00");
						re3.put("P","0.00");
//						re3.put("M",user1.getM());
						list3.add(re3);
					}
				}
			}
		}



		re.put("List",list3);


		return re;
	}
}
