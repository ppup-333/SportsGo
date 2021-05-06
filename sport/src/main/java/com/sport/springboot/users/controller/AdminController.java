package com.sport.springboot.users.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import com.sport.springboot.users.service.UserAuthService;
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

	@Autowired
	UserAuthService userAuthService;

	@GetMapping(value = "/AdminLogin")
	public String adminLogin(Model model, HttpSession session) {
		Users users = new Users();
		model.addAttribute("adminLogin", users);

//		if (session.getAttribute("account") != null) {
//			return "users/AdminHomePage";
//		}

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
//		UserAuthList userAuth = new UserAuthList();
		model.addAttribute("userAuth", users);
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
	public @ResponseBody List<Map<String, Object>> adminResultAllUser(@RequestParam(value = "account") String account,
			@RequestParam(value = "name") String name, @RequestParam(value = "id") String id,
			@RequestParam(value = "cityCode") String cityCode,
			@RequestParam(value = "userDistrictCode") Integer userDistrictCode,
			@RequestParam(value = "address") String address, @RequestParam(value = "statusCode") String statusCode) {

		Users users = new Users();
//		System.out.println("++++++++" + statusCode);

		users.setAccount(account);
		users.setName(name);
		users.setId(id);
		users.setCityCode(userCityService.get(cityCode));
		users.setUserDistrictCode(userDistrictService.get(userDistrictCode));
		users.setAddress(address);
		users.setStatusCode(userStatusService.get(statusCode));

//		System.out.println("++++++++++++++++" + cityCode);
		List<Users> adminRs = usersService.adminResult(users);

		List<Map<String, Object>> adminRsUsersData = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < adminRs.size(); i++) {

			Map<String, Object> temp = new HashMap<>();

			temp.put("account", adminRs.get(i).getAccount());
			temp.put("name", adminRs.get(i).getName());
			temp.put("id", adminRs.get(i).getId());
			temp.put("gender", adminRs.get(i).getGender());
			temp.put("birthday", adminRs.get(i).getBirthday());
			temp.put("email", adminRs.get(i).getEmail());
			temp.put("city", adminRs.get(i).getCityCode().getCity());
			temp.put("district", adminRs.get(i).getUserDistrictCode().getDistrict());
			temp.put("address", adminRs.get(i).getAddress());
			temp.put("tel", adminRs.get(i).getTel());
			temp.put("mobile", adminRs.get(i).getMobile());
			temp.put("status", adminRs.get(i).getStatusCode().getStatus());
			temp.put("ver", adminRs.get(i).getVer());
			adminRsUsersData.add(temp);
		}

		return adminRsUsersData;
	}

	@PostMapping(value = "/UpdateStatus")
	public String updateStatus(@RequestParam(value = "selectAct") String account,
			@RequestParam(value = "selectStatus") String selectStatus) {

//		System.out.println("******************" + account + selectStatus);

		Users userData = usersService.get(account);
		UserStatus updateStatus = userStatusService.get(selectStatus);
		userData.setStatusCode(updateStatus);
		userData.setVer(Timestamp.valueOf(LocalDateTime.now()));

		usersService.save(userData);

		return "redirect:/admin/resultAllUsers";

	}

	@PostMapping(value = "/ResultAdmin")
	public @ResponseBody List<Map<String, Object>> adminResultAllAdmin(
			@RequestParam(value = "account") String account) {

		List<UserAuthList> actAuthData = userAuthListService.chkUserAuth(account);
		List<Map<String, Object>> adminRsAdminData = new ArrayList<Map<String, Object>>();
//		Users users = new Users();

		if (actAuthData.size() == 0) {
			return adminRsAdminData;
		}

//		users.setAccount(actAuthData.get(0).getUsers().getAccount());

		Users temp1 = usersService.get(actAuthData.get(0).getUsers().getAccount());

		List<Users> adminRs = new ArrayList<>();
		adminRs.add(temp1);

//		System.out.println("------" + adminRs.get(0).getName());

//		List<Users> adminRs = usersService.adminResult(users);

//		System.out.println("------" + actAuthData.get(0).getAuthCode().getAuthName());

		for (int i = 0; i < adminRs.size(); i++) {

			Map<String, Object> temp = new HashMap<>();

			temp.put("account", adminRs.get(i).getAccount());
			temp.put("name", adminRs.get(i).getName());
			temp.put("id", adminRs.get(i).getId());
			temp.put("gender", adminRs.get(i).getGender());
			temp.put("birthday", adminRs.get(i).getBirthday());
			temp.put("email", adminRs.get(i).getEmail());
			temp.put("city", adminRs.get(i).getCityCode().getCity());
			temp.put("district", adminRs.get(i).getUserDistrictCode().getDistrict());
			temp.put("address", adminRs.get(i).getAddress());
			temp.put("tel", adminRs.get(i).getTel());
			temp.put("mobile", adminRs.get(i).getMobile());
			temp.put("auth", actAuthData.get(i).getAuthCode().getAuthName());
			temp.put("ver", adminRs.get(i).getVer());
			adminRsAdminData.add(temp);
		}

//		System.out.println("-------------" + actAuthData.get(0).getUsers().getAccount());

		return adminRsAdminData;

	}

	@PostMapping(value = "/AddAdmin")
	public String addAdmin(@RequestParam(value = "inputAct") String account) {
//		boolean pass = usersService.getChkAccount(account);
//		List<UserAuthList> pass1 = userAuthListService.chkUserAuth(account);

//		int i = 0;

//		System.out.println("HELLO" + pass);
//		System.out.println("HELLO" + pass1);
//		if (pass == false || pass1.size() != 0) {
//			return "redirect:/admin/resultAllAdmins";
//		}

		UUID uuid = UUID.randomUUID();
		String code = uuid.toString().toUpperCase().replaceAll("-", "");

		UserAuthList userAuthList = new UserAuthList();
		userAuthList.setUserAuthListOid(code);
		userAuthList.setUsers(usersService.get(account));
		userAuthList.setAuthCode(userAuthService.get("02"));
		userAuthList.setVer(Timestamp.valueOf(LocalDateTime.now()));

		userAuthListService.save(userAuthList);

		return "redirect:/admin/resultAllAdmins";

	}

	@PostMapping(value = "/chkAct")
	public @ResponseBody Map<String, String> getChkAccount(@RequestParam(value = "account") String account) {

//		System.out.println("account = " + account.toString());
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

	@PostMapping(value = "/DeleteAdmin")
	public String deleteAdmin(@RequestParam(value = "selectAct") String account) {
//		List<UserAuthList> temp = userAuthListService.chkUserAuth(account);

//		System.out.println("**********************************" + temp.get(0).getUserAuthListOid());

//		String authListOid = temp.get(0).getUserAuthListOid();
//		System.out.println("**********************************" + authListOid);
//		userAuthListService.delete(authListOid);

		String authCode = "02";
		userAuthListService.deleteAdmin(account, authCode);

		return "redirect:/admin/resultAllAdmins";

	}

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
