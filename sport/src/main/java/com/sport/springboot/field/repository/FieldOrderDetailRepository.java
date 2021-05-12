package com.sport.springboot.field.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.model.FieldOrderDetail;
import com.sport.springboot.field.model.FieldPeriod;
import com.sport.springboot.field.model.FieldType;

public interface FieldOrderDetailRepository extends JpaRepository<FieldOrderDetail, Integer> {
	
	@Query("from FieldOrderDetail where date = :date and field = :field")
	public List<FieldOrderDetail> getByDateAndField(@Param("date")String date, @Param("field")Field field);
	
//	@Query("from FieldOrderDetail where date = :date and field = :field and fieldMemberOrder.orderStatus = 1")
//	public List<FieldOrderDetail> getByDateAndField(@Param("date")String date, @Param("field")Field field);
	
	@Query("from FieldOrderDetail where date = :date and fieldPeriod = :fieldPeriod and fieldMemberOrder.orderStatus = 1 order by fieldId")
	public List<FieldOrderDetail> getByDateAndPeriod(
			@Param("date")String date, @Param("fieldPeriod")FieldPeriod fieldPeriod);
	
	//放棄刪除 
	/*@Modifying
	@Query("delete from FieldOrderDetail c where actOrderId=:actOrderId")
	public void deleteByActOrderId(@Param("actOrderId")int actOrderId);
	
	@Modifying
	@Query("delete from FieldOrderDetail c where fieldId=:fieldId")
	public void deleteByActFieldId(@Param("fieldId")String fieldId);*/

	

}
