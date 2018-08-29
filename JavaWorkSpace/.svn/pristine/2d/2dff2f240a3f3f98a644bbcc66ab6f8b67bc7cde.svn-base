package com.dhchain.business.activiti.controller;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dhchain.business.attr.service.AttrService;
import com.dhchain.business.attrappl.service.AttrapplService;
import com.dhchain.business.attrappl.vo.AttrAppl;
import com.dhchain.business.code.service.CodeApplService;
import com.dhchain.business.code.vo.CodeAppl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.TaskFormData;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.identity.Authentication;
//import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.transformer.Identity;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.IdentityLink;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dhchain.business.user.vo.Group;
import com.dhchain.business.activiti.model.Leave;
import com.dhchain.business.user.vo.MemberShip;
import com.dhchain.business.activiti.model.MyTask;
import com.dhchain.business.activiti.model.PageInfo;
import com.dhchain.business.user.vo.ActUser;
import com.dhchain.business.activiti.service.LeaveService;
import com.dhchain.business.activiti.util.DateJsonValueProcessor;
import com.dhchain.business.activiti.util.ResponseUtil;
import org.springframework.web.servlet.ModelAndView;

/**
 * 历史流程批注管理
 *
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/task")
public class TaskController {

	// 引入activiti自带的Service接口
	@Resource
	private TaskService taskService;

	@Resource
	private RepositoryService repositoryService;

	@Resource
	private RuntimeService runtimeService;

	@Resource
	private FormService formService;

	@Resource
	private LeaveService leaveService;

	@Resource
	private HistoryService historyService;

	@Autowired
	private CodeApplService codeApplService;

	@Autowired
	private AttrapplService attrapplService;


	/**
	 * 查询历史流程批注
	 *
	 * @param response
	 * @param processInstanceId
	 *            流程ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/listHistoryCommentWithProcessInstanceId")
	public String listHistoryCommentWithProcessInstanceId(
			HttpServletResponse response, String processInstanceId) throws Exception {
		if (processInstanceId == null) {
			return null;
		}
		List<Comment> commentList = taskService
				.getProcessInstanceComments(processInstanceId);
		// 改变顺序，按原顺序的反向顺序返回list
		Collections.reverse(commentList); //集合元素反转
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class,
				//时间格式转换
				new DateJsonValueProcessor("yyyy-MM-dd hh:mm:ss"));
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(commentList, jsonConfig);
		result.put("rows", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}

	/**
	 * 重定向审核处理页面
	 * @param taskId
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/redirectPage")
	public String redirectPage(String taskId,HttpServletResponse response)throws Exception{
		TaskFormData formData=formService.getTaskFormData(taskId);
		String url=formData.getFormKey();
		System.out.println("*********************"+url);
		JSONObject result=new JSONObject();
		result.put("url", url);
		ResponseUtil.write(response, result);
		return null;
	}


	/**
	 * 待办流程分页查询
	 * @param response
	 * @param page 当前页数
	 * @param rows 每页显示页数
	 * @param s_name 流程名称
	 * @param userId 流程ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/taskPage")
	public String taskPage(HttpServletResponse response,String page,String rows,String s_name,String user_name,String s_applyno, String userId,String s_inputdate) throws Exception{

		if(s_name==null){
			s_name="";
		}
		PageInfo pageInfo=new PageInfo();
		Integer pageSize=Integer.parseInt(rows);
		pageInfo.setPageSize(pageSize);
		if(page==null||page.equals("")){
			page="1";
		}
		pageInfo.setPageIndex((Integer.parseInt(page)-1)*pageInfo.getPageSize());
		// 获取总记录数
		System.out.println("用户ID："+userId+"\n"+"名称:"+s_name);
		String[] group = userId.split("-");
		long alltotal = 0;
		List<Task> alltaskList = new ArrayList();
//		if (group.length>1){
//			for(int i = 1;i<group.length;i++){
//				long total=taskService.createTaskQuery()
//						.taskCandidateGroup(group[i])
//						.taskNameLike("%"+s_name+"%")
//						.count(); // 获取总记录数
				long total=taskService.createTaskQuery()
						.taskAssignee(userId)
						.count(); // 获取总记录数
				alltotal = alltotal+total;
				//有想法的话，可以去数据库观察  ACT_RU_TASK 的变化
//				List<Task> taskList= (List<Task>) taskService.createTaskQuery()
//						// 根据用户id查询
//						.taskCandidateGroup(group[i])
//						// 根据任务名称查询
//						.taskNameLike("%"+s_name+"%").orderByTaskCreateTime().desc().list();
				List<Task> taskList= (List<Task>) taskService.createTaskQuery()
						// 根据用户id查询
						.taskAssignee(userId)
						// 根据任务名称查询
						.taskNameLike("%"+s_name+"%").orderByTaskCreateTime().desc().list();
						// 返回带分页的结果集合
//						.listPage(pageInfo.getPageIndex(), pageInfo.getPageSize()
//						);
				alltaskList.addAll(taskList);
//			}

//		}

		//这里需要使用一个工具类来转换一下主要是转成JSON格式
		List<MyTask> MyTaskList=new ArrayList<MyTask>();
		for(Task t:alltaskList){
			String processInstanceId =  t.getProcessInstanceId();
			String formKey = t.getFormKey();
			MyTask myTask=new MyTask();
			if(formKey!=null){
				if(formKey.equals("codeapply_bz.jsp")){
					CodeAppl codeAppl = codeApplService.getCodeApplByTaskId(processInstanceId);
					if(codeAppl!=null){
						myTask.setCreateMan(codeAppl.getInputman());
						myTask.setApplyno(codeAppl.getApplyno());
						myTask.setRank(codeAppl.getRank());
						myTask.setLcname("主数据创建流程");
					}

				}
				if(formKey.equals("attrapply_bz.jsp")){
					AttrAppl attrAppl = attrapplService.getAttrApplByTaskId(processInstanceId);
					if(attrAppl!=null){
						myTask.setCreateMan(attrAppl.getInputman());
						myTask.setApplyno(attrAppl.getApplyno());
						myTask.setLcname("属性创建流程");
						myTask.setRank(attrAppl.getRank());
					}

				}
				myTask.setId(t.getId());
				myTask.setName(t.getName());
				Date creattime = t.getCreateTime();
				Calendar c = Calendar.getInstance();
				c.setTime(creattime);
				c.add(Calendar.DAY_OF_MONTH, 1);// 今天+1天
				Date endtime = c.getTime();
				Date date = new Date();
				String state;
				if (endtime.getTime() > date.getTime()) {
					long diff = endtime.getTime() - date.getTime();//这样得到的差值是微秒级别
					long days = diff / (1000 * 60 * 60 * 24);

					long hours = (diff-days*(1000 * 60 * 60 * 24))/(1000* 60 * 60);
					long minutes = (diff-days*(1000 * 60 * 60 * 24)-hours*(1000* 60 * 60))/(1000* 60);
					state = "还剩"+days+"天"+hours+"小时"+minutes+"分";
				}else{
					long diff = date.getTime() - endtime.getTime();//这样得到的差值是微秒级别
					long days = diff / (1000 * 60 * 60 * 24);

					long hours = (diff-days*(1000 * 60 * 60 * 24))/(1000* 60 * 60);
					long minutes = (diff-days*(1000 * 60 * 60 * 24)-hours*(1000* 60 * 60))/(1000* 60);
					state = "超时"+days+"天"+hours+"小时"+minutes+"分";
				}

				myTask.setCreateTime(t.getCreateTime());
				myTask.setState(state);
				boolean flag = true;
				if(s_inputdate!=null&&!s_inputdate.equals("")){
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
					Date date1 = sdf.parse(s_inputdate);
					Calendar cal1 = Calendar.getInstance();
					cal1.setTime(date1);
					Calendar cal2 = Calendar.getInstance();
					cal2.setTime(t.getCreateTime());
					flag = isSameDay(cal1, cal2);
				}

				if(myTask.getCreateMan()!=null&&myTask.getApplyno()!=null&&flag){
					if(myTask.getCreateMan().contains(user_name)&&myTask.getApplyno().contains(s_applyno)){
						MyTaskList.add(myTask);
					}
				}

			}


		}
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
		JSONObject result=new JSONObject();
		JSONArray jsonArray=JSONArray.fromObject(MyTaskList,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", MyTaskList.size());
		ResponseUtil.write(response, result);
		return null;
	}

	public static boolean isSameDay(Calendar cal1, Calendar cal2) {
		if (cal1 != null && cal2 != null) {
			return cal1.get(0) == cal2.get(0) && cal1.get(1) == cal2.get(1) && cal1.get(6) == cal2.get(6);
		} else {
			throw new IllegalArgumentException("The date must not be null");
		}
	}
	/**
	 * 查询当前流程图
	 * @return
	 */
	@RequestMapping("/showCurrentView")
	public String showCurrentView(HttpServletResponse response,String taskId)throws Exception{
		//视图
		response.setCharacterEncoding("utf-8");
		ModelAndView mav=new ModelAndView();

		Task task=taskService.createTaskQuery() // 创建任务查询
				.taskId(taskId) // 根据任务id查询
				.singleResult();
		// 获取流程定义id
		String processDefinitionId=task.getProcessDefinitionId();
		ProcessDefinition processDefinition=repositoryService.createProcessDefinitionQuery() // 创建流程定义查询
				// 根据流程定义id查询
				.processDefinitionId(processDefinitionId)
				.singleResult();
		// 部署id
		mav.addObject("deploymentId",processDefinition.getDeploymentId());
		mav.addObject("diagramResourceName", processDefinition.getDiagramResourceName()); // 图片资源文件名称

		ProcessDefinitionEntity processDefinitionEntity=(ProcessDefinitionEntity)
				repositoryService.getProcessDefinition(processDefinitionId);
		// 获取流程实例id
		String processInstanceId=task.getProcessInstanceId();
		// 根据流程实例id获取流程实例
		ProcessInstance pi=runtimeService.createProcessInstanceQuery()
				.processInstanceId(processInstanceId)
				.singleResult();

		// 根据活动id获取活动实例
//		ActivityImpl activityImpl=processDefinitionEntity.findActivity(pi.getActivityId());
//		//整理好View视图返回到显示页面
//		mav.addObject("x", activityImpl.getX()); // x坐标
//		mav.addObject("y", activityImpl.getY()); // y坐标
//		mav.addObject("width", 800); // 宽度
//		mav.addObject("height", 800); // 高度
		InputStream inputStream=repositoryService.getResourceAsStream(processDefinition.getDeploymentId(), processDefinition.getDiagramResourceName());

//		String url = task.getFormKey();
//		int limit = url.indexOf(".");
//		String name = url.substring(0,limit);
//		if(name.equals("codeapply_bz")){
//			url = "D:\\fartec\\HMDM\\HMDM\\src\\test\\resources\\diagrams\\test\\vacationRequest6.png";
//		}else if(name.equals("attrapply_bz")){
//			url = "D:\\fartec\\HMDM\\HMDM\\src\\test\\resources\\diagrams\\test\\vacationRequest4.png";
//		}
//		InputStream inputStream = new FileInputStream(url);
		OutputStream out=response.getOutputStream();
		for(int b=-1;(b=inputStream.read())!=-1;){
			out.write(b);
		}
		out.close();
		inputStream.close();
//		return null;
//		mav.setViewName("page/currentView");
		return null;
	}
	/**
	 * 查询历史批注
	 * @param response
	 * @param taskId 流程ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/listHistoryComment")
	public String listHistoryComment(HttpServletResponse response,String taskId) throws Exception{
		if(taskId==null){
			taskId="";
		}
		HistoricTaskInstance hti=historyService.createHistoricTaskInstanceQuery()
				.taskId(taskId)
				.singleResult();
		JsonConfig jsonConfig=new JsonConfig();
		JSONObject result=new JSONObject();
		List<Comment> commentList=null;
		if(hti!=null){
			commentList=taskService.getProcessInstanceComments(hti.getProcessInstanceId());
			// 集合元素反转
			Collections.reverse(commentList);

			//日期格式转换
			jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd hh:mm:ss"));
		}
		JSONArray jsonArray=JSONArray.fromObject(commentList,jsonConfig);
		result.put("rows", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}

	/**
	 * 审批
	 * @param taskId 任务id
	 * @param leaveDays 请假天数
	 * @param comment 批注信息
	 * @param state 审核状态 1 通过 2 驳回
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/audit_bz")
	public String audit_bz(String taskId,Integer leaveDays,String UserId,String GroupId,String comment,Integer state,HttpServletResponse response,HttpSession session)throws Exception{
		//首先根据ID查询任务
		Task task=taskService.createTaskQuery() // 创建任务查询
				.taskId(taskId) // 根据任务id查询
				.singleResult();
		Map<String,Object> variables=new HashMap<String,Object>();
		//取得角色用户登入的session对象
		MemberShip currentMemberShip=(MemberShip) session.getAttribute("currentMemberShip");
		//取出用户，角色信息
//		User currentUser=currentMemberShip.getUser();
//		Group currentGroup=currentMemberShip.getGroup();
		ActUser currentUser = new ActUser();
		Group currentGroup = new Group();
		currentGroup.setName(GroupId);
		String firstname = UserId.substring(0,1);
		currentUser.setFirstName(firstname);
		String lastname = UserId.substring(1);
		currentUser.setLastName(lastname);
		if(currentGroup.getName().contains("admin")){
			if(state==1){
				String leaveId=(String) taskService.getVariable(taskId, "leaveId");
				Leave leave=leaveService.findById(leaveId);
				leave.setState("审核通过");
				// 更新审核信息
				leaveService.updateLeave(leave);
				variables.put("msg", "通过");
			}else{
				String leaveId=(String) taskService.getVariable(taskId, "leaveId");
				Leave leave=leaveService.findById(leaveId);
				leave.setState("审核未通过");
				// 更新审核信息
				leaveService.updateLeave(leave);
				variables.put("msg", "未通过");
			}
		}
		if(state==1){
			String leaveId=(String) taskService.getVariable(taskId, "leaveId");
			variables.put("msg", "通过");
		}else{
			String leaveId=(String) taskService.getVariable(taskId, "leaveId");
			Leave leave=leaveService.findById(leaveId);
			leave.setState("审核未通过");
			// 更新审核信息
			leaveService.updateLeave(leave);
			variables.put("msg", "未通过");
		}

		// 设置流程变量
		variables.put("dasy", leaveDays);
		// 获取流程实例id
		String processInstanceId=task.getProcessInstanceId();
		// 设置用户id
		List list = taskService.getIdentityLinksForTask(taskId);
		IdentityLink li = (IdentityLink)list.get(0);
		Authentication.setAuthenticatedUserId(currentUser.getFirstName()+currentUser.getLastName());
//		Authentication.setAuthenticatedUserId(currentUser.getFirstName()+currentUser.getLastName()+"["+li.getGroupId()+"]");
		// 添加批注信息
		taskService.addComment(taskId, processInstanceId, comment);
		// 完成任务
		taskService.complete(taskId, variables);
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}

	/**
	 * 查詢流程正常走完的历史流程表 :  act_hi_actinst
	 * @param response
	 * @param rows
	 * @param page
	 * @param s_name
	 * @param groupId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/finishedList")
	public String finishedList(HttpServletResponse response,String page,String rows,String s_name,String user_name,String s_applyno, String groupId,String s_inputdate) throws Exception{
		if(s_name==null){
			s_name="";
		}
		PageInfo pageInfo=new PageInfo();
		Integer pageSize=Integer.parseInt(rows);
		pageInfo.setPageSize(pageSize);
		if(page==null||page.equals("")){
			page="1";
		}
		pageInfo.setPageIndex((Integer.parseInt(page)-1)*pageSize);
		String[] group = groupId.split("-");
		long alltotal = 0;
		List<HistoricTaskInstance> alltaskList = new ArrayList();
		if (group.length>1){
			for(int i = 1;i<group.length;i++){
		//创建流程历史实例查询
		List<HistoricTaskInstance> histList=historyService.createHistoricTaskInstanceQuery()
				.taskCandidateGroup(group[i])//根据角色名称查询
				.taskNameLike("%"+s_name+"%").orderByTaskCreateTime().desc()
				.listPage(pageInfo.getPageIndex(), pageInfo.getPageSize());
				alltaskList.addAll(histList);
		long histCount=historyService.createHistoricTaskInstanceQuery()
				.taskCandidateGroup(group[i])
				.taskNameLike("%"+s_name+"%")
				.count();

			}
		}
		List<MyTask> taskList=new ArrayList<MyTask>();
		//有序
		Map<String,MyTask> map = new LinkedHashMap<String,MyTask>();
		//这里递出没有用的字段，免得给前端页面做成加载压力
		for(HistoricTaskInstance hti:alltaskList){
			String processInstanceId = hti.getProcessInstanceId();
			String formKey = hti.getFormKey();
			MyTask myTask=new MyTask();
			if(formKey.equals("codeapply_bz.jsp")){
				CodeAppl codeAppl = codeApplService.getCodeApplByTaskId(processInstanceId);
				if(codeAppl!=null){
					myTask.setCreateMan(codeAppl.getInputman());
					myTask.setApplyno(codeAppl.getApplyno());
				}

			}
			if(formKey.equals("attrapply_bz.jsp")){
				AttrAppl attrAppl = attrapplService.getAttrApplByTaskId(processInstanceId);
				if(attrAppl!=null){
					myTask.setCreateMan(attrAppl.getInputman());
					myTask.setApplyno(attrAppl.getApplyno());
				}

			}
			myTask.setId(hti.getId());
			myTask.setName(hti.getName());
			myTask.setCreateTime(hti.getCreateTime());
			myTask.setEndTime(hti.getEndTime());
			boolean flag = true;
			if(s_inputdate!=null&&!s_inputdate.equals("")){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				Date date1 = sdf.parse(s_inputdate);
				Calendar cal1 = Calendar.getInstance();
				cal1.setTime(date1);
				Calendar cal2 = Calendar.getInstance();
				cal2.setTime(hti.getCreateTime());
				flag = isSameDay(cal1, cal2);
			}

			if(myTask.getCreateMan()!=null&&myTask.getApplyno()!=null&&flag){
				if(myTask.getCreateMan().contains(user_name)&&myTask.getApplyno().contains(s_applyno)){
					taskList.add(myTask);
					if(map.get(myTask.getApplyno())==null){
						map.put(myTask.getApplyno(),myTask);
					}

				}
			}

		}
		List<MyTask> taskList2=new ArrayList<MyTask>();
		for (String key : map.keySet()) {
			taskList2.add(map.get(key));
		}
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
		JSONObject result=new JSONObject();
		JSONArray jsonArray=JSONArray.fromObject(taskList2,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total",taskList2.size() );
		ResponseUtil.write(response, result);
		return null;
	}

	/**
	 * 根据任务id查询流程实例的具体执行过程
	 * @param taskId
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/listAction")
	public String listAction(String taskId,HttpServletResponse response)throws Exception{
		if(taskId!=null){
			HistoricTaskInstance hti=historyService.createHistoricTaskInstanceQuery().taskId(taskId).singleResult();
			String processInstanceId=hti.getProcessInstanceId(); // 获取流程实例id
			List<HistoricActivityInstance> haiList=historyService.createHistoricActivityInstanceQuery().processInstanceId(processInstanceId).list();
			JsonConfig jsonConfig=new JsonConfig();
			jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd hh:mm:ss"));
			JSONObject result=new JSONObject();
			JSONArray jsonArray=JSONArray.fromObject(haiList,jsonConfig);
			result.put("rows", jsonArray);
			ResponseUtil.write(response, result);

		}
		return null;

	}
}
