package com.sport.springboot.bulletin.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.sport.springboot.bulletin.model.Bulletin;

public interface BulletinPageRepository extends PagingAndSortingRepository<Bulletin, Integer> {
	
}
