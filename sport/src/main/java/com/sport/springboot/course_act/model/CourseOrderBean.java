package com.sport.springboot.course_act.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Table(name = "courseOrder")
@Entity
@Component
public class CourseOrderBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="orderId")
	private int orderId;
	private String orderDate;
	private int courseId;
	private int cost;
	private String account;
	private int payState;
	private String remark;
	private String MerchantTradeNo;
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "courseOrderBean",cascade = CascadeType.ALL)
	Set<EcpayOrderBean> ECpay=new HashSet<>();

	
	@ManyToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	@JoinColumn(name="courseId",insertable = false, updatable = false)
	private courseBean coursebean;
	
	
	
	
	
	public String getMerchantTradeNo() {
		return MerchantTradeNo;
	}

	public void setMerchantTradeNo(String merchantTradeNo) {
		MerchantTradeNo = merchantTradeNo;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public courseBean getCoursebean() {
		return coursebean;
	}

	public void setCoursebean(courseBean coursebean) {
		this.coursebean = coursebean;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public int getCourseId() {
		return courseId;
	}

	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public int getPayState() {
		return payState;
	}

	public void setPayState(int payState) {
		this.payState = payState;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}



	public Set<EcpayOrderBean> getECpay() {
		return ECpay;
	}

	public void setECpay(Set<EcpayOrderBean> eCpay) {
		ECpay = eCpay;
	}
	
	
}
