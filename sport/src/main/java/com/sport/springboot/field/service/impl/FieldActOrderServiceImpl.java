package com.sport.springboot.field.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.model.FieldActOrder;
import com.sport.springboot.field.model.FieldOrderDetail;
import com.sport.springboot.field.repository.FieldActOrderRepository;
import com.sport.springboot.field.repository.FieldOrderDetailRepository;
import com.sport.springboot.field.repository.FieldRepository;
import com.sport.springboot.field.service.FieldActOrderService;

@Service
public class FieldActOrderServiceImpl implements FieldActOrderService {

	@Autowired
	FieldActOrderRepository fieldActOrderRepository;
	@Autowired
	FieldOrderDetailRepository fieldOrderDetailRepository;
	@Autowired
	FieldRepository fieldRepository;
	
	@Override
	public FieldActOrder save(FieldActOrder fieldActOrder) {
		return fieldActOrderRepository.save(fieldActOrder);
	}

	@Override
	public void update(FieldActOrder fieldActOrder) {
		fieldActOrderRepository.save(fieldActOrder);
	}

	@Override
	public void delete(Integer id) {
		fieldActOrderRepository.deleteById(id);
	}

	@Override
	public FieldActOrder get(Integer id) {
		return fieldActOrderRepository.getOne(id);
	}

	@Override
	public List<FieldActOrder> getAll() {
		return fieldActOrderRepository.findAll();
	}

	@Override
	public boolean checkOrderTime() {
		
		
		for(int x = 0; x < 100; x++) {
			String date = "";
			Integer startTime = 0;
			Integer hours = 0;
			String fieldId = "";
			Field field = fieldRepository.getOne(fieldId);
			int periodCount = 0;
			int[] timeList = new int[periodCount];
			List<FieldOrderDetail> orderDetailList = fieldOrderDetailRepository.getByDateAndField(date, field);

			for (int i = 0; i < timeList.length; i++) {
				for (int j = 0; j < orderDetailList.size(); j++) {
					if (timeList[i] == orderDetailList.get(j).getFieldPeriod().getId()) {
						return false;
					}
				}
			}
		}
		
		
		
		return true;
	}

}
