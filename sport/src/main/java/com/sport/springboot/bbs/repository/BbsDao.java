package com.sport.springboot.bbs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.bbs.model.Bbs;

public interface BbsDao extends JpaRepository<Bbs, Integer> {

	List<Bbs> findByOrderByBbsSetupTimeDesc();
	
	List<Bbs> findByBbsTypeTypeIdOrderByBbsSetupTimeDesc(Integer typeId);
	
	@Query("FROM Bbs where (bbsTitle like %:search% or bbsMessage like %:search%)"
			   + " and bbsDelete in(0, 2)"
			   + " order by bbsSetupTime Desc")
	public List<Bbs> findBySearch(@Param("search") String search);
	
	List<Bbs> findByBbsTypeTypeGroupOrderByBbsSetupTimeDesc(String typeGroup);
	
	List<Bbs> findByBbsDeleteOrderByBbsSetupTimeDesc(Integer bbsDelete);
	
	List<Bbs> findByUsersAccountOrderByBbsSetupTimeDesc(String account);
}
