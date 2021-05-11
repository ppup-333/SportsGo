package com.sport.springboot.field.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.field.model.FieldActOrder;

public interface FieldActOrderRepository extends JpaRepository<FieldActOrder, Integer> {

	@Query("from FieldActOrder where courseId=:courseId")
	public FieldActOrder getFieldOrderByCourseId(@Param("courseId")int courseId);
	
	@Query("from FieldActOrder where actId=:actId")
	public FieldActOrder getFieldOrderByActId(@Param("actId")int actId);
}
