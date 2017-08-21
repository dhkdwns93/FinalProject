package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.MyMemo;

public class MemoValidator implements Validator  {

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(MyMemo.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MyMemo mm = (MyMemo)target;
		
		// 메모제목
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memoName", "required");
		
		// 메모내용
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memoTxt", "required");
	}

	
}
