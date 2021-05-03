package com.sport.springboot.users.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sport.springboot.users.model.UserAuthList;
import com.sport.springboot.users.model.UserCity;
import com.sport.springboot.users.model.UserDistrict;
import com.sport.springboot.users.model.Users;
import com.sport.springboot.users.service.UserAuthListService;
import com.sport.springboot.users.service.UserAuthService;
import com.sport.springboot.users.service.UserCityService;
import com.sport.springboot.users.service.UserDistrictService;
import com.sport.springboot.users.service.UserStatusService;
import com.sport.springboot.users.service.UsersService;
import com.sport.springboot.users.validate.AdminLoginValidator;
import com.sport.springboot.users.validate.LoginValidator;
import com.sport.springboot.users.validate.UserUpdateValidator;
import com.sport.springboot.users.validate.UserValidator;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserDistrictService userDistrictService;

	@Autowired
	UserCityService userCityService;

	@Autowired
	UsersService usersService;

	@Autowired
	UserStatusService userStatusService;

	@Autowired
	UserAuthService userAuthService;

	@Autowired
	UserAuthListService userAuthListService;

	@GetMapping(value = "/RegisterEdit")
	public String registerEdit(Model model) {
		Users users = new Users();
		users.setAccount("test1001");
		users.setPassword("test1001");
		users.setDbChkPwd("test1001");
		users.setName("測試帳號1001");
		users.setId("A123456789");
		users.setBirthday("04/13/2021");
		users.setEmail("test1001@gmail.com");
		users.setAddress("大安區信義路二段1號1樓");
		users.setTel("0223456789");

		users.setGender("M");

		model.addAttribute("users", users);
		return "users/RegisterEdit";
	}

	@GetMapping(value = "/Login")
	public String userLogin(Model model, HttpSession session) {
		Users users = new Users();
		model.addAttribute("loginPage", users);

		if (session.getAttribute("account") != null) {
			return "users/LoginHomePage";
		}

		return "users/Login";
	}

