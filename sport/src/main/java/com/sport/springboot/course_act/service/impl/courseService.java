package com.sport.springboot.course_act.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sport.springboot.course_act.model.CATime;
import com.sport.springboot.course_act.model.CourseOrderBean;
import com.sport.springboot.course_act.model.courseBean;
import com.sport.springboot.course_act.repository.courseRepository;
import com.sport.springboot.field.model.FieldActOrder;
import com.sport.springboot.field.service.impl.FieldActOrderServiceImpl;


@Service
public class courseService  {

	@Autowired
	private courseRepository coursedao;
	@Autowired
	private CATimeService catimeservice;
	@Autowired 
	private teacherService teacherservice;
	@Autowired
	private CourseOrderService courseorderservice;
	@Autowired
	FieldActOrderServiceImpl fieldActOrderService;
	
	public void updateStudentCurrent(int courseId) {
		Optional<courseBean> courseBean=coursedao.findById(courseId);
		courseBean course=courseBean.get();
		List<CourseOrderBean> courseOrderList = courseorderservice.selectOrder(courseId);
		int studentCurrent=0;
		for(int i=0;i<courseOrderList.size();i++) {
			int payState=courseOrderList.get(i).getPayState();
			if(payState==1) {
				studentCurrent++;
			}			
		}
		course.setStudentCurrentNum(studentCurrent);
		System.out.println("目前學生人數:"+studentCurrent);
		coursedao.save(course);
	} 
	
	public Optional<courseBean> selectId(int id) {
		return coursedao.findById(id);
	}
	
	public List<courseBean> selectCourse(String courseName) {
		return coursedao.selectCourse(courseName);
	
	}
	
	public List<courseBean> selectAllCourse(){
		return coursedao.findAll();
	}
	
	public List<List<String>> insertCourse2(int courseId,
									int courseCost,
									int studentMaxNum,
									int freq,
									int teacherId,
									String courseKind,
									String courseIntroduce,									
									String from,
									String place
									) {
		List<List<String>> resultList=new ArrayList<>();
		List<String> tempList=new ArrayList<>();
		courseBean course=coursedao.getOne(courseId);
		course.setCourseCost(courseCost);
		course.setCourseKind(courseKind.split(" ")[0]);
		course.setStudentMaxNum(studentMaxNum);
		course.setCourseIntroduce(courseIntroduce);
		course.setTeacherId(teacherId);
		String type="course";
		String courseTimeStart = (courseKind.split(" ")[1]).split("~")[0];
		String courseTimeEnd = (courseKind.split(" ")[1]).split("~")[1];
		boolean result=catimeservice.checkTimeCanRentOrNot(from, courseTimeStart, courseTimeEnd, freq, place, type, course, null);

		return resultList;
	}
	
	
	public boolean insertCourse(courseBean course,
								String DateStart,
								int freq,
								int teacherId,
								String TimeStart,
								String TimeEnd,
								String place,
								String type) {
		
		boolean result=catimeservice.checkTimeCanRentOrNot(DateStart, TimeStart, TimeEnd, freq,place,type,course,null);	
		
//		boolean cps=coursePlaceService.checkPlaceCanRentOrNot(course);
//		int temps;	
		try {
			if(result) {			
					coursedao.save(course);
				
				return true;
			}else {
				return false;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	@Transactional
	public boolean changeCATime(courseBean course) {
		boolean b=catimeservice.deleteTimeByCourse(course);	
		if(b) {
			return true;
		}else {
			return false;
		}
	}
	
	@Transactional
	public boolean updateCourse(int courseId,
								int courseCost,
								String courseKind,
								int studentMaxNum,
								String courseIntroduce,
								int freq,
								String from,
								int teacherId,
								String place
									) {
		courseBean course=coursedao.getOne(courseId);
		course.setCourseCost(courseCost);
		course.setCourseKind(courseKind.split(" ")[0]);
		course.setStudentMaxNum(studentMaxNum);
		course.setCourseIntroduce(courseIntroduce);
		course.setTeacherId(teacherId);
		String type="course";
		String courseTimeStart = (courseKind.split(" ")[1]).split("~")[0];
		String courseTimeEnd = (courseKind.split(" ")[1]).split("~")[1];
		//刪除原本CATime 時間		
		boolean b=catimeservice.deleteTimeByCourse(course);			
	
			//場地訂單換狀態
			boolean orderStatus = fieldActOrderService.changeOrderStatusByCourseId(courseId);
			if(orderStatus) {
				System.out.println("changeOrderStatusByCourseId成功");
				//重新新增時間與更改場地狀態
				boolean result=catimeservice.checkTimeCanRentOrNot(from, courseTimeStart, courseTimeEnd, freq, place, type, course, null);
				try {
					if(result) {			
						coursedao.save(course);					
						return true;
					}else {
						return false;
					}
					
				}catch(Exception e) {
					e.printStackTrace();
					return false;
				}
			
			}

		
		return false;
	}
	//放棄刪除
	/*
	@Transactional
	public boolean deleteCourse(int courseId) {
		try {
			courseBean course=coursedao.getOne(courseId);
			boolean orderStatus = fieldActOrderService.deleteFieldActOrderByCourse(course);
			if(orderStatus) {
				System.out.println("場地刪除完成");
				boolean b=catimeservice.deleteTimeByCourse(course);	
			
				if(b) {
					System.out.println("時間刪除完成");
					System.out.println("開始刪除課程");
					coursedao.deleteCourse(courseId);
					return true;
				}else {
					
					System.out.println("時間刪除失敗");
					return false;
				}
			}else {
				System.out.println("場地換狀態失敗");
				return false;
			}	
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	
	}*/
	
}
