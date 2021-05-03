package com.sport.springboot.field.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.model.FieldOrderDetail;

public interface FieldOrderDetailRepository extends JpaRepository<FieldOrderDetail, Integer> {
	
	@Query("from FieldOrderDetail where date = :date and field = :field and fieldMemberOrder.orderStatus = 1")
	public List<FieldOrderDetail> getByDateAndField(@Param("date")String date, @Param("field")Field field);

}
