package com.sport.springboot.field.service;

import java.util.List;

import com.sport.springboot.field.model.FieldActOrder;
import com.sport.springboot.field.model.FieldOrderDetail;

public interface FieldActOrderService {
	
	FieldActOrder save(FieldActOrder fieldActOrder);
	void update(FieldActOrder fieldActOrder);
	void delete(Integer id);
	FieldActOrder get(Integer id);
	List<FieldActOrder> getAll();
	//boolean checkOrderTime();
	//boolean checkOrderTime(String Date, String time, String place);
	List<FieldOrderDetail> checkOrderTime(String fieldId, String date, String startTime, String endTime);
	
	
}
