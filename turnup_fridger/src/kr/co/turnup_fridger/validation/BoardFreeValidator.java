package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.BoardFree;

public class BoardFreeValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return clazz.isAssignableFrom(BoardFree.class);
	}

	@Override
	public void validate(Object target, Errors errors) {

		BoardFree boardFree = (BoardFree)target;
		
		//게시판 제목
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "boardFreeTitle", "required");
		
		//게시판 내용
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "boardFreeTxt", "required");

	}

		
}
