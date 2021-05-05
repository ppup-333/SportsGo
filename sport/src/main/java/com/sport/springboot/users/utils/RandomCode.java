package com.sport.springboot.users.utils;

import java.util.Random;

public class RandomCode {
	
	public String verifyCode() {
		String str= "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		String code= "";
		StringBuilder sb=new StringBuilder(4);	
		for(int i=0; i < 4; i ++) {
			char ch=str.charAt(new Random().nextInt(str.length()));
		     sb.append(ch);
		}

		code = sb.toString();
		return code;
	}
	
}
