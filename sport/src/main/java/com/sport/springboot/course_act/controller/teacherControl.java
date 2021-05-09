package com.sport.springboot.course_act.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sport.springboot.course_act.model.activityBean;
import com.sport.springboot.course_act.model.courseBean;
import com.sport.springboot.course_act.model.teacherBean;
import com.sport.springboot.course_act.service.impl.teacherService;
import com.sport.springboot.users.model.Users;

@Controller
public class teacherControl {

	@Autowired
	private teacherService teacherservice;

	@GetMapping("teacherHome")
	public String teacherMain(Model model) {
		List<teacherBean> teacherList = teacherservice.selectAllTeacher();
		model.addAttribute("teacherList", teacherList);
		return "course_act/teacherMain";
	}

	@GetMapping("teacherUpdate")
	public String teacherUpdate(@RequestParam String teacherId, Model model) {
		int id = Integer.parseInt(teacherId);
		Optional<teacherBean> selectoneteacher = teacherservice.selectTeacher(id);
		teacherBean teacher = selectoneteacher.get();
		byte[] imgData = teacher.getTeacherPicture();
		String base64data = "";
		if (imgData != null) {
			base64data = Base64.getEncoder().encodeToString(imgData);
		} else {
			String FilePath = "D:/_SpringBoot/images/user.png";
			try {
				FileInputStream fis1 = new FileInputStream(FilePath);
				imgData = new byte[fis1.available()];
				fis1.read(imgData);
				base64data = Base64.getEncoder().encodeToString(imgData);
				fis1.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		model.addAttribute("teacher", teacher);
		model.addAttribute("base64data", base64data);
		return "course_act/teacherUpdate";
	}
	
	
	@PostMapping("teacherUpdateImpl")
	public String teacherUpdateImpl(@RequestParam String teacherId,@RequestParam String teacherName, @RequestParam String gender,
			@RequestParam String phone, @RequestParam String salary,
			@RequestParam("teacherPicture") MultipartFile multipartfile, HttpServletRequest request)
			throws IllegalStateException, IOException{
		int g = Integer.parseInt(gender);
		int s = Integer.parseInt(salary);
		int id= Integer.parseInt(teacherId);
		teacherBean teacher = new teacherBean();
		
		
		if (multipartfile.isEmpty()) {
			Optional<teacherBean> t=teacherservice.selectTeacher(id);
			teacherBean teacher2=t.get();
			teacher.setTeacherPicture(teacher2.getTeacherPicture());
		} else {
			String filename = multipartfile.getOriginalFilename();	
			String saveDirPath = request.getSession().getServletContext().getRealPath("/") + "uploadTempDir\\";
			File fileDir = new File(saveDirPath);
			fileDir.mkdirs();
			String saveFilePath = saveDirPath + filename;
			File saveFile = new File(saveFilePath);
			System.out.println("saveFilePath:" + saveFilePath);			
			multipartfile.transferTo(saveFile);
			if (filename != null && filename.length() != 0) {
				savePicture(teacher, filename, saveFilePath);

			}
		}

		boolean b=teacherservice.updateTeacher(id,teacher, teacherName, g, phone, s);
		if (b) {
			System.out.println("update ok");
		} else {
			System.out.println("update not ok");
		}
		return "course_act/InsertOK";
	}

	@GetMapping("teacherDelete")
	public String teacherDelete(@RequestParam String teacherId) {
		int id=Integer.parseInt(teacherId);
		teacherservice.deleteTeacher(id);
		return "redirect:teacherHome";
	}
	
		@GetMapping("teacherInsert")
	public String teacherInsert() {
		return "course_act/teacherInsert";
	}

	@PostMapping("teacherInsertImpl")
	public String teacherInsertImpl(@RequestParam String teacherName, @RequestParam String gender,
			@RequestParam String phone, @RequestParam String salary,
			@RequestParam("teacherPicture") MultipartFile multipartfile, HttpServletRequest request)
			throws IllegalStateException, IOException {
		int g = Integer.parseInt(gender);
		int s = Integer.parseInt(salary);
		System.out.println(teacherName + g + s + salary);
		String filename = multipartfile.getOriginalFilename();
		System.out.println(filename);
		teacherBean teacher = new teacherBean();
		String saveDirPath = request.getSession().getServletContext().getRealPath("/") + "uploadTempDir\\";
		File fileDir = new File(saveDirPath);
		fileDir.mkdirs();
		String saveFilePath = saveDirPath + filename;
		File saveFile = new File(saveFilePath);
		System.out.println("saveFilePath:" + saveFilePath);
		if (multipartfile.isEmpty()) {

		} else {
			multipartfile.transferTo(saveFile);
			if (filename != null && filename.length() != 0) {
				savePicture(teacher, filename, saveFilePath);

			}
		}

		teacherservice.InsertTeacher(teacher, teacherName, g, phone, s);

		return "course_act/InsertOK";
	}


	private void savePicture(teacherBean teacherBean, String filename, String saveFilePath) {
		try {

			FileInputStream fis1 = new FileInputStream(saveFilePath);
			byte[] b1 = new byte[fis1.available()];
			fis1.read(b1);
			fis1.close();
			teacherBean.setTeacherPicture(b1);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
}
