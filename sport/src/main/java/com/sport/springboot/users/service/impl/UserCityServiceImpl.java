package com.sport.springboot.users.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.users.model.UserCity;
import com.sport.springboot.users.repository.UserCityRepository;
import com.sport.springboot.users.service.UserCityService;

@Service
public class UserCityServiceImpl implements UserCityService {

	@Autowired
	UserCityRepository userCityDao;

	@Override
	public List<UserCity> getAllCity() {
		return (List<UserCity>) userCityDao.findAll();
	}

	@Override
	public UserCity getCity(String cityCode) {
		Optional<UserCity> optional1 = userCityDao.findById(cityCode);
		UserCity userCity = null;
		if (optional1.isPresent()) {
			userCity = optional1.get();
		} else {
			throw new RuntimeException("Citycode" + cityCode + "不存在");
		}
		
		return userCity;
	}

	@Override
	public UserCity get(String cityCode) {
		// TODO Auto-generated method stub
		return userCityDao.getOne(cityCode);
	}

}
