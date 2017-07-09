/**
 (Validator)MebmerChangeInfoValidator
작성자 :  김경혜
최초 작성일 170709
변경이력
*/
package kr.co.turnup_fridger.validation;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.validation.form.MemberChangeForm;

@Component
public class MemberChangeInfoValidator implements Validator {
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(MemberChangeForm.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberChangeForm memberChangeForm=(MemberChangeForm)target;
//		System.out.println("validator" + memberChangeForm);
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberId", "requiredChange");
		/*if(!passwordEncoder.matches(memberChangeForm.getOldMemberPw(),memberChangeForm.getOriginalMemberPw())){
			errors.rejectValue("oldMemberPw", "synchronizeFail","*비밀번호가 일치하지 않습니다.");
		}*/
		if(memberChangeForm.getMemberPw().length()<6||memberChangeForm.getMemberPw().length()>15){
			errors.rejectValue("memberPw", "length","*패스워드는 글자수 6~15자 내로 설정해주십시오.");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberName", "requiredChange");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberAddress", "requiredChange");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberEmail", "requiredChange");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberTel", "requiredChange");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberSex", "requiredChange");
	}

	
}
