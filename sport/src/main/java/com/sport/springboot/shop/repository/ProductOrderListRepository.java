package com.sport.springboot.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.shop.model.ProductOrderList;

public interface ProductOrderListRepository extends JpaRepository<ProductOrderList, Integer> {

    @Query("from ProductOrderList where member_id = :account")
	public List<ProductOrderList> findByAccount(@Param ("account")String account);


}
