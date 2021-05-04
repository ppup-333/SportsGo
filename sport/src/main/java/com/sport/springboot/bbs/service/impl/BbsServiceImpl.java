package com.sport.springboot.bbs.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.bbs.model.Bbs;
import com.sport.springboot.bbs.repository.BbsDao;
import com.sport.springboot.bbs.service.BbsService;

@Service
public class BbsServiceImpl implements BbsService {
	
	@Autowired
	private BbsDao bbsDao;

	@Override
	public Bbs save(Bbs bbs) {
		bbs.setBbsDelete(0);
		return bbsDao.save(bbs);
	}

	@Override
	public void delete(Bbs bbs) {
//		bbs.getReplyList().removeAll(bbs.getReplyList());
		bbs.setBbsDelete(1);
		bbsDao.save(bbs);
	}
	
	@Override
	public Bbs deleteBbsByManager(Bbs bbs) {
		bbs.setBbsDelete(2);
		return bbsDao.save(bbs);
	}
	
	@Override
	public Bbs recoveryBbsByManager(Bbs bbs) {
		bbs.setBbsDelete(0);
		return bbsDao.save(bbs);
	}

	@Override
	public Bbs get(Integer bbsId) {
		Optional<Bbs> optional = bbsDao.findById(bbsId);
		Bbs bbs = null;
		if(optional.isPresent()) {
			bbs = optional.get();
		}else {
			throw new RuntimeException("Bbs(id=" + bbsId + ")不存在");
		}
		return bbs;
	}

	@Override
	public void update(Bbs bbs) {
		bbsDao.save(bbs);
	}

	@Override
	public List<Bbs> getAllBbs() {
		return bbsDao.findByOrderByBbsSetupTimeDesc();
	}

	@Override
	public List<Bbs> getBbsBySearch(String search) {
		return bbsDao.findBySearch(search);
	}

	@Override
	public List<Bbs> getBbsByTypeId(Integer typeId) {
		return bbsDao.findByBbsTypeTypeIdOrderByBbsSetupTimeDesc(typeId);
	}

	@Override
	public Bbs getBbsByBbsId(Integer bbsId) {
		return bbsDao.findById(bbsId).get();
	}

	@Override
	public List<Bbs> getBbsByTypeGroup(Integer typeId) {
		String typeGroup = "";
		if(typeId == -1) {
			typeGroup = "Game";
		}else if(typeId == -2) {
			typeGroup = "Health";
		}else {
			typeGroup = "Sport";
		}
		return bbsDao.findByBbsTypeTypeGroupOrderByBbsSetupTimeDesc(typeGroup);
	}

	@Override
	public List<Bbs> getBbsByBbsDelete(Integer bbsDelete) {
		return bbsDao.findByBbsDeleteOrderByBbsSetupTimeDesc(bbsDelete);
	}

}
