package com.sport.springboot.users.service;

import com.sport.springboot.users.model.UserAuth;

public interface UserAuthService {

	UserAuth get(String authCode);
}
