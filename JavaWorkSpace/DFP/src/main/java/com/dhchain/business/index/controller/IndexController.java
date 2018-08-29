package com.dhchain.business.index.controller;

import java.io.IOException;
import java.text.Collator;
import java.util.*;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dhchain.business.index.vo.User;

import com.dhchain.business.user.service.MemberShipService;
import com.dhchain.business.user.vo.LoginUser;
import com.dhchain.business.user.vo.MemberShip;
import com.dhchain.config.base.BaseController;
import com.dhchain.config.csrf.CsrfToken;
import com.dhchain.config.shiro.PasswordHash;
import com.dhchain.util.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.dhchain.business.index.service.IndexService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller

public class IndexController extends BaseController {

	@Autowired
	private IndexService indexService;
	private PasswordHash passwordHash;
	@Autowired
	private MemberShipService memberShipService;
	/**
	 * 首页页面
	 * */
	@RequestMapping(value={"","/index"},method=RequestMethod.GET)
	public ModelAndView goIndex(){
		Map<String,Object> model = new HashMap<>();
		model.put("name", UUID.randomUUID().toString());
		return new ModelAndView("index",model);
	}

	@GetMapping("/main")
	public String gotoMainPage()
	{
		return "main";
	}
	@GetMapping("/test")
	public String gotoTest()
	{
		return "test";
	}
	public String mainToExptypeQueryParm()
	{
		return "exp/exptypeQueryParm";
	}
	@GetMapping("/MouldManagement")
	public String mainToMouldManagement()
	{
		return "partpunchingworkshop/MouldManagement";
	}
	@GetMapping("/ProcessDocumentation")
	public String mainToProcessDocumentation()
	{
		return "partpunchingworkshop/ProcessDocumentation";
	}
	@GetMapping("/MonthPlan")
	public String mainToMonthPlan()
	{
		return "partpunchingworkshop/MonthPlan";
	}
	@GetMapping("/ContractPlan")
	public String mainToContractPlan()
	{
		return "partpunchingworkshop/ContractPlan";
	}
	@GetMapping("/MissionIssued")
	public String mainToMissionIssued()
	{
		return "partpunchingworkshop/MissionIssued";
	}
	@GetMapping("/ProductionTaskManagement")
	public String mainToProductionTaskManagement()
	{
		return "partpunchingworkshop/ProductionTaskManagement";
	}
	@GetMapping("/ElementDetail")
	public String mainToElementDetail()
	{
		return "partpunchingworkshop/ElementDetail";
	}
	@GetMapping("/DeviceManagement")
	public String mainToDeviceManagement()
	{
		return "partpunchingworkshop/DeviceManagement";
	}
	@GetMapping("/EquipmentMaintenance")
	public String mainToEquipmentMaintenance()
	{
		return "partpunchingworkshop/EquipmentMaintenance";
	}
	@GetMapping("/QualityAssurance")
	public String mainToQualityAssurance()
	{
		return "partpunchingworkshop/QualityAssurance";
	}
	@GetMapping("/PersonnelMaintenance")
	public String mainToPersonnelMaintenance()
	{
		return "partpunchingworkshop/PersonnelMaintenance";
	}
	@GetMapping("/BasicData")
	public String mainToBasicData()
	{
		return "partpunchingworkshop/BasicData";
	}
	@GetMapping("/Info")
	public String mainToInfo()
	{
		return "partpunchingworkshop/Info";
	}
	@GetMapping("/Equipmentnspection")
	public String mainToEquipmentnspection()
	{
		return "partpunchingworkshop/Equipmentnspection";
	}
	@GetMapping("/Material")
	public String mainToMaterial()
	{
		return "partpunchingworkshop/Material";
	}
	@GetMapping("/resource")
	public String mainToresource()
	{
		return "resource/resource";
	}
	@GetMapping("/resourceAdd")
	public String mainToresourceAdd()
	{
		return "resource/resourceAdd";
	}
	@GetMapping("/user")
	public String mainTouser()
	{
		return "user/user";
	}

	@GetMapping("/userAdd")
	public String mainTouserAdd()
	{
		return "user/userAdd";
	}

