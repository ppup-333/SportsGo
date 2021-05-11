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
import javax.persistence.Transient;

import com.sport.springboot.course_act.model.activityBean;
import com.sport.springboot.course_act.model.courseBean;

@Entity
@Table(name = "fieldActOrder")
public class FieldActOrder {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Transient
	private Integer courseId;
	
	@Transient
	private Integer actId;
	
	private String createTime;
	
	private String updateTime;
	
	private String paymentMethod;
	
	private int paymentStatus;
	
	private int orderStatus;
	
	private String remark;
	
	@OneToMany(mappedBy = "fieldActOrder",
			cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private List<FieldOrderDetail> orderDetails;
	
	@ManyToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	@JoinColumn(name="actId")
	private activityBean activitybean;

	@ManyToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	@JoinColumn(name="courseId")
	private courseBean coursebean;
	
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCourseId() {
		return courseId;
	}

	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}

	public Integer getActId() {
		return actId;
	}

	public void setActId(Integer actId) {
		this.actId = actId;
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

	public activityBean getActivitybean() {
		return activitybean;
	}

	public void setActivitybean(activityBean activitybean) {
		this.activitybean = activitybean;
	}

	public courseBean getCoursebean() {
		return coursebean;
	}

	public void setCoursebean(courseBean coursebean) {
		this.coursebean = coursebean;
	}

	
	
}
