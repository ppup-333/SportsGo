package com.sport.springboot.field.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.field.model.FieldType;
import com.sport.springboot.field.repository.FieldTypeRepository;
import com.sport.springboot.field.service.FieldTypeService;

@Service
public class FieldTypeServiceImpl implements FieldTypeService {
	
	@Autowired
	FieldTypeRepository fieldTypeRepository;
	
	@Override
	public FieldType getById(Integer id) {		
		return fieldTypeRepository.getOne(id);
	}

	@Override
	public List<FieldType> getAll() {
		return fieldTypeRepository.findAll();
	}

}
