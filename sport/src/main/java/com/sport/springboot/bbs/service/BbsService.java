package com.sport.springboot.bbs.service;

import java.util.List;

import com.sport.springboot.bbs.model.Bbs;

public interface BbsService {

	Bbs save(Bbs bbs);
	
	void delete(Bbs bbs);
	
	Bbs deleteBbsByManager(Bbs bbs);
	
	Bbs recoveryBbsByManager (Bbs bbs);
	
	Bbs get(Integer bbsId);
	
	void update(Bbs bbs);
	
	List<Bbs> getAllBbs();
	
	List<Bbs> getBbsByTypeId(Integer typeId);
	
	List<Bbs> getBbsBySearch(String search);
	
	Bbs getBbsByBbsId(Integer bbsId);
	
	List<Bbs> getBbsByTypeGroup(Integer typeId);
	
	List<Bbs> getBbsByBbsDelete(Integer bbsDelete);
	
	List<Bbs> getBbsByUsersAccount(String account);
	
}	
