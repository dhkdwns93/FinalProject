package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.BoardQnA;

public class BoardQnAValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return clazz.isAssignableFrom(BoardQnA.class);
	}

	@Override
	public void validate(Object target, Errors errors) {

		BoardQnA boardQnA = (BoardQnA)target;
		
		//게시판 제목
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "boardQnATitle", "required");
		
		//게시판 내용
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "boardQnATxt", "required");

	}

		
}
