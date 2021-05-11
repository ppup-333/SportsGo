package com.sport.springboot.field.model;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.sport.springboot.course_act.model.CATime;


@Entity
@Table(name = "field",
	   uniqueConstraints = {@UniqueConstraint(columnNames = "name")})
public class Field {

	@Id
	private String id;
	
	private String name;
	
	@ManyToOne
	@JoinColumn(name = "typeId")
	@JsonIgnoreProperties(value = {"fields","fieldItems"})
	private FieldType fieldType;
	
	private String position;
	
	private int rentForMember;
	
	private int rentForAct;
	
	private int situation;
	
	private String remark;
	
	private String buildDate;
	
	private Date createDate;
	
	private Date updateDate;
	
	
	@OneToMany(mappedBy = "field")
	@JsonIgnore
	private List<FieldOrderDetail> orderDetails;
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "fieldbean",cascade = CascadeType.ALL)
	@JsonIgnore
	private List<CATime> time;	
	
	public Field() {
		
	}
	
	public Field(String id, String name, FieldType fieldType, String position,
			int rentForMember, int rentForAct, int situation, String remark,
			String buildDate) {
		this.id = id;
		this.name = name;
		this.fieldType = fieldType;
		this.position = position;
		this.rentForMember = rentForMember;
		this.rentForAct = rentForAct;
		this.situation = situation;
		this.remark = remark;
		this.buildDate = buildDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public FieldType getFieldType() {
		return fieldType;
	}

	public void setFieldType(FieldType fieldType) {
		this.fieldType = fieldType;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public int getRentForMember() {
		return rentForMember;
	}

	public void setRentForMember(int rentForMember) {
		this.rentForMember = rentForMember;
	}

	public int getRentForAct() {
		return rentForAct;
	}

	public void setRentForAct(int rentForAct) {
		this.rentForAct = rentForAct;
	}

	public int getSituation() {
		return situation;
	}

	public void setSituation(int situation) {
		this.situation = situation;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getBuildDate() {
		return buildDate;
	}

	public void setBuildDate(String buildDate) {
		this.buildDate = buildDate;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public List<FieldOrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<FieldOrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public List<CATime> getTime() {
		return time;
	}

	public void setTime(List<CATime> time) {
		this.time = time;
	}
	
	
		
	
	
}
