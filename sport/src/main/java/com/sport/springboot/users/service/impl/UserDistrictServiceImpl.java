package com.sport.springboot.users.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.users.model.UserDistrict;
import com.sport.springboot.users.repository.UserDistrictRepository;
import com.sport.springboot.users.service.UserDistrictService;

@Service
public class UserDistrictServiceImpl implements UserDistrictService {

	@Autowired
	UserDistrictRepository userDistrictDao;

	@Override
	public List<UserDistrict> getAllDistrict() {
		return (List<UserDistrict>) userDistrictDao.findAll();
	}

	@Override
	public UserDistrict getDistrict(Integer userDistrictCode) {
		Optional<UserDistrict> optional1 = userDistrictDao.findById(userDistrictCode);
		UserDistrict userDistrict = null;
		if (optional1.isPresent()) {
			userDistrict = optional1.get();
		} else {
			throw new RuntimeException("UserDistrictCode" + userDistrictCode + "不存在");
		}
		return userDistrict;
	}

	@Override
	public UserDistrict get(Integer userDistrictCode) {
		// TODO Auto-generated method stub
		return userDistrictDao.getOne(userDistrictCode);
	}

}
