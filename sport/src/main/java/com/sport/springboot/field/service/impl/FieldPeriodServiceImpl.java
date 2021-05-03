package com.sport.springboot.field.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.field.model.FieldPeriod;
import com.sport.springboot.field.repository.FieldPeriodRepository;
import com.sport.springboot.field.service.FieldPeriodService;

@Service
public class FieldPeriodServiceImpl implements FieldPeriodService {

	@Autowired
	FieldPeriodRepository fieldPeriodRepository;
	
	@Override
	public FieldPeriod get(Integer id) {
		return fieldPeriodRepository.getOne(id);
	}

	@Override
	public List<FieldPeriod> getAll() {
		return fieldPeriodRepository.findAll();
	}

}
