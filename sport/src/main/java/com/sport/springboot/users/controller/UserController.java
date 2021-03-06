package com.sport.springboot.users.controller;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sport.springboot.users.model.UserActValidateTemp;
import com.sport.springboot.users.model.UserAuthList;
import com.sport.springboot.users.model.UserCity;
import com.sport.springboot.users.model.UserDistrict;
import com.sport.springboot.users.model.UserStatus;
import com.sport.springboot.users.model.Users;
import com.sport.springboot.users.service.UserActValidateTempService;
import com.sport.springboot.users.service.UserAuthListService;
import com.sport.springboot.users.service.UserAuthService;
import com.sport.springboot.users.service.UserCityService;
import com.sport.springboot.users.service.UserDistrictService;
import com.sport.springboot.users.service.UserStatusService;
import com.sport.springboot.users.service.UsersService;
import com.sport.springboot.users.utils.RandomCode;
import com.sport.springboot.users.validate.LoginValidator;
import com.sport.springboot.users.validate.UserForgetPwdValidate;
import com.sport.springboot.users.validate.UserUpdatePwdValidator;
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

	@Autowired
	UserActValidateTempService userActValidateTempService;

	@Autowired
	JavaMailSender mailSender;

	@GetMapping(value = "/RegisterEdit")
	public String registerEdit(Model model) {
		Users users = new Users();
		users.setAccount("beyond1000");
		users.setPassword("beyond1000");
		users.setDbChkPwd("beyond1000");
		users.setName("?????????");
		users.setId("A161627871");
		users.setBirthday("12/04/1989");
		users.setEmail("beyond780412@gmail.com");
		users.setAddress("???????????????390???3???");
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
			//return "index";
			return "redirect:/";
//			String account = session.getAttribute("account").toString();
//			if (chkStatus(account)) {
//				//////////////////////////////////////////////////////////////////////////////////////
//				return "redirect:/user/ChkEmail";
//			} else {
//			}
		}

		return "users/Login";
	}

	@GetMapping(value = "/ForgetPwd")
	public String forgetPwd(Model model) {
		Users users = new Users();
		model.addAttribute("forgetPwd", users);
		return "users/ForgetPwd";

	}

	@GetMapping(value = "/userUpdatePwd")
	public String userUpdatePwd(Model model, HttpSession session) {
		Users users = new Users();
		String userAct = session.getAttribute("account").toString();
		users.setAccount(userAct);
		model.addAttribute("chkUserUpdatePwd", users);
		return "users/ChkUserUpdatePwd";

	}

	@PostMapping(value = "/chkAccount")
	public @ResponseBody Map<String, String> getChkAccount(@RequestParam(value = "account") String account) {

		boolean pass;
		String chkAct = "(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]{8,16}";
		Map<String, String> map = new HashMap<>();
		if (account.matches(chkAct) == false) {
			map.put("result", "true");
			return map;
		} else {

			pass = usersService.getChkAccount(account);
			System.out.println("account = " + account.toString());
//		System.out.println(account);
			System.out.println("b =" + pass);
			if (pass) {
				map.put("result", "false");
			} else {
				map.put("result", "true");
			}

//		System.out.println("mpa1=" + map);
			return map;
		}

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

				System.out.println("districtList = " + userDistrict.getDistrict());
				model.addAttribute("districtList", districtList1);

			}
		}
