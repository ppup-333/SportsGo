package com.sport.springboot.bbs.service;

import java.util.List;

import com.sport.springboot.bbs.model.BbsType;

public interface BbsTypeService {
	
	List<BbsType> getAllBbsType();
	
	BbsType getBbsType(Integer typeId);
	
	BbsType sava(BbsType bbsType);
	
	List<BbsType> getByTypeGroup(String typeGroup);
	
}
