package com.sport.springboot.course_act.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.course_act.model.CourseOrderBean;
import com.sport.springboot.course_act.repository.CourseOrderRepository;

@Service
public class CourseOrderService {

	@Autowired
	private CourseOrderRepository CourseOrderDao;

	public Optional<CourseOrderBean>  selectOneOrder(int orderId) {
		return CourseOrderDao.findById(orderId);
	}
	
	public List<CourseOrderBean>  selectOrder(int courseId) {
		return CourseOrderDao.whereCourseId(courseId);
	}
	
	public List<CourseOrderBean> selectByAccount(String account){
		List<CourseOrderBean> courseOrder=CourseOrderDao.whereAccount(account);
		return courseOrder;
	}
	
	public List<CourseOrderBean> selectByAccountAndPaystament(String account,int payState){
		List<CourseOrderBean> courseOrder=CourseOrderDao.whereAccount(account,payState);
		return courseOrder;
	}
	 
	public void updateCourseOrder(CourseOrderBean courseOrder) {
		CourseOrderDao.save(courseOrder);
	}
	
	public CourseOrderBean insertOrder(int courseId, String account,int cost, String remark) {
			
		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
			Date date = new Date();
            String orderDate=dateFormat.format(date);
          
			CourseOrderBean courseOrder=new CourseOrderBean();
			courseOrder.setOrderDate(orderDate);
			courseOrder.setCourseId(courseId);
			courseOrder.setCost(cost);
			courseOrder.setAccount(account);
			courseOrder.setPayState(0);
			courseOrder.setRemark(remark);
			CourseOrderDao.save(courseOrder);
			return courseOrder;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
//	public boolean checkOrder(int courseId,String account) {
//			List<CourseOrderBean> list = CourseOrderDao.whereAccount(account);
//			if(list.isEmpty()) {
//				return true;
//			}else {
//				for(int i=0;i<list.size();i++) {
//					int id=list.get(i).getCourseId();
//					if(courseId==id) {
//						return false;
//					}
//				}
//				return true;
//			}
//	}
	
	

	

	

}
