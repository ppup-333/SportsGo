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

import com.sport.springboot.course_act.model.ActivityOrderBean;
import com.sport.springboot.course_act.model.CATime;
import com.sport.springboot.course_act.model.CourseOrderBean;
import com.sport.springboot.course_act.model.EcpayOrderActBean;
import com.sport.springboot.course_act.model.activityBean;
import com.sport.springboot.course_act.service.impl.ActivityOrderService;
import com.sport.springboot.course_act.service.impl.EcpayOrderActService;
import com.sport.springboot.users.model.Users;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;
import ecpay.payment.integration.domain.QueryTradeInfoObj;


@Controller
public class EcpayActController {

	@Autowired
	private EcpayOrderActService ecpayorderactservice;
	@Autowired
	private ActivityOrderService activityorderservice;
	
	private final String properties=(this.getClass().getResource("")+"").substring(6);
	@PostMapping("ecpayAct")
	public String ecpay(@RequestParam String actId,
						@RequestParam String orderId,
						@RequestParam String account,
						@RequestParam String itemName,
			            @RequestParam String totalAmount,
			            @RequestParam String TradeDesc,Model model) {
	
		System.out.println(orderId+account+itemName+totalAmount+TradeDesc);
		BasicConfigurator.configure();
		AioCheckOutALL atm=ecpayorderactservice.insertEcpayActOrder(orderId, orderId, itemName, totalAmount, TradeDesc);
		AllInOne ecpay=new AllInOne(properties);	
		String htmlform=ecpay.aioCheckOut(atm, null);
		model.addAttribute("htmlform", htmlform);
		return "course_act/ecpay";
	}
	@GetMapping("orderAct")
	public String order(Model model,HttpSession session) {
		
		String account = (String) session.getAttribute("account");
		
		if(account !=null) {
			
	
		String MerchantTradeNo="";
		List<ActivityOrderBean> actOrderList=activityorderservice.selectByAccount(account);
		List<ActivityOrderBean> updateActOrderList=new ArrayList<>();
		
		String result="";
		if(!actOrderList.isEmpty()) {
			for(int i=0;i<actOrderList.size();i++) {
				Set<EcpayOrderActBean> ecpayOrderSet = actOrderList.get(i).getECpayOrder();
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
					String Status=statusSplit[statusSplit.length-2];//????????????
					String TradeStatus=(Status.split("="))[1];
					System.out.println(TradeStatus);
						if(Integer.parseInt(TradeStatus)==1) {
							ActivityOrderBean actOrder=actOrderList.get(i);
							actOrder.setPayState(1);
						
							updateActOrderList.add(actOrder);
							
						}
					
				}
			}
			
			for(int i=0;i<updateActOrderList.size();i++) {
				updateActOrderList.get(i).setMerchantTradeNo(MerchantTradeNo);
				activityorderservice.updateActivityOrder(updateActOrderList.get(i));
			}
			
			List<List> resultList=new ArrayList<>();
			List<ActivityOrderBean> courseOrderList2=activityorderservice.selectByAccountAndPaystament(account, 1);		
			
			List<String> tempList = new ArrayList<>();
			for(int i=0;i<courseOrderList2.size();i++) {
			List courseList = new ArrayList<>();
				activityBean activity = courseOrderList2.get(i).getActivitybean();
				courseList.add(activity.getActName());
				courseList.add(activity.getActCost());
//				activity.getCourseKind();
//				activity.getCourseCost();
				
				Iterator<CATime> it = activity.getTime().iterator();
				
				boolean b = true;
				int count = 0;
				while (it.hasNext()) {
					CATime time = it.next();
					tempList.add(time.getDate());
					if (b) {
						if(time.getFieldbean().getName()!=null) {
							courseList.add(time.getFieldbean().getName());
						}						
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
		return "course_act/ActOrderSelect";
		}else {
			return "user/Login";
		}
		
	}
	
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
	
}
