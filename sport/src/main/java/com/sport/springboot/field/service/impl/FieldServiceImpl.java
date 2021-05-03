package com.sport.springboot.field.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.repository.FieldRepository;
import com.sport.springboot.field.service.FieldService;

@Service
public class FieldServiceImpl implements FieldService {

	@Autowired
	FieldRepository fieldRepository;
	
	@Override
	public Field save(Field field) {
		return fieldRepository.save(field);
	}

	@Override
	public void delete(String id) {
		fieldRepository.deleteById(id);

	}

	@Override
	public void update(Field field) {
		fieldRepository.save(field);

	}

	@Override
	public Field get(String id) {
		return fieldRepository.getOne(id);
	}
	
	@Override
	public List<Field> findByFieldId(String id) {
		return fieldRepository.findByFieldId(id);
	}

	@Override
	public List<Field> getAll() {
		return fieldRepository.findAll();
	}

	@Override
	public List<Field> getByTypeId(Integer id) {
		return fieldRepository.getByTypeID(id);
	}


}
