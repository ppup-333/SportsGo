package com.sport.springboot.shop.model;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@Entity
@Table(name = "product_order_detail")
public class ProductOrderDetail {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer order_detail_id;
		
	@ManyToOne
	@JoinColumn(name = "order_Id")
	@JsonIgnoreProperties("orderDetails")
	ProductOrderList order_list;
	
	@ManyToOne  
	@JoinColumn(name = "product_id")
	@JsonIgnoreProperties("orderDetails")
	Product product;

	Integer product_number;

	public Integer getOrder_detail_id() {
		return order_detail_id;
	}

	public void setOrder_detail_id(Integer order_detail_id) {
		this.order_detail_id = order_detail_id;
	}

	public ProductOrderList getOrder_list() {
		return order_list;
	}

	public void setOrder_list(ProductOrderList order_list) {
		this.order_list = order_list;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Integer getProduct_number() {
		return product_number;
	}

	public void setProduct_number(Integer product_number) {
		this.product_number = product_number;
	}

	
	
	

}
