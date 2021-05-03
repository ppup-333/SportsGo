package com.sport.springboot.bbs.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.sport.springboot.bbs.model.Bbs;

public interface BbsService {

	Bbs save(Bbs bbs);
	
	void delete(Integer bbsId);
	
	Bbs get(Integer bbsId);
	
	void update(Bbs bbs);
	
	List<Bbs> getAllBbs();
	
	List<Bbs> getBbsByTypeId(Integer typeId);
	
	List<Bbs> getBbsBySearch(String search);
	
	Bbs getBbsByBbsId(Integer bbsId);
	
	Page<Bbs> getPageBbs(Integer page, Integer size);
	
}	
