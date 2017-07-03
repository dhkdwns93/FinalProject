package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.MyIrdnt;

public class MyIrdntValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(MyIrdnt.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MyIrdnt irdnt = (MyIrdnt) target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "irdntId", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "startDate", "required");
		
		
	}
	
	
}
