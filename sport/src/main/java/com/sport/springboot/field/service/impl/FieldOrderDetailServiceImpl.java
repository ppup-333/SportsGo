package com.sport.springboot.field.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.model.FieldOrderDetail;
import com.sport.springboot.field.repository.FieldOrderDetailRepository;
import com.sport.springboot.field.service.FieldOrderDetailService;

@Service
public class FieldOrderDetailServiceImpl implements FieldOrderDetailService {

	@Autowired
	FieldOrderDetailRepository fieldOrderDetailRepository;
	
	@Override
	public FieldOrderDetail save(FieldOrderDetail fieldOrderDetail) {
		return fieldOrderDetailRepository.save(fieldOrderDetail);
	}

	@Override
	public void update(FieldOrderDetail fieldOrderDetail) {
		fieldOrderDetailRepository.save(fieldOrderDetail);
	}

	@Override
	public void delete(Integer id) {
		fieldOrderDetailRepository.deleteById(id);
	}

	@Override
	public FieldOrderDetail get(Integer id) {
		return fieldOrderDetailRepository.getOne(id);
	}

	@Override
	public List<FieldOrderDetail> getAll() {
		return fieldOrderDetailRepository.findAll();
	}

	@Override
	public List<FieldOrderDetail> getByDateAndField(String date, Field field) {
		return fieldOrderDetailRepository.getByDateAndField(date, field);
	}

}
