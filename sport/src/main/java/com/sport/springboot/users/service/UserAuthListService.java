package com.sport.springboot.users.service;

import java.util.List;

import com.sport.springboot.users.model.UserAuthList;

public interface UserAuthListService {

	UserAuthList save(UserAuthList userAuthList);
	List<UserAuthList> chkUserAuth(String account);
//	List<UserAuthList> chkUserAuth2();
}
