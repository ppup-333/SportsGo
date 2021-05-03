package com.sport.springboot.shop.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.shop.model.ProductOrderDetail;
import com.sport.springboot.shop.repository.ProductOrderDetailRepository;
import com.sport.springboot.shop.service.ProductOrderDetailService;

@Service
public class ProductOrderDetailServiceImpl implements ProductOrderDetailService {
	
	@Autowired
	ProductOrderDetailRepository productOrderDetailRepository;
	
	@Override
	public ProductOrderDetail save(ProductOrderDetail productOrderDetail) {
		return productOrderDetailRepository.save(productOrderDetail);
	}

	@Override
	public void update(ProductOrderDetail productOrderDetail) {
		productOrderDetailRepository.save(productOrderDetail);

	}

	@Override
	public void delete(Integer id) {
		productOrderDetailRepository.deleteById(id);
	}

	@Override
	public ProductOrderDetail get(Integer id) {
		return productOrderDetailRepository.getOne(id);
	}

	@Override
	public List<ProductOrderDetail> getAll() {
		return productOrderDetailRepository.findAll();
	}

	@Override
	public List<ProductOrderDetail> getAllById(Integer order_id) {
		return productOrderDetailRepository.findAllByOrderId(order_id);
	}

}
