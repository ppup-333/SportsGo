package com.sport.springboot.course_act.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.course_act.model.CATime;
import com.sport.springboot.course_act.model.courseBean;

public interface CATimeRepository extends JpaRepository<CATime,Integer> {

	
	@Query("select c from CATime c where Date=:Date and TimeStart=:TimeStart and TimeEnd=:TimeEnd")
	public List<CATime> checkDate(@Param("Date")String Date,@Param("TimeStart")String TimeStart,@Param("TimeEnd")String TimeEnd);

	@Modifying
	@Query("delete from CATime c where coursebean.courseId=:courseId")
	public void deleteTimeByCourseId(@Param("courseId")int courseId);
	
	
}
