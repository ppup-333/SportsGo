package com.sport.springboot.users.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sport.springboot.users.model.UserAuthList;
import com.sport.springboot.users.model.UserCity;
import com.sport.springboot.users.model.UserDistrict;
import com.sport.springboot.users.model.UserStatus;
import com.sport.springboot.users.model.Users;
import com.sport.springboot.users.service.UserAuthListService;
import com.sport.springboot.users.service.UserCityService;
import com.sport.springboot.users.service.UserDistrictService;
import com.sport.springboot.users.service.UserStatusService;
import com.sport.springboot.users.service.UsersService;
import com.sport.springboot.users.validate.AdminLoginValidator;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	UsersService usersService;

	@Autowired
	UserAuthListService userAuthListService;

	@Autowired
	UserDistrictService userDistrictService;

	@Autowired
	UserCityService userCityService;

	@Autowired
	UserStatusService userStatusService;

	@GetMapping(value = "/AdminLogin")
	public String adminLogin(Model model, HttpSession session) {
		Users users = new Users();
		model.addAttribute("adminLogin", users);

		if (session.getAttribute("account") != null) {
			return "users/AdminHomePage";
		}

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
			return "users/AdminLogin";
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
		return "redirect:/";

	}

	@GetMapping(value = "/adminUserHomePage")
	public String adminUserHomePage() {
		return "users/AdminUserHomePage";

	}

	@GetMapping(value = "/resultAllUsers")
	public String adminResultUsers(Model model) {
		Users users = new Users();
		model.addAttribute("adminResultUsers", users);
		List<UserCity> cityList = userCityService.getAllCity();
		model.addAttribute("cityList", cityList);
		List<UserStatus> statusList = userStatusService.getAllStatus();
		model.addAttribute("statusList", statusList);
		return "users/AdminResultUsers";

	}
	@GetMapping(value = "/resultAllAdmins")
	public String adminResultAdmin(Model model) {
		Users users = new Users();
		UserAuthList userAuth = new UserAuthList();
		model.addAttribute("users", users);
		return "users/AdminResultAdmin";
		
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
//		System.out.println("city = " + cityCode);
//		System.out.println("districtList = " + districtList.get(0).getDistrict());
		return districtList1;

	}

	@PostMapping(value = "/ResultData")
	public @ResponseBody List<Map<String, Object>> adminResult(@RequestParam(value = "account") String account,
			@RequestParam(value = "name") String name, @RequestParam(value = "id") String id,
			@RequestParam(value = "cityCode") String cityCode,
			@RequestParam(value = "userDistrictCode") Integer userDistrictCode,
			@RequestParam(value = "address") String address, @RequestParam(value = "statusCode") String statusCode) {

		Users users = new Users();
		System.out.println("++++++++" + statusCode);

		users.setAccount(account);
		users.setName(name);
		users.setId(id);
		users.setCityCode(userCityService.get(cityCode));
		users.setUserDistrictCode(userDistrictService.get(userDistrictCode));
		users.setAddress(address);
		users.setStatusCode(userStatusService.get(statusCode));

//		System.out.println("++++++++++++++++" + cityCode);
		List<Users> adminRs = usersService.adminResult(users);
		List<Map<String, Object>> temp = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < adminRs.size(); i++) {
			Map<String, Object> temp1 = new HashMap<>();
			temp1.put("account", adminRs.get(i).getAccount());
			temp1.put("name", adminRs.get(i).getName());
			temp1.put("id", adminRs.get(i).getId());
			temp1.put("gender", adminRs.get(i).getGender());
			temp1.put("birthday", adminRs.get(i).getBirthday());
			temp1.put("email", adminRs.get(i).getEmail());
			temp1.put("city", adminRs.get(i).getCityCode().getCity());
			temp1.put("district", adminRs.get(i).getUserDistrictCode().getDistrict());
			temp1.put("address", adminRs.get(i).getAddress());
			temp1.put("tel", adminRs.get(i).getTel());
			temp1.put("mobile", adminRs.get(i).getMobile());
			temp1.put("status", adminRs.get(i).getStatusCode().getStatus());
			temp1.put("ver", adminRs.get(i).getVer());
			temp.add(temp1);
		}

		return temp;
	}

	@PostMapping(value = "/UpdateStatus")
	public String updateStatus(@RequestParam(value = "selectAct") String account,
			@RequestParam(value = "selectStatus") String selectStatus) {

		System.out.println("******************" + account + selectStatus);
		
		Users userData = usersService.get(account);
		UserStatus temp = userStatusService.get(selectStatus);
		userData.setStatusCode(temp);
		
		usersService.save(userData);
		
		return "redirect:/admin/resultAllUsers";

	}

