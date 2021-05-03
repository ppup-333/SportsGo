package com.sport.springboot.users.service;

import java.util.List;

import com.sport.springboot.users.model.UserDistrict;

public interface UserDistrictService {

	List<UserDistrict> getAllDistrict();
	UserDistrict getDistrict(Integer userDistrictCode);
}