//		System.out.println("city = " + cityCode);
//		System.out.println("districtList = " + districtList.get(0).getDistrict());
		return districtList1;

	}

	@PostMapping(value = "/RegisterEdit")
	public String addUser(@ModelAttribute("users") Users users, BindingResult result, HttpServletRequest request,
			HttpSession session, Model model) {
		// ??????????????????start
		UserValidator validator = new UserValidator();
		validator.validate(users, result);
		if (result.hasErrors()) {
			return "users/RegisterEdit";
		}
		// ??????????????????end

		String userAct = users.getAccount();
		List<Users> sqlUserAct = usersService.userLogin(userAct);
		System.out.println("???????????????List??????=" + sqlUserAct.size() + ", ??????????????????= " + userAct);

		if (sqlUserAct.size() != 0) {
			result.rejectValue("account", "", "??????????????????");
			return "users/RegisterEdit";
		}

		// ?????????????????????satrt
		String userPwd = users.getPassword(); // ????????????
		BCryptPasswordEncoder BCrypt = new BCryptPasswordEncoder();
		String encPwd = BCrypt.encode(userPwd);
		System.out.println("????????????=" + encPwd);

		boolean b = BCrypt.matches(userPwd, encPwd);
		System.out.println("????????????=" + b);
		// ?????????????????????end

		users.setPassword(encPwd);

		if ("".equals(users.getMobile())) {
			users.setMobile(null);
		}
		if ("".equals(users.getTel())) {
			users.setTel(null);
		}
		Timestamp dateTime = Timestamp.valueOf(LocalDateTime.now());
		users.setStatusCode(userStatusService.get("01"));
		users.setActRegisteredTime(dateTime);
		users.setPwLastUpdateDate(dateTime);
		users.setVer(dateTime);

//		Timestamp temp = Timestamp.valueOf(LocalDateTime.now());
//		Date temp1 = new Date();
//		temp1 = temp;
//		SimpleDateFormat temp2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		String temp3 = temp2.format(temp1);
//		
//		try {
//			Date temp4 = temp2.parse(temp3);
//			Timestamp temp5 = new Timestamp(temp4.getTime());
//			users.setVer(temp5);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}

		UserCity userCity = userCityService.getCity(users.getCityCode().getCityCode());
		users.setCityCode(userCity);
		UserDistrict userDistrict = userDistrictService.getDistrict(users.getUserDistrictCode().getUserDistrictCode());
		users.setUserDistrictCode(userDistrict);

		UUID uuid = UUID.randomUUID();
		String code = uuid.toString().toUpperCase().replaceAll("-", "");

		UserAuthList userAuthList = new UserAuthList();
		userAuthList.setUserAuthListOid(code);
		userAuthList.setUsers(users);
		userAuthList.setAuthCode(userAuthService.get("01"));
		userAuthList.setVer(dateTime);

		try {

			usersService.save(users);
			userAuthListService.save(userAuthList);
			sendToGmail(users);
		} catch (Exception ex) {

			System.out.println(ex.getClass().getName() + ", ex.getMessage()=" + ex.getMessage());
			result.rejectValue("id", "", "????????????????????????");
			result.rejectValue("email", "", "????????????????????????");
			return "users/RegisterEdit";
		}

//		this.checkAccount = users.getAccount();
//////////////////////////////////////////////////////////////////////////////////////
		session.setAttribute("tempAccount", users.getAccount());
		return "redirect:/user/ChkEmail";

	}

	@ModelAttribute
	public void commonData(Model model) {
		Map<String, String> genderMap = new HashMap<>();
		genderMap.put("M", "???");
		genderMap.put("F", "???");
		model.addAttribute("genderMap", genderMap);

		List<UserCity> cityList = userCityService.getAllCity();
		model.addAttribute("cityList", cityList);
	}

	@PostMapping(value = "/Login")
	public String chkUserLogin(@ModelAttribute("loginPage") Users users, BindingResult result,
			@RequestParam(value = "account") String account, @RequestParam(value = "password") String password,
			@RequestParam(value = "loginUrl") String loginUrl,
			HttpSession session, RedirectAttributes reAttr) {

		LoginValidator validator = new LoginValidator();
		validator.validate(users, result);
		if (result.hasErrors()) {
//			return "users/Login";
			session.setAttribute("loginErrorCode", "1");
			return "index";
//			return "redirect:/";
		}

		try {

			String inputAct = users.getAccount();
			String inputPwd = users.getPassword();
			System.out.println("????????????????????? = " + inputAct);
			System.out.println("????????????????????? = " + inputPwd);

			Users userAct = usersService.get(account);
			String userPwd = userAct.getPassword();
			System.out.println("??????????????? = " + userAct.getAccount());
			System.out.println("??????????????? = " + userPwd);

			BCryptPasswordEncoder BCrypt = new BCryptPasswordEncoder();
			boolean b = BCrypt.matches(inputPwd, userPwd);
			System.out.println("????????????:" + b);

			String userStatus = userAct.getStatusCode().getStatusCode();
			System.out.println("????????????Code = " + userAct.getStatusCode().getStatusCode());

			if (b == false) {
				result.rejectValue("password", "", "????????????????????????");
//				return "users/Login";
				session.setAttribute("loginErrorCode", "1");
				return "index";
//				return "redirect:/";

			} else if ("03".equals(userStatus)) {
				result.rejectValue("password", "", "?????????????????????????????????");
//				return "users/Login";
				session.setAttribute("loginErrorCode", "1");
				return "index";
//				return "redirect:/";
			} else if ("01".equals(userStatus)) {
//				this.checkAccount = users.getAccount();
				session.setAttribute("tempAccount", users.getAccount());
				session.setAttribute("loginErrorCode", "2");
				return "redirect:/user/ChkEmail";
			}

		} catch (Exception ex) {

			result.rejectValue("password", "", "????????????????????????");
//			return "users/Login";
			session.setAttribute("loginErrorCode", "1");
			return "index";
//			return "redirect:/";
		}

		session.removeAttribute("loginErrorCode");
		session.setAttribute("account", account);
		session.setAttribute("username", usersService.get(account).getName());
		System.out.println("session1=" + session.getAttribute("account"));
//		if (chkStatus(account)) {
////////////////////////////////////////////////////////////////////////////////////////
//			//reAttr.addAttribute("tempAccount", reAttr)
//			return "redirect:/user/ChkEmail";
//		}
//		return "index";
		return (loginUrl == null || loginUrl.equals("")) ? "redirect:/" : "redirect:/" + loginUrl;

	}

	@PostMapping(value = "/ForgetPwd")
	public String chkForgetPwd(@ModelAttribute("forgetPwd") Users users, BindingResult result, Model model,
			@RequestParam(value = "account") String account, @RequestParam(value = "id") String id,
			@RequestParam(value = "email") String email) {

		UserForgetPwdValidate validator = new UserForgetPwdValidate();
		validator.validate(users, result);
		if (result.hasErrors()) {
			return "users/ForgetPwd";
		}

		String inputAct = users.getAccount();
		String inputId = users.getId();
		String inputEmail = users.getEmail();

		boolean temp1 = usersService.getChkAccount(account);

		if (temp1 == false) {

			Users userAccount = usersService.get(account);

			String userAct = userAccount.getAccount();
			// !!!!!!
			String userId = userAccount.getId();
			String userEmail = userAccount.getEmail();

			System.out.println("??????????????? = " + inputAct);
			System.out.println("?????????ID = " + inputId);
			System.out.println("??????????????? = " + inputEmail);
			System.out.println("?????????????????? = " + userAct);
			System.out.println("????????????ID = " + userId);
			System.out.println("?????????????????? = " + userEmail);

			if (!inputAct.equalsIgnoreCase(userAct) || !inputId.equalsIgnoreCase(userId)
					|| !inputEmail.equalsIgnoreCase(userEmail)) {
				result.rejectValue("account", "", "???????????????????????????");
				return "users/ForgetPwd";
			}
			Users userUpdatePwd = new Users();
			userUpdatePwd.setAccount(inputAct);
			model.addAttribute("updatePwd", userUpdatePwd);
			return "users/UpdatePwd";
		}

		result.rejectValue("account", "", "???????????????????????????");
		return "users/ForgetPwd";
	}

	@PostMapping(value = "/UpdatePwd")
	public String updatePwd(@ModelAttribute("updatePwd") Users users, BindingResult result,
			@RequestParam(value = "account") String account, @RequestParam(value = "password") String password,
			HttpSession session) {

		UserUpdatePwdValidator validator = new UserUpdatePwdValidator();
		validator.validate(users, result);
		if (result.hasErrors()) {
			return "users/UpdatePwd";
		}

		String userAct = users.getAccount();
		String userNewPwd = users.getPassword();
		BCryptPasswordEncoder BCrypt = new BCryptPasswordEncoder();
		String encPwd = BCrypt.encode(userNewPwd);
		Users userData = usersService.get(userAct);
		userData.setPassword(encPwd);
		Timestamp dateTime = Timestamp.valueOf(LocalDateTime.now());
		userData.setPwLastUpdateDate(dateTime);
		userData.setVer(dateTime);

		System.out.println("????????? = " + userNewPwd);
		System.out.println("??????????????? = " + encPwd);

		usersService.save(userData);
		session.invalidate();
//		System.out.println("??????????????? = " + userAct);
//		System.out.println("????????? = " + userData.getName());

		//return "index";
		return "redirect:/";
		
	}

	@PostMapping(value = "/ChkUserUpdatePwd")
	public String chkUserUpdatePwd(@ModelAttribute("chkUserUpdatePwd") Users users, BindingResult result, Model model,
			@RequestParam(value = "account") String account, @RequestParam(value = "password") String password) {

		LoginValidator validator = new LoginValidator();
		validator.validate(users, result);
		if (result.hasErrors()) {
			return "users/ChkUserUpdatePwd";
		}

		String inputAct = "";
		String inputPwd = "";
		try {

			inputAct = users.getAccount();
			inputPwd = users.getPassword();
			System.out.println("????????????????????? = " + inputAct);
			System.out.println("????????????????????? = " + inputPwd);

			Users userAct = usersService.get(account);
			String userPwd = userAct.getPassword();
			System.out.println("??????????????? = " + userAct.getAccount());
			System.out.println("??????????????? = " + userPwd);

			BCryptPasswordEncoder BCrypt = new BCryptPasswordEncoder();
			boolean b = BCrypt.matches(inputPwd, userPwd);

			System.out.println("????????????:" + b);

			if (b == false) {
				result.rejectValue("password", "", "????????????????????????");
				return "users/ChkUserUpdatePwd";
			}

		} catch (Exception ex) {

			result.rejectValue("password", "", "????????????????????????");
			return "users/ChkUserUpdatePwd";
		}

		Users userUpdatePwd = new Users();
		userUpdatePwd.setAccount(inputAct);
		model.addAttribute("updatePwd", userUpdatePwd);
		return "users/UpdatePwd";

	}

	@PostMapping(value = "/Logout")
	public String logout(HttpSession session) {
//		System.out.println("session2=" + session.getAttribute("account"));
		session.invalidate();
//		session.setAttribute("account", null);
//		System.out.println("session2=" + session.getAttribute("account"));
		return "redirect:/";

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
	public String userLoginHomePage(HttpSession session) {
		String account = session.getAttribute("account").toString();
		if (chkStatus(account))
			return "redirect:/user/ChkEmail";
		return "users/LoginHomePage";

	}

	@GetMapping(value = "/userUpdate")
	public String userUpdate(Model model, HttpSession session) {
//		System.out.println("test==============================================" + account);
		String userAct = session.getAttribute("account").toString();
		Users userData = usersService.get(userAct);
		model.addAttribute(userData);

//		System.out.println("====" + userData.getCityCode().getCity());
//		System.out.println("====" + userData.getUserDistrictCode().getDistrict());

		return "users/UserUpdate";

	}

	@PostMapping(value = "/userUpdate")
	public String userUpdateSave(@ModelAttribute("users") Users users, BindingResult result, HttpSession session) {

		UserUpdateValidator validator = new UserUpdateValidator();
		validator.validate(users, result);
		if (result.hasErrors()) {
			return "users/UserUpdate";
		}

//		System.out.println("====2" + userData.getPassword());
		String userAct = session.getAttribute("account").toString();
		Users userData = usersService.get(userAct);
		users.setPassword(userData.getPassword());

		users.setStatusCode(userStatusService.get("02"));
		users.setVer(Timestamp.valueOf(LocalDateTime.now()));

		users.setActRegisteredTime(userData.getActRegisteredTime());
		users.setPwLastUpdateDate(userData.getPwLastUpdateDate());

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

//	private String checkAccount = "";
	@GetMapping(value = "/ChkEmail")
	public String chkEmail(Model model) {
//	public String chkEmail(HttpSession session, Model model) {
//		if(this.checkAccount != "") {
//			model.addAttribute("checkAccount", checkAccount);
//			checkAccount = "";
//		}

		return "users/ChkEmail";
	}

	@PostMapping(value = "/verifyEmail")
	public String verifyEmail(@ModelAttribute("error") String error,
			@RequestParam(value = "verifyCode") String verifyCode, HttpSession session, RedirectAttributes reAttr) {
		System.out.println("================");
		System.out.println("verifyCode:" + verifyCode);
		System.out.println("================");
		UserActValidateTemp uavt = new UserActValidateTemp();
		String account = session.getAttribute("tempAccount").toString();		
		
		uavt = userActValidateTempService.getInfo(account);
		Date sqlDate = uavt.getExpired_time();
		Date nowDate = new Timestamp(System.currentTimeMillis());
		long dateCompare = nowDate.getTime() - sqlDate.getTime();// ?????????????????????

		boolean flag1 = false, flag2 = false;

		if (verifyCode.equals(uavt.getValidate_code())) {
			flag1 = true;
		} else {
			System.out.println("==========Wrong verifyCode==============");
		}
		if (dateCompare >= 0 && dateCompare <= 900000) {// 900000?????????15??????
			flag2 = true;
		} else {
			System.out.println("===========OverTime===================");
		}
		if (flag1 == true && flag2 == true) {
			Users user = new Users();
			user = usersService.get(session.getAttribute("tempAccount").toString());
			UserStatus userstate = new UserStatus();
			userstate = userStatusService.get("02");
			user.setStatusCode(userstate);

			usersService.save(user);
			System.out.println("=========verify Success!!!=========");
			session.removeAttribute("tempAccount");
			//session.setAttribute("account", user.getAccount());
			session.setAttribute("account", account);
			session.setAttribute("username", usersService.get(account).getName());
			return "redirect:/";
		} else {
			System.out.println("=========verify Fail!!!============\n");
		}
		reAttr.addFlashAttribute("error", "?????????????????????????????????");
		return "redirect:/user/ChkEmail";
	}

	@GetMapping(value = "/resetVerifyCode")
	@ResponseBody
	public void resetVerifyCode(HttpSession session) throws UnsupportedEncodingException {
		RandomCode random = new RandomCode();
		String verifyCode = random.verifyCode();
		String account = session.getAttribute("tempAccount").toString();
//		String account = checkAccount;
		Users user = new Users();
		user = usersService.get(account);
		System.out.println("==============resetVerifyCode==============");

		UserActValidateTemp uavt = new UserActValidateTemp();
		uavt = userActValidateTempService.getInfo(account);
		uavt.setValidate_code(verifyCode);
		uavt.setExpired_time(new Timestamp(System.currentTimeMillis()));

		userActValidateTempService.updateCode(uavt);
		// ???????????????????????????

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper;
			helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom("hla524290337@gmail.com", "SportsGo!????????????");
			helper.setTo(user.getEmail());
			helper.setSubject("????????????????????????");
			helper.setText(user.getName() + "??????!\n??????4???????????????: " + verifyCode + "\n??????15???????????????????????????");
			mailSender.send(message);
		} catch (MessagingException e) {
			System.out.println("=======sending email fail!==========");
			e.printStackTrace();
		}

	}

	void sendToGmail(Users user) throws UnsupportedEncodingException {
//		SimpleMailMessage message = new SimpleMailMessage();

		RandomCode random = new RandomCode();
		String verifyCode = random.verifyCode();

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper;
			helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom("hla524290337@gmail.com", "SportsGo!????????????");
			helper.setTo(user.getEmail());
			helper.setSubject("????????????????????????");
			helper.setText(user.getName() + "??????!\n??????4???????????????: " + verifyCode + "\n??????15???????????????????????????");
			mailSender.send(message);
		} catch (MessagingException e) {
			System.out.println("=======sending email fail!==========");
			e.printStackTrace();
		}
		UserActValidateTemp uavt = new UserActValidateTemp();
		uavt.setAccount(user.getAccount());
		uavt.setValidate_code(verifyCode);
		uavt.setExpired_time(new Timestamp(System.currentTimeMillis()));

		userActValidateTempService.save(uavt);

	}

	boolean chkStatus(String account) {
		Users user = new Users();
		user = usersService.get(account);
		String userStatus = user.getStatusCode().getStatusCode();
		if ("01".equals(userStatus)) {
			return true;
		}
		return false;
	}

	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}

}
