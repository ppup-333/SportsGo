package com.sport.springboot.field.service;

import java.util.List;

import com.sport.springboot.field.model.FieldMemberOrder;
import com.sport.springboot.field.model.FieldType;

public interface FieldMemberOrderService {
	
	FieldMemberOrder save(FieldMemberOrder fieldMemberOrder);
	void update(FieldMemberOrder fieldMemberOrder);
	void delete(Integer id);
	FieldMemberOrder get(Integer id);
	List<FieldMemberOrder> getAll();
	List<FieldMemberOrder> getAllByAccount(String account);
	List<FieldMemberOrder> getOrderByAccount(String account);
	List<FieldMemberOrder> getPastOrdersByAccount(String account);
	List<FieldMemberOrder> getOrderByDateAndPeriod(Integer typeId, String date, Integer periodId);

}
