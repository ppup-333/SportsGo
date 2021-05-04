package com.sport.springboot.course_act.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sport.springboot.course_act.model.CATime;
import com.sport.springboot.course_act.model.courseBean;
import com.sport.springboot.course_act.model.teacherBean;
import com.sport.springboot.course_act.service.impl.CATimeService;
import com.sport.springboot.course_act.service.impl.courseService;
import com.sport.springboot.course_act.service.impl.teacherService;

@Controller
public class courseControl {

	@Autowired
	private courseService courseservice;
	@Autowired
	private CATimeService coursetimeservice;
	@Autowired
	private teacherService teacherservice;

	@GetMapping("/courseHome")
	public String index() {
		return "course_act/home";
	}

	@GetMapping("/courseInsert")
	public String courseInsert(Model model) {
		
		List<teacherBean> teacherList=teacherservice.selectAllTeacher();
		model.addAttribute("teacherList", teacherList);
		return "course_act/courseInsert";
	}
//	public  ResponseEntity<List<courseBean>> courseInsert() {
//		ResponseEntity<List<courseBean>> re = null;		
//		List<courseBean> cblist=courseservice.selectAllCourse();
//		
//		re = new ResponseEntity<>(cblist, HttpStatus.OK);
//		return re;
//	}

	
	
	
	@PostMapping("/courseUpdateImpl")
	public String courseUpdateImpl(
			@RequestParam String courseId,
			@RequestParam String courseName,
			@RequestParam String courseKind,
			@RequestParam String courseCost,	
			@RequestParam String from,
			@RequestParam String freq,
			@RequestParam String teacherId,
			@RequestParam String studentMaxNum,
			@RequestParam String courseIntroduce
			) {
		System.out.printf("%s %s %s %s %s %s %s %s %s ",courseId,courseName,courseKind,courseCost,	from,freq,teacherId,studentMaxNum,courseIntroduce);

		
		int id=Integer.parseInt(courseId);
		int cost=Integer.parseInt(courseCost);
		int studentmaxnum= Integer.parseInt(studentMaxNum);
		int fre=Integer.parseInt(freq);
		int tId=Integer.parseInt(teacherId);
		boolean b=courseservice.updateCourse(id, cost, courseKind,studentmaxnum, courseIntroduce, fre, from, tId);
		if (b) {
			System.out.println("update ok");
		} else {
			System.out.println("update not ok");
		}
		return "course_act/InsertOK";
	}
	// 前往 更新jsp
	@GetMapping("/courseUpdate")
	public String courseUpdate(@RequestParam String id, Model model) {
		int courseId = Integer.parseInt(id);
		Optional<courseBean> course = courseservice.selectId(courseId);
		courseBean c = course.get();
		Iterator<CATime> it = c.getTime().iterator();
		List<String> timeList = new ArrayList<>();
		List<String> tempList = new ArrayList<>();
		boolean b = true;
		int count = 0;
		while (it.hasNext()) {
			CATime time = it.next();
			tempList.add(time.getDate());
			if (b) {
				timeList.add(time.getTimeStart().substring(0, 5));
				timeList.add(time.getTimeEnd().substring(0, 5));
				b = false;
			}
			count++;
		}
		Collections.sort(tempList);
		String DateStart = tempList.get(0);
		String DateEnd = tempList.get(tempList.size() - 1);
		timeList.add(DateStart);
		timeList.add(DateEnd);
		// 取得帳號資訊
		String account = "mary123";
		Optional<teacherBean> t=teacherservice.selectTeacher(c.getTeacherId());
		List<teacherBean> teacherList=teacherservice.selectAllTeacher();
		teacherBean teacher=t.get();

		model.addAttribute("timeList",timeList);
		model.addAttribute("course", c);
		model.addAttribute("count", count);
		model.addAttribute("account", account);
		model.addAttribute("teacher", teacher);
		model.addAttribute("teacherList", teacherList);
		
		return "course_act/manageCourseUpdate";
	}

