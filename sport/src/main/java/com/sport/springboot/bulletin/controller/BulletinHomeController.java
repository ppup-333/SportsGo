package com.sport.springboot.bulletin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
