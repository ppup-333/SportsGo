package com.sport.springboot.bulletin.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.bulletin.model.BulletinClass;
import com.sport.springboot.bulletin.repository.BulletinClassRepository;
import com.sport.springboot.bulletin.service.BulletinClassService;

@Service
public class BulletinClassServiceImpl implements BulletinClassService {

	@Autowired
	BulletinClassRepository bulletinClassDao;
	
	@Override
	public List<BulletinClass> getAllBulletinClass() {
		return (List<BulletinClass>) bulletinClassDao.findAll();

	}

	@Override
	public BulletinClass getBulletinClass(Integer id) {
		Optional <BulletinClass> optional = bulletinClassDao.findById(id);
		BulletinClass bulletinClass = null;
		if(optional.isPresent()) {
			bulletinClass = optional.get();
		}else {
			throw new RuntimeException("BulletinClass(id=" + id + ")不存在");
		}
		return bulletinClass;
	}

}
