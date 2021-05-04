package com.sport.springboot.course_act.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.course_act.model.teacherBean;

public interface teacherRepository extends JpaRepository<teacherBean,Integer>{

	
	@Query("select c from teacherBean c where teacherName=:teacherName")
	public teacherBean selectTeacherId(@Param("teacherName")String teacherName);
	
}
