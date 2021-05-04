package com.sport.springboot.course_act.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.course_act.model.EcpayOrderBean;

public interface EcpayOrderRepository extends JpaRepository<EcpayOrderBean,Integer>{

}
