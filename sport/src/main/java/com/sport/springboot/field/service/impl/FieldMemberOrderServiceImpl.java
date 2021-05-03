package com.sport.springboot.field.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.field.model.FieldMemberOrder;
import com.sport.springboot.field.repository.FieldMemberOrderRepository;
import com.sport.springboot.field.service.FieldMemberOrderService;

@Service
public class FieldMemberOrderServiceImpl implements FieldMemberOrderService {

	@Autowired
	FieldMemberOrderRepository fieldMemberOrderRepository;
	
	@Override
	public FieldMemberOrder save(FieldMemberOrder fieldMemberOrder) {
		return fieldMemberOrderRepository.save(fieldMemberOrder);
	}

	@Override
	public void update(FieldMemberOrder fieldMemberOrder) {
		fieldMemberOrderRepository.save(fieldMemberOrder);
	}

	@Override
	public void delete(Integer id) {
		fieldMemberOrderRepository.deleteById(id);
	}

	@Override
	public FieldMemberOrder get(Integer id) {
		return fieldMemberOrderRepository.getOne(id);
	}

	@Override
	public List<FieldMemberOrder> getAll() {
		return fieldMemberOrderRepository.findAll();
	}

	@Override
	public List<FieldMemberOrder> getAllByAccount(String account) {
		return fieldMemberOrderRepository.getAllByAccount(account);
	}

	@Override
	public List<FieldMemberOrder> getOrderByAccount(String account) {
		List<FieldMemberOrder> fieldMemberOrders = fieldMemberOrderRepository.getAllByAccount(account);
		List<FieldMemberOrder> fieldMemberOrder = new ArrayList<>();
		for(int i = 0; i < fieldMemberOrders.size(); i++) {
			if(fieldMemberOrders.get(i).getAttendance() == 0 
					&& fieldMemberOrders.get(i).getOrderStatus() == 1) {
				fieldMemberOrder.add(fieldMemberOrders.get(i));
			}
		}
		return fieldMemberOrder;
	}

	@Override
	public List<FieldMemberOrder> getPastOrdersByAccount(String account) {
		List<FieldMemberOrder> fieldMemberOrders = fieldMemberOrderRepository.getAllByAccount(account);
		List<FieldMemberOrder> pastFieldMemberOrders = new ArrayList<>();
		for(int i = 0; i < fieldMemberOrders.size(); i++) {
			if(fieldMemberOrders.get(i).getAttendance() != 0
					|| fieldMemberOrders.get(i).getOrderStatus() == 0) {
				pastFieldMemberOrders.add(fieldMemberOrders.get(i));
			}
		}
		return pastFieldMemberOrders;
	}

}
