package com.sport.springboot.course_act.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Table(name = "teacher")
@Entity
@Component
public class teacherBean {
	
@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private int teacherId;
private String teacherName;
private int gender;
private String phone;
private int salary;
private String hireDate;
private byte[] teacherPicture;

@OneToMany(fetch = FetchType.LAZY,mappedBy = "teacherbean",cascade = CascadeType.ALL)
Set<courseBean> course=new HashSet<>();


public byte[] getTeacherPicture() {
	return teacherPicture;
}
public void setTeacherPicture(byte[] teacherPicture) {
	this.teacherPicture = teacherPicture;
}
public Set<courseBean> getCourse() {
	return course;
}
public void setCourse(Set<courseBean> course) {
	this.course = course;
}
public int getTeacherId() {return teacherId;}
public String getTeacherName() {return teacherName;}
public int getGender() {return gender;}
public String getPhone() {return phone;}
public int getSalary() {return salary;}
public String getHireDate() {return hireDate;}


public void setTeacherId(int teacherId) {this.teacherId = teacherId;}
public void setTeacherName(String teacherName) {this.teacherName = teacherName;}
public void setGender(int gender) {this.gender = gender;}
public void setPhone(String phone) {this.phone = phone;}
public void setSalary(int salary) {this.salary = salary;}
public void setHireDate(String hireDate) {
	this.hireDate = hireDate;
}

}
