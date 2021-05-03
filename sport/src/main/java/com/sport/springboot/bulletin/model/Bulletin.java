package com.sport.springboot.bulletin.model;

import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "bulletin")
public class Bulletin {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;
	String title;
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "class_id", nullable = false)
	BulletinClass class_id;
	String contents;
	Timestamp date;
	Timestamp update_time;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public BulletinClass getClass_id() {
		return class_id;
	}
	public void setClass_id(BulletinClass class_id) {
		this.class_id = class_id;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public Timestamp getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Timestamp update_time) {
		this.update_time = update_time;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Bulletin [id=");
		builder.append(id);
		builder.append(", title=");
		builder.append(title);
		builder.append(", class_id=");
		builder.append(class_id);
		builder.append(", contents=");
		builder.append(contents);
		builder.append(", date=");
		builder.append(date);
		builder.append(", update_time=");
		builder.append(update_time);
		builder.append("]");
		return builder.toString();
	}
	
	
	
	
	
	
}
