package com.sport.springboot.field.model;

import java.sql.Blob;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "fieldItem")
public class FieldItem {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	private String name;
	
	@ManyToOne
	@JoinColumn(name = "typeId")
	@JsonIgnoreProperties("fieldItems")
	private FieldType fieldType;
	
	private Blob img;
	
	private int rentForMember;
	
	private int rentForAct;
	
	private int amount;
	
	private int situation;
	
	private String remark;
	
	@OneToMany(mappedBy = "fieldItem")
	private List<FieldItemOrderDetail> orderDetails;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
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

	public Blob getImg() {
		return img;
	}

	public void setImg(Blob img) {
		this.img = img;
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

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
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

	public List<FieldItemOrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<FieldItemOrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	
}
