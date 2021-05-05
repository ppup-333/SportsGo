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
	
}
