package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.BoardReview;

public class BoardReviewValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return clazz.isAssignableFrom(BoardReview.class);
	}

	@Override
	public void validate(Object target, Errors errors) {

		BoardReview boardReview = (BoardReview)target;
		
		//게시판 제목
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "boardReviewTitle", "required");
		
		//게시판 내용
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "boardReviewTxt", "required");
		
		//게시판 별점
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "boardReviewStar", "required");
	}

		
}
