package com.sport.springboot.bbs.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.bbs.model.BbsReply;

public interface BbsReplyDao extends JpaRepository<BbsReply, Integer> {

}
