package com.sport.springboot.field.validate;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.sport.springboot.field.model.Field;

@Component
public class FieldValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return Field.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		
		Field field = (Field)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "id", "", "不能空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "", "不能空白");
		
		if(field.getFieldType().getId() == 0) {
			errors.rejectValue("fieldType", "", "請選擇類型");
		}
		
		if(field.getRentForMember() <= 0) {
			errors.rejectValue("rentForMember", "", "必須大於 0 元");
		}
		
		if(field.getRentForAct() <= 0) {
			errors.rejectValue("rentForAct", "", "必須大於 0 元");
		}
		
	}

}
