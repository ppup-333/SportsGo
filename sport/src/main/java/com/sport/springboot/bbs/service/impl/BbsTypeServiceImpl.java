package com.sport.springboot.bbs.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.bbs.model.BbsType;
import com.sport.springboot.bbs.repository.BbsTypeDao;
import com.sport.springboot.bbs.service.BbsTypeService;

@Service
public class BbsTypeServiceImpl implements BbsTypeService {
	
	@Autowired
	BbsTypeDao bbsTypeDao;

	@Override
	public List<BbsType> getAllBbsType() {
		return bbsTypeDao.findAll();
	}

	@Override
	public BbsType getBbsType(Integer typeId) {
		Optional<BbsType> optional = bbsTypeDao.findById(typeId);
		BbsType bbsType = null;
		if (optional.isPresent()) {
			bbsType = optional.get();
		} else {
			throw new RuntimeException("BbsType(id=" + bbsType + ")不存在");

		}
		return bbsType;
	}

	@Override
	public BbsType sava(BbsType bbsType) {
		return bbsTypeDao.save(bbsType);
	}

	@Override
	public List<BbsType> getByTypeGroup(String typeGroup) {
		return bbsTypeDao.findByTypeGroup(typeGroup);
	}

}
