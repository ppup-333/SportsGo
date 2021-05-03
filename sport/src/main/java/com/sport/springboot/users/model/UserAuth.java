package com.sport.springboot.users.model;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="user_auth")
public class UserAuth {

	@Id
	@Column(name = "AUTH_CODE", unique = true, nullable = false)
	private String authCode;

	@Column(name = "AUTH_NAME")
	private String authName;

	@Column(name = "VER")
	private Timestamp ver;

	@OneToMany(mappedBy = "authCode")
	private List<UserAuthList> authList;

	public String getAuthCode() {
		return authCode;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}

	public String getAuthName() {
		return authName;
	}

	public void setAuthName(String authName) {
		this.authName = authName;
	}

	public Timestamp getVer() {
		return ver;
	}

	public void setVer(Timestamp ver) {
		this.ver = ver;
	}

	public List<UserAuthList> getAuthList() {
		return authList;
	}

	public void setAuthList(List<UserAuthList> authList) {
		this.authList = authList;
	}

}
