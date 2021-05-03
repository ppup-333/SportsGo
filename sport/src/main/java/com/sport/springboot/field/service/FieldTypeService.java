package com.sport.springboot.field.service;

import java.util.List;

import com.sport.springboot.field.model.FieldType;

public interface FieldTypeService {
	FieldType getById(Integer id);
	List<FieldType> getAll();
}
