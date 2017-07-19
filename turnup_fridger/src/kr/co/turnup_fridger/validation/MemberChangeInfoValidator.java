/**
 (Validator)MemberChangeInfoValidator
작성자 :  김경혜
최초 작성일 170709
변경이력
170719 이메일 형식 추가
*/
package kr.co.turnup_fridger.validation;



import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

	 private Pattern pattern;  
	 private Matcher matcher;  
	  
	 private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"  
	   + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";  
	 String ID_PATTERN = "[0-9]+";  
	 String STRING_PATTERN = "[a-zA-Z]+";  
	 String MOBILE_PATTERN = "[0-9]{10}";  
	  
	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(MemberChangeForm.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		//System.out.println(passwordEncoder);
		MemberChangeForm memberChangeForm=(MemberChangeForm)target;
//		System.out.println("validator" + memberChangeForm);
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberId", "requiredChange");
		if(!passwordEncoder.matches(memberChangeForm.getOldMemberPw(),memberChangeForm.getOriginalMemberPw())){
			errors.rejectValue("oldMemberPw", "synchronizeFail","*비밀번호가 일치하지 않습니다.");
		}
		if(memberChangeForm.getMemberPw().length()<6||memberChangeForm.getMemberPw().length()>15){
			errors.rejectValue("memberPw", "length","*패스워드는 글자수 6~15자 내로 설정해주십시오.");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberName", "requiredChange");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberAddress", "requiredChange");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberEmail", "requiredChange");
		if (!(memberChangeForm.getMemberEmail() != null && memberChangeForm.getMemberEmail().isEmpty())) {  
			   pattern = Pattern.compile(EMAIL_PATTERN);  
			   matcher = pattern.matcher(memberChangeForm.getMemberEmail());  
			   if (!matcher.matches()) {  ;
			    errors.rejectValue("memberEmail", "email.incorrect",  
			      "*이메일 형식으로 작성하여 주세요.");  
			   }  
		} 
               
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberTel", "requiredChange");
		if(memberChangeForm.getMemberTel().length()!=11){
			errors.rejectValue("memberTel", "length","*사용하시는 휴대폰번호 11자리를 입력해주십시오. 문자서비스를 받기 위함입니다.");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberSex", "requiredChange");
	}

	
}