//	@PostMapping(value = "/ResultData")
//	public String adminResult(@ModelAttribute("adminResultUsers") Users users,
//			@RequestParam(value = "adminSelect") String selectValue,
//			@RequestParam(value = "adminInput") String adminInput, BindingResult result) {
//
//		System.out.println("Select的值 = " + selectValue);
//
//
//		if (selectValue.equals("01")) {
//
//			String inputAct = users.getAdminInput();
//			System.out.println("輸入的查詢關鍵字 = " + inputAct);
//			List<Users> actResult = usersService.adminResultAct(inputAct);
//			System.out.println("共有幾筆資料 = " + actResult.size());
//
//			return "AdminResultUsers";
//		} else if (selectValue.equals("02")) {
//
//			String inputName = users.getAdminInput();
//			System.out.println("輸入的查詢關鍵字 = " + inputName);
//			List<Users> nameResult = usersService.adminResultName(inputName);
//			System.out.println("共有幾筆資料 = " + nameResult.size());
//
//			return "AdminResultUsers";
//		} else if (selectValue.equals("03")) {
//
//			String inputId = users.getAdminInput();
//			System.out.println("輸入的查詢關鍵字 = " + inputId);
//			List<Users> idResult = usersService.adminResultId(inputId);
//			System.out.println("共有幾筆資料 = " + idResult.size());
//
//			return "AdminResultUsers";
//		}
//
//		result.rejectValue("account", "", "請選擇搜尋類別");
//		return "AdminResultUsers";
//
//	}

//	@GetMapping(value = "/resultAllUsers")
//	public String resultAllUsers(Model model, Users users) {
//		// 抓全部會員資料
//		List<Users> allUsersData = usersService.getAllUsers();
//		model.addAttribute("users", allUsersData);
//
//		// 抓全部會員資料的城市
//		List<UserCity> allCity = new ArrayList<UserCity>();
//		for (int i = 0; i < allUsersData.size(); i++) {
//			allCity.add(userCityService.getCity(allUsersData.get(i).getCityCode().getCityCode()));
//		}
//		model.addAttribute("userCity", allCity);
//
//		// 抓全部會員資料的鄉鎮市區
//		List<UserDistrict> allDistrict = new ArrayList<UserDistrict>();
//		for (int i = 0; i < allUsersData.size(); i++) {
//			allDistrict.add(
//					userDistrictService.getDistrict(allUsersData.get(i).getUserDistrictCode().getUserDistrictCode()));
//		}
//		model.addAttribute("userDistrict", allDistrict);
//		
//		// 抓全部會員資料的狀態
//		List<UserStatus> allStatus = new ArrayList<UserStatus>();
//		for (int i = 0; i < allUsersData.size(); i++) {
//			allStatus.add(userStatusService.get(allUsersData.get(i).getStatusCode().getStatusCode()));
//		}
//		model.addAttribute("userStatus", allStatus);
//
////		System.out.println("----------" + temp);
////		System.out.println("----------" + userCity);
//
////		System.out.println(allUsersData.get(0).getCityCode().getCity());
//		return "AdminResultAllUsers";
//
//	}

//	@GetMapping(value = "/resultAllAdmins")
//	public String resultAllAdmins(Model model) {
//		return null;
//
//	}
}
