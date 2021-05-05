package com.sport.springboot.users.service;

import java.util.List;

import com.sport.springboot.users.model.UserStatus;

public interface UserStatusService {

	UserStatus get(String statusCode);
	List<UserStatus> getAllStatus();
}
