package com.sport.springboot.users.service;

import java.util.List;

import com.sport.springboot.users.model.Users;

public interface UsersService {
	
	Users save(Users users);
	Users get(String account);
	boolean getChkAccount(String account);
	void update(Users users);
	List<Users> getAllUsers();
//	Users userLogin(String account);
	List<Users> userLogin(String account);
}
