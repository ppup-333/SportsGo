package com.sport.springboot.field.service;

import java.util.List;

import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.model.FieldOrderDetail;

public interface FieldOrderDetailService {

	FieldOrderDetail save(FieldOrderDetail fieldOrderDetail);
	void update(FieldOrderDetail fieldOrderDetail);
	void delete(Integer id);
	FieldOrderDetail get(Integer id);
	List<FieldOrderDetail> getAll();
	List<FieldOrderDetail> getByDateAndField(String date, Field field);
	
}