	// 新增課程
	@GetMapping("/courseInsertImpl")
	@ResponseBody
	public String courseInsert2(@RequestParam String courseName, @RequestParam String courseKind,
			@RequestParam String from, @RequestParam String freq, @RequestParam String courseCost,
			@RequestParam String coursePlace, @RequestParam String teacherId, @RequestParam String studentMaxNum,
			@RequestParam String courseIntroduce) {
		String courseTimeStart = (courseKind.split(" ")[1]).split("~")[0];
		String courseTimeEnd = (courseKind.split(" ")[1]).split("~")[1];
		System.out.println(" " + courseTimeStart + " " + courseTimeEnd);
		System.out.println(from + " " + from.substring(8) + " " + freq);
		int date = Integer.parseInt(from.substring(8)) + 7;
		System.out.println(from.substring(0, 8) + date);
		System.out.println(teacherId);

		int tId = Integer.parseInt(teacherId);

		courseBean course = new courseBean();
		
		course.setTeacherId(tId);
		course.setCourseName(courseName);
		course.setCourseKind(courseKind.split(" ")[0]);
		course.setCourseCost(Integer.parseInt(courseCost));
		course.setStudentMaxNum(Integer.parseInt(studentMaxNum));
		course.setCourseIntroduce(courseIntroduce);
		String type = "course";
		boolean b = courseservice.insertCourse(course, from, Integer.parseInt(freq), tId, courseTimeStart,
				courseTimeEnd, coursePlace, type);

		if (b) {
			System.out.println("insert ok");
		} else {
			System.out.println("insert not ok");
		}

		// System.out.println(result);
		// courseTime coursetime=new courseTime(courseTimeStart,courseTimeEnd,from);

//		int teacherId=teacherservice.selectTeacherId(teacherName);
//		courseBean course=new courseBean(courseName,courseKind1,Integer.parseInt(courseCost),coursePlace,teacherId,Integer.parseInt(studentMaxNum),courseIntroduce);
//		boolean result=courseservice.insertCourse(course);
//		if(result) {
//			return "<button>ok</button>";
//		}
		return "gg";

	}

