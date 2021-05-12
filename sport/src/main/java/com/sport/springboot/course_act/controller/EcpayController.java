package com.sport.springboot.course_act.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.log4j.BasicConfigurator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sport.springboot.course_act.model.CATime;
import com.sport.springboot.course_act.model.CourseOrderBean;
import com.sport.springboot.course_act.model.EcpayOrderBean;
import com.sport.springboot.course_act.model.courseBean;
import com.sport.springboot.course_act.service.impl.CourseOrderService;
import com.sport.springboot.course_act.service.impl.EcpayOrderService;
import com.sport.springboot.users.model.Users;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;
import ecpay.payment.integration.domain.QueryTradeInfoObj;

@Controller
public class EcpayController {

	@Autowired
	private EcpayOrderService ecpayservice;
	@Autowired
	private CourseOrderService courseorderservice;
	
	private final String properties=(this.getClass().getResource("")+"").substring(6);
	
	@PostMapping("ecpay")
	public String ecpay(@RequestParam String courseId,
						@RequestParam String orderId,
						@RequestParam String account,
						@RequestParam String itemName,
			            @RequestParam String totalAmount,
			            @RequestParam String TradeDesc,Model model) {
		

		System.out.println(orderId+account+itemName+totalAmount+TradeDesc);
		BasicConfigurator.configure();
		AioCheckOutALL atm=ecpayservice.insertEcpayCourseOrder(orderId, courseId,itemName, totalAmount, TradeDesc);
		AllInOne ecpay=new AllInOne(properties);	
		String htmlform=ecpay.aioCheckOut(atm, null);
		model.addAttribute("htmlform", htmlform);
		return "course_act/ecpay";
	}
	
	@GetMapping("CourseOrder")
	public String order(Model model,HttpSession session) {
		String account = (String) session.getAttribute("account");
		if(account !=null) {
			
		
		String MerchantTradeNo="";
		List<CourseOrderBean> courseOrderList=courseorderservice.selectByAccount(account);
		List<CourseOrderBean> updatecourseOrderList=new ArrayList<>();
		String result="";
		if(!courseOrderList.isEmpty()) {
			for(int i=0;i<courseOrderList.size();i++) {
				Set<EcpayOrderBean> ecpayOrderSet = courseOrderList.get(i).getECpay();
				Iterator<EcpayOrderBean> ecpayOrderIt = ecpayOrderSet.iterator();
			
				 
				while(ecpayOrderIt.hasNext()) {
					
					
					EcpayOrderBean ecpayOrder = ecpayOrderIt.next();
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
			
			List<List> resultList=new ArrayList<>();
			List<CourseOrderBean> courseOrderList2=courseorderservice.selectByAccountAndPaystament(account, 1);		
			
			List<String> tempList = new ArrayList<>();
			for(int i=0;i<courseOrderList2.size();i++) {
				List courseList = new ArrayList<>();
				courseBean course = courseOrderList2.get(i).getCoursebean();
				courseList.add(course.getCourseName()+course.getCourseKind());
				courseList.add(course.getCourseCost());
				course.getCourseKind();
				course.getCourseCost();
				
				Iterator<CATime> it = course.getTime().iterator();
				
				boolean b = true;
				int count = 0;
				while (it.hasNext()) {
					CATime time = it.next();
					tempList.add(time.getDate());
					if (b) {
						courseList.add(time.getFieldbean().getName());
						courseList.add(time.getTimeStart().substring(0, 5));
						courseList.add(time.getTimeEnd().substring(0, 5));
						b = false;
					}
					count++;
				}
				Collections.sort(tempList);
				String DateStart = tempList.get(0);
				String DateEnd = tempList.get(tempList.size() - 1);
				courseList.add(DateStart);
				courseList.add(DateEnd);
				resultList.add(courseList);
			}
			for(int i=0;i<resultList.size();i++) {
				for(int j=0;j<resultList.get(i).size();j++) {
					System.out.println(resultList.get(i).get(j));
				}
			}
			model.addAttribute("resultList", resultList);
			result="1";
			model.addAttribute("result", result);
			
		}else {
			result="0";
			model.addAttribute("result", result);
			
		}	
		return "course_act/courseOrderSelect";
		}else {
			return "user/Login";
		}
	}
	
	@PostMapping("ecpayReturn")
	public String ecpayReturn(@RequestParam String MerchantTradeNo,@RequestParam int RtnCode) {
		System.out.println(MerchantTradeNo);
		System.out.println(RtnCode);
		return "course_act/home";
	}
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
	

}
