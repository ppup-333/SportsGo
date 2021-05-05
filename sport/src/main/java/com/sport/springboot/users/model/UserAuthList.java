package com.sport.springboot.users.model;

import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "user_auth_list")
public class UserAuthList {

	@Id
	@Column(name = "USER_AUTH_LIST_OID")
	private String userAuthListOid;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "ACCOUNT", nullable = false)
	private Users users;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "AUTH_CODE", nullable = false)
	@JsonIgnoreProperties("authList")
	private UserAuth authCode;

	@Column(name = "VER")
	private Timestamp ver;

	public String getUserAuthListOid() {
		return userAuthListOid;
	}

	public void setUserAuthListOid(String userAuthListOid) {
		this.userAuthListOid = userAuthListOid;
	}

	public Users getUsers() {
		return users;
	}

	public void setUsers(Users users) {
		this.users = users;
	}

	public UserAuth getAuthCode() {
		return authCode;
	}

	public void setAuthCode(UserAuth authCode) {
		this.authCode = authCode;
	}

	public Timestamp getVer() {
		return ver;
	}

	public void setVer(Timestamp ver) {
		this.ver = ver;
	}

}
