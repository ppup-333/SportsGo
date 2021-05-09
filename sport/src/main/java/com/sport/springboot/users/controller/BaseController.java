package com.sport.springboot.users.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sport.springboot.users.model.Users;

@Controller
public class BaseController {
	@RequestMapping("/")
	public String login() {
		
		return "users/HomePage";
		
	}
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
	
//	@ModelAttribute
//	void d(Model m) {
//		m.addAttribute("loginPage", new Users());
//	}

}
