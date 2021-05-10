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
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.sport.springboot.field.model.FieldActOrder;

@Table(name = "activity")
@Entity
@Component
public class activityBean {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="actId")
	private int actId;
	private String actName;
	private int actCost;
	private int actMaxNum;
	private int actCurrentNum;
	private String account;
	private String actIntroduce;
	private String fileName;
	private byte[] actPicture;
	
	//mappedBy reference is  CATime private courseBean [coursebean];
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "activitybean",cascade = CascadeType.ALL)
	Set<CATime> time=new HashSet<>();
	 
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "activitybean",cascade = CascadeType.ALL)
	Set<FieldActOrder> fieldActOrder=new HashSet<>();
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "activitybean",cascade = CascadeType.ALL)
	Set<ActivityOrderBean> activtiyOrder=new HashSet<>();
	
	public int getActCurrentNum() {
		return actCurrentNum;
	}
	public void setActCurrentNum(int actCurrentNum) {
		this.actCurrentNum = actCurrentNum;
	}
	public Set<CATime> getTime() {
		return time;
	}
	public void setTime(Set<CATime> time) {
		this.time = time;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getActIntroduce() {
		return actIntroduce;
	}
	public void setActIntroduce(String actIntroduce) {
		this.actIntroduce = actIntroduce;
	}
	public byte[] getActPicture() {
		return actPicture;
	}
	public void setActPicture(byte[] actPicture) {
		this.actPicture = actPicture;
	}
	public int getActId() {
		return actId;
	}
	public void setActId(int actId) {
		this.actId = actId;
	}
	public String getActName() {
		return actName;
	}
	public void setActName(String actName) {
		this.actName = actName;
	}
	public int getActCost() {
		return actCost;
	}
	public void setActCost(int actCost) {
		this.actCost = actCost;
	}
	public int getActMaxNum() {
		return actMaxNum;
	}
	public void setActMaxNum(int actMaxNum) {
		this.actMaxNum = actMaxNum;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public Set<ActivityOrderBean> getActivtiyOrder() {
		return activtiyOrder;
	}
	public void setActivtiyOrder(Set<ActivityOrderBean> activtiyOrder) {
		this.activtiyOrder = activtiyOrder;
	}
	public Set<FieldActOrder> getFieldActOrder() {
		return fieldActOrder;
	}
	public void setFieldActOrder(Set<FieldActOrder> fieldActOrder) {
		this.fieldActOrder = fieldActOrder;
	}
	
	
}
