package com.sport.springboot.shop.validate;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.sport.springboot.shop.model.Product;

@Component
public class ProductValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
//		System.out.println(clazz.getName());
		boolean b = Product.class.isAssignableFrom(clazz);
		return b;
	}

	@Override
	public void validate(Object target, Errors errors) {
		Product product = (Product) target;
//		ValidationUtils.rejectIfEmptyOrWhitespace
//			(errors, "product_id", "", "帳號欄不能空白(預設值)");
		ValidationUtils.rejectIfEmptyOrWhitespace
			(errors, "product_name", "", "商品名稱不能空白(預設值)");
		ValidationUtils.rejectIfEmptyOrWhitespace
			(errors, "product_price", "", "價錢不能空白");
		ValidationUtils.rejectIfEmptyOrWhitespace
			(errors, "product_stock", "", "庫存不能空白");
		

//		if (product.get().length()<5) {
//			errors.rejectValue("account","", "帳號欄不能小於五個字元");
//		}
//		
		if (product.getProductCategory().getId() == -1) {
			errors.rejectValue("productCategory","", "必須挑選分類欄的選項");
		}
//		if (member.getHobby().getId() == -1) {
//			errors.rejectValue("hobby","", "必須挑選嗜好欄的選項");
//		}

	}

}
