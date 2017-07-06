package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.BoardShareRecipe;

public class BoardShareRecipeValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		return clazz.isAssignableFrom(BoardShareRecipe.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		BoardShareRecipe boardShareRecipe = (BoardShareRecipe)target;
		//title 체크
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "required");
		// 내용
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "txt", "required");
		
		
		/*if((boardShareRecipe.getTxt()==null||boardShareRecipe.getTxt().trim().isEmpty())&&boardShareRecipe.getTxt().length()<1000){
			errors.rejectValue("txt", "required");
		}*/
		
		//사진 체크
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "image", "required", "사진은 필수입력사항입니다.");
		
		
		
		
		
	}

}
