package com.sport.springboot.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.shop.model.ProductOrderDetail;

public interface ProductOrderDetailRepository extends JpaRepository<ProductOrderDetail, Integer> {

	
	@Query("from ProductOrderDetail where order_id = :order_id")
	public List<ProductOrderDetail> findAllByOrderId(@Param ("order_id")Integer order_id);
	

}
