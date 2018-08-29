package com.dhchain.business.user.dao;

import com.dhchain.business.user.vo.ActUser;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ActUserMapper {

	public ActUser findById(String userid);

	public ActUser userLogin(ActUser user);


	public List<ActUser> userPage(Map<String, Object> map);
	
	public int userCount(Map<String, Object> map);
	

	public int deleteUser(List<String> id);
	

	public int updateUser(ActUser user);
	

	public int addUser(ActUser user);
}