	@GetMapping("/roleAdd")
	public String mainToroleAdd()
	{
		return "role/roleAdd";
	}
	@GetMapping("/role")
	public String mainTorole()
	{
		return "role/role";
	}
	@RequestMapping(value = "DealerStock", method = RequestMethod.GET)
	public String gotoDealerStock()
	{
		return "DealerStock";
	}
	@RequestMapping(value = "DomesticInventoryReport", method = RequestMethod.GET)
	public String gotoDomesticInventoryReport()
	{
		return "DomesticInventoryReport";
	}
	@GetMapping("/organization")
	public String mainToorganization()
	{
		return "organization/organization";
	}
	@GetMapping("/organizationAdd")
	public String mainToorganizationAdd()
	{
		return "organization/organizationAdd";
	}
	@RequestMapping(value = "Tractor", method = RequestMethod.GET)
	public String gotoTractor()
	{
		return "Tractor/Tractor";
	}
	@RequestMapping(value = "/Cultivator", method = RequestMethod.GET)
	public String gotoCultivator()
	{
		return "Cultivator/Cultivator";
	}
	@RequestMapping(value = "/CultivatorOtherAdd", method = RequestMethod.GET)
	public String gotCultivatorOtherAdd()
	{
		return "Cultivator/CultivatorOtherAdd";
	}
	@RequestMapping(value = "/BaseInfo", method = RequestMethod.GET)
	public String gotoBaseInfo()
	{
		return "BaseInfo/BaseInfo";
	}
	@RequestMapping(value = "/TractorAdd", method = RequestMethod.GET)
	public String gotoTractorAdd()
	{
		return "Tractor/TractorAdd";
	}
	@RequestMapping(value = "/TractorEdit", method = RequestMethod.GET)
	public String gotoTractorEdit()
	{
		return "Tractor/TractorEdit";
	}
	@RequestMapping(value = "/CultivatorAdd", method = RequestMethod.GET)
	public String gotoCultivatorAdd()
	{
		return "Cultivator/CultivatorAdd";
	}
	@RequestMapping(value = "/CultivatorEdit", method = RequestMethod.GET)
	public String gotoCultivatorEdit()
	{
		return "Cultivator/CultivatorEdit";
	}
	@RequestMapping(value = "/DateEdit", method = RequestMethod.GET)
	public String gotoDateEdit()
	{
		return "BaseInfo/DateEdit";
	}
	@RequestMapping(value = "/EngineEdit", method = RequestMethod.GET)
	public String gotoEngineEdit()
	{
		return "BaseInfo/EngineEdit";
	}
	@RequestMapping(value = "/TyreEdit", method = RequestMethod.GET)
	public String gotoTyreEdit()
	{
		return "BaseInfo/TyreEdit";
	}
	@ResponseBody
	@RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
	public JSONObject query1(User query, String Username, HttpServletRequest request){
		Username = request.getParameter("Username");
		String password = request.getParameter("password");
		List jslist =  indexService.queryAsList1(query,Username);
		boolean flag = false;
		JSONObject re = new JSONObject();
		User user;
		if(jslist.size()>0) {
			Map mpny = new HashMap();
			user = (User) jslist.get(0);
			String User = user.getUserName();
			String Password = user.getPassword();
			String MDM = user.getMDM();
			String Department = user.getDepartment();
			re.put("User",User);
			re.put("Password",Password);
			re.put("MDM",MDM);
			re.put("Department",Department);
			if(password.equals(Password)){
				flag = true;
			}
		}
		if(flag){
			request.getSession().setAttribute("username",Username);
		}

		return re;
	}


	@ResponseBody
	@RequestMapping(value="/selectDepartment",method={RequestMethod.GET,RequestMethod.POST})

	public JSONObject selectDepartment( HttpServletRequest request){
		JSONObject re = new JSONObject();
		List<String> jslist =  indexService.queryAllDepartment();
		JSONArray jslst = new JSONArray();
		String department;
		if(jslist.size()>0) {
			for (int i=0;i<jslist.size();i++){
				JSONObject re1 = new JSONObject();
				department = (String)jslist.get(i);
				re1.put("department",department);
				jslst.add(re1);
			}
		}
		re.put("rows",jslst);
		re.put("total",jslst.size());
		return re;
	}

