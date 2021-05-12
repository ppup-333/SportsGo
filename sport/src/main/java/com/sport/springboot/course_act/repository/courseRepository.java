package com.sport.springboot.course_act.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.course_act.model.courseBean;

public interface courseRepository extends JpaRepository<courseBean, Integer> {
	
	@Query("select c from courseBean c where courseName=:courseName")
	public List<courseBean> selectCourse(@Param("courseName")String courseName);
	
	@Modifying
	@Query("delete from courseBean c where courseId=:courseId")
	public void deleteCourse(@Param("courseId")int courseId);
}
