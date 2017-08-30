package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.Shop;

public class ShopValidator implements Validator  {

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(Shop.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Shop s = (Shop)target;
		
		// 쇼핑몰 이름
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shopName", "required");
		
		// 쇼핑몰 주소(url)
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shopAddress", "required");
	
	}

}
