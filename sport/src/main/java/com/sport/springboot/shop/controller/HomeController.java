package com.sport.springboot.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sport.springboot.users.model.Users;

@Controller
public class HomeController {
	
	@RequestMapping("/shopHome")
	public String home() {
		return "shop/shop_index";
	}
	
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
}
