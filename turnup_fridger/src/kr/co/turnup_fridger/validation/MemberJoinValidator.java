/**
 (Validator)MemberJoinValidator
작성자 :  김경혜
최초 작성일 170704
변경이력
*/
package kr.co.turnup_fridger.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.turnup_fridger.vo.Member;

public class MemberJoinValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(Member.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Member member=(Member)target;
		if(member.getMemberId()==null||member.getMemberId().trim().isEmpty()||member.getMemberId().length()<2||member.getMemberId().length()>15){
			errors.rejectValue("memberId", "length","*아이디는 공백없이 글자수 2~15자 내로 작성해주십시오.");
			member.setMemberId("");
		}
		if(member.getMemberPw().length()<6||member.getMemberPw().length()>15){
			errors.rejectValue("memberPw", "length","*패스워드는 글자수 6~15자 내로 설정해주십시오.");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberName", "requiredJoin");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberAddress", "requiredJoin");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberEmail", "requiredJoin");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberTel", "requiredJoin");
		if(member.getMemberTel().length()!=11){
			errors.rejectValue("memberTel", "length","*사용하시는 휴대폰번호 11자리를 입력해주십시오. 문자서비스를 받기 위함입니다.");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberSex", "requiredJoin");
	}

}
