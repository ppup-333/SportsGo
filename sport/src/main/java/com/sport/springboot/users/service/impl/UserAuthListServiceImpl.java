package com.sport.springboot.users.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.users.model.UserAuthList;
import com.sport.springboot.users.repository.UserAuthListRepository;
import com.sport.springboot.users.service.UserAuthListService;

@Service
public class UserAuthListServiceImpl implements UserAuthListService {

	@Autowired
	UserAuthListRepository userAuthListDao;
	
	@Override
	public UserAuthList save(UserAuthList userAuthList) {
		return userAuthListDao.save(userAuthList);
	}

	@Override
	public List<UserAuthList> chkUserAuth(String account) {
		// TODO Auto-generated method stub
		return userAuthListDao.chkUserAuth(account);
	}
	
//	@Override
//	public List<UserAuthList> chkUserAuth2() {
//		// TODO Auto-generated method stub
//		return userAuthListDao.chkUserAuth2();
//	}

}
