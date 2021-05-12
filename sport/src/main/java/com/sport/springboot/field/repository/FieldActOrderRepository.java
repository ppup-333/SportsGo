package com.sport.springboot.field.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.field.model.FieldActOrder;

public interface FieldActOrderRepository extends JpaRepository<FieldActOrder, Integer> {

	@Query("from FieldActOrder where courseId=:courseId")
	public FieldActOrder getFieldOrderByCourseId(@Param("courseId")int courseId);
	
	@Query("from FieldActOrder where actId=:actId")
	public List<FieldActOrder> getFieldOrderByActId(@Param("actId")int actId);
	
	//放棄刪除
	/*@Query("delete from FieldActOrder c where courseId=:courseId")
	public void deleteByCourseId(@Param("courseId")int courseId);*/
}
