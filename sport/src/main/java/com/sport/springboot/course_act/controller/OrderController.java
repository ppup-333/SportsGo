package com.sport.springboot.course_act.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.log4j.BasicConfigurator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sport.springboot.course_act.model.ActivityOrderBean;
import com.sport.springboot.course_act.model.CATime;
import com.sport.springboot.course_act.model.CourseOrderBean;
import com.sport.springboot.course_act.model.EcpayOrderActBean;
import com.sport.springboot.course_act.model.EcpayOrderBean;
import com.sport.springboot.course_act.model.activityBean;
import com.sport.springboot.course_act.model.courseBean;
import com.sport.springboot.course_act.service.impl.ActivityOrderService;
import com.sport.springboot.course_act.service.impl.CourseOrderService;
import com.sport.springboot.course_act.service.impl.courseService;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.QueryTradeInfoObj;

@Controller
public class OrderController {

	@Autowired
	private ActivityOrderService activityorderservice;
	@Autowired
	private CourseOrderService courseorderservice;
	
	@Autowired
	private courseService courseservice;
	
	
	private final String properties=(this.getClass().getResource("")+"").substring(6);
	
	//public List<Map<String,Integer>> courseList=new ArrayList<>();
	//public List<Map<String,Integer>> activityList=new ArrayList<>();
	 
	// List<Map<Integer,Integer>> mapCourseList=new ArrayList<>();
	 Map<Integer,List<Integer>> mapCourse=new HashMap<>();
	 Map<Integer,List<Integer>> mapAct=new HashMap<>();
	@GetMapping("DashBoard")
	public String DashBoard(Model model,HttpSession session) {
		mapCourse.clear();
		mapAct.clear();
		List<CourseOrderBean> courseOrderList=courseorderservice.selectAll();
		List<ActivityOrderBean> activityOrderList=activityorderservice.selectAll();
		Integer total=getOrder(courseOrderList,activityOrderList);
		System.out.println("total==============="+total);
	
		List<courseBean> courseList = courseservice.selectAllCourse();
		Map<Integer,List<Integer>> totalMap=new HashMap<>();
		Map<String,List<Integer>> sportMap=new HashMap<>();
		//所有的course
		for(int i=0;i<courseList.size();i++) {
			Integer listCourseId = courseList.get(i).getCourseId();
			List<Integer> mapCourseS = mapCourse.get(listCourseId);
			if(mapCourseS!=null) {
					totalMap.put(listCourseId, mapCourseS);				
			}else {				
				totalMap.put(listCourseId, null);
			}			
		}
		//按照運動分類
		//拿出totalMap中的List 根據運動分類放進 sportMap
		for(Map.Entry<Integer,List<Integer>> key:totalMap.entrySet()) {
			Integer courseId = key.getKey();
			List<Integer> totalList = totalMap.get(courseId);					
			Optional<courseBean> c = courseservice.selectId(courseId);
			courseBean course = c.get();
			String courseName = course.getCourseName();
			if(sportMap.containsKey(courseName)) {
				List<Integer> tempList=sportMap.get(courseName);
				tempList.add(course.getCourseCost());
				sportMap.replace(courseName,tempList);
			}else {				
				sportMap.put(courseName, totalList);
			}
			
		}
		
		model.addAttribute("total", total);
		model.addAttribute("sportMap", sportMap);
		model.addAttribute("totalMap", totalMap);
		//session.setAttribute("mapCourse", mapCourse);
		//session.setAttribute("mapAct", mapAct);
		return "course_act/DashBoard";
	}
	
	@SuppressWarnings("unchecked")
	@GetMapping("OrderController/courseDetail")
	@ResponseBody
	public  Map<String,List<Integer>> courseDetail(HttpSession session,Model model) {
		
		Map<Integer,List<Integer>> sessionCourseMap =(Map<Integer, List<Integer>>) session.getAttribute("mapCourse");
		//session.setAttribute("secondMapCourse", (Map<Integer, List<Integer>>) session.getAttribute("mapCourse"));
		/*if(session.getAttribute("mapCourse")==null) {
			sessionCourseMap=(Map<Integer, List<Integer>>) session.getAttribute("secondMapCourse");
		}else {
			sessionCourseMap=(Map<Integer, List<Integer>>) session.getAttribute("mapCourse");
		}
		session.removeAttribute("mapCourse");*/
		
		List<courseBean> courseList = courseservice.selectAllCourse();
		Map<Integer,List<Integer>> totalMap=new HashMap<>();
		Map<String,List<Integer>> sportMap=new HashMap<>();
		//所有的course
		for(int i=0;i<courseList.size();i++) {
			Integer listCourseId = courseList.get(i).getCourseId();
			List<Integer> mapCourseS = sessionCourseMap.get(listCourseId);
			if(mapCourseS!=null) {
					totalMap.put(listCourseId, mapCourseS);				
			}else {				
				totalMap.put(listCourseId, null);
			}			
		}
		//按照運動分類
		//拿出totalMap中的List 根據運動分類放進 sportMap
		for(Map.Entry<Integer,List<Integer>> key:totalMap.entrySet()) {
			Integer courseId = key.getKey();
			List<Integer> totalList = totalMap.get(courseId);					
			Optional<courseBean> c = courseservice.selectId(courseId);
			courseBean course = c.get();
			String courseName = course.getCourseName();
			if(sportMap.containsKey(courseName)) {
				List<Integer> tempList=sportMap.get(courseName);
				tempList.add(course.getCourseCost());
				sportMap.replace(courseName,tempList);
			}else {				
				sportMap.put(courseName, totalList);
			}
			
		}
		
		
		return sportMap;
	}
	@SuppressWarnings("unchecked")
	@GetMapping("OrderController/actDetail")
	@ResponseBody
	public  Map<Integer,List<Integer>> actDetail(HttpSession session){
		Map<Integer,List<Integer>> sessionActMap =  (Map<Integer, List<Integer>>) session.getAttribute("mapAct");
		
		return sessionActMap;
	}
	
