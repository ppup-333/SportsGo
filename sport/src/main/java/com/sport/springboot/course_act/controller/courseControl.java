package com.sport.springboot.course_act.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.log4j.BasicConfigurator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sport.springboot.course_act.model.CATime;
import com.sport.springboot.course_act.model.CourseOrderBean;
import com.sport.springboot.course_act.model.EcpayOrderBean;
import com.sport.springboot.course_act.model.courseBean;
import com.sport.springboot.course_act.model.teacherBean;
import com.sport.springboot.course_act.service.impl.CATimeService;
import com.sport.springboot.course_act.service.impl.CourseOrderService;
import com.sport.springboot.course_act.service.impl.courseService;
import com.sport.springboot.course_act.service.impl.teacherService;
import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.service.FieldService;
import com.sport.springboot.users.model.Users;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.QueryTradeInfoObj;

@Controller
public class courseControl {

	@Autowired
	private courseService courseservice;
	@Autowired
	FieldService fieldService;	
	@Autowired
	private teacherService teacherservice;
	
	@Autowired
	private CourseOrderService courseorderservice;
	
	//private final String properties="D:\\_SpringBoot\\SportsGo\\sport\\src\\main\\java\\ecpay\\payment\\integration";
	private final String properties="/src/main/java/ecpay/payment/integration";

	@GetMapping("/courseHome")
	public String index() {
		return "course_act/home";
	}

