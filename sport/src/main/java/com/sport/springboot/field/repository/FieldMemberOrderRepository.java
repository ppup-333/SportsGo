package com.sport.springboot.field.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.field.model.FieldMemberOrder;

public interface FieldMemberOrderRepository extends JpaRepository<FieldMemberOrder, Integer> {

	@Query("from FieldMemberOrder where account = :account order by id desc")
	public List<FieldMemberOrder> getAllByAccount(@Param("account")String account);	
	
}
