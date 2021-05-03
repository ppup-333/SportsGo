package com.sport.springboot.shop.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.shop.model.ProductCategory;

public interface ProductCategoryRepository extends JpaRepository<ProductCategory, Integer> {
	
	

}
