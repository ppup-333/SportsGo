package com.sport.springboot.course_act.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.course_act.model.courseBean;

public interface courseRepository extends JpaRepository<courseBean, Integer> {
	
	@Query("select c from courseBean c where courseName=:courseName")
	public List<courseBean> selectCourse(@Param("courseName")String courseName);
	
	
}
