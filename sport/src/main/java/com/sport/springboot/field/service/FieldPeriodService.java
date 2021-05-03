package com.sport.springboot.field.service;

import java.util.List;

import com.sport.springboot.field.model.FieldPeriod;

public interface FieldPeriodService {

	FieldPeriod get(Integer id);
	List<FieldPeriod> getAll();
	
}
