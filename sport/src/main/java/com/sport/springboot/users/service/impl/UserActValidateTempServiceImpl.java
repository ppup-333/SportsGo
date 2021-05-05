package com.sport.springboot.users.service.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.users.model.UserActValidateTemp;
import com.sport.springboot.users.repository.UserActValidateTempRepository;
import com.sport.springboot.users.service.UserActValidateTempService;
@Service
public class UserActValidateTempServiceImpl implements UserActValidateTempService {
	
	@Autowired
	UserActValidateTempRepository userValidateDao;
	
	
	
	@Override
	public UserActValidateTemp getInfo(String account) {
		Optional<UserActValidateTemp> optional = userValidateDao.findById(account);
		UserActValidateTemp uavt = null;
		if(optional.isPresent()) {
			uavt = optional.get();
		}else {
			throw new RuntimeException("uavt(account=" + account + ")不存在");
		}
		
		return uavt;
		
//		return userValidateDao.getInfo(account);
	}

	@Override
	public UserActValidateTemp save(UserActValidateTemp userValidate) {
		return userValidateDao.save(userValidate);
	}

	@Override
	public void updateCode(UserActValidateTemp uavt) {
		userValidateDao.save(uavt);
	}

}
