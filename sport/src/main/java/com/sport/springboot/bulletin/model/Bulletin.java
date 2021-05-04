package com.sport.springboot.bulletin.model;

import java.sql.Blob;
import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

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
	Blob image;
	String fileName;
	@Transient
	MultipartFile productImage;
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
	public void setUpdate_time(Timestamp timestamp) {
		this.update_time = timestamp;
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
	public MultipartFile getProductImage() {
		return productImage;
	}
	public void setProductImage(MultipartFile productImage) {
		this.productImage = productImage;
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
		builder.append(", image=");
		builder.append(image);
		builder.append(", fileName=");
		builder.append(fileName);
		builder.append(", productImage=");
		builder.append(productImage);
		builder.append("]");
		return builder.toString();
	}
	
}
