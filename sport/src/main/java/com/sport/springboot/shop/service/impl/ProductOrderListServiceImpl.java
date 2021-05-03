package com.sport.springboot.shop.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.shop.model.ProductOrderList;
import com.sport.springboot.shop.repository.ProductOrderListRepository;
import com.sport.springboot.shop.service.ProductOrderListService;

@Service
public class ProductOrderListServiceImpl implements ProductOrderListService {
	
	
	@Autowired
	ProductOrderListRepository productOrderListRepository;

	@Override
	public ProductOrderList save(ProductOrderList productOrderList) {
		return productOrderListRepository.save(productOrderList);
	}

	@Override
	public void update(ProductOrderList productOrderList) {
		productOrderListRepository.save(productOrderList);
	}

	@Override
	public void delete(Integer id) {
		productOrderListRepository.deleteById(id);
	}

	@Override
	public ProductOrderList get(Integer id) {
		return productOrderListRepository.getOne(id);
	}

	@Override
	public List<ProductOrderList> getAll() {
		return productOrderListRepository.findAll();
	}

	@Override
	public List<ProductOrderList> getByAccount(String account) {
		return productOrderListRepository.findByAccount(account);
	}

}
