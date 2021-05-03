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
@Table(name = "fieldItemOrderDetail")
public class FieldItemOrderDetail {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@ManyToOne
	@JoinColumn(name = "itemId")
	@JsonIgnoreProperties("fieldItemOrderDetails")
	private FieldItem fieldItem;
	
	private String date;
	
	@ManyToOne
	@JoinColumn(name = "periodId")
	@JsonIgnoreProperties("fieldItemOrderDetails")
	private FieldPeriod fieldPeriod;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public FieldItem getFieldItem() {
		return fieldItem;
	}

	public void setFieldItem(FieldItem fieldItem) {
		this.fieldItem = fieldItem;
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
