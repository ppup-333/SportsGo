package com.sport.springboot.bulletin.controller.spring_mvc;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sport.springboot.bulletin.model.Bulletin;
import com.sport.springboot.bulletin.model.BulletinClass;
import com.sport.springboot.bulletin.service.BulletinClassService;
import com.sport.springboot.bulletin.service.BulletinService;

@Controller
@RequestMapping("/bulletin")
public class BulletinController {
	
	@Autowired
	BulletinService bulletinService;
	
	@Autowired
	BulletinClassService bulletinClassService;
	
	@Autowired
	ServletContext context;
	
	//讀取所有公告標題
	@GetMapping("/showAllBulletin")
	public String list(Model model) {
		model.addAttribute("bulletins", bulletinService.getAllBulletin());
		return "bulletin/bulletins";
	}
	//分頁查詢
	@GetMapping("/bulletinPaging/{pageNum}")
	public String pageable(@PathVariable("pageNum")Integer pageNum) {
		int pageSize = 3;
		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, Sort.Direction.DESC, "id"); 
		return "";
	}
	
	
	//查看公告內容
	@GetMapping("/showBulletinContent/{id}")
	public String showBulletinContent(@PathVariable("id")Integer id,Model model) {
		Bulletin bulletin = bulletinService.get(id);
		model.addAttribute(bulletin);
		return "bulletin/showBulletin";
	}
	
	
	//新增時送出空白表單供
	@GetMapping(value = "/add")
	public String showEmptyForm(Model model) {
		Bulletin bulletin = new Bulletin();
		//一鍵輸入
		
		
		model.addAttribute("bulletin",bulletin);
		return "bulletin/addBulletin";
	}
	//按下submit按鈕後 接受瀏覽器送來的資料，新增。
	@PostMapping(value = "/add")
	public String add(@ModelAttribute("bulletin")Bulletin bulletin,
		 Model model, HttpServletRequest request) {
		BulletinClass bulletinClass = bulletinClassService.getBulletinClass(bulletin.getClass_id().getId());
		bulletin.setClass_id(bulletinClass);
		
		
		Timestamp adminTime = new Timestamp(System.currentTimeMillis());
		bulletin.setDate(adminTime);
		bulletin.setUpdate_time(adminTime);
		try {
			bulletinService.save(bulletin);
		}catch (Exception e) {
			System.out.println("add error");
		}
		return "redirect:/bulletin/showAllBulletin";
	}
	//修改公告時，送回含有公告資料的表單，讓使用者修改
	@GetMapping(value = "/update/{id}")
	public String showDataForm(@PathVariable("id")Integer id, Model model) {
		Bulletin bulletin = bulletinService.get(id);
		model.addAttribute(bulletin);
		return "bulletin/updateBulletin";
	}

	
	@PostMapping(value = "/update/{id}")
	public String modify(@ModelAttribute("bulletin")Bulletin bulletin, Model model,@PathVariable("id")Integer id , HttpServletRequest request) {
		Bulletin bulletin1 = bulletinService.get(bulletin.getId());
		
		BulletinClass bulletinClass = bulletinClassService.getBulletinClass(bulletin.getClass_id().getId());
		bulletin.setClass_id(bulletinClass);
		
		Timestamp adminTime = new Timestamp(System.currentTimeMillis());
		bulletin.setUpdate_time(adminTime);
		bulletin.setDate(bulletin1.getDate());
		bulletinService.update(bulletin);
		return "redirect:/bulletin/showAllBulletin";
	}
	
	@DeleteMapping(value = "/delete/{id}")
	public String delete(@PathVariable("id")Integer id) {
		bulletinService.delete(id);
		return "redirect:/bulletin/showAllBulletin";
	}
	
	@ModelAttribute
	public void commonData(Model model) {
		List<BulletinClass> classList = bulletinClassService.getAllBulletinClass();
		model.addAttribute("classList", classList);
	}
}
