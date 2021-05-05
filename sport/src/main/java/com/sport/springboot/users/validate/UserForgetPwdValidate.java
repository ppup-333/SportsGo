package com.sport.springboot.users.validate;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.sport.springboot.users.model.Users;

@Component
public class UserForgetPwdValidate implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		boolean b = Users.class.isAssignableFrom(clazz);
		return b;
	}

	@Override
	public void validate(Object target, Errors errors) {

		Users users = (Users) target;
		String chkAccount = "(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]{8,16}";
		String chkId = "[A-Z]{1}[1-2]{1}[0-9]{8}";
		String isId = users.getId();
		String chkEmail = "^.+@.+\\..{2,3}$";

		boolean pass = false;
		if (isId.matches(chkId) == true) {
			List<String> list1 = Arrays.asList("A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "O", "N",
					"P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "I");
			List<String> list2 = Arrays.asList("10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21",
					"35", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "34");
			List<Integer> list3 = new ArrayList<Integer>();
			String firstCharStr = isId.substring(0, 1).toUpperCase();
			int idxOfEng = list1.indexOf(firstCharStr);
			String firstCharInt = list2.get(idxOfEng);
			list3.add(Integer.parseInt(firstCharInt.substring(0, 1)));
			list3.add(Integer.parseInt(firstCharInt.substring(1, 2)));
			for (int i = 1; i <= 9; i++) {
				list3.add(Integer.parseInt(isId.substring(i, i + 1)));
			}
			if ((list3.get(0) * 1 + list3.get(1) * 9 + list3.get(2) * 8 + list3.get(3) * 7 + list3.get(4) * 6
					+ list3.get(5) * 5 + list3.get(6) * 4 + list3.get(7) * 3 + list3.get(8) * 2 + list3.get(9) * 1
					+ list3.get(10) * 1) % 10 == 0) {
				pass = true;
			}
		}

		if (users.getAccount().matches(chkAccount) == false || users.getId().matches(chkId) == false || pass == false
				|| users.getEmail().matches(chkEmail) == false) {
			errors.rejectValue("account", "", "查無資料或資料有誤");
		}

//		if (users.getPassword().matches(chkPwd) == false) {
//			errors.rejectValue("password", "", "密碼欄位空白或格式不正確");
//		}

	}

}
