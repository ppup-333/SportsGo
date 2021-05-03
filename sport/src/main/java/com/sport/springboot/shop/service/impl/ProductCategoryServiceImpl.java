package com.sport.springboot.shop.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.shop.model.ProductCategory;
import com.sport.springboot.shop.repository.ProductCategoryRepository;
import com.sport.springboot.shop.service.ProductCategoryService;


@Service 
public class ProductCategoryServiceImpl implements ProductCategoryService {
	
	@Autowired
	ProductCategoryRepository productCategoryDao;


	@Override
	public List<ProductCategory> getAllProductCategories() {
		return (List<ProductCategory>) productCategoryDao.findAll();
	}

	@Override
	public ProductCategory getProductCategory(Integer id) {
		Optional<ProductCategory> optional = productCategoryDao.findById(id); 
		ProductCategory productCategory = null;
		if (optional.isPresent()) {
			productCategory = optional.get();
		} else {
			throw new RuntimeException("productCategory(id=" + id + ")不存在");
		}
		return productCategory;
	}

}
