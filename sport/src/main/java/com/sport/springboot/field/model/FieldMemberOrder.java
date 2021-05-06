package com.sport.springboot.field.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.sport.springboot.users.model.Users;


@Entity
@Table(name = "fieldMemberOrder")
public class FieldMemberOrder {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	//------------------------------account	
	
	@ManyToOne
	@JoinColumn(name = "account")
	private Users user;
	
	private String createTime;
	
	private String updateTime;
	
	private String paymentMethod;
	
	private int paymentStatus;
	
	private int attendance;
	
	private int orderStatus;
	
	private String remark;	
	
	@OneToMany(mappedBy = "fieldMemberOrder",
			cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private List<FieldOrderDetail> orderDetails;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Users getUsers() {
		return user;
	}

	public void setUsers(Users user) {
		this.user = user;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public int getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(int paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public int getAttendance() {
		return attendance;
	}

	public void setAttendance(int attendance) {
		this.attendance = attendance;
	}

	public int getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<FieldOrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<FieldOrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	
	
}
