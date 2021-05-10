package com.sport.springboot.shop.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;



@Entity
@Table(name = "product_order_list")
public class ProductOrderList {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer order_id;
	String member_id;
	String name;
	String tel;
	String address;
	Integer order_price;
	Integer ship;
	String shipway;

	String order_status;
	String order_create_date;
	String order_update_date;
	String MerchantTradeNo;
	

	@OneToMany(mappedBy = "order_list")
	@JsonIgnore
	List<ProductOrderDetail> orderDetails;
	
//	@ManyToOne  //(cascade = CascadeType.ALL)
//	@JoinColumn(name = "member_id", nullable = false)
//	Member member;



	public Integer getOrder_id() {
		return order_id;
	}


	public void setOrder_id(Integer order_id) {
		this.order_id = order_id;
	}


	public String getMember_id() {
		return member_id;
	}


	public void setMember_id(String string) {
		this.member_id = string;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getTel() {
		return tel;
	}


	public void setTel(String tel) {
		this.tel = tel;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public Integer getShip() {
		return ship;
	}


	public void setShip(Integer ship) {
		this.ship = ship;
	}


	public String getOrder_status() {
		return order_status;
	}


	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}


	public String getOrder_create_date() {
		return order_create_date;
	}


	public void setOrder_create_date(String order_create_date) {
		this.order_create_date = order_create_date;
	}


	public String getOrder_update_date() {
		return order_update_date;
	}


	public void setOrder_update_date(String order_update_date) {
		this.order_update_date = order_update_date;
	}


	public List<ProductOrderDetail> getOrderDetails() {
		return orderDetails;
	}


	public void setOrderDetails(List<ProductOrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}
	
	public Integer getOrder_price() {
		return order_price;
	}


	public void setOrder_price(Integer order_price) {
		this.order_price = order_price;
	}
	
	public String getShipway() {
		return shipway;
	}


	public void setShipway(String shipway) {
		this.shipway = shipway;
	}


	public String getMerchantTradeNo() {
		return MerchantTradeNo;
	}


	public void setMerchantTradeNo(String merchantTradeNo) {
		MerchantTradeNo = merchantTradeNo;
	}




	
}
