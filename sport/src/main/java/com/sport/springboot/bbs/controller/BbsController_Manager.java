package com.sport.springboot.bbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BbsController_Manager {

	@GetMapping("/bbsManager")
	public String bbsManagerHomePage() {
		return "bbs/BbsManagerHomePage";
	}
	
	
}
