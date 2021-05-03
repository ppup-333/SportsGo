package com.sport.springboot.users.validate;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.sport.springboot.users.model.Users;

@Component
public class AdminLoginValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		boolean b = Users.class.isAssignableFrom(clazz);
		return b;
	}

	@Override
	public void validate(Object target, Errors errors) {

		Users users = (Users) target;
		String chkAccount = "(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]{8,16}";
		String chkPwd = "(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]{8,16}";

		if (users.getAccount().matches(chkAccount) == false || users.getPassword().matches(chkPwd) == false) {
			errors.rejectValue("password", "", "帳號密碼錯誤或無此權限");
		}

//		if (users.getPassword().matches(chkPwd) == false) {
//			errors.rejectValue("password", "", "密碼欄位空白或格式不正確");
//		}

	}

}
