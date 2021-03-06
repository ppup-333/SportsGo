package com.sport.springboot.course_act.service.impl;


import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sport.springboot.course_act.model.activityBean;
import com.sport.springboot.course_act.model.courseBean;
import com.sport.springboot.course_act.repository.activityRepository;
import com.sport.springboot.field.service.FieldActOrderService;
import com.sport.springboot.field.service.impl.FieldActOrderServiceImpl;

@Service
public class activityService {

	@Autowired
	private activityRepository activityDao;
	@Autowired
	private CATimeService catimeservice;

	@Autowired
	FieldActOrderServiceImpl fieldActOrderService;
	
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
	public boolean changeCATimeByAct(activityBean activity) {
		boolean b=catimeservice.deleteTimeByAct(activity);
		if(b) {
			return true;
		}else {
			return false;
		}
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
		boolean actStatus=catimeservice.deleteTimeByAct(act);
		if(actStatus) {
			System.out.println("actStatus??????");
		}else {
			System.out.println("actStatus??????");
		}
		
		boolean orderStatus = fieldActOrderService.changeOrderStatusByActId(act.getActId());
			if(orderStatus) {
				boolean timeCheck=catimeservice.checkTimeCanRentOrNot(dateStart, timeStart, timeEnd, freq, place,type,null,act);
				try {
					if(timeCheck) {	
					activityDao.save(act);
					System.out.println("??????????????????");
					return true;
					}else {
						System.out.println("??????????????????-??????????????????");
						return false;
					}
				}catch(Exception e) {
					e.printStackTrace();
					System.out.println("??????????????????-??????????????????");
					return false;
				}
			}else {
				System.out.println("??????????????????-????????????");
				return false;
			}

		
	}
	
}
