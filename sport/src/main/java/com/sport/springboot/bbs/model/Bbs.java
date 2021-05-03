package com.sport.springboot.bbs.model;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "bbs")
public class Bbs {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer bbsId;

	private String bbsBuilder;

	private String bbsTitle;

	private String bbsMessage;

	private Timestamp bbsSetupTime;

	private Timestamp bbsUpdateTime;

	@ManyToOne
	@JoinColumn(name="typeId")
	private BbsType bbsType;
	
	@OneToMany(mappedBy = "bbs")
	private List<BbsReply> replyList;

	public Integer getBbsId() {
		return bbsId;
	}

	public void setBbsId(Integer bbsId) {
		this.bbsId = bbsId;
	}

	public String getBbsBuilder() {
		return bbsBuilder;
	}

	public void setBbsBuilder(String bbsBuilder) {
		this.bbsBuilder = bbsBuilder;
	}

	public String getBbsTitle() {
		return bbsTitle;
	}

	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}

	public String getBbsMessage() {
		return bbsMessage;
	}

	public void setBbsMessage(String bbsMessage) {
		this.bbsMessage = bbsMessage;
	}

	public Timestamp getBbsSetupTime() {
		return bbsSetupTime;
	}

	public void setBbsSetupTime(Timestamp bbsSetupTime) {
		this.bbsSetupTime = bbsSetupTime;
	}

	public Timestamp getBbsUpdateTime() {
		return bbsUpdateTime;
	}

	public void setBbsUpdateTime(Timestamp bbsUpdateTime) {
		this.bbsUpdateTime = bbsUpdateTime;
	}

	public BbsType getBbsType() {
		return bbsType;
	}

	public void setBbsType(BbsType bbsType) {
		this.bbsType = bbsType;
	}

	public List<BbsReply> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<BbsReply> replyList) {
		this.replyList = replyList;
	}
	
}
