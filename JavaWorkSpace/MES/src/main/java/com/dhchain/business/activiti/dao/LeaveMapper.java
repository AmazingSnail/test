package com.dhchain.business.activiti.dao;

import com.dhchain.business.activiti.model.Leave;

import java.util.List;
import java.util.Map;

/**
 * ҵ�����
 * @author Administrator
 *
 */

public interface LeaveMapper {
		public List<Leave> leavePage(Map<String, Object> map);
		
		public int leaveCount(Map<String, Object> map);
		
		public int addLeave(Leave leave);
		
		public Leave findById(String id);
		
		public int updateLeave(Leave leave);
		
		public Leave getLeaveByTaskId(String processInstanceId);
}
