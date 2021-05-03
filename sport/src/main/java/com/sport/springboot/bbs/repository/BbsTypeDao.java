package com.sport.springboot.bbs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.bbs.model.BbsType;

public interface BbsTypeDao extends JpaRepository<BbsType, Integer> {

	List<BbsType> findByTypeGroup(String typeGroup);
	
}
