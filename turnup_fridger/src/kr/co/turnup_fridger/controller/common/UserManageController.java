/**
 (Controller)UserManageController
작성자 :  김경혜
최초 작성일 170703
변경이력
*/
package kr.co.turnup_fridger.controller.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.SignUpMemberFailException;
import kr.co.turnup_fridger.service.MemberService;
import kr.co.turnup_fridger.vo.Member;

/**
 * 인증이 필요없는 작업처리 -사용자 관리
 */
@Controller
public class UserManageController {
	
	@Autowired
	private MemberService service;
	
	/**
	 * 회원 등록
	 * 처리후 join_member_success.do를 이용해 응답처리 -redirect방식 이동
	 * 요청파라미터 : memberId
	 * @param member
	 * @return
	 * @throws SignUpMemberFailException 
	 */
	@RequestMapping("/user/join_member")
	public ModelAndView signUpMember(@ModelAttribute Member member) throws SignUpMemberFailException{
		service.signUpMember(member);
		return new ModelAndView("redirect:/user/join_member_success.do","memberId",member.getMemberId());
	}
	
	@RequestMapping("/user/join_member_success")
	public ModelAndView signUpSuccessMember(@RequestParam String memberId){
		Member member=service.inquiryMemberInfo(memberId);
		return new ModelAndView("/user/member/join_member_success.do","member",member);
	}

}
