package com.sport.springboot.bbs.service;

import java.util.List;

import com.sport.springboot.bbs.model.BbsReply;

public interface BbsReplyService {

	List<BbsReply> getAllBbsReply();
	
	BbsReply getBbsReply(Integer replyId);
	
}
