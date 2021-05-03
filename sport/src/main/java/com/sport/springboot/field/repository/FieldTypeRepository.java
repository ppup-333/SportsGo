package com.sport.springboot.field.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.field.model.FieldType;

public interface FieldTypeRepository extends JpaRepository<FieldType, Integer> {

}
