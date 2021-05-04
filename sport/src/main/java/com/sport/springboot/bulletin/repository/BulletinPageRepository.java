package com.sport.springboot.bulletin.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.bulletin.model.Bulletin;

public interface BulletinPageRepository extends PagingAndSortingRepository<Bulletin, Integer> {
	
	@Query(value="select * from bulletin where id > :id",nativeQuery = true) 
	Page<Bulletin> findByIdSort(@Param("id") Integer id, Pageable pageable);
	
	@Query(value="select * from bulletin where id > :id and class_id = :class_id",nativeQuery = true) 
	Page<Bulletin> findByIdAndClassId(@Param("id") Integer id,@Param("class_id")Integer classId, Pageable pageable);
}
