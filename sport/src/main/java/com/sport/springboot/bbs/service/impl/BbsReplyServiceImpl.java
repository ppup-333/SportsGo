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

	@Override
	public List<BbsReply> getBbsReplyByBbsId(Integer bbsId) {
		return bbsReplyDao.findByBbsBbsIdOrderByReplySetupTimeDesc(bbsId);
	}

	@Override
	public BbsReply save(BbsReply bbsReply) {
		long replyRank = bbsReplyDao.countByBbsBbsId(bbsReply.getBbs().getBbsId());
		bbsReply.setReplyRank(replyRank + 1);
		bbsReply.setReplyDelete(0);
		return bbsReplyDao.save(bbsReply);
	}

	@Override
	public void delete(Integer replyId) {
		BbsReply bbsReply = getBbsReply(replyId);
		bbsReply.setReplyDelete(1);
		bbsReplyDao.save(bbsReply);
	}
	
	@Override
	public BbsReply deleteByManager(BbsReply bbsReply) {
		bbsReply.setReplyDelete(2);
		return bbsReplyDao.save(bbsReply);
	}
	
	@Override
	public BbsReply recoveryByManager(BbsReply bbsReply) {
		bbsReply.setReplyDelete(0);
		return bbsReplyDao.save(bbsReply);
	}

	@Override
	public BbsReply getReplyByReplyId(Integer replyId) {
		return bbsReplyDao.findById(replyId).get();
	}

	@Override
	public void update(BbsReply bbsReply) {
		bbsReplyDao.save(bbsReply);
	}

}
