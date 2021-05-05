package com.sport.springboot.users.service;

import java.util.List;

import com.sport.springboot.users.model.UserCity;

public interface UserCityService {

	List<UserCity> getAllCity();
	UserCity getCity(String cityCode);
	UserCity get (String cityCode);
}
