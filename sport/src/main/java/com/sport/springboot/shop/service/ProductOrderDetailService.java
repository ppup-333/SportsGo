package com.sport.springboot.shop.service;

import java.util.List;

import com.sport.springboot.shop.model.ProductOrderDetail;


public interface ProductOrderDetailService {
	ProductOrderDetail save(ProductOrderDetail productOrderDetail);
	void update(ProductOrderDetail productOrderDetail);
	void delete(Integer id);
	ProductOrderDetail get(Integer id);
	List<ProductOrderDetail> getAll();
	List<ProductOrderDetail> getAllById(Integer order_id);
	
}
