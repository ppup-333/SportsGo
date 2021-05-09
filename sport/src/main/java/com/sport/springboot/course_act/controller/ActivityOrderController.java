package com.sport.springboot.course_act.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.sport.springboot.course_act.model.ActivityOrderBean;
import com.sport.springboot.course_act.service.impl.ActivityOrderService;
import com.sport.springboot.users.model.Users;


@Controller
public class ActivityOrderController {

	@Autowired
	private ActivityOrderService activiryorderservice;
	
	@GetMapping("confirmActivityApply")
	public String ActivtiyApplyOrder(@RequestParam String actId,
			                       @RequestParam String actName,
			                       @RequestParam String actTime,
			                       @RequestParam String actDateStart,
			                       @RequestParam String actDateEnd,
			                       @RequestParam String actPlace,
			                       @RequestParam String actCost,
			                       Model m
										) {
		int id=Integer.parseInt(actId);
		int Cost=Integer.parseInt(actCost);
		String account="mary123";
		String remark=actTime+actDateStart+actDateEnd+actPlace;
		ActivityOrderBean activityOrder = activiryorderservice.insertOrder(id, account, Cost, remark);
		m.addAttribute("actId", actId);
		m.addAttribute("orderId",activityOrder.getOrderId());
		m.addAttribute("account",account);
		m.addAttribute("itemName", actName);
		m.addAttribute("totalAmount",actCost);
		m.addAttribute("TradeDesc",remark);
		return "course_act/EcpayActivityConfirm";
	}
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
}