//	@GetMapping(value = "/AdminLogin")
//	public String adminLogin(Model model) {
//		Users users = new Users();
//		model.addAttribute("adminLogin", users);
//		return "AdminLogin";
//	}

	@PostMapping(value = "/chkAccount")
	public @ResponseBody Map<String, String> getChkAccount(@RequestParam(value = "account") String account) {

		System.out.println("account = " + account.toString());
		boolean b = usersService.getChkAccount(account);
		Map<String, String> map = new HashMap<>();
//		System.out.println(usersService.getChkAccount(account));
//		System.out.println("b =" + b);
		if (b) {
			map.put("result", "true");
		} else {
			map.put("result", "false");
		}

//		System.out.println("mpa1=" + map);
		return map;

	}

	@PostMapping(value = "/getDistrict")
	public @ResponseBody List<Map<String, Object>> getDistrict(String cityCode, Model model) {

		List<UserDistrict> districtList = userDistrictService.getAllDistrict();
		List<Map<String, Object>> districtList1 = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < districtList.size(); i++) {
			UserDistrict userDistrict = districtList.get(i);
			if (cityCode.equals(userDistrict.getCityCode().getCityCode())) {

				Map<String, Object> temp = new HashMap<>();
				temp.put("userDistrictCode", userDistrict.getUserDistrictCode());
				temp.put("district", userDistrict.getDistrict());
				districtList1.add(temp);

				System.out.println("districtList1111 = " + districtList.get(i).getDistrict());
				model.addAttribute("districtList", districtList1);

			}
		}
		System.out.println("city = " + cityCode);
		System.out.println("districtList = " + districtList.get(0).getDistrict());
		return districtList1;

	}

	@PostMapping(value = "/RegisterEdit")
	public String addUser(@ModelAttribute("users") Users users, BindingResult result, HttpServletRequest request) {
		// 格式驗證方法start
		UserValidator validator = new UserValidator();
		validator.validate(users, result);
		if (result.hasErrors()) {
			return "users/RegisterEdit";
		}
		// 格式驗證方法end

		String userAct = users.getAccount();
		List<Users> sqlUserAct = usersService.userLogin(userAct);
		System.out.println("資料庫回傳List大小=" + sqlUserAct.size() + ", 用戶輸入帳號= " + userAct);

		if (sqlUserAct.size() != 0) {
			result.rejectValue("account", "", "帳號已被使用");
			return "users/RegisterEdit";
		}

		// 使用者密碼加密satrt
		String userPwd = users.getPassword(); // 註冊密碼
		BCryptPasswordEncoder BCrypt = new BCryptPasswordEncoder();
		String encPwd = BCrypt.encode(userPwd);
		System.out.println("註冊加密=" + encPwd);

		boolean b = BCrypt.matches(userPwd, encPwd);
		System.out.println("註冊比對=" + b);
		// 使用者密碼加密end

		users.setPassword(encPwd);

//		String districtCode = users.getCityCode().getCityCode();
//		List<UserDistrict> districtList = userDistrictService.getAllDistrict();
//		List<String> districtList1 = new ArrayList<String>();
//		for (int i = 0; i < districtList.size(); i++) {
//			if (districtCode == districtList.get(i).getCityCode().getCityCode()) {
//				districtList1.add(districtList.get(i).getDistrict());
//				System.out.println("districtList1 = " + districtList.get(i).getDistrict());
//				model.addAttribute("districtList", districtList1);
//
//			}
//		}
//		System.out.println("city = " + districtCode);
//		System.out.println("districtList = " + districtList.get(0).getDistrict());
//
		if ("".equals(users.getMobile())) {
			users.setMobile(null);
		}
		if ("".equals(users.getTel())) {
			users.setTel(null);
		}
		users.setStatusCode(userStatusService.get("01"));
		users.setVer(Timestamp.valueOf(LocalDateTime.now()));

		UserCity userCity = userCityService.getCity(users.getCityCode().getCityCode());
		users.setCityCode(userCity);
		UserDistrict userDistrict = userDistrictService.getDistrict(users.getUserDistrictCode().getUserDistrictCode());
		users.setUserDistrictCode(userDistrict);

		UUID uuid = UUID.randomUUID();
		String code = uuid.toString().toUpperCase().replaceAll("-", "");
		;
		UserAuthList userAuthList = new UserAuthList();
		userAuthList.setUserAuthListOid(code);
		userAuthList.setUsers(users);
		userAuthList.setAuthCode(userAuthService.get("01"));
		userAuthList.setVer(Timestamp.valueOf(LocalDateTime.now()));
//		
		try {

			usersService.save(users);
			userAuthListService.save(userAuthList);
//			if ("".equals(account) || account == null) {
//				usersService.save(users);
//
//			} else {
//				result.rejectValue("account", "", "此帳號已經被使用");
//				return "RegisterEdit";
//			}

		} catch (Exception ex) {

			System.out.println(ex.getClass().getName() + ", ex.getMessage()=" + ex.getMessage());
			result.rejectValue("id", "", "此證號已經註冊過");
			result.rejectValue("email", "", "此信箱已經被使用");
			return "users/RegisterEdit";
		}

		return "redirect:/user/Login";

	}

	@ModelAttribute
	public void commonData(Model model) {
		Map<String, String> genderMap = new HashMap<>();
		genderMap.put("M", "男");
		genderMap.put("F", "女");
		model.addAttribute("genderMap", genderMap);

		List<UserCity> cityList = userCityService.getAllCity();
		model.addAttribute("cityList", cityList);
	}

	@PostMapping(value = "/Login")
	public String chkUserLogin(@ModelAttribute("loginPage") Users users, BindingResult result,
			@RequestParam(value = "account") String account, @RequestParam(value = "password") String password,
			HttpSession session) {

		LoginValidator validator = new LoginValidator();
		validator.validate(users, result);
		if (result.hasErrors()) {
			return "users/Login";
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
				result.rejectValue("password", "", "帳號或密碼不正確");
				return "users/Login";
			}

		} catch (Exception ex) {

			result.rejectValue("password", "", "帳號或密碼不正確");
			return "users/Login";
		}

		session.setAttribute("account", account);
		System.out.println("session1=" + session.getAttribute("account"));
		return "users/LoginHomePage";

	}

