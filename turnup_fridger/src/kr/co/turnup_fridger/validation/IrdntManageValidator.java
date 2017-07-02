package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.IrdntManage;

public class IrdntManageValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(IrdntManage.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		IrdntManage irdnt = (IrdntManage) target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "irdntId", "requried");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "irdntName", "requried");

		if(irdnt.getIrdntPeriod()<0||irdnt.getIrdntPeriod()>1000){
			errors.rejectValue("irdntPeriod", "required");
		}
		
	}

}
