/**
 (Controller)UserManageController
작성자 :  김경혜
최초 작성일 170703
변경이력
*//*
package kr.co.turnup_fridger.controller.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.SignUpMemberFailException;
import kr.co.turnup_fridger.service.AuthorityService;
import kr.co.turnup_fridger.service.MemberService;
import kr.co.turnup_fridger.validation.MemberJoinValidator;
import kr.co.turnup_fridger.vo.Member;

*//**
 * 인증이 필요없는 작업처리 -사용자 관리
 *//*
@Controller
public class UserManageController2 {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AuthorityService authorityService;
	
	*//**
	 * 회원 등록
	 * 처리후 join_member_success.do를 이용해 응답처리 -redirect방식 이동
	 * 요청파라미터 : memberId
	 * @param member
	 * @return
	 * @throws SignUpMemberFailException 
	 *//*
	@RequestMapping("/join_member")
	public ModelAndView signUpMember(@ModelAttribute Member member,@RequestParam int myDislikeIrdntId, BindingResult errors) throws SignUpMemberFailException{
		//1.요청파라미터 조회+검증
		MemberJoinValidator validator=new MemberJoinValidator();
		validator.validate(member, errors);
		if(errors.hasErrors()){//errors에 오류가 1개라도 등록되있으면 다시 form으로 돌아가
			return new ModelAndView("user/join_member_form","member",member);
		}
		System.out.println(myDislikeIrdntId);
		//2.BusinessLogic
		//memberService.signUpMember(member);
		
		//3.응답
		return new ModelAndView("redirect:/join_member_success.do","memberId",member.getMemberId());
	}
	
	@RequestMapping("/join_member_success")
	public ModelAndView signUpSuccessMember(@RequestParam String memberId){
		Member member=memberService.inquiryMemberInfo(memberId);
		return new ModelAndView("user/join_member_success","member",member);
	}
	
	*//**
	 * 회원등록시 아이디 중복조회-Ajax처리
	 * @param inputId
	 * @return
	 *//*
	@RequestMapping(value="/popup_duplicate_id", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String duplicateId(String inputId){
		//1.요청파라미터 조회+검증
		//System.out.println(memberId);
		//2.BusinessLogic
		if(authorityService.findAuthority(inputId)!=null){
			//System.out.println("ID있음");
			return "duplicateIdError";
		}
		if(inputId.trim().length()<2||inputId.trim().length()>15){
			return "idLengthError";
		}
		return inputId.trim();
	}
	
	*//**
	 * 회원등록시 이메일 중복조회-Ajax처리
	 * @param inputId
	 * @return
	 *//*
	@RequestMapping(value="/popup_duplicate_email", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String duplicateEmail(String inputEmail){
		//1.요청파라미터 조회+검증
		//2.BusinessLogic
		if(memberService.findMemberByEmail(inputEmail)!=null){
			//System.out.println("ID있음");
			return "duplicateEmailError";
		}
		return inputEmail;
	}

}
*/