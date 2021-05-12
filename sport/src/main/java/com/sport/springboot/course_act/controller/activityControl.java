package com.sport.springboot.course_act.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.http.HttpRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sport.springboot.course_act.model.CATime;
import com.sport.springboot.course_act.model.activityBean;
import com.sport.springboot.course_act.service.impl.activityService;
import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.service.FieldService;
import com.sport.springboot.users.model.Users;

@Controller
public class activityControl {

	@Autowired
	private activityService activityservice;
	@Autowired
	FieldService fieldService;	
	
	@GetMapping("/activityInsert")
	public String activityInsert(@RequestParam String ymd,Model model) {
		String account = "mary123";
		
		List<Field> fieldList = fieldService.getAll();
		model.addAttribute("account", account);
		model.addAttribute("ymd", ymd);
		model.addAttribute("fieldList",fieldList);
		return "course_act/activityInsert";
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@GetMapping("/actUpdate")
	public String actUpdate(@RequestParam String id, Model model,HttpServletRequest request) {
		int actId = Integer.parseInt(id);
		Optional<activityBean> a = activityservice.selectId(actId);
		activityBean activity = a.get();
		Map activityMap=new HashMap();
		activityMap.put("actId", activity.getActId());
		byte[] imgData = activity.getActPicture();
		String base64data = "";
		if (imgData != null) {
			base64data = Base64.getEncoder().encodeToString(imgData);
		} else {
			String FilePath=request.getSession().getServletContext().getRealPath("/uploadTempDir/not_found.png");
			//String FilePath=(this.getClass().getResource("../../../../")+"images/courseImages/not_found.png");
			//String FilePath="/images/courseImages/not_found.png";
			System.out.println(FilePath);
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
		activityMap.put("account",activity.getAccount());
		activityMap.put("actCost", activity.getActCost());
		activityMap.put("actMaxNum", activity.getActMaxNum());
		activityMap.put("actCurrentNum",activity.getActCurrentNum());
		activityMap.put("actName", activity.getActName());
		activityMap.put("actIntroduce", activity.getActIntroduce());
		Iterator<CATime> it = activity.getTime().iterator();
		List<String> tempList = new ArrayList<>();
		boolean b = true;
		int count = 0;
		List<Field> fieldList = fieldService.getAll();
		Field firstfield = fieldList.get(0);
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
				activityMap.put("TimeStart", time.getTimeStart().substring(0, 5));
				activityMap.put("TimeEnd", time.getTimeEnd().substring(0, 5));
				b = false;
			}
			count++;
		}
		String nowDate="";
		String DateStart="";
		String DateEnd="";
		if(tempList.size()>0) {
			Collections.sort(tempList);
			DateStart = tempList.get(0);
			DateEnd = tempList.get(tempList.size() - 1);
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        nowDate=dateFormat.format(date);
		}
		 
		activityMap.put("DateStart", DateStart);
		activityMap.put("DateEnd", DateEnd);		
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("activityMap", activityMap);
		model.addAttribute("base64data", base64data);
		model.addAttribute("fieldList",fieldList);

		return  "course_act/manageActUpdate";
	}
	@PostMapping("actUpdateImpl")
	public String actUpdateImpl(@RequestParam("actId") String actId,
			@RequestParam("account") String account, @RequestParam("actName") String actName,
			@RequestParam("actCost") String actCost, @RequestParam("DateStart") String DateStart,
			@RequestParam("DateEnd") String DateEnd, @RequestParam("TimeStart") String TimeStart,
			@RequestParam("TimeEnd") String TimeEnd, @RequestParam("place") String place,
			@RequestParam("actMaxNum") String actMaxNum, @RequestParam("actIntroduce") String actIntroduce,
			@RequestParam("actPicture") MultipartFile multipartfile, HttpServletRequest request,Model model,RedirectAttributes attr) 
					throws IllegalStateException, IOException{
		int id=Integer.parseInt(actId);
		activityBean act=activityservice.getOne(id);	
		boolean actStatus=activityservice.changeCATimeByAct(act);
		if(actStatus) {
			System.out.println("actStatus成功");
		}else {
			System.out.println("actStatus失敗");
		}
		attr.addAttribute("actId",actId);
		attr.addAttribute("account",account);
		attr.addAttribute("actName",actName);
		attr.addAttribute("actCost",actCost);
		attr.addAttribute("DateEnd",DateEnd);
		attr.addAttribute("DateStart",DateStart);
		attr.addAttribute("TimeStart",TimeStart);
		attr.addAttribute("TimeEnd",TimeEnd);
		attr.addAttribute("actMaxNum",actMaxNum);
		attr.addAttribute("actIntroduce",actIntroduce);
		attr.addAttribute("actPicture",multipartfile);
		
		return "redirect:actUpdateImpl2";
	}
	
