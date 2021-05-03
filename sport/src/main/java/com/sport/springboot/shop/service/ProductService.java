package com.sport.springboot.shop.service;

import java.util.List;

import com.sport.springboot.shop.model.Product;

public interface ProductService {
	
	Product save(Product product);
	void delete(Integer product_id);
	Product get(Integer product_id);
	void update(Product product);
	List<Product> getAllProducts();
	List<Product> getByName(String pname);
	Product getByName1(String pname);
	List<Product> getProdByPage(int startRow, int pageSize);
	List<Product> getProdByStatus(String status);
	List<Product> getProdByStatusByName(String pname,String status);
	List<Product> getProdByStatusByname2(String pname);
	List<Product> getProdByStatusByCategory(String status, String category);
	List<Product> getProdByCategory(String category);
	List<Product> getProdByStatusByNameByCategory(String pname, String status, String category);
	List<Product> getProdByNameByCategory(String pname, String category);
	
	
}
