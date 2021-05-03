package com.sport.springboot.users.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.users.model.UserAuth;
import com.sport.springboot.users.repository.UserAuthRepository;
import com.sport.springboot.users.service.UserAuthService;

@Service
public class UserAuthServiceImpl implements UserAuthService {

	@Autowired
	UserAuthRepository usersAuthDao;
	
	@Override
	public UserAuth get(String authCode) {
		// TODO Auto-generated method stub
		return usersAuthDao.getOne(authCode);
	}

}
