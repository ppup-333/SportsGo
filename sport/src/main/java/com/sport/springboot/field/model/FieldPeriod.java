package com.sport.springboot.field.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "fieldPeriod")
public class FieldPeriod {
	
	@Id
	private Integer id;
	
	private String period;
	
	@OneToMany(mappedBy = "fieldPeriod")
	private List<FieldOrderDetail> fieldOrderDetails;
	
	@OneToMany(mappedBy = "fieldPeriod")
	private List<FieldItemOrderDetail> itemOrderDetails;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public List<FieldOrderDetail> getFieldOrderDetails() {
		return fieldOrderDetails;
	}

	public void setFieldOrderDetails(List<FieldOrderDetail> fieldOrderDetails) {
		this.fieldOrderDetails = fieldOrderDetails;
	}

	public List<FieldItemOrderDetail> getItemOrderDetails() {
		return itemOrderDetails;
	}

	public void setItemOrderDetails(List<FieldItemOrderDetail> itemOrderDetails) {
		this.itemOrderDetails = itemOrderDetails;
	}
	

}
