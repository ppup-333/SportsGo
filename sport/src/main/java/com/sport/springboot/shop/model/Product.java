package com.sport.springboot.shop.model;

import java.sql.Blob;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "product")
public class Product {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer product_id;
	String product_name;
	String product_category;
	Integer product_price;
	Integer product_stock;
	String product_img;
	String product_remark;
	String product_status;
	String product_create_date;
	String product_update_date;
	

	@ManyToOne  //(cascade = CascadeType.ALL)
	@JoinColumn(name = "category_id", nullable = false)
	ProductCategory productCategory;
	
	@OneToMany(mappedBy = "product")
	@JsonIgnore
	List<ProductOrderDetail> orderDetails;
	
	@JsonIgnore
	Blob image;
	String fileName;
	
	
	@Transient
	MultipartFile productImage;
	
	public Integer getProduct_id() {
		return product_id;
	}
	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_category() {
		return product_category;
	}
	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}
	public Integer getProduct_price() {
		return product_price;
	}
	public void setProduct_price(Integer product_price) {
		this.product_price = product_price;
	}
	public Integer getProduct_stock() {
		return product_stock;
	}
	public void setProduct_stock(Integer product_stock) {
		this.product_stock = product_stock;
	}
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}
	public String getProduct_remark() {
		return product_remark;
	}
	public void setProduct_remark(String product_remark) {
		this.product_remark = product_remark;
	}
	public String getProduct_status() {
		return product_status;
	}
	public void setProduct_status(String product_status) {
		this.product_status = product_status;
	}
	public String getProduct_create_date() {
		return product_create_date;
	}
	public void setProduct_create_date(String date) {
		this.product_create_date = date;
	}
	public String getProduct_update_date() {
		return product_update_date;
	}
	public void setProduct_update_date(String date) {
		this.product_update_date = date;
	}
	public MultipartFile getProductImage() {
		return productImage;
	}
	public void setProductImage(MultipartFile productImage) {
		this.productImage = productImage;
	}
	public Blob getImage() {
		return image;
	}
	public void setImage(Blob image) {
		this.image = image;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public ProductCategory getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(ProductCategory productCategory) {
		this.productCategory = productCategory;
	}
	
	public List<ProductOrderDetail> getOrderDetails() {
		return orderDetails;
	}
	public void setOrderDetails(List<ProductOrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	
	
	

}