	@GetMapping("actUpdateImpl2")
	public String actUpdateImpl2(@RequestParam("actId") String actId,
			@RequestParam("account") String account, @RequestParam("actName") String actName,
			@RequestParam("actCost") String actCost, @RequestParam("DateStart") String DateStart,
			@RequestParam("DateEnd") String DateEnd, @RequestParam("TimeStart") String TimeStart,
			@RequestParam("TimeEnd") String TimeEnd, @RequestParam("place") String place,
			@RequestParam("actMaxNum") String actMaxNum, @RequestParam("actIntroduce") String actIntroduce,
			@RequestParam("actPicture") MultipartFile multipartfile, HttpServletRequest request,Model model,RedirectAttributes attr) 
					throws IllegalStateException, IOException{
		
		System.out.println("開始執行actUpdateImpl2");
		 int id=Integer.parseInt(actId);

		 activityBean act=activityservice.getOne(id);
		 act.setAccount(account);
		 act.setActName(actName);
		 act.setActCost(Integer.parseInt(actCost));
		 act.setActMaxNum(Integer.parseInt(actMaxNum));
		 act.setActIntroduce(actIntroduce);
		 
			if (multipartfile.isEmpty()) {
				Optional<activityBean> a=activityservice.selectId(id);
				activityBean activity=a.get();
				act.setActPicture(activity.getActPicture());
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
					savePicture(act, filename, saveFilePath);

				}
			}
		String type="activity";
		
		boolean b=activityservice.updateActivity(act,DateStart, DateEnd, TimeStart, TimeEnd, place, type);
		
		String result="";
		if (b) {
			result="更新成功";
			System.out.println(true);
		} else {
			result="更新失敗,有衝突到其他時段";
			System.out.println(false);
		}
		model.addAttribute("result", result);
		return "course_act/updateOk";
	}

