package com.sport.springboot.field.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.course_act.model.activityBean;
import com.sport.springboot.course_act.model.courseBean;
import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.model.FieldActOrder;
import com.sport.springboot.field.model.FieldOrderDetail;
import com.sport.springboot.field.model.FieldPeriod;
import com.sport.springboot.field.repository.FieldActOrderRepository;
import com.sport.springboot.field.repository.FieldOrderDetailRepository;
import com.sport.springboot.field.repository.FieldPeriodRepository;
import com.sport.springboot.field.repository.FieldRepository;
import com.sport.springboot.field.service.FieldActOrderService;

@Service
public class FieldActOrderServiceImpl implements FieldActOrderService {

	@Autowired
	FieldActOrderRepository fieldActOrderRepository;
	@Autowired
	FieldOrderDetailRepository fieldOrderDetailRepository;
	@Autowired
	FieldRepository fieldRepository;
	@Autowired
	FieldPeriodRepository fieldPeriodRepository;
	
	@Override
	public FieldActOrder save(FieldActOrder fieldActOrder) {
		return fieldActOrderRepository.save(fieldActOrder);
	}

	@Override
	public void update(FieldActOrder fieldActOrder) {
		fieldActOrderRepository.save(fieldActOrder);
	}

	@Override
	public void delete(Integer id) {
		fieldActOrderRepository.deleteById(id);
	}

	@Override
	public FieldActOrder get(Integer id) {
		return fieldActOrderRepository.getOne(id);
	}

	@Override
	public List<FieldActOrder> getAll() {
		return fieldActOrderRepository.findAll();
	}

	@Override
	public List<FieldOrderDetail> checkOrderTime(String fieldId, String date, String startTime, String endTime) {
		  
		  Integer startTimeInt = Integer.parseInt(startTime.substring(0, 2));
		  int hours = Integer.parseInt(endTime.substring(0, 2)) - startTimeInt;
		  Field field = fieldRepository.getOne(fieldId);
		  List<FieldOrderDetail> orderDetailList = fieldOrderDetailRepository.getByDateAndField(date, field);
		  
		  List<FieldOrderDetail> returnOrderDetailList = new ArrayList<>();
		  
		  if(orderDetailList.size() != 0) {
		  
		   for (int i = 0; i < hours; i++) {
		    for (int j = 0; j < orderDetailList.size(); j++) {
		     if (startTimeInt == orderDetailList.get(j).getFieldPeriod().getId()) {
		      return null;
		     }
		    }
		    
		    FieldPeriod fieldPeriod = fieldPeriodRepository.getOne(startTimeInt);  
		    FieldOrderDetail fieldOrderDetail = new FieldOrderDetail();
		    fieldOrderDetail.setDate(date);
		    fieldOrderDetail.setField(field);
		    fieldOrderDetail.setFieldPeriod(fieldPeriod);
		    returnOrderDetailList.add(fieldOrderDetail);
		    startTimeInt ++;
		   }
		  }else {
		   for(int i = 0; i < hours; i++) {
		    FieldPeriod fieldPeriod = fieldPeriodRepository.getOne(startTimeInt);  
		    FieldOrderDetail fieldOrderDetail = new FieldOrderDetail();
		    fieldOrderDetail.setDate(date);
		    fieldOrderDetail.setField(field);
		    fieldOrderDetail.setFieldPeriod(fieldPeriod);
		    returnOrderDetailList.add(fieldOrderDetail);
		    startTimeInt ++;
		   }
		   
		  }
		  
		  return returnOrderDetailList;  
		 }
	public void createActOrder(List<FieldOrderDetail> orderDetailList,activityBean activity,courseBean course) {
		FieldActOrder fieldActOrder = new FieldActOrder();
		Date createDate = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateStr = dateFormat.format(createDate);
		
		if(activity!=null) {
			fieldActOrder.setActivitybean(activity);
			
		}
		if(course!=null) {
			fieldActOrder.setCoursebean(course);
		}				
		
		fieldActOrder.setCreateTime(dateStr);
		fieldActOrder.setOrderStatus(1);
		//fieldActOrder.setOrderDetails(orderDetailList); //失望
		fieldActOrderRepository.save(fieldActOrder);
		
	//	fieldOrderDetailRepository.saveAll(orderDetailList);
		
		//如果上面那行fieldOrderDetailRepository.saveAll(orderDetailList);失敗的話就試下面的
		for(int i = 0; i < orderDetailList.size(); i++) {
			orderDetailList.get(i).setFieldActOrder(fieldActOrder);
			System.out.println(orderDetailList.get(i).getFieldPeriod().getId());
			
		}
		
		fieldOrderDetailRepository.saveAll(orderDetailList);
	}

	@Override
	public boolean changeOrderStatusByCourseId(int courseId) {
		
		try {
			FieldActOrder fieldActOrder = fieldActOrderRepository.getFieldOrderByCourseId(courseId);
		fieldActOrder.setOrderStatus(0);
		fieldActOrderRepository.save(fieldActOrder);
		return true;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("更改OrderStatus狀態發生錯誤");
			return false;
		}
	}
	@Override
	public boolean changeOrderStatusByActId(int actId) {
		
		try {
			FieldActOrder fieldActOrder = fieldActOrderRepository.getFieldOrderByActId(actId);
		fieldActOrder.setOrderStatus(0);
		fieldActOrderRepository.save(fieldActOrder);
		return true;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("更改OrderStatus狀態發生錯誤");
			return false;
		}
	}

}