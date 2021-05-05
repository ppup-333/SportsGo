package com.sport.springboot.users.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.users.model.UserStatus;
import com.sport.springboot.users.repository.UserStatusRepository;
import com.sport.springboot.users.service.UserStatusService;

@Service
public class UsersStatusServiceImpl implements UserStatusService {

	@Autowired
	UserStatusRepository userStatusDao;

	@Override
	public UserStatus get(String statusCode) {
		return userStatusDao.getOne(statusCode);

	}

	@Override
	public List<UserStatus> getAllStatus() {
		// TODO Auto-generated method stub
		return (List<UserStatus>) userStatusDao.findAll();
	}

}
