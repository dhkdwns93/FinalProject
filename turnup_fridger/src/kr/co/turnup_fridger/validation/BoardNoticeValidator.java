package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.BoardNotice;

public class BoardNoticeValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return clazz.isAssignableFrom(BoardNotice.class);
	}

	@Override
	public void validate(Object target, Errors errors) {

		BoardNotice boardNotice = (BoardNotice)target;
		
		//게시판 말머리
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "items", "required");
		
		//게시판 제목
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "required");
		
		//게시판 내용
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "txt", "required");
	}

		
}
