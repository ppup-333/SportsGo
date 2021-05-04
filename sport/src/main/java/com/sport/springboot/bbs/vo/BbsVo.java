package com.sport.springboot.bbs.vo;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BbsVo {
	
	private Integer bbsId;

	private String bbsBuilder;

	private String bbsTitle;

	private String bbsMessage;

	@JsonFormat(pattern="yyyy-MM-dd HH:mm")
	private Timestamp bbsSetupTime;

	@JsonFormat(pattern="yyyy-MM-dd HH:mm")
	private Timestamp bbsUpdateTime;
	
	private String typeName;
	
	private Integer bbsDelete;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm")
	private Timestamp replySetupTime;
	
	private String replyAccount;
	
	private Integer replyDelete;
	
	
	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

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

	public Integer getBbsDelete() {
		return bbsDelete;
	}

	public void setBbsDelete(Integer bbsDelete) {
		this.bbsDelete = bbsDelete;
	}

	public Timestamp getReplySetupTime() {
		return replySetupTime;
	}

	public void setReplySetupTime(Timestamp replySetupTime) {
		this.replySetupTime = replySetupTime;
	}

	public String getReplyAccount() {
		return replyAccount;
	}

	public void setReplyAccount(String replyAccount) {
		this.replyAccount = replyAccount;
	}

	public Integer getReplyDelete() {
		return replyDelete;
	}

	public void setReplyDelete(Integer replyDelete) {
		this.replyDelete = replyDelete;
	}

}