/**
 (Controller)MebmerManageController
작성자 :  김경혜
최초 작성일 170704
변경이력
*/
package kr.co.turnup_fridger.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.turnup_fridger.exception.ChangeMemberInfoFailException;
import kr.co.turnup_fridger.service.MemberService;
import kr.co.turnup_fridger.vo.Member;

/**
 *	/common/member/경로로 요청하는 작업 처리
 */

@Controller
@RequestMapping("/common/member")
public class MemberManageController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	/**
	 * 회원 정보 수정
	 * 수정할 정보와 기존 패스워드를 받음
	 * 수정 후 member_mypage로 이동
	 * @param member
	 * @param oldMemberPassword
	 * @return
	 * @throws ChangeMemberInfoFailException 
	 */
	@RequestMapping("/member_change")
	public String changeMemberInfo(@ModelAttribute Member member, @RequestParam String newMemberPw, @RequestParam int myDislikeIrdntId) throws ChangeMemberInfoFailException{
		//1. 요청한 사용자 정보 조회
		SecurityContext ctx=SecurityContextHolder.getContext();
		Authentication authentication=ctx.getAuthentication();
		//System.out.println(authentication);
		//System.out.println(member);
		//System.out.println("기존의 비밀번호" + member.getMemberPw());
		//PW 체크
		String memberPw=((Member)authentication.getPrincipal()).getMemberPw();
		//if(!passwordEncoder.matches(memberPw,member.getMemberPw())){
		if(!memberPw.equals(member.getMemberPw())){
			System.out.println("MemberManageController + PW가 다릅니다");
			throw new RuntimeException("PW가 다릅니다.");
		}
		System.out.println(myDislikeIrdntId);
		
		
		//2. Business Logic 호출
		member.setMemberPw(newMemberPw);
		//System.out.println("MemberManage"+newMemberPw);
		
		memberService.changeMemberInfo(member);
		
		ctx.setAuthentication(new UsernamePasswordAuthenticationToken(member,null,authentication.getAuthorities()));
		return "common/member/user/member_mypage";
	}

	/**
	 * 회원탈퇴
	 * 기존 패스워드를 받음
	 * 탈퇴 후 기본페이지로 이동 -redirect방식 이동
	 * @param member
	 * @param oldMemberPassword
	 * @return
	 * @throws ChangeMemberInfoFailException 
	 */
	@RequestMapping("/member_delete")
	public String leaveMember(@RequestParam String memberId, @RequestParam String inputPw){
		//1. 요청한 사용자 정보 조회
		SecurityContext ctx=SecurityContextHolder.getContext();
		Authentication authentication=ctx.getAuthentication();
		//PW 체크
		String memberPw=((Member)authentication.getPrincipal()).getMemberPw();
		//if(!passwordEncoder.matches(oldMemberPassword,((Member)authentication.getPrincipal()).getMemberPw())){
		if(!memberPw.equals(inputPw)){
			System.out.println("MemberManageController(deleteMember메소드) + PW가 다릅니다");
			throw new RuntimeException("PW가 다릅니다.");
		}
		
		//2.Business Logic 호출
		//System.out.println("회원탈퇴메소드 확인"+memberId);
		memberService.deleteMember(memberId);
		
		//3.응답
		ctx.setAuthentication(null);//로그아웃처리

		return "redirect:../../index_kh.do";
	}

}
