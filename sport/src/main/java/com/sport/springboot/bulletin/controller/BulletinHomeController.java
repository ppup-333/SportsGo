package com.sport.springboot.bulletin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sport.springboot.users.model.Users;

@Controller
public class BulletinHomeController {
	
	@RequestMapping("/bulletin")
	public String home() {
		return "bulletinIndex";
	}
	
	@RequestMapping("Bulletin/viewBulletin")
	public String viewBulletin() {
		return "Bulletin/viewBulletin";
	}
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
}
