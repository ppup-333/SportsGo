package com.sport.springboot.users.model;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="user_city")
public class UserCity {

	@Id
	@Column(name = "CITY_CODE", unique = true, nullable = false)
	private String cityCode;

	@Column(name = "CITY")
	private String city;

	@Column(name = "VER")
	private Timestamp ver;

	@OneToMany(mappedBy = "cityCode")
	private List<Users> cityList;

	@OneToMany(mappedBy = "cityCode")
	private List<UserDistrict> cityDistrictList;

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Timestamp getVer() {
		return ver;
	}

	public void setVer(Timestamp ver) {
		this.ver = ver;
	}

	public List<Users> getCityList() {
		return cityList;
	}

	public void setCityList(List<Users> cityList) {
		this.cityList = cityList;
	}

	public List<UserDistrict> getCityDistrictList() {
		return cityDistrictList;
	}

	public void setCityDistrictList(List<UserDistrict> cityDistrictList) {
		this.cityDistrictList = cityDistrictList;
	}

}
