package com.sport.springboot.course_act.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.course_act.model.ActivityOrderBean;
import com.sport.springboot.course_act.repository.ActivityOrderRepository;

@Service
public class ActivityOrderService {

	@Autowired
	private ActivityOrderRepository ActivityOrderDao;
	

	public Optional<ActivityOrderBean>  selectOneOrder(int orderId) {
		return ActivityOrderDao.findById(orderId);
	}
	
	public List<ActivityOrderBean>  selectOrder(int courseId) {
		return ActivityOrderDao.whereCourseId(courseId);
	}
	
	public List<ActivityOrderBean> selectByAccount(String account){
		List<ActivityOrderBean> activityOrder=ActivityOrderDao.whereAccount(account);
		return activityOrder;
	}
	
	public List<ActivityOrderBean> selectByAccountAndPaystament(String account,int payState){
		List<ActivityOrderBean> activityOrder=ActivityOrderDao.whereAccount(account,payState);
		return activityOrder;
	}
	 
	public void updateCourseOrder(ActivityOrderBean activityOrder) {
		ActivityOrderDao.save(activityOrder);
	}
	
	public ActivityOrderBean insertOrder(int actId, String account,int cost, String remark) {
	
	try {
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		Date date = new Date();
        String orderDate=dateFormat.format(date);
      
		ActivityOrderBean actOrder=new ActivityOrderBean();
		actOrder.setOrderDate(orderDate);
		actOrder.setActId(actId);
		actOrder.setCost(cost);
		actOrder.setAccount(account);
		actOrder.setPayState(0);
		actOrder.setRemark(remark);
		ActivityOrderDao.save(actOrder);
		return actOrder;
		
	}catch(Exception e) {
		e.printStackTrace();
		return null;
	}
	
}
}
