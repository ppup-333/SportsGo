package com.sport.springboot.course_act.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.course_act.model.courseBean;
import com.sport.springboot.course_act.model.teacherBean;
import com.sport.springboot.course_act.repository.teacherRepository;

@Service
public class teacherService {

	@Autowired
	private teacherRepository teacherdao;
	
	public int selectTeacherId(String teacherName) {
		teacherBean teacher=teacherdao.selectTeacherId(teacherName);
		return teacher.getTeacherId();
	}
	
	public Optional<teacherBean> selectTeacher(int teacherId) {
		return teacherdao.findById(teacherId);
	}
	
	public List<teacherBean> selectAllTeacher(){
		return teacherdao.findAll();
	}
	
	public void deleteTeacher(int teacherId) {
		teacherdao.deleteById(teacherId);
	}
	
	public boolean InsertTeacher(teacherBean teacher,String teacherName,int gender,String phone,int salary) {
		
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String hireDate=dateFormat.format(date);
		teacher.setTeacherName(teacherName);
		teacher.setGender(gender);
		teacher.setPhone(phone);
		teacher.setSalary(salary);
		teacher.setHireDate(hireDate);
		try {
			teacherdao.save(teacher);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}

	}
	
	public boolean updateTeacher(int teacherId, teacherBean teacher, String teacherName, int g, String phone, int s) {		
		
	
		try {
			teacherBean teacherbean=teacherdao.getOne(teacherId);
			teacherbean.setTeacherName(teacherName);
			teacherbean.setGender(g);
			teacherbean.setPhone(phone);
			teacherbean.setSalary(s);
			teacherbean.setTeacherPicture(teacher.getTeacherPicture());			
			teacherdao.save(teacherbean);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}
}