	@GetMapping("/courseInsert")
	public String courseInsert(@RequestParam String ymd,Model model,HttpSession session) {
		 
		String courseName=(String) session.getAttribute("courseName");
		String courseTypeId=(String) session.getAttribute("courseTypeId");
		
		
		int typeId=Integer.parseInt(courseTypeId);
		List<Field> fieldList = fieldService.getByTypeId(typeId);
		
		
		List<courseBean> courseList = courseservice.selectCourse(courseName);
		
		 List<String>  Timeperiod=new ArrayList<>();
		
		 System.out.println("選擇的時間"+ymd);
		for(int i=0;i<courseList.size();i++) {
			Set<CATime> timeset = courseList.get(i).getTime();
			Iterator<CATime> it = timeset.iterator();
			while(it.hasNext()) {
				CATime time = it.next();
			//	System.out.println(time.getDate());
				if(time.getDate().equals(ymd)) {
					System.out.println(ymd);
					String timestart=time.getTimeStart().split("\\.")[0].substring(0,5);
					String timeEnd=time.getTimeEnd().split("\\.")[0].substring(0,5);
					Timeperiod.add(courseList.get(i).getCourseKind()+" "+timestart+"~"+timeEnd);
				}
			}
		}
		
		
		List<teacherBean> teacherList=teacherservice.selectAllTeacher();
		
		System.out.println(courseName);
		
		
		model.addAttribute("courseName",courseName);
		model.addAttribute("Timeperiod", Timeperiod);
		model.addAttribute("time", ymd);
		model.addAttribute("teacherList", teacherList);
		model.addAttribute("fieldList", fieldList);
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
			@RequestParam String coursePlace,
			@RequestParam String studentMaxNum,
			@RequestParam String courseIntroduce,
			Model model
			) {
		System.out.printf("%s %s %s %s %s %s %s %s %s ",courseId,courseName,courseKind,courseCost,	from,freq,teacherId,studentMaxNum,courseIntroduce);

		
		int id=Integer.parseInt(courseId);
		int cost=Integer.parseInt(courseCost);
		int studentmaxnum= Integer.parseInt(studentMaxNum);
		int fre=Integer.parseInt(freq);
		int tId=Integer.parseInt(teacherId);
		boolean b=courseservice.updateCourse(id, cost, courseKind,studentmaxnum, courseIntroduce, fre, from, tId,coursePlace);
		if (b) {
			model.addAttribute("result", "更新成功");
			System.out.println("update ok");
		} else {
			model.addAttribute("result","更新失敗,查詢相關資訊請聯絡後台工程師");
		}
		return "course_act/updateOk";
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
		List<Field> fieldList = fieldService.getAll();
		Field firstfield = fieldList.get(0);
		boolean b = true;
		int count = 0;
		while (it.hasNext()) {
			CATime time = it.next();
			tempList.add(time.getDate());
			if (b) {
				for(int i=0;i<fieldList.size();i++) {
					if(fieldList.get(i).getName().equals(time.getFieldbean().getName())) {
						Field nowField = fieldList.get(i);
						fieldList.set(i, firstfield);
						fieldList.set(0, nowField);
					}
				}
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
		model.addAttribute("fieldList",fieldList);
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
		//System.out.println(from + " " + from.substring(8) + " " + freq);
		int date = Integer.parseInt(from.substring(8)) + 7;


		int tId = Integer.parseInt(teacherId);

		courseBean course = new courseBean();
		System.out.println(coursePlace);
		course.setTeacherId(tId);
		course.setCourseName(courseName);
		course.setCourseKind(courseKind.split(" ")[0]);
		course.setCourseCost(Integer.parseInt(courseCost));
		course.setStudentMaxNum(Integer.parseInt(studentMaxNum));
		course.setCourseIntroduce(courseIntroduce);
		
		String type = "course";
		boolean b = courseservice.insertCourse(course, from, Integer.parseInt(freq), tId, courseTimeStart,
				courseTimeEnd, coursePlace, type);
		String result="";
		if (b) {
			result="新增成功";
			System.out.println("insert ok");
		} else {
			result="新增失敗";
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
		return result;

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
	
	
	@GetMapping("NewManageCourseMain")
	public String NewManageCourseMain() {
		return "course_act/NewManageCourseMain";
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@GetMapping("/manageCourseMain")
	public String manageCourseMain(@RequestParam String sport, Model model,HttpSession session) {
		List<courseBean> cblist = null;
		if ("1".equals(sport) || "羽球".equals(sport)) {
			String courseName = "羽球";
			cblist = courseservice.selectCourse(courseName);
			session.setAttribute("courseName", courseName);
			session.setAttribute("courseTypeId", "1");
			
		} else if ("2".equals(sport) || "桌球".equals(sport)) {
			String courseName = "桌球";
			cblist = courseservice.selectCourse(courseName);
			session.setAttribute("courseName", courseName);
			session.setAttribute("courseTypeId", "4");
		} else if ("3".equals(sport) || "籃球".equals(sport)) {
			String courseName = "籃球";
			cblist = courseservice.selectCourse(courseName);
			session.setAttribute("courseName", courseName);
			session.setAttribute("courseTypeId", "2");
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

	@GetMapping("NewCourseMain")
	public String NewCourseMain() {
		return "course_act/NewCourseMain";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@GetMapping("/courseMain")
	@ResponseBody
	public List courseMain(@RequestParam String sport,HttpSession session) {
		
		
		List<courseBean> cblist = null;
		if ("1".equals(sport) || "羽球".equals(sport)) {
			String courseName = "羽球";
			cblist = courseservice.selectCourse(courseName);
			session.setAttribute("courseName", courseName);
			session.setAttribute("courseTypeId", "1");
		} else if ("2".equals(sport) || "桌球".equals(sport)) {
			String courseName = "桌球";
			cblist = courseservice.selectCourse(courseName);
			session.setAttribute("courseName", courseName);
			session.setAttribute("courseTypeId", "4");
		} else if ("3".equals(sport) || "籃球".equals(sport)) {
			String courseName = "籃球";
			cblist = courseservice.selectCourse(courseName);
			session.setAttribute("courseName", courseName);
			session.setAttribute("courseTypeId", "2");
		}
		
		//更新 最新報名人數
		List<CourseOrderBean> courseOrderList=new ArrayList<>();
		
		
		for(int i=0;i<cblist.size();i++) {
			 Set<CourseOrderBean> courseOrderSet = cblist.get(i).getCourseOrder();
			  Iterator<CourseOrderBean> it = courseOrderSet.iterator();
			  
			  
			  while(it.hasNext()) {
				  CourseOrderBean courseOrder = it.next();
				  
				  Set<EcpayOrderBean> easyPaySet = courseOrder.getECpay();
				  Iterator<EcpayOrderBean> easyit = easyPaySet.iterator();
				  while(easyit.hasNext()) {
					  EcpayOrderBean easyPay = easyit.next();
					  String MerchantTradeNo = easyPay.getMerchantTradeNo();
					  String status="";
					  BasicConfigurator.configure();
						AllInOne ecpay=new AllInOne(properties);
						QueryTradeInfoObj trade=new QueryTradeInfoObj();
						trade.setMerchantTradeNo(MerchantTradeNo);
						status=ecpay.queryTradeInfo(trade);
						String[] statusSplit=status.split("&");				
						String Status=statusSplit[statusSplit.length-2];//交易狀態
						String TradeStatus=(Status.split("="))[1];
						System.out.println(TradeStatus);
						if(Integer.parseInt(TradeStatus)==1) {
							courseOrder.setPayState(1);
							courseOrderList.add(courseOrder);
							//courseorderservice.updateCourseOrder(courseOrder);
						}
				  }
			  }
		}
		
		for(int i=0;i<courseOrderList.size();i++) {
			courseorderservice.updateCourseOrder(courseOrderList.get(i));
		}
		
		
		// 要回傳的List
		List resultList = new ArrayList<>();
		for (int i = 0; i < cblist.size(); i++) {
			Iterator<CATime> time = cblist.get(i).getTime().iterator();
			// 存時間結果的List
			List timeList = new ArrayList<>();	
			Map m=new HashMap<>();
			m.put("courseId",cblist.get(i).getCourseId());
			m.put("courseName", cblist.get(i).getCourseName());
			m.put("courseKind", cblist.get(i).getCourseKind());
			m.put("courseCost", cblist.get(i).getCourseCost());		
			
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
			
			m.put("DateStart", DateStart);
			m.put("DateEnd", DateEnd);
			System.out.println(DateStart);
			System.out.println(DateEnd);
			int courseId=cblist.get(i).getCourseId();
			courseservice.updateStudentCurrent(courseId);
			int studentCurrentNum=cblist.get(i).getStudentCurrentNum();
			int studentMaxNum=cblist.get(i).getStudentMaxNum();
			
			if(studentCurrentNum==studentMaxNum) {
				
			}else {
				m.put("studentCurrentNum", studentCurrentNum);
				m.put("studentMaxNum", studentMaxNum);
				resultList.add(m);
			}
			
		}
		return resultList;
	}

	// 我要報名
	@GetMapping("/courseApply")
	public String courseApply(@RequestParam(value = "id") String id,@RequestParam(value = "type") String type, Model model) {
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
		
		if("first".equals(type)) {
			return "course_act/courseDetail";
		}else {
			return "course_act/checkSignUp";
		}
	
	}

	public String confirmCourseApply() {
		return "course_act/InsertOK";
	}

	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
	
}
