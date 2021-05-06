//package com.sport.springboot.users.config;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//
//import com.sport.springboot.users.interceptor.LoginInterceptor;
//
//@Configuration
//public class LoginInterceptorWebMvcConfig implements WebMvcConfigurer {
//
//	@Autowired
//	private LoginInterceptor loginInterceptor;
//
//	@Override
//	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(loginInterceptor).addPathPatterns("/**").excludePathPatterns("/user/RegisterEdit",
//				"/user/Login", "/admin/AdminLogin", "/user/chkAccount", "/user/getDistrict", "/user/ForgetPwd",
//				"/user/UpdatePwd", "/user/ChkEmail", "/user/verifyEmail", "/", "/css/**", "/images/**");
//	}
//
//}