	@ResponseBody
	@RequestMapping(value="/select",method={RequestMethod.GET,RequestMethod.POST})
	public JSONObject selectUsersByDepartment(String department , HttpServletRequest request){
		department = request.getParameter("department");
//		List<User> jslist =  indexService.queryByDepartment(department);
		List<LoginUser> jslist =  indexService.selectByDepartment(department);
		JSONObject re = new JSONObject();
		JSONArray jslst = new JSONArray();
		LoginUser user;
		ArrayList<String> list=new ArrayList<String>();
		if(jslist.size()>0) {
			for (int i=0;i<jslist.size();i++){
//				JSONObject re1 = new JSONObject();
				user = (LoginUser)jslist.get(i);
//				re1.put("name",user.getLoginName());
				list.add(user.getLoginName());
//				jslst.add(re1);
			}
		}
		String[] strings = new String[list.size()];
		list.toArray(strings);
		getSortOfChinese(strings);
		for(String s:strings){
			JSONObject re1 = new JSONObject();
			re1.put("name",s);
			jslst.add(re1);
		}
		re.put("rows",jslst);
		re.put("total",jslst.size());
		return re;
	}


	/**
	 * GET 登录
	 * @return {String}
	 */
	@GetMapping("/login")
	@CsrfToken(create = true)
	public String login() {
//		logger.info("GET请求登录");
		if (SecurityUtils.getSubject().isAuthenticated()) {
			return "redirect:/index3";
		}
		return "main";
	}


	/**
	 * POST 登录 shiro 写法
	 *
	 * @param username 用户名
	 * @param password 密码
	 * @return {Object}
	 */
	@PostMapping("/login")
	@CsrfToken(remove = true)
	@ResponseBody
	public JSONObject loginPost(HttpServletRequest request, HttpServletResponse response,
								String username, String password, String department,
								@RequestParam(value = "remembe", defaultValue = "0") Integer rememberMe) throws ServletException, IOException {
		JSONObject re = new JSONObject();
		// 改为全部抛出异常，避免ajax csrf token被刷新

		if (StringUtils.isBlank(username)) {
			throw new RuntimeException("用户名不能为空");
		}
		if (StringUtils.isBlank(password)) {
			throw new RuntimeException("密码不能为空");
		}

		Subject user = SecurityUtils.getSubject();

		UsernamePasswordToken token = new UsernamePasswordToken(username, password,department);
		// 设置记住密码
		token.setRememberMe(1 == 1);
		try {

			user.login(token);
			re.put("User",username);
			re.put("IsOK","Y");
			StringBuffer group =new StringBuffer("123");
			List<MemberShip> actlist = memberShipService.selectMemberShipByUserId(username);
			for (int n= 0;n<actlist.size();n++){
				MemberShip memberShip = actlist.get(n);
				group.append("-"+ memberShip.getGroupId());
			}
			request.getSession().setAttribute("GroupSession",group);
			re.put("actGroup",group);

		} catch (UnknownAccountException e) {
			re.put("ErrMes","账号不存在");
			re.put("IsOK","N");
			throw new RuntimeException("账号不存在！", e);
		} catch (DisabledAccountException e) {
			re.put("ErrMes","账号未启用");
			re.put("IsOK","N");
			throw new RuntimeException("账号未启用！", e);
		} catch (IncorrectCredentialsException e) {
			re.put("ErrMes","密码错误");
			re.put("IsOK","N");
			throw new RuntimeException("密码错误！", e);
		} catch (Throwable e) {
			re.put("ErrMes",e.getMessage());
			re.put("IsOK","N");
			throw new RuntimeException(e.getMessage(), e);
		}
		return re;



	}


	/**
	 * 修改密码页
	 *
	 * @return
	 */
	@GetMapping("/userEditPwd")
	public String editPwdPage() {
		return "/userEditPwd";
	}

	/**
	 * 修改密码
	 *
	 * @param oldPwd
	 * @param pwd
	 * @return
	 */
	@PostMapping("/editUserPwd")
	@ResponseBody
	public Object editUserPwd(String oldPwd, String pwd) {
		long id = this.getShiroUser().getId();
		LoginUser user = indexService.selectById(id);
//		LoginUser user = indexService.selectById(getUserId());
		String salt = user.getSalt();
		if (!user.getPassword().equals(passwordHash.toHex(oldPwd, salt))) {
			return renderError("老密码不正确!");
		}
		String password =  passwordHash.toHex(pwd, salt);
		indexService.updatePwdByUserId(id, password);
		return renderSuccess("密码修改成功！");
	}

	/**
	 *
	 * @param a String[]
	 * @return String[]
	 */
	public static String[] getSortOfChinese(String[] a) {
		// Collator 类是用来执行区分语言环境这里使用CHINA
		Comparator cmp = Collator.getInstance(java.util.Locale.CHINA);

		// JDKz自带对数组进行排序。
		Arrays.sort(a, cmp);
		return a;
	}

}
