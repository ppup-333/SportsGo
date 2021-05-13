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
import com.sport.springboot.course_act.service.impl.activityService;
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
	@Autowired
	private activityService activityservice;
	
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
		
		
		 List<activityBean> activityList = activityservice.selectAllActivity();
		Map<Integer,List<Integer>> ActTotalMap=new HashMap<>();
		Map<String,List<Integer>> ActNameMap=new HashMap<>();
		
		//所有活動
		for(int i=0;i<activityList.size();i++) {
			Integer listActId = activityList.get(i).getActId();
			List<Integer> mapActA = mapAct.get(listActId);
			if(mapActA!=null) {
				ActTotalMap.put(listActId, mapActA);				
				}else {				
					ActTotalMap.put(listActId, null);
				}			
			}
		
		//按照活動分類		
		for(Map.Entry<Integer,List<Integer>> key:ActTotalMap.entrySet()) {
				Integer actId = key.getKey();
				List<Integer> totalList = ActTotalMap.get(actId);
				Optional<activityBean> a = activityservice.selectId(actId);
				activityBean activity = a.get();
				String actName = activity.getActName();
				if(ActNameMap.containsKey(actName)) {
					List<Integer> tempList=ActNameMap.get(actName);
					tempList.add(activity.getActCost());
					ActNameMap.replace(actName, tempList);
				}else {
					ActNameMap.put(actName, totalList);
				}
			}
		
		
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
		List<List> TwoActList = convertMap(ActTotalMap);
		List<String> actNameList=new ArrayList<>();
		List<Integer> actCostTotal=new ArrayList<>();
		List<Integer> actCount=new ArrayList<>();
		for(int i=0;i<TwoActList.size();i++) {
			for(int j=0;j<TwoActList.get(i).size();j++) {
				if(i==0) {
					Integer actId = (Integer) TwoActList.get(i).get(j);
					Optional<activityBean> a = activityservice.selectId(actId);
					activityBean activity = a.get();
					String actName = activity.getActName();
					System.out.println("活動名稱:"+actName);
					actNameList.add(actName);
				}else if(i==1){
					List<Integer> insideList = (List<Integer>) TwoActList.get(i).get(j);
					int totalCost=0;
					
					if(insideList!=null) {
						int count=insideList.size();
					for(int k=0;k<insideList.size();k++) {
						totalCost+=insideList.get(k);
						}					
					System.out.println("活動次數:"+count);
					System.out.println("活動總價:"+totalCost);
					actCostTotal.add(totalCost);
					actCount.add(count);
					}
					
				}
			}
		}
		model.addAttribute("actCount", actCount);
		model.addAttribute("actNameList", actNameList);
		model.addAttribute("actCostTotal", actCostTotal);
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


	public List<List> convertMap(Map<Integer, List<Integer>> x) {
		List<List> l1 = new ArrayList<>();
		List<Integer> l2 = new ArrayList<>();
		List<List> l3 = new ArrayList<>();
		Set<Integer> keyset = x.keySet();
		Iterator it = keyset.iterator();
		while (it.hasNext()) {
			List<Integer> l4 = new ArrayList<>();
			int key = (int) it.next();
			l2.add(key);
			l4 = x.get(key);
			l3.add(l4);
		}
		l1.add(l2);
		l1.add(l3);
		return l1;
	}
	
}
