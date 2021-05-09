package com.sport.springboot.course_act.controller;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sport.springboot.course_act.model.CourseOrderBean;
import com.sport.springboot.course_act.service.impl.CourseOrderService;
import com.sport.springboot.users.model.Users;

@Controller
public class CourseOrderController {
	
	@Autowired
	private CourseOrderService courseorderservice;
	
	
//	
//	@GetMapping({ "/index", "/" })
//	public String index() {
//		return "home";
//	}
//	
//	@GetMapping("order")
//	public String order() {
//		String status="";
//		String properties="D:/_SpringBoot/workspace/ECpayTest/src/main/java";
//		String MerchantTradeNo="A6666612347";
//		BasicConfigurator.configure();
//		AllInOne ecpay=new AllInOne(properties);
//		QueryTradeInfoObj trade=new QueryTradeInfoObj();
//		trade.setMerchantTradeNo(MerchantTradeNo);
//		status=ecpay.queryTradeInfo(trade);
//		System.out.println(status);
//		return "order";
//	}
	
	@PostMapping("confirmCourseApply")
	public String courseApplyOrder(@RequestParam String courseId,
								@RequestParam String account,
								@RequestParam String courseName,
								@RequestParam String courseKind,
								@RequestParam String courseCost,
								@RequestParam String TimeStart,
								@RequestParam String TimeEnd,
								@RequestParam String count,
								@RequestParam String DateStart,
								@RequestParam String DateEnd,
								@RequestParam String remark,
								Model m) {
		int id=Integer.parseInt(courseId);
		int cost=Integer.parseInt(courseCost);
		//int freq=Integer.parseInt(count);        
		CourseOrderBean courseOrder=courseorderservice.insertOrder(id,account,cost,remark);	
		remark+="_courseApply";
		if(courseOrder!=null) {
		m.addAttribute("courseId", courseId);
		m.addAttribute("orderId",courseOrder.getOrderId());
		m.addAttribute("account",account);
		m.addAttribute("itemName", courseName+courseKind);
		m.addAttribute("totalAmount",courseCost);
		m.addAttribute("TradeDesc",remark);
		}		
		return "course_act/EcpayConfirm";
	}
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
	
	
}
