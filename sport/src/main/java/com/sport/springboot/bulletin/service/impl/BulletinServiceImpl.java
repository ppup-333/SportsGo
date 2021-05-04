package com.sport.springboot.bulletin.service.impl;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.sport.springboot.bulletin.model.Bulletin;
import com.sport.springboot.bulletin.repository.BulletinPageRepository;
import com.sport.springboot.bulletin.repository.BulletinRepository;
import com.sport.springboot.bulletin.service.BulletinService;
@Service
@Transactional
public class BulletinServiceImpl implements BulletinService {

	@Autowired
	BulletinRepository bulletinDao;
	@Autowired
	BulletinPageRepository bulletinPageDao;
	
	@Override
	public Bulletin save(Bulletin bulletin) {
		return bulletinDao.save(bulletin);
	}

	@Override
	public void delete(Integer id) {
//		bulletinDao.deleteById(id);
		bulletinDao.deleteByIdmethod1(id);
	}

	

	@Override
	public void update(Bulletin bulletin) {
		bulletinDao.save(bulletin);
	}

	@Override
	public Bulletin get(Integer id) {
		Optional<Bulletin> optional = bulletinDao.findById(id);
		Bulletin bulletin = null;
		if(optional.isPresent()) {
			bulletin = optional.get();
		}else {
			throw new RuntimeException("bulletin(id=" + id + ")不存在");
		}
		return bulletin;
	}
	
	@Override
	public List<Bulletin> getAllBulletin() {
		return bulletinDao.findAll();
	}
	
	 @Override public Page<Bulletin> findByIdSort(Integer id, Pageable pageable) { 
		 return bulletinPageDao.findByIdSort(id,pageable); 
	}
	 @Override 
	 public Page<Bulletin> findByIdAndClassId(Integer id, Integer classId, Pageable pageable){
		 return bulletinPageDao.findByIdAndClassId(id, classId, pageable);
	 }
	 
	 @Override
	public void resetPicture(Integer id) {
		bulletinDao.resetPicture(id);
	}
}