	public int getOrder(List<CourseOrderBean> courseOrderList,List<ActivityOrderBean> activityOrderList) {
		
		
		String MerchantTradeNo="";
		int total=0;
		
		if(!courseOrderList.isEmpty()) {
			List<CourseOrderBean> updatecourseOrderList=new ArrayList<>();
			
			for(int i=0;i<courseOrderList.size();i++) {
				Set<EcpayOrderBean> ecpayOrderSet = courseOrderList.get(i).getECpay();
				Iterator<EcpayOrderBean> ecpayOrderIt = ecpayOrderSet.iterator();
				while(ecpayOrderIt.hasNext()) {
	
					EcpayOrderBean ecpayOrder = ecpayOrderIt.next();
					MerchantTradeNo=ecpayOrder.getMerchantTradeNo();
					System.out.println("MerchantTradeNo"+MerchantTradeNo);
					String status="";
					BasicConfigurator.configure();
					AllInOne ecpay=new AllInOne(properties);
					QueryTradeInfoObj trade=new QueryTradeInfoObj();
					trade.setMerchantTradeNo(MerchantTradeNo);
					status=ecpay.queryTradeInfo(trade);
					System.out.println(status);
					String[] statusSplit=status.split("&");				
					String Status=statusSplit[statusSplit.length-2];//交易狀態
					String TradeStatus=(Status.split("="))[1];
					System.out.println(TradeStatus);
						if(Integer.parseInt(TradeStatus)==1) {
							CourseOrderBean courseOrder=courseOrderList.get(i);
							courseOrder.setPayState(1);
							updatecourseOrderList.add(courseOrder);
							//courseorderservice.updateCourseOrder(courseOrder);
						}
					
				}
			}
			for(int i=0;i<updatecourseOrderList.size();i++) {
				updatecourseOrderList.get(i).setMerchantTradeNo(MerchantTradeNo);
				courseorderservice.updateCourseOrder(updatecourseOrderList.get(i));
			}		
			List<CourseOrderBean> courseOrderList2=courseorderservice.selectByPaystament(1);							
			
			
			for(int i=0;i<courseOrderList2.size();i++) {	
				List<Integer> courseList=new ArrayList<>();
				 courseBean course = courseOrderList2.get(i).getCoursebean();
				 		Integer courseId = course.getCourseId();
				 		Integer courseOrderCost=courseOrderList2.get(i).getCost();
				 		if(mapCourse.containsKey(courseId)) {
				 			System.out.println("重複的"+courseId);
				 			List<Integer> tempList=mapCourse.get(courseId);
				 			tempList.add(courseOrderCost);
				 			mapCourse.replace(courseId, tempList);
				 			
				 		}else {
				 			courseList.add(courseOrderCost);
				 			mapCourse.put(courseId, courseList);
				 		}
				 		
				total+=courseOrderCost;
			}
			
		
		}
		if(!activityOrderList.isEmpty()) {
			List<ActivityOrderBean> updateActOrderList=new ArrayList<>();
			for(int i=0;i<activityOrderList.size();i++) {
				Set<EcpayOrderActBean> ecpayOrderSet = activityOrderList.get(i).getECpayOrder();
				Iterator<EcpayOrderActBean> ecpayOrderIt = ecpayOrderSet.iterator();
				while(ecpayOrderIt.hasNext()) {
					EcpayOrderActBean ecpayOrder = ecpayOrderIt.next();
					MerchantTradeNo=ecpayOrder.getMerchantTradeNo();
					String status="";
					BasicConfigurator.configure();
					AllInOne ecpay=new AllInOne(properties);
					QueryTradeInfoObj trade=new QueryTradeInfoObj();
					trade.setMerchantTradeNo(MerchantTradeNo);
					status=ecpay.queryTradeInfo(trade);
					System.out.println(status);
					String[] statusSplit=status.split("&");				
					String Status=statusSplit[statusSplit.length-2];//交易狀態
					String TradeStatus=(Status.split("="))[1];
					System.out.println(TradeStatus);
						if(Integer.parseInt(TradeStatus)==1) {
							ActivityOrderBean actOrder=activityOrderList.get(i);
							actOrder.setPayState(1);
							updateActOrderList.add(actOrder);
							//activityorderservice.updateCourseOrder(actOrder);
						}
					
				}
			}			
			for(int i=0;i<updateActOrderList.size();i++) {
				updateActOrderList.get(i).setMerchantTradeNo(MerchantTradeNo);
				activityorderservice.updateActivityOrder(updateActOrderList.get(i));
			}
			List<ActivityOrderBean> courseOrderList2=activityorderservice.selectByPaystament(1);				
			for(int i=0;i<courseOrderList2.size();i++) {
				List<Integer> actList=new ArrayList<>();
				activityBean act= courseOrderList2.get(i).getActivitybean();	
				Integer actId = act.getActId();
		 		Integer actOrderCost=courseOrderList2.get(i).getCost();
		 		if(mapAct.containsKey(actId)) {
		 			System.out.println("重複的"+actId);
		 			List<Integer> tempList=mapAct.get(actId);
		 			tempList.add(actOrderCost);
		 			mapAct.replace(actId, tempList);		 			
		 		}else {
		 			actList.add(actOrderCost);
		 			mapAct.put(actId, actList);
		 		}
		 		
				total+=actOrderCost;
			}
		}
		return  total;
	}


	
	
}
