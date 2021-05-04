package com.sport.springboot.bbs.service;

import java.util.List;

import com.sport.springboot.bbs.model.BbsReply;

public interface BbsReplyService {
	
	BbsReply save(BbsReply bbsReply);

	List<BbsReply> getAllBbsReply();
	
	BbsReply getBbsReply(Integer replyId);
	
	List<BbsReply> getBbsReplyByBbsId(Integer bbsId);
	
	BbsReply getReplyByReplyId(Integer replyId);
	
	void delete(Integer replyId);
	
	BbsReply deleteReplyByManager(BbsReply bbsReply);
	
	BbsReply recoveryReplyByManager(BbsReply bbsReply);
	
	void update(BbsReply bbsReply);
	
}
