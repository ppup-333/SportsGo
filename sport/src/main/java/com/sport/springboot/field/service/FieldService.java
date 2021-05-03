package com.sport.springboot.field.service;

import java.util.List;

import com.sport.springboot.field.model.Field;

public interface FieldService {

	Field save(Field field);
	void delete(String id);
	void update(Field field);
	Field get(String id);
	List<Field> findByFieldId(String id);
	List<Field> getAll();
	
	List<Field> getByTypeId(Integer id);
	
}
