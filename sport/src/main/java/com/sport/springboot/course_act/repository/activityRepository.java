package com.sport.springboot.course_act.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.course_act.model.activityBean;

public interface activityRepository extends JpaRepository<activityBean,Integer> {

}