	// 課程總攬
//	@GetMapping("/courseMain")
//	public ResponseEntity<List<courseBean>> courseMain(@RequestParam String sport) {
//		List<courseBean> cblist=null;
//		ResponseEntity<List<courseBean>> re = null;		
//		if("1".equals(sport)||"羽球".equals(sport)) {
//			String courseName="羽球";			
//			cblist= courseservice.selectCourse(courseName);
//			System.out.println(cblist.get(0));
//		}else if("2".equals(sport)) {
//			String courseName="桌球";			
//			cblist= courseservice.selectCourse(courseName);
//		}else if("3".equals(sport)||"籃球".equals(sport)) {
//			String courseName="籃球";			
//			cblist= courseservice.selectCourse(courseName);
//		}
//		
//		re = new ResponseEntity<>(cblist, HttpStatus.OK); 
//		return re;
//	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@GetMapping("/manageCourseMain")
	public String manageCourseMain(@RequestParam String sport, Model model) {
		List<courseBean> cblist = null;
		if ("1".equals(sport) || "羽球".equals(sport)) {
			String courseName = "羽球";
			cblist = courseservice.selectCourse(courseName);
		} else if ("2".equals(sport) || "桌球".equals(sport)) {
			String courseName = "桌球";
			cblist = courseservice.selectCourse(courseName);
		} else if ("3".equals(sport) || "籃球".equals(sport)) {
			String courseName = "籃球";
			cblist = courseservice.selectCourse(courseName);
		}
		// 要回傳的List
		List resultList = new ArrayList<>();
		for (int i = 0; i < cblist.size(); i++) {
			Iterator<CATime> time = cblist.get(i).getTime().iterator();
			// 存時間結果的List
			List timeList = new ArrayList<>();
			timeList.add(cblist.get(i).getCourseName());
			timeList.add(cblist.get(i).getCourseKind());
			timeList.add(cblist.get(i).getCourseCost());
			// 暫時存timeset裡面所有資料的List
			List<String> tempList = new ArrayList<>();
			boolean b = true;
			while (time.hasNext()) {
				CATime c = time.next();
				tempList.add(c.getDate());
				if (b) {
					timeList.add(c.getTimeStart().substring(0, 5));
					timeList.add(c.getTimeEnd().substring(0, 5));
					b = false;
				}
			}
			Collections.sort(tempList);
			String DateStart = tempList.get(0);
			String DateEnd = tempList.get(tempList.size() - 1);
			timeList.add(DateStart);
			timeList.add(DateEnd);
			timeList.add(cblist.get(i).getCourseId());
			resultList.add(timeList);
		}
		model.addAttribute("resultList", resultList);

		return "course_act/manageCourseSelect";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@GetMapping("/courseMain")
	public String courseMain(@RequestParam String sport, Model model) {
		
		
		List<courseBean> cblist = null;
		if ("1".equals(sport) || "羽球".equals(sport)) {
			String courseName = "羽球";
			cblist = courseservice.selectCourse(courseName);
		} else if ("2".equals(sport) || "桌球".equals(sport)) {
			String courseName = "桌球";
			cblist = courseservice.selectCourse(courseName);
		} else if ("3".equals(sport) || "籃球".equals(sport)) {
			String courseName = "籃球";
			cblist = courseservice.selectCourse(courseName);
		}
		// 要回傳的List
		List resultList = new ArrayList<>();
		for (int i = 0; i < cblist.size(); i++) {
			Iterator<CATime> time = cblist.get(i).getTime().iterator();
			// 存時間結果的List
			List timeList = new ArrayList<>();	
			timeList.add(cblist.get(i).getCourseName());
			timeList.add(cblist.get(i).getCourseKind());
			timeList.add(cblist.get(i).getCourseCost());			
			
			// 暫時存timeset裡面所有資料的List
			List<String> tempList = new ArrayList<>();
			boolean b = true;
			while (time.hasNext()) {
				CATime c = time.next();
				tempList.add(c.getDate());
				if (b) {
					timeList.add(c.getTimeStart().substring(0, 5));
					timeList.add(c.getTimeEnd().substring(0, 5));
					b = false;
				}
			}
			Collections.sort(tempList);
			String DateStart = tempList.get(0);
			String DateEnd = tempList.get(tempList.size() - 1);
			timeList.add(DateStart);
			timeList.add(DateEnd);
			timeList.add(cblist.get(i).getCourseId());
			
			int courseId=cblist.get(i).getCourseId();
			courseservice.updateStudentCurrent(courseId);
			int StudentCurrentNum=cblist.get(i).getStudentCurrentNum();
			int StudentMaxNum=cblist.get(i).getStudentMaxNum();
			
			if(StudentCurrentNum==StudentMaxNum) {
				
			}else {
				System.out.println("目前學生人數:"+StudentCurrentNum);
				resultList.add(timeList);
			}
			
		}
		model.addAttribute("resultList", resultList);

		return "course_act/courseSelect";
	}

	// 我要報名
	@GetMapping("/courseApply")
	public String courseApply(@RequestParam String id, Model model) {
		int courseId = Integer.parseInt(id);
	
		Optional<courseBean> course = courseservice.selectId(courseId);
		courseBean c = course.get();
		Iterator<CATime> it = c.getTime().iterator();
		List<String> timeList = new ArrayList<>();
		List<String> tempList = new ArrayList<>();
		boolean b = true;
		int count=0;
		while (it.hasNext()) {
			CATime time = it.next();
			tempList.add(time.getDate());
			if (b) {
				timeList.add(time.getTimeStart().substring(0, 5));
				timeList.add(time.getTimeEnd().substring(0, 5));
				b = false;
			}
			count++;
		}
		Collections.sort(tempList);
		String DateStart = tempList.get(0);
		String DateEnd = tempList.get(tempList.size() - 1);
		timeList.add(DateStart);
		timeList.add(DateEnd);
		// 取得帳號資訊
		String account = "mary123";
		Optional<teacherBean> t=teacherservice.selectTeacher(c.getTeacherId());
		teacherBean teacher=t.get();
		String teacherName=teacher.getTeacherName();
		System.out.println(teacherName);
		model.addAttribute("teacherName", teacherName);
		model.addAttribute("course", c);
		model.addAttribute("account", account);
		model.addAttribute("timeList", timeList);
		model.addAttribute("count", count);
		return "course_act/checkSignUp";
	}

	public String confirmCourseApply() {
		return "course_act/InsertOK";
	}

}
