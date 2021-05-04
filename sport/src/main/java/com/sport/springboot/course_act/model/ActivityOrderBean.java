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

@Table(name = "activityOrder")
@Entity
@Component
public class ActivityOrderBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="orderId")
	private int orderId;
	private int MerchantTradeNo;
	private String orderDate;
	private int actId;
	private int cost;
	private String account;
	private int payState;
	private String remark;
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "activityOrderBean",cascade = CascadeType.ALL)
	Set<EcpayOrderActBean> ECpayOrder=new HashSet<>();

	@ManyToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	@JoinColumn(name="actId",insertable = false, updatable = false)
	private activityBean activitybean;
	
	public int getOrderId() {
		return orderId;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getMerchantTradeNo() {
		return MerchantTradeNo;
	}

	public void setMerchantTradeNo(int merchantTradeNo) {
		MerchantTradeNo = merchantTradeNo;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public int getActId() {
		return actId;
	}

	public void setActId(int actId) {
		this.actId = actId;
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


	public Set<EcpayOrderActBean> getECpayOrder() {
		return ECpayOrder;
	}

	public void setECpayOrder(Set<EcpayOrderActBean> eCpayOrder) {
		ECpayOrder = eCpayOrder;
	}

	public activityBean getActivitybean() {
		return activitybean;
	}

	public void setActivitybean(activityBean activitybean) {
		this.activitybean = activitybean;
	}
	
	
}
