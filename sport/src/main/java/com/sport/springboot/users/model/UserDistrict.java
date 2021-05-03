package com.sport.springboot.users.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="user_district")
public class UserDistrict {

	@Id
	@Column(name = "USER_DISTRICT_CODE", unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer userDistrictCode;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "CITY_CODE", nullable = true)
	private UserCity cityCode;

	@Column(name = "DISTRICT")
	private String district;

	@Column(name = "VER")
	private String ver;

	@OneToMany(mappedBy = "userDistrictCode")
	private List<Users> districtList;

	public Integer getUserDistrictCode() {
		return userDistrictCode;
	}

	public void setUserDistrictCode(Integer userDistrictCode) {
		this.userDistrictCode = userDistrictCode;
	}

	public UserCity getCityCode() {
		return cityCode;
	}

	public void setCityCode(UserCity cityCode) {
		this.cityCode = cityCode;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getVer() {
		return ver;
	}

	public void setVer(String ver) {
		this.ver = ver;
	}

	public List<Users> getDistrictList() {
		return districtList;
	}

	public void setDistrictList(List<Users> districtList) {
		this.districtList = districtList;
	}

}
