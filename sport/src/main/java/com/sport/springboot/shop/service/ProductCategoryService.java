package com.sport.springboot.shop.service;

import java.util.List;

import com.sport.springboot.shop.model.ProductCategory;

public interface ProductCategoryService {
	
	List<ProductCategory> getAllProductCategories();
	ProductCategory getProductCategory(Integer id);
	
}
