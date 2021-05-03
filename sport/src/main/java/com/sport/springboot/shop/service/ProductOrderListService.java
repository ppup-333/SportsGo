package com.sport.springboot.shop.service;

import java.util.List;

import com.sport.springboot.shop.model.ProductOrderList;

public interface ProductOrderListService {
	ProductOrderList save(ProductOrderList productOrderList);
	void update(ProductOrderList productOrderList);
	void delete(Integer id);
	ProductOrderList get(Integer id);
	List<ProductOrderList> getAll();
	List<ProductOrderList> getByAccount(String account);
	

}
