/**
 (Validator)UserLoginValidator
작성자 :  김경혜
최초 작성일 170706
변경이력 
*/
package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.Authority;

public class UserLoginValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(Authority.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Authority authority=(Authority)target;
		
		//로그인 Id체크
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "loginId", "required");
		//로그인 PW체크
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "loginPw", "required");
		
	}

}
