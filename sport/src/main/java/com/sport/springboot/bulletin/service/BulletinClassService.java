package com.sport.springboot.bulletin.service;

import java.util.List;

import com.sport.springboot.bulletin.model.BulletinClass;

public interface BulletinClassService {
	List<BulletinClass> getAllBulletinClass();
	BulletinClass getBulletinClass(Integer id);
}
