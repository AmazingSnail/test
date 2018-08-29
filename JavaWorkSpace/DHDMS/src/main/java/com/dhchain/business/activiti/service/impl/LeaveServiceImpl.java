package com.dhchain.business.activiti.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dhchain.business.activiti.dao.LeaveMapper;
import com.dhchain.business.activiti.model.Leave;
import com.dhchain.business.activiti.service.LeaveService;
@Service("leaveService")
public class LeaveServiceImpl implements LeaveService{
	@Resource 
	private LeaveMapper leaveMapper;
	public List<Leave> leavePage(Map<String,Object> map){
		return leaveMapper.leavePage(map);
	}
	
	public int leaveCount(Map<String,Object> map){
		return leaveMapper.leaveCount(map);
	}
	
	public int addLeave(Leave leave){
		return leaveMapper.addLeave(leave);
	}
	
	public Leave findById(String id){
		return leaveMapper.findById(id);
	}
	
	public int updateLeave(Leave leave){
		return leaveMapper.updateLeave(leave);
	}
	
	public Leave getLeaveByTaskId(String processInstanceId){
		return leaveMapper.getLeaveByTaskId(processInstanceId);
	}
}
