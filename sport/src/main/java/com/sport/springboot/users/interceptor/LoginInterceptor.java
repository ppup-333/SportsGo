package com.sport.springboot.users.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		Object user = session.getAttribute("account");
		if(user == null) {
			response.sendRedirect("/sport");
			System.out.println("未登入");
			return false;
		}
		System.out.println("已登入");
		return true;
	}
}
