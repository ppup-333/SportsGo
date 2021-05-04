package com.sport.springboot.course_act.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sport.springboot.course_act.model.CATime;
import com.sport.springboot.course_act.model.activityBean;
import com.sport.springboot.course_act.service.impl.activityService;

@Controller
public class activityControl {

	@Autowired
	private activityService activityservice;

	@GetMapping("/activityInsert")
	public String activityInsert(Model model) {
		String account = "mary123";
		model.addAttribute("account", account);
		return "course_act/activityInsert";
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

		String account = "jacky123";
		model.addAttribute("activity", a);
		model.addAttribute("account", account);
		model.addAttribute("timeList", timeList);
		return "course_act/activityCheckSignUp";
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@GetMapping("/activityMain")
	public ResponseEntity<List> activityMain() {
		List<activityBean> alist = null;
		List resultList = new ArrayList<>();

		alist = activityservice.selectAllActivity();

		for (int i = 0; i < alist.size(); i++) {
			resultList.add(alist.get(i).getActId());
			resultList.add(alist.get(i).getActPicture());
			resultList.add(alist.get(i).getActCost());
			resultList.add(alist.get(i).getActMaxNum());
			resultList.add(alist.get(i).getActCurrentNum());
			resultList.add(alist.get(i).getActName());
			Iterator it = alist.get(i).getTime().iterator();
			String DateStart = "";
			String DateEnd = "";
			List<String> insideMap = new ArrayList<>();
			boolean b = true;
			while (it.hasNext()) {
				CATime time = (CATime) it.next();
				insideMap.add(time.getDate());
				if (b) {
					resultList.add(time.getTimeStart());
					resultList.add(time.getTimeEnd());
					b = false;
				}
			}
			Collections.sort(insideMap);
			DateStart = insideMap.get(0);
			DateEnd = insideMap.get(insideMap.size() - 1);
			resultList.add(DateStart);
			resultList.add(DateEnd);
			System.out.println("--------------------------");
			System.out.println("開始日期:" + DateStart + "結束日期:" + DateEnd);

		}

		// model.addAttribute("resultList", resultList);
		// return "actMain";
		// List<activityBean> alist=null;
		ResponseEntity<List> re = null;
		re = new ResponseEntity<>(resultList, HttpStatus.OK);
		return re;
	}

	@PostMapping("/activityInsertImpl")
	public String activityInsertImpl(@RequestParam("account") String account, @RequestParam("actName") String actName,
			@RequestParam("actCost") String actCost, @RequestParam("DateStart") String DateStart,
			@RequestParam("DateEnd") String DateEnd, @RequestParam("TimeStart") String TimeStart,
			@RequestParam("TimeEnd") String TimeEnd, @RequestParam("place") String place,
			@RequestParam("actMaxNum") String actMaxNum, @RequestParam("actIntroduce") String actIntroduce,
			@RequestParam("actPicture") MultipartFile multipartfile, HttpServletRequest request)
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
		if (b) {
			System.out.println(true);
		} else {
			System.out.println(false);
		}

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
}
