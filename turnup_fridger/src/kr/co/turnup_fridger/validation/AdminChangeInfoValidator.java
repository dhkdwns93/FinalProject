/**
 (Validator)AdminChangeInfoValidator
작성자 :  김경혜
최초 작성일 170712
변경이력
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

import kr.co.turnup_fridger.validation.form.AdminChangeForm;

@Component
public class AdminChangeInfoValidator implements Validator{
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
		return clazz.isAssignableFrom(AdminChangeForm.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		AdminChangeForm adminChangeForm=(AdminChangeForm)target;
		if(!passwordEncoder.matches(adminChangeForm.getOldAdminPw(), adminChangeForm.getOriginalAdminPw())){
			errors.rejectValue("oldAdminPw", "synchronizeFail","*비밀번호가 일치하지 않습니다.");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminPw", "requiredChange");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminName", "requiredChange");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminTel", "requiredChange");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminEmail", "requiredChange");
		if (!(adminChangeForm.getAdminEmail() != null && adminChangeForm.getAdminEmail().isEmpty())) {  
			   pattern = Pattern.compile(EMAIL_PATTERN);  
			   matcher = pattern.matcher(adminChangeForm.getAdminEmail());  
			   if (!matcher.matches()) {  ;
			    errors.rejectValue("adminEmail", "email.incorrect",  
			      "*이메일 형식으로 작성하여 주세요.");  
			   }  
		}
		
	}
	
}
