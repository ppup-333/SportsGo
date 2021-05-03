package com.sport.springboot.bbs.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="bbsType")
public class BbsType {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer typeId;
	
	private String typeGroup;
	
	private String typeName;
	
	@OneToMany(mappedBy = "bbsType")
	private List<Bbs> bbsList;

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public String getTypeGroup() {
		return typeGroup;
	}

	public void setTypeGroup(String typeGroup) {
		this.typeGroup = typeGroup;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public List<Bbs> getBbsList() {
		return bbsList;
	}

	public void setBbsList(List<Bbs> bbsList) {
		this.bbsList = bbsList;
	}
	
}