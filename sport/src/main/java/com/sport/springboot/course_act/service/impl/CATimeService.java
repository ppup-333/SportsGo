package com.sport.springboot.course_act.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.course_act.model.CATime;
import com.sport.springboot.course_act.model.activityBean;
import com.sport.springboot.course_act.model.courseBean;
import com.sport.springboot.course_act.repository.CATimeRepository;

@Service
public class CATimeService {

	@Autowired
	private CATimeRepository CATimeDao;
	
	
	public String convertCourseDate(String courseDate) {
		String convertDate="";
		System.out.println(courseDate.substring(8));
		int Date=Integer.parseInt(courseDate.substring(8));
		int month=Integer.parseInt(courseDate.substring(5,7));
		int year=Integer.parseInt(courseDate.substring(0,4));
		
		if(month==1||month==3||month==5||month==7||month==8||month==10||month==12) {
			if(Date>31) {
				if(month>12) {
					year=year+1;
					month=1;
				}else {
					month=month+1;
				}
				Date=Date-31;
			}
		}else {
			
			if(month==2) {
				if(Date>28) {
					month=month+1;
					Date=Date-28;
				}
			}else {
				if(Date>30) {
					month=month+1;
					Date=Date-30;
				}
			}	
		}
		
		if(month<10) {
			convertDate=year+"-0"+month+"-"+Date;
		}else {
			convertDate=year+"-"+month+"-"+Date;
		}
		return convertDate;
	}
	
//	public List<String> checkTimeCanRentOrNot2() {
//		
//	}
	
	public boolean checkTimeCanRentOrNot(String Date,
										String TimeStart,
										String TimeEnd,
										int freq,
										String Place,
										String type,
										courseBean coursebean,
										activityBean activitybean) {
		
		int D;
		List<CATime> timeList=null;
		if("course".equals(type)) {
			Set<CATime> timeSet=null;
			List<CATime> insertList=new ArrayList<>();
			CATime time=null;
			for (int i = 0; i < freq; i++) {
			System.out.println(Date);
			timeList=CATimeDao.checkDate(Date, TimeStart, TimeEnd);
			
			if(timeList.isEmpty()) {
				timeSet=new HashSet<>();
				time=new CATime();
				System.out.println(Date+" "+TimeStart+" "+TimeEnd);
				time.setDate(Date);
				time.setTimeStart(TimeStart);
				time.setTimeEnd(TimeEnd);
				time.setCoursebean(coursebean);
				insertList.add(time);
				timeSet.add(time);	
				coursebean.setTime(timeSet);
				
				//boolean cps=coursePlaceService.save(coursebean);				
				//檢查場地service
//				if(cps) {
//					
//				}else {
//					return false;
//				}
				Iterator<CATime> it=coursebean.getTime().iterator();
				while(it.hasNext()) {
					CATime time1=it.next();
					System.out.println(time1.getDate());
					System.out.println(time1.getTimeStart());
					System.out.println(time1.getTimeEnd());
					    			time1.getFieldId();
					
				}

			}else {
				return false;
			}
			D=Integer.parseInt(Date.substring(8))+7;
			Date=Date.substring(0,8)+D;
			
			Date=convertCourseDate(Date);
		}
			boolean b =insertTime(insertList);
			if(b) {
				coursebean.setTime(timeSet);
			}else {
				return false;
			}
		}else if("activity".equals(type)) {
			Set<CATime> timeSet=null;
			List<CATime> insertList=new ArrayList<>();
			CATime time=null;
			
			for (int i = 0; i <=freq; i++) {
			timeList=CATimeDao.checkDate(Date, TimeStart, TimeEnd);
			System.out.println("timeList is:"+timeList.isEmpty());
			if(timeList.isEmpty()) {
				timeSet=new HashSet<>();
				time=new CATime();
				System.out.println(Date+" "+TimeStart+" "+TimeEnd);
				time.setDate(Date);
				time.setTimeStart(TimeStart);
				time.setTimeEnd(TimeEnd);
				time.setActivitybean(activitybean);
				insertList.add(time);
				timeSet.add(time);				
				//檢查場地service
//				boolean cps=coursePlaceService.checkPlaceCanRentOrNot(courseDate,courseTimeStart,coursePlace);
//				if(cps) {
//					
//				}else {
//					return false;
//				}
			}else {
				return false;
			}
			D=Integer.parseInt(Date.substring(8))+1;
			System.out.println(D);
			Date=Date.substring(0,8)+D;		
			System.out.println(Date);
			Date=convertCourseDate(Date);
		}	
			boolean b =insertTime(insertList);
			if(b) {
				activitybean.setTime(timeSet);
			}else {
				return false;
			}
				
	}
		return true;
	}

	public boolean insertTime(List<CATime> time) {

		try {
			for(int i=0;i<time.size();i++) {
				CATimeDao.save(time.get(i));
			}			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}
	
	public boolean deleteTimeByCourse(courseBean course){
		try {
			 CATimeDao.deleteTimeByCourseId(course.getCourseId());
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
}
