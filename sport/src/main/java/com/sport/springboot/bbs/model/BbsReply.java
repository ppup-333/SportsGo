package com.sport.springboot.bbs.model;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "bbsReply")
public class BbsReply {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer replyId;
	
	private String replyAccount;

	private String reply;

	private Timestamp replySetupTime;

	private Timestamp replyUpdateTime;
	
	private Long replyRank;
	
	private Integer replyDelete;

	@ManyToOne
	@JoinColumn(name = "bbsId")
	private Bbs bbs;

	public Integer getReplyId() {
		return replyId;
	}

	public void setReplyId(Integer replyId) {
		this.replyId = replyId;
	}

	public String getReplyAccount() {
		return replyAccount;
	}

	public void setReplyAccount(String replyAccount) {
		this.replyAccount = replyAccount;
	}

	public String getReply() {
		return reply;
	}
	
	public String getReplyByDetail() {
		return reply.replaceAll("\n", "<br>").replaceAll("嗨", "&#128563");
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public Timestamp getReplySetupTime() {
		return replySetupTime;
	}

	public void setReplySetupTime(Timestamp replySetupTime) {
		this.replySetupTime = replySetupTime;
	}

	public Timestamp getReplyUpdateTime() {
		return replyUpdateTime;
	}

	public void setReplyUpdateTime(Timestamp replyUpdateTime) {
		this.replyUpdateTime = replyUpdateTime;
	}

	public Bbs getBbs() {
		return bbs;
	}

	public void setBbs(Bbs bbs) {
		this.bbs = bbs;
	}

	public Long getReplyRank() {
		return replyRank;
	}

	public void setReplyRank(Long replyRank) {
		this.replyRank = replyRank;
	}

	public Integer getReplyDelete() {
		return replyDelete;
	}

	public void setReplyDelete(Integer replyDelete) {
		this.replyDelete = replyDelete;
	}
		
}
