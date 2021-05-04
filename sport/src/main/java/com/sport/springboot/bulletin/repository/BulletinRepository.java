package com.sport.springboot.bulletin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sport.springboot.bulletin.model.Bulletin;

@Repository
public interface BulletinRepository extends JpaRepository<Bulletin, Integer> {

	@Modifying
    @Query(value = "delete from Bulletin s where s.id = :id")
    void deleteByIdmethod1(Integer id);
	
	@Modifying
	@Query(value = "update Bulletin s set s.image=NULL, s.fileName=NULL where s.id= :id")
	void resetPicture(Integer id);
	
}
