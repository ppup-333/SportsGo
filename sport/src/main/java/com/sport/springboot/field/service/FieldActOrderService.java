package com.sport.springboot.field.service;

import java.util.List;

import com.sport.springboot.field.model.FieldActOrder;

public interface FieldActOrderService {
	
	FieldActOrder save(FieldActOrder fieldActOrder);
	void update(FieldActOrder fieldActOrder);
	void delete(Integer id);
	FieldActOrder get(Integer id);
	List<FieldActOrder> getAll();
	boolean checkOrderTime();
	
	
}
