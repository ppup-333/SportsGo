package com.sport.springboot.users.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="user_act_validate_temp")
public class UserActValidateTemp {

	@Id
	@Column(name = "ACCOUNT")
	private String account;

	@Column(name = "VALIDATE_CODE")
	private String validate_code;

	@Column(name = "EXPIRED_TIME")
	private Timestamp expired_time;

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getValidate_code() {
		return validate_code;
	}

	public void setValidate_code(String validate_code) {
		this.validate_code = validate_code;
	}

	public Timestamp getExpired_time() {
		return expired_time;
	}

	public void setExpired_time(Timestamp expired_time) {
		this.expired_time = expired_time;
	}

}
