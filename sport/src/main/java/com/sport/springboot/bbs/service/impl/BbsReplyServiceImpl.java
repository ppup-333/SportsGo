package com.sport.springboot.bbs.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.bbs.model.BbsReply;
import com.sport.springboot.bbs.repository.BbsReplyDao;
import com.sport.springboot.bbs.service.BbsReplyService;

@Service
public class BbsReplyServiceImpl implements BbsReplyService {

	@Autowired
	private BbsReplyDao bbsReplyDao;

	@Override
	public List<BbsReply> getAllBbsReply() {
		return bbsReplyDao.findAll();
	}

	@Override
	public BbsReply getBbsReply(Integer replyId) {
		Optional<BbsReply> optional = bbsReplyDao.findById(replyId);
		BbsReply bbsReply = null;
		if (optional.isPresent()) {
			bbsReply = optional.get();
		} else {
			throw new RuntimeException("BbsReply(id=" + replyId + ")不存在");

		}
		return bbsReply;
	}

}
