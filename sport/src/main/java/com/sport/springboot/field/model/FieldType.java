package com.sport.springboot.field.model;

import java.sql.Blob;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "fieldType")
@Component
public class FieldType {

	@Id
	@Column(name = "id")
	private Integer id;
	
	@Column(name = "name")
	private String name;
	
	@Column(name = "img")
	private Blob img;
	
	@OneToMany(mappedBy = "fieldType")
	private List<Field> fields;
	
	@OneToMany(mappedBy = "fieldType")
	private List<FieldItem> fieldItems;

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

	public Blob getImg() {
		return img;
	}

	public void setImg(Blob img) {
		this.img = img;
	}

	public List<Field> getFields() {
		return fields;
	}

	public void setFields(List<Field> fields) {
		this.fields = fields;
	}

	public List<FieldItem> getFieldItems() {
		return fieldItems;
	}

	public void setFieldItems(List<FieldItem> fieldItems) {
		this.fieldItems = fieldItems;
	}

	
	
}
