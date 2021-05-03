package com.sport.springboot.users.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.users.model.Users;
import com.sport.springboot.users.repository.UsersRepository;
import com.sport.springboot.users.service.UsersService;

@Service
public class UserServiceImpl implements UsersService {

	@Autowired
	UsersRepository usersDao;

	@Override
	public Users save(Users users) {
		return usersDao.save(users);
	}

	@Override
	public Users get(String account) {
		return usersDao.getOne(account);
	}

	@Override
	public boolean getChkAccount(String account) {
		Optional<Users> optional = usersDao.findById(account);

		Users users = null;
		System.out.println("optional=" + optional);
		if (optional.isPresent()) {
			users = optional.get();
			System.out.println("users2=" + users);
			return true;
		}
		return false;
	}

	@Override
	public void update(Users users) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Users> getAllUsers() {
		// TODO Auto-generated method stub
		return null;
	}

//	@Override
//	public Users userLogin(String account) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public List<Users> userLogin(String account) {
		// TODO Auto-generated method stub
		return usersDao.userLogin(account);
	}
	
	

	
	

}
