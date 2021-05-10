package com.sport.springboot.bbs.model;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.sport.springboot.users.model.Users;

@Entity
@Table(name = "bbs")
public class Bbs implements Comparable<Bbs> {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer bbsId;

	@ManyToOne
	@JoinColumn(name = "bbsBuilder")
	private Users users;
	
	private String bbsTitle;

	private String bbsMessage;

	private Timestamp bbsSetupTime;

	private Timestamp bbsUpdateTime;
	
	private Integer bbsDelete;

	@ManyToOne
	@JoinColumn(name="typeId")
	private BbsType bbsType;
	
	@OneToMany(mappedBy = "bbs", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<BbsReply> replyList;

	public Integer getBbsId() {
		return bbsId;
	}

	public void setBbsId(Integer bbsId) {
		this.bbsId = bbsId;
	}

	public Users getUsers() {
		return users;
	}

	public void setUsers(Users users) {
		this.users = users;
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
		return bbsMessage;
	}
	
	public String getBbsMessageByDetail() {
		return bbsMessage.replaceAll("\n", "<br>").replaceAll("嗨", "&#128563");
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

	public Integer getBbsDelete() {
		return bbsDelete;
	}

	public void setBbsDelete(Integer bbsDelete) {
		this.bbsDelete = bbsDelete;
	}

	@Override
	public int compareTo(Bbs o) {
		return o.getBbsSetupTime().compareTo(this.getBbsSetupTime());
	}

}
