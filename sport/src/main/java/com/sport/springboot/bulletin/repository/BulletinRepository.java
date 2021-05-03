package com.sport.springboot.bulletin.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sport.springboot.bulletin.model.Bulletin;

@Repository
public interface BulletinRepository extends JpaRepository<Bulletin, Integer> {

	@Modifying
    @Query(value = "delete from Bulletin s where s.id = :id")
    void deleteByIdmethod1(Integer id);
	
	@Query(value="select * from user where id > (:id)",nativeQuery = true) 
	Page<Bulletin> findByIdSort(@Param("id") Integer id, Pageable pageable);
}
