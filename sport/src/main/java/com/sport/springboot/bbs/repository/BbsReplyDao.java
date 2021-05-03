package com.sport.springboot.bbs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.bbs.model.BbsReply;

public interface BbsReplyDao extends JpaRepository<BbsReply, Integer> {

	List<BbsReply> findByBbsBbsIdOrderByReplySetupTimeDesc(Integer bbsId);
	
	List<BbsReply> deleteByBbsBbsId(Integer bbsId);
	
	long countByBbsBbsId(Integer bbsId);
	
}
