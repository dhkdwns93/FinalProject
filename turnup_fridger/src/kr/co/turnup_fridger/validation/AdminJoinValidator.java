/**
 (Validator)AdminJoinValidator
작성자 :  김경혜
최초 작성일 170704
변경이력
*/
package kr.co.turnup_fridger.validation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.service.AdminService;
import kr.co.turnup_fridger.service.AuthorityService;
import kr.co.turnup_fridger.vo.Admin;

@Component
public class AdminJoinValidator implements Validator {
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private AdminService adminService;
	
	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(Admin.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Admin admin=(Admin)target;
		
		String adminId=admin.getAdminId();
		//ID 공백 & 글자수 조회
		if(adminId==null||adminId.trim().isEmpty()||adminId.length()<2||adminId.length()>15){
			errors.rejectValue("adminId", "length","*아이디는 공백없이 글자수 2~15자 내로 작성해주십시오.");
			admin.setAdminId("");
		}
		//ID중복조회
		if(authorityService.findAuthority(adminId)!=null){//해당 아이디의 유저(회원,관리자포함)가 있으면
			errors.rejectValue("adminId", "duplicate","*해당 아이디는 이미 사용중입니다.");
		}
		//비밀번호 글자수 조회
		if(admin.getAdminPw().length()<6||admin.getAdminPw().length()>15){
			errors.rejectValue("adminPw", "length","*패스워드는 글자수 6~15자 내로 설정해주십시오.");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminName", "requiredJoin");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminTel", "requiredJoin");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminEmail", "requiredJoin");
	}

}
