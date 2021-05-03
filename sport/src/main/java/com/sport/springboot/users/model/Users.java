package com.sport.springboot.users.model;

import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;


@Entity
@Table(name = "users", uniqueConstraints = { @UniqueConstraint(columnNames = "ID"),
		@UniqueConstraint(columnNames = "EMAIL") })
public class Users {

	@Id
	@Column(name = "ACCOUNT")
	private String account;

	@Column(name = "PASSWORD")
	private String password;

	@Column(name = "NAME")
	private String name;

	@Column(name = "ID")
	private String id;

	@Column(name = "GENDER")
	private String gender;

	@Column(name = "BIRTHDAY")
	private String birthday;

	@Column(name = "EMAIL")
	private String email;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "CITY_CODE", nullable = true)
	private UserCity cityCode;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "USER_DISTRICT_CODE", nullable = true)
	private UserDistrict userDistrictCode;

	@Column(name = "ADDRESS")
	private String address;

	@Column(name = "TEL")
	private String tel;

	@Column(name = "MOBILE")
	private String mobile;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "STATUS_CODE", nullable = true)
	private UserStatus statusCode;

	@Column(name = "ACT_REGISTERED_TIME")
	private String actRegisteredTime;

	@Column(name = "LOGIN_FAIL_COUNT")
	private Integer loginFailCount;

	@Column(name = "PW_LAST_UPDATE_DATE")
	private Timestamp pwLastUpdateDate;

	@Column(name = "VER")
	private Timestamp ver;

	@Transient
	private String dbChkPwd;

	public String getDbChkPwd() {
		return dbChkPwd;
	}

	public void setDbChkPwd(String dbChkPwd) {
		this.dbChkPwd = dbChkPwd;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public UserCity getCityCode() {
		return cityCode;
	}

	public void setCityCode(UserCity cityCode) {
		this.cityCode = cityCode;
	}

	public UserDistrict getUserDistrictCode() {
		return userDistrictCode;
	}

	public void setUserDistrictCode(UserDistrict userDistrictCode) {
		this.userDistrictCode = userDistrictCode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public UserStatus getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(UserStatus statusCode) {
		this.statusCode = statusCode;
	}

	public String getActRegisteredTime() {
		return actRegisteredTime;
	}

	public void setActRegisteredTime(String actRegisteredTime) {
		this.actRegisteredTime = actRegisteredTime;
	}

	public Integer getLoginFailCount() {
		return loginFailCount;
	}

	public void setLoginFailCount(Integer loginFailCount) {
		this.loginFailCount = loginFailCount;
	}

	public Timestamp getPwLastUpdateDate() {
		return pwLastUpdateDate;
	}

	public void setPwLastUpdateDate(Timestamp pwLastUpdateDate) {
		this.pwLastUpdateDate = pwLastUpdateDate;
	}

	public Timestamp getVer() {
		return ver;
	}

	public void setVer(Timestamp ver) {
		this.ver = ver;
	}

}
