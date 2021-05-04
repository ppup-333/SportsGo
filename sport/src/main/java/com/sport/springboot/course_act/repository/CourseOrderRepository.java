package com.sport.springboot.course_act.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.course_act.model.CourseOrderBean;

public interface CourseOrderRepository extends JpaRepository<CourseOrderBean,Integer> {

	
	@Query("select c from CourseOrderBean c where account=:account")
	public List<CourseOrderBean> whereAccount(@Param("account")String account);
	
	@Query("select c from CourseOrderBean c where account=:account and payState=:payState")
	public List<CourseOrderBean> whereAccount(@Param("account")String account,@Param("payState")int payState);
	
	@Query("select c from CourseOrderBean c where courseId=:courseId")
	public List<CourseOrderBean> whereCourseId(@Param("courseId")int courseId);
	

}
