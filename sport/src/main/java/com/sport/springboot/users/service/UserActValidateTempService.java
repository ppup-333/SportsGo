package com.sport.springboot.users.service;

import com.sport.springboot.users.model.UserActValidateTemp;

public interface UserActValidateTempService {

	UserActValidateTemp getInfo(String account);
	UserActValidateTemp save(UserActValidateTemp userValidate);
	void updateCode(UserActValidateTemp uavt);
}
