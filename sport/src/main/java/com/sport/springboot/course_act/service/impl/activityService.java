package com.sport.springboot.course_act.service.impl;


import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sport.springboot.course_act.model.activityBean;
import com.sport.springboot.course_act.repository.activityRepository;

@Service
public class activityService {

	@Autowired
	private activityRepository activityDao;
	@Autowired
	private CATimeService catimeservice;

	
	public Optional<activityBean> selectId(int id) {
		return activityDao.findById(id);
	} 
	
	public boolean insertActivity(activityBean activitybean,
									String DateStart,
									String DateEnd,
									String TimeStart,
									String TimeEnd,
									String place,
									String type) {
	
		int startMonth=Integer.parseInt(DateStart.substring(5, 7));
		int endMonth=Integer.parseInt(DateEnd.substring(5, 7));
		int ds,de,freq=0,Date=0;
		ds=Integer.parseInt(DateStart.substring(8));
		de=Integer.parseInt(DateEnd.substring(8));
		if(startMonth==endMonth) {
			freq=de-ds;
		}else {
			if(startMonth==1||startMonth==3||startMonth==5||startMonth==7||startMonth==8||startMonth==10||startMonth==12) {
				Date=31;			
			}else {				
				if(startMonth==2) {	
					Date=28;
				}else {
					Date=30;					
				}	
			}
			ds=Date-ds;
			freq=ds+de;			
		}
		
		
		System.out.println("freq is:"+freq);
		boolean timeCheck=catimeservice.checkTimeCanRentOrNot(DateStart, TimeStart, TimeEnd, freq, place,type,null,activitybean);
		
		try {
			if(timeCheck) {	
			System.out.println(activitybean.getActName());
			System.out.println("account:"+activitybean.getAccount());
			System.out.println("cost"+activitybean.getActCost());
			activityDao.save(activitybean);
			
			return true;
			}else {
				return false;
			}
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}
	
	public List<activityBean> selectAllActivity(){
		return activityDao.findAll();
	}
	
	public Optional<activityBean> selectOneActivity(int id){
		return activityDao.findById(id);
	}
	
	public activityBean getOne(int actId) {
		return activityDao.getOne(actId);
	}

	@Transactional
	public boolean updateActivity(activityBean act, String dateStart, String dateEnd, String timeStart, String timeEnd,
									String place, String type) {
		int startMonth=Integer.parseInt(dateStart.substring(5, 7));
		int endMonth=Integer.parseInt(dateEnd.substring(5, 7));
		int ds,de,freq=0,Date=0;
		ds=Integer.parseInt(dateStart.substring(8));
		de=Integer.parseInt(dateEnd.substring(8));
		if(startMonth==endMonth) {
			freq=de-ds;
		}else {
			if(startMonth==1||startMonth==3||startMonth==5||startMonth==7||startMonth==8||startMonth==10||startMonth==12) {
				Date=31;			
			}else {				
				if(startMonth==2) {	
					Date=28;
				}else {
					Date=30;					
				}	
			}
			ds=Date-ds;
			freq=ds+de;			
		}
		
		boolean b=catimeservice.deleteTimeByAct(act);
		if(b) {
			boolean timeCheck=catimeservice.checkTimeCanRentOrNot(dateStart, timeStart, timeEnd, freq, place,type,null,act);
			try {
				if(timeCheck) {	
				activityDao.save(act);
				System.out.println("活動更新成功");
				return true;
				}else {
					System.out.println("活動更新失敗-時間檢查重複");
					return false;
				}
			}catch(Exception e) {
				e.printStackTrace();
				System.out.println("活動更新失敗-不可預期錯誤");
				return false;
			}
		}else {
			System.out.println("活動更新失敗-刪除失敗");
			return false;
		}
		
		
	}
	
}
