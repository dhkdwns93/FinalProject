package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.CommentFree;

public class CommentFreeValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return clazz.isAssignableFrom(CommentFree.class);
	}

	@Override
	public void validate(Object target, Errors errors) {

		CommentFree commentFree = (CommentFree)target;
		
		//댓글 내용
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "commentFreeTxt", "required");


	}

		
}
