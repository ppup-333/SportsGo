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



@Table(name = "course")
@Entity
@Component
public class courseBean {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
@Column(name="courseId")
private int courseId;
private String courseName;
private String courseKind;
private int courseCost;
private int teacherId;
private int studentMaxNum;
private int studentCurrentNum;
private String courseIntroduce;

@OneToMany(fetch = FetchType.LAZY,mappedBy = "coursebean",cascade = CascadeType.ALL)
Set<CATime> time=new HashSet<>();

@OneToMany(fetch = FetchType.LAZY,mappedBy = "coursebean",cascade = CascadeType.ALL)
Set<CourseOrderBean> CourseOrder=new HashSet<>();

@ManyToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
@JoinColumn(name="teacherId",insertable = false, updatable = false)
private teacherBean teacherbean;




public courseBean() {
	
}

public courseBean(String courseName, String courseKind, int courseCost, String coursePlace,
		int teacherId, int studentMaxNum,String courseIntroduce) {
	super();

	this.courseName = courseName;
	this.courseKind = courseKind;
	this.courseCost = courseCost;
	this.studentMaxNum = studentMaxNum;
	this.courseIntroduce=courseIntroduce;
}




public teacherBean getTeacherbean() {
	return teacherbean;
}

public void setTeacherbean(teacherBean teacherbean) {
	this.teacherbean = teacherbean;
}

public Set<CourseOrderBean> getCourseOrder() {
	return CourseOrder;
}

public void setCourseOrder(Set<CourseOrderBean> courseOrder) {
	CourseOrder = courseOrder;
}

public int getTeacherId() {
	return teacherId;
}

public void setTeacherId(int teacherId) {
	this.teacherId = teacherId;
}

public teacherBean getTeacherBean() {
	return teacherbean;
}

public void setTeacherBean(teacherBean teacherBean) {
	this.teacherbean = teacherBean;
}

public Set<CATime> getTime() {
	return time;
}

public void setTime(Set<CATime> time) {
	this.time = time;
}

public int getCourseId() {return courseId;}
public String getCourseName() {return courseName;}
public String getCourseKind() {return courseKind;}
public int getCourseCost() {return courseCost;}
public int getStudentMaxNum() {return studentMaxNum;}
public int getStudentCurrentNum() {return studentCurrentNum;}
public String getCourseIntroduce() {return courseIntroduce;}



public void setCourseId(int courseId) {this.courseId = courseId;}
public void setCourseName(String courseName) {this.courseName = courseName;}
public void setCourseKind(String courseKind) {this.courseKind = courseKind;}
public void setCourseCost(int courseCost) {this.courseCost = courseCost;}
public void setStudentMaxNum(int studentMaxNum) {this.studentMaxNum = studentMaxNum;}
public void setStudentCurrentNum(int studentCurrentNum) {this.studentCurrentNum = studentCurrentNum;}
public void setCourseIntroduce(String courseIntroduce) {this.courseIntroduce = courseIntroduce;}
}
