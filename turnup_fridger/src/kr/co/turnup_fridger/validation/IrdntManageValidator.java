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
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "irdntId", "requried","재료id는 필수 입력사항입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "irdntName", "requried","재료명은 필수 입력사항입니다.");
		
		if(irdnt.getIrdntPeriod()<0||irdnt.getIrdntPeriod()>1000){
			errors.rejectValue("irdntPeriod", "required","보관기간은 1일-1000일 사이만 가능합니다.");
		}
		
	}

}
