package com.sport.springboot.field.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "fieldItemOrder")
public class FieldItemOrder {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@ManyToOne
	@JoinColumn(name = "fieldMemberOrderId")
	@JsonIgnoreProperties("fieldItemOrders")
	private FieldMemberOrder fieldMemberOrder;
	
	@ManyToOne
	@JoinColumn(name = "fieldActOrderId")
	@JsonIgnoreProperties("fieldItemOrders")
	private FieldActOrder fieldActOrder;
	
	private String createTime;
	
	private String updateTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public FieldMemberOrder getFieldMemberOrder() {
		return fieldMemberOrder;
	}

	public void setFieldMemberOrder(FieldMemberOrder fieldMemberOrder) {
		this.fieldMemberOrder = fieldMemberOrder;
	}

	public FieldActOrder getFieldActOrder() {
		return fieldActOrder;
	}

	public void setFieldActOrder(FieldActOrder fieldActOrder) {
		this.fieldActOrder = fieldActOrder;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	
	
	
}
