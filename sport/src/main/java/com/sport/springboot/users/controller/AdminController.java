package com.sport.springboot.users.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sport.springboot.users.model.UserAuthList;
import com.sport.springboot.users.model.Users;
import com.sport.springboot.users.service.UserAuthListService;
import com.sport.springboot.users.service.UsersService;
import com.sport.springboot.users.validate.AdminLoginValidator;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	UsersService usersService;

	@Autowired
	UserAuthListService userAuthListService;

	@GetMapping(value = "/AdminLogin")
	public String adminLogin(Model model) {
		Users users = new Users();
		model.addAttribute("adminLogin", users);
		return "users/AdminLogin";
	}

	@PostMapping(value = "/AdminLogin")
	public String chkAdminLogin(@ModelAttribute("adminLogin") Users users, BindingResult result,
			@RequestParam(value = "account") String account, @RequestParam(value = "password") String password,
			HttpSession session) {

		AdminLoginValidator validator = new AdminLoginValidator();
		validator.validate(users, result);
		if (result.hasErrors()) {
			return "users/AdminLogin";
		}

		String userAct = users.getAccount();
		List<UserAuthList> sqlUserAct = userAuthListService.chkUserAuth(userAct);
		if (sqlUserAct.size() == 0) {
			result.rejectValue("password", "", "帳號或密碼錯誤或無此權限");
			return "users/AdminLogin";
		}

		try {

			String userAccount1 = users.getAccount();
			String userPwd1 = users.getPassword();
			System.out.println("使用者輸入帳號 = " + userAccount1);
			System.out.println("使用者輸入密碼 = " + userPwd1);

			Users userAccount = usersService.get(account);
			String userPwd = userAccount.getPassword();
			System.out.println("資料庫帳號 = " + account);
			System.out.println("資料庫密碼 = " + userPwd);

			BCryptPasswordEncoder BCrypt = new BCryptPasswordEncoder();
			boolean b = BCrypt.matches(userPwd1, userPwd);
			System.out.println("登入比對:" + b);

			if (b == false) {
				result.rejectValue("password", "", "帳號或密碼錯誤或無此權限");
				return "users/AdminLogin";
			}

		} catch (Exception ex) {

			result.rejectValue("password", "", "帳號或密碼錯誤或無此權限");
			return "AdminLogin";
		}

		session.setAttribute("account", account);
//		System.out.println("session1=" + session.getAttribute("account"));
		return "users/AdminHomePage";

	}

	@PostMapping(value = "/Logout")
	public String logout(HttpSession session) {
		System.out.println("session2=" + session.getAttribute("account"));
		session.invalidate();
//		session.setAttribute("account", null);
//		System.out.println("session2=" + session.getAttribute("account"));
		return "redirect:/user_Login";

	}

}
