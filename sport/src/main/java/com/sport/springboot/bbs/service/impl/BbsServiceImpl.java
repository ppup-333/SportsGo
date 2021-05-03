package com.sport.springboot.bbs.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
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
		return bbsDao.save(bbs);
	}

	@Override
	public void delete(Integer bbsId) {
		bbsDao.deleteById(bbsId);
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
	public Page<Bbs> getPageBbs(Integer page, Integer size){
		Page<Bbs> pageResult = bbsDao.findAll(
				PageRequest.of(page, size, Sort.by("bbsSetupTime").descending()));
//		pageResult.getNumberOfElements(); // 本頁筆數
//        pageResult.getSize();             // 每頁筆數 
//        pageResult.getTotalElements();    // 全部筆數
//        pageResult.getTotalPages();       // 全部頁數
        
//        List<Bbs> bbsList =  pageResult.getContent();
    
        return pageResult;
		
	}
	
}
