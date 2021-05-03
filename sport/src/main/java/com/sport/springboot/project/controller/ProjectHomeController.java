package com.sport.springboot.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProjectHomeController {

	@GetMapping("/")
	public String projectHome() {
		return "index";
	}
	
	@GetMapping("/header")
	public String projectHeader() {
		return "fieldOrder/header";
	}
	
}
