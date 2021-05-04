package com.sport.springboot.course_act.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.course_act.model.CourseOrderBean;
import com.sport.springboot.course_act.model.EcpayOrderBean;
import com.sport.springboot.course_act.repository.EcpayOrderRepository;

import ecpay.payment.integration.domain.AioCheckOutALL;

@Service
public class EcpayOrderService {

	@Autowired
	private EcpayOrderRepository Ecpaydao;
	
	@Autowired
	private CourseOrderService courseorderservice;
	
	public AioCheckOutALL insertEcpayCourseOrder(String orderId,String courseId,String itemName,String totalAmount,String TradeDesc) {
		EcpayOrderBean ecpay=new EcpayOrderBean();
		String ReturnURL="http://localhost:8012/springEcpay/ecpayReturn";
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		Date date = new Date();
        String orderDate=dateFormat.format(date);
        String d=orderDate.split(" ")[0];
        String t=orderDate.split(" ")[1];
        String[] d1=d.split("/");
        String[] d2=t.split(":");
        String context="";
        for(int i=1;i<d1.length;i++) {
        	context+=d1[i];
        }
        for(int i=0;i<d2.length;i++) {
        	context+=d2[i];
        }
        String MerchantTradeNo=orderId+context;
        TradeDesc+="_courseApply";
        System.out.println(MerchantTradeNo);
        int id=Integer.parseInt(orderId);
        ecpay.setMerchantTradeNo(MerchantTradeNo);
        ecpay.setMerchantTradeDate(orderDate);
        ecpay.setItemName(itemName);
        int amount = Integer.parseInt(totalAmount);
        ecpay.setTotalAmount(amount);
        ecpay.setTradeDesc(TradeDesc);
        ecpay.setReturnURL(ReturnURL);
        ecpay.setCourseOrderId(id);
//        Optional<CourseOrderBean> courseOrder=courseorderservice.selectOneOrder(id);
//        CourseOrderBean courseorder=courseOrder.get();
//        ecpay.setCourseOrder(courseorder);
        Ecpaydao.save(ecpay);
        
        AioCheckOutALL atm=new AioCheckOutALL();
		atm.setTotalAmount(totalAmount);
		atm.setItemName(itemName);
		atm.setMerchantTradeNo(MerchantTradeNo);
		atm.setMerchantTradeDate(orderDate);
		atm.setTradeDesc(TradeDesc);
		atm.setReturnURL(ReturnURL);
		System.out.println(TradeDesc);
        return atm;
	}
}
