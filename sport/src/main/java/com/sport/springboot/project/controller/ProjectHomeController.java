package com.sport.springboot.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.sport.springboot.users.model.Users;

@Controller
public class ProjectHomeController {

	@GetMapping("/")
	public String projectHome() {
		return "index";
	}
	
	@GetMapping("/header")
	public String projectHeader() {
		return "header";
	}
	
	@GetMapping("/footer")
	public String projectFooter() {
		return "footer";
	}
	
	@GetMapping("/managerHome")
	public String projectManagerHome() {
		return "indexM";
	}
	
	@GetMapping("/headerM")
	public String projectManagerHeader() {
		return "headerM";
	}
	
	@GetMapping("/footerM")
	public String projectManagerFooter() {
		return "footerM";
	}
	
	@ModelAttribute
	public void model(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
}
