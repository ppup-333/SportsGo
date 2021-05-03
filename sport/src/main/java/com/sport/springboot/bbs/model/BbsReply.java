package com.sport.springboot.bbs.model;

import java.sql.Timestamp;

import javax.persistence.CascadeType;
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
	
	//@OneToOne
	private String replyAccount;

	private String reply;

	private Timestamp replySetupTime;

	private Timestamp replyUpdateTime;

	@ManyToOne(cascade = CascadeType.ALL)
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
	
}
