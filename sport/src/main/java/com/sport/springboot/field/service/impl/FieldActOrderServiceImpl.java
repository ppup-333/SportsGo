package com.sport.springboot.field.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

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
		//fieldActOrder.setOrderDetails(orderDetailList); //??????
		fieldActOrderRepository.save(fieldActOrder);
		
	//	fieldOrderDetailRepository.saveAll(orderDetailList);
		
		//??????????????????fieldOrderDetailRepository.saveAll(orderDetailList);???????????????????????????
		for(int i = 0; i < orderDetailList.size(); i++) {
			orderDetailList.get(i).setFieldActOrder(fieldActOrder);
			System.out.println(orderDetailList.get(i).getFieldPeriod().getId());
			
		}
		
		fieldOrderDetailRepository.saveAll(orderDetailList);
	}

	@Override
	public boolean changeOrderStatusByCourseId(int courseId) {
		
		try {
			 List<FieldActOrder> fieldActOrderList = fieldActOrderRepository.getFieldOrderByCourseId(courseId);
			 for(int i=0;i<fieldActOrderList.size();i++) {
				 fieldActOrderList.get(i).setOrderStatus(0);
				 fieldActOrderRepository.save(fieldActOrderList.get(i));
			 }
		return true;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("??????OrderStatus??????????????????");
			return false;
		}
	}
	@Override
	public boolean changeOrderStatusByActId(int actId) {
		
		try {
			
			 List<FieldActOrder> fieldActOrderList = fieldActOrderRepository.getFieldOrderByActId(actId);
			 for(int i=0;i<fieldActOrderList.size();i++) {
				 fieldActOrderList.get(i).setOrderStatus(0);
				 fieldActOrderRepository.save(fieldActOrderList.get(i));
			 }
		
		return true;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("??????OrderStatus??????????????????");
			return false;
		}
	}
	
	//???????????? 
	/*public boolean deleteFieldActOrderByCourse(courseBean course) {
		
		try{
			Set<FieldActOrder> fieldActOrderSet = course.getFieldActOrder();
			Iterator<FieldActOrder> fIt = fieldActOrderSet.iterator();
			while(fIt.hasNext()) {
				FieldActOrder fieldActOrder = fIt.next();
				
				Integer fieldOrderId = fieldActOrder.getId();
				
				List<FieldOrderDetail> fieldActOrderList = fieldActOrder.getOrderDetails();
				for(int i=0;i<fieldActOrderList.size();i++) {
					if(fieldActOrderList.get(i)!=null) {
						fieldActOrderList.get(i).setDate(null);
						//fieldActOrderList.get(i).getField().getId();
						//fieldActOrderList.get(i)
						fieldActOrderList.get(i).setFieldMemberOrder(null);
						fieldActOrderList.get(i).setFieldPeriod(null);		
						
						if(fieldActOrderList.get(i).getField().getId()!=null) {
							String fieldId=fieldActOrderList.get(i).getField().getId();
							fieldOrderDetailRepository.deleteByActFieldId(fieldId);
						}
						
						if(fieldActOrderList.get(i).getFieldActOrder().getId()!=null) {
							Integer acOrderId=fieldActOrderList.get(i).getFieldActOrder().getId();
							fieldOrderDetailRepository.deleteByActOrderId(acOrderId);
						}
						
						fieldOrderDetailRepository.delete(fieldActOrderList.get(i));
						
						
					}
					
				}
				if(fieldOrderId!=null) {
					//System.out.println("fieldOrderId==============="+fieldOrderId);
					fieldActOrder.setActId(null);
					fieldActOrder.setActivitybean(null);
					fieldActOrder.setCoursebean(null);
					fieldActOrder.setCourseId(null);
					fieldActOrder.setCreateTime(null);
					fieldActOrder.setOrderDetails(null);
					fieldActOrder.setOrderStatus(0);
					fieldActOrder.setPaymentMethod(null);
					fieldActOrder.setPaymentStatus(0);
					fieldActOrder.setPaymentMethod(null);
					fieldActOrder.setRemark(null);
					fieldActOrder.setUpdateTime(null);
					fieldActOrderRepository.delete(fieldActOrder);
					//fieldActOrderRepository.deleteById(fieldOrderId);
					//fieldActOrderRepository.deleteByCourseId(course.getCourseId());
				}
								
			}

			
			return true;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("deleteFieldActOrderByCourse??????????????????");
			return false;
		}
		
	}*/

}