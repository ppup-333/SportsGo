package com.sport.springboot.bulletin.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.sport.springboot.bulletin.model.Bulletin;

public interface BulletinService {
	Bulletin save(Bulletin bulletin);
	void delete(Integer id);
	Bulletin get(Integer id);
	void update(Bulletin bulletin);
	List<Bulletin> getAllBulletin();
	Page<Bulletin> findById( Integer id, Pageable pageable);
}
