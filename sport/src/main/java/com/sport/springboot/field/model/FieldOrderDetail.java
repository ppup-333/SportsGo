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
@Table(name = "fieldOrderDetail")
public class FieldOrderDetail {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@ManyToOne
	@JoinColumn(name = "memberOrderId")
	@JsonIgnoreProperties("orderDetails")
	private FieldMemberOrder fieldMemberOrder;
	
	@ManyToOne
	@JoinColumn(name = "actOrderId")
	@JsonIgnoreProperties({"orderDetails", "activitybean", "coursebean"})
	private FieldActOrder fieldActOrder;
	
	@ManyToOne
	@JoinColumn(name = "fieldId")
	@JsonIgnoreProperties({"orderDetails", "time"})
	private Field field;
	
	private String date;
	
	@ManyToOne
	@JoinColumn(name = "periodId")
	@JsonIgnoreProperties("fieldOrderDetails")
	private FieldPeriod fieldPeriod;

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

	public Field getField() {
		return field;
	}

	public void setField(Field field) {
		this.field = field;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public FieldPeriod getFieldPeriod() {
		return fieldPeriod;
	}

	public void setFieldPeriod(FieldPeriod fieldPeriod) {
		this.fieldPeriod = fieldPeriod;
	}

	
	
}
