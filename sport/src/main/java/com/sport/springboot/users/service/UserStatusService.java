package com.sport.springboot.users.service;

import com.sport.springboot.users.model.UserStatus;

public interface UserStatusService {

	UserStatus get(String statusCode);
}
