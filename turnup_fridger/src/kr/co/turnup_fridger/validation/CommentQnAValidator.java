package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.CommentQnA;

public class CommentQnAValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return clazz.isAssignableFrom(CommentQnA.class);
	}

	@Override
	public void validate(Object target, Errors errors) {

		CommentQnA commentQnA = (CommentQnA)target;
		
		//댓글 내용
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "commentQnATxt", "required");


	}

		
}