//	@PostMapping(value = "/AdminLogin")
//	public String chkAdminLogin(@ModelAttribute("adminLogin") Users users, BindingResult result,
//			@RequestParam(value = "account") String account, @RequestParam(value = "password") String password,
//			HttpSession session) {
//
//		AdminLoginValidator validator = new AdminLoginValidator();
//		validator.validate(users, result);
//		if (result.hasErrors()) {
//			return "AdminLogin";
//		}
//
//		String userAct = users.getAccount();
//		List<UserAuthList> sqlUserAct = userAuthListService.chkUserAuth(userAct);
//		if (sqlUserAct.size() == 0) {
//			result.rejectValue("password", "", "帳號或密碼錯誤或無此權限");
//			return "AdminLogin";
//		}
//
//		try {
//
//			String userAccount1 = users.getAccount();
//			String userPwd1 = users.getPassword();
//			System.out.println("使用者輸入帳號 = " + userAccount1);
//			System.out.println("使用者輸入密碼 = " + userPwd1);
//
//			Users userAccount = usersService.get(account);
//			String userPwd = userAccount.getPassword();
//			System.out.println("資料庫帳號 = " + account);
//			System.out.println("資料庫密碼 = " + userPwd);
//
//			BCryptPasswordEncoder BCrypt = new BCryptPasswordEncoder();
//			boolean b = BCrypt.matches(userPwd1, userPwd);
//			System.out.println("登入比對:" + b);
//
//			if (b == false) {
//				result.rejectValue("password", "", "帳號或密碼錯誤或無此權限");
//				return "AdminLogin";
//			}
//
//		} catch (Exception ex) {
//
//			result.rejectValue("password", "", "帳號或密碼錯誤或無此權限");
//			return "AdminLogin";
//		}
//
//		session.setAttribute("account", account);
////		System.out.println("session1=" + session.getAttribute("account"));
//		return "AdminHomePage";
//
//	}

	@PostMapping(value = "/Logout")
	public String logout(HttpSession session) {
//		System.out.println("session2=" + session.getAttribute("account"));
		session.invalidate();
//		session.setAttribute("account", null);
//		System.out.println("session2=" + session.getAttribute("account"));
		return "redirect:/user_Login";

	}

	@GetMapping(value = "/userResult")
	public String resultUser(HttpSession session, Model model) {
//		System.out.println("==========test==========");

		String userAct = session.getAttribute("account").toString();
		Users userData = usersService.get(userAct);
		model.addAttribute("user", userData);

		UserCity userDataCity = userCityService.getCity(userData.getCityCode().getCityCode());
		model.addAttribute("userCity", userDataCity);
//		System.out.println("==========test==========" + userDataCity.getCity());

		UserDistrict userDataDistrict = userDistrictService
				.getDistrict(userData.getUserDistrictCode().getUserDistrictCode());
		model.addAttribute("userDistrict", userDataDistrict);
//		System.out.println("user = " + usersService.get(userAct));
		return "users/UserResult";

	}

	@GetMapping(value = "/loginHomePage")
	public String userLoginHomePage() {
		return "users/LoginHomePage";

	}

	@GetMapping(value = "/userUpdate")
	public String userUpdate( Model model, HttpSession session) {
//		System.out.println("test==============================================" + account);
		String userAct = session.getAttribute("account").toString();
		Users userData = usersService.get(userAct);
		model.addAttribute(userData);

//		System.out.println("====" + userData.getCityCode().getCity());
//		System.out.println("====" + userData.getUserDistrictCode().getDistrict());

		return "users/UserUpdate";

	}

	@PostMapping(value = "/userUpdate")
	public String userUpdateSave( @ModelAttribute("users") Users users,
			BindingResult result, HttpServletRequest request, HttpSession session) {

		UserUpdateValidator validator = new UserUpdateValidator();
		validator.validate(users, result);
		if (result.hasErrors()) {
			return "users/UserUpdate";
		}

		
		
//		Users userData = users;
		
		
//		System.out.println("====2" + userData.getPassword());
		String userAct = session.getAttribute("account").toString();
		Users userData = usersService.get(userAct);
		users.setPassword(userData.getPassword());
//		users.setPassword(userData.getPassword());

		users.setStatusCode(userStatusService.get("01"));
		users.setVer(Timestamp.valueOf(LocalDateTime.now()));

		if ("".equals(users.getMobile())) {
			users.setMobile(null);
		}
		if ("".equals(users.getTel())) {
			users.setTel(null);
		}
		UserCity userCity = userCityService.getCity(users.getCityCode().getCityCode());
		users.setCityCode(userCity);
		UserDistrict userDistrict = userDistrictService.getDistrict(users.getUserDistrictCode().getUserDistrictCode());
		users.setUserDistrictCode(userDistrict);

		usersService.save(users);
		return "redirect:/user/loginHomePage";

	}

}