//	@GetMapping("/activityMain")
//	public ResponseEntity<Map<String,String>> activityMain(){
//		List<activityBean> alist=activityservice.selectAllActivity();
//		
//		for(int i=0;i<alist.size();i++) {
//			alist.get(i).getActName();
//			alist.get
//			alist.get(i).getActPicture();
//		}
//		
//		ResponseEntity<Map<String,String>> re = new ResponseEntity<>(alist, HttpStatus.OK); 
//		return re;
//	}

	@GetMapping("/activityApply")
	public String activityApply(@RequestParam String actId, Model model) {
		int id = Integer.parseInt(actId);
		Optional<activityBean> activity = activityservice.selectOneActivity(id);
		activityBean a = activity.get();
		Iterator<CATime> time = a.getTime().iterator();
		List<String> timeList = new ArrayList<>();
		List<String> tempList = new ArrayList<>();
		 String fieldName="";

		boolean b = true;
		while (time.hasNext()) {
			CATime c = time.next();
			tempList.add(c.getDate());
			if (b) {
				fieldName=c.getFieldbean().getName();
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

		String account = "jacky123";
		model.addAttribute("activity", a);
		model.addAttribute("account", account);
		model.addAttribute("timeList", timeList);
		model.addAttribute("fieldName", fieldName);
		return "course_act/activityCheckSignUp";
	}

	@GetMapping("/activityMain")
	public String GetActivityMainJsp() {
		return "course_act/NewActMain";
	}
	
	@GetMapping("/NewManageActivityMain")
	public String NewManageActivityMain() {
		return "course_act/NewManageActivityMain";
	}
	
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@GetMapping("/activity")
	@ResponseBody
	public List activityMain(HttpServletRequest request) {
		List<activityBean> alist = null;
		List resultList = new ArrayList<>();

		alist = activityservice.selectAllActivity();

		for (int i = 0; i < alist.size(); i++) {
			Map activityMap=new HashMap();
			activityMap.put("actId", alist.get(i).getActId());
			byte[] imgData =alist.get(i).getActPicture();
			String base64data = "";
			if (imgData != null) {
				base64data = Base64.getEncoder().encodeToString(imgData);
			} else {
				String FilePath=request.getSession().getServletContext().getRealPath("/uploadTempDir/not_found.png");
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
			activityMap.put("actPicture", base64data);
			activityMap.put("actCost", alist.get(i).getActCost());
			activityMap.put("actMaxNum", alist.get(i).getActMaxNum());
			activityMap.put("actCurrentNum", alist.get(i).getActCurrentNum());
			activityMap.put("actName", alist.get(i).getActName());

			
			Iterator it = alist.get(i).getTime().iterator();
			String DateStart = "";
			String DateEnd = "";
			List<String> insideMap = new ArrayList<>();
			boolean b = true;
			while (it.hasNext()) {
				CATime time = (CATime) it.next();
				insideMap.add(time.getDate());
				if (b) {
					activityMap.put("TimeStart", time.getTimeStart().substring(0, 5));
					activityMap.put("TimeEnd", time.getTimeEnd().substring(0, 5));
					b = false;
				}
			}
			
			if(insideMap.size()>0) {
				Collections.sort(insideMap);
			DateStart = insideMap.get(0);
			DateEnd = insideMap.get(insideMap.size() - 1);
			activityMap.put("DateStart", DateStart);
			activityMap.put("DateEnd", DateEnd);
			resultList.add(activityMap);
			System.out.println("--------------------------");
			System.out.println("開始日期:" + DateStart + "結束日期:" + DateEnd);
			}
			

		}

		// model.addAttribute("resultList", resultList);
		// return "actMain";
		// List<activityBean> alist=null;
		return resultList;
	}

	@PostMapping("/activityInsertImpl")
	public String activityInsertImpl(@RequestParam("account") String account, @RequestParam("actName") String actName,
			@RequestParam("actCost") String actCost, @RequestParam("DateStart") String DateStart,
			@RequestParam("DateEnd") String DateEnd, @RequestParam("TimeStart") String TimeStart,
			@RequestParam("TimeEnd") String TimeEnd, @RequestParam("place") String place,
			@RequestParam("actMaxNum") String actMaxNum, @RequestParam("actIntroduce") String actIntroduce,
			@RequestParam("actPicture") MultipartFile multipartfile, HttpServletRequest request,Model model)
			throws IllegalStateException, IOException {
		activityBean activitybean = new activityBean();

		activitybean.setAccount(account);
		activitybean.setActName(actName);
		activitybean.setActCost(Integer.parseInt(actCost));
		activitybean.setActMaxNum(Integer.parseInt(actMaxNum));
		activitybean.setActIntroduce(actIntroduce);
		activitybean.setActCurrentNum(0);
		String filename = multipartfile.getOriginalFilename();
		System.out.println(filename);
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
				savePicture(activitybean, filename, saveFilePath);

			}
		}
		String type = "activity";
		System.out.println(activitybean.getActPicture());
		boolean b = activityservice.insertActivity(activitybean, DateStart, DateEnd, TimeStart, TimeEnd, place, type);
		String result="";
		if (b) {
			result="新增成功";
			System.out.println(true);
		} else {
			result="新增失敗,有衝突到其他時段";
			System.out.println(false);
		}
		model.addAttribute("result", result);
		return "course_act/InsertOK";
	}
	
	

	private void savePicture(activityBean activitybean, String filename, String saveFilePath) {
		try {

			FileInputStream fis1 = new FileInputStream(saveFilePath);
			byte[] b1 = new byte[fis1.available()];
			fis1.read(b1);
			fis1.close();
			activitybean.setActPicture(b1);

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
