package com.sport.springboot.course_act.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

@Table(name = "CATime")
@Entity
@Component
public class CATime {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="TimeId")
	private int TimeId;
	private String TimeStart;
	private String TimeEnd;
	private String Date;
	
	@Column(name="courseId")
	@Transient
	private int courseId;
	
	@Column(name="activityId")
	@Transient
	private int activityId;
	
	@ManyToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	@JoinColumn(name="activityId")
	private activityBean activitybean;
	
	@ManyToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	@JoinColumn(name="courseId")
	private courseBean coursebean;
	
	
	private String fieldId;
	
	
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

	public CATime() {
		
	}
	
	public CATime(String TimeStart, String TimeEnd, String Date) {
		super();
		this.TimeStart = TimeStart;
		this.TimeEnd = TimeEnd;
		this.Date = Date;
	}
	
	
	
	public String getFieldId() {
		return fieldId;
	}

	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
	}

	public int getTimeId() {
		return TimeId;
	}

	public void setTimeId(int timeId) {
		TimeId = timeId;
	}

	public String getTimeStart() {
		return TimeStart;
	}

	public void setTimeStart(String timeStart) {
		TimeStart = timeStart;
	}

	public String getTimeEnd() {
		return TimeEnd;
	}

	public void setTimeEnd(String timeEnd) {
		TimeEnd = timeEnd;
	}

	public String getDate() {
		return Date;
	}

	public void setDate(String date) {
		Date = date;
	}

	public int getActivityId() {
		return activityId;
	}

	public void setActivityId(int activityId) {
		this.activityId = activityId;
	}

	public int getCourseId() {
		return courseId;
	}
	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}
	
	
	
}
