package com.sport.springboot.users.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="user_status")
public class UserStatus {

	@Id
	@Column(name = "STATUS_CODE", unique = true, nullable = false)
	private String statusCode;

	@Column(name = "STATUS")
	private String status;

	@Column(name = "VER")
	private Timestamp ver;

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getVer() {
		return ver;
	}

	public void setVer(Timestamp ver) {
		this.ver = ver;
	}

}
