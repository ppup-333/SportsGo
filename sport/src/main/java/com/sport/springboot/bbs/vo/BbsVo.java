package com.sport.springboot.bbs.vo;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BbsVo {
	
	private Integer bbsId;

	private String account;
	
	private String bbsTitle;

	private String bbsMessage;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm" , timezone = "GMT+8")
	private Timestamp bbsSetupTime;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm" , timezone = "GMT+8")
	private Timestamp bbsUpdateTime;
	
	private String typeName;
	
	private Integer bbsDelete;
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm" , timezone = "GMT+8")
	private Timestamp replySetupTime;
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm" , timezone = "GMT+8")
	private Timestamp replyUpdateTime;
	
	private String replyAccount;
	
	private Integer replyDelete;
	
	private String name;
	
	
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

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getBbsTitle() {
		return bbsTitle;
	}
	
	public String getBbsTitleByDetail() {
		return bbsTitle.replaceAll("嗨", "&#128563");
	}

	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}

	public String getBbsMessage() {
		return bbsMessage.replaceAll("<br>", "&nbsp");
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

	public Timestamp getReplyUpdateTime() {
		return replyUpdateTime;
	}

	public void setReplyUpdateTime(Timestamp replyUpdateTime) {
		this.replyUpdateTime = replyUpdateTime;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
