package com.sport.springboot.course_act.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.course_act.model.ActivityOrderBean;

public interface ActivityOrderRepository extends JpaRepository<ActivityOrderBean,Integer> {

	
	@Query("select c from ActivityOrderBean c where account=:account")
	public List<ActivityOrderBean> whereAccount(@Param("account")String account);
	
	@Query("select c from ActivityOrderBean c where account=:account and payState=:payState")
	public List<ActivityOrderBean> whereAccount(@Param("account")String account,@Param("payState")int payState);
	
	@Query("select c from ActivityOrderBean c where actId=:actId")
	public List<ActivityOrderBean> whereCourseId(@Param("actId")int actId);
	
	@Query("select c from ActivityOrderBean c where payState=:payState")
	public List<ActivityOrderBean> wherePayState(@Param("payState")int payState);
}
