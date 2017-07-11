/**
 (Service)memberService
작성자 :  김경혜
최초 작성일 170630
변경이력
170701 Exception 추가
*/
package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.exception.ChangeMemberInfoFailException;
import kr.co.turnup_fridger.exception.FindMemberFailException;
import kr.co.turnup_fridger.exception.SignUpMemberFailException;
import kr.co.turnup_fridger.vo.Member;

/**
 * 사용자 관련 업무로직 처리
 */
public interface MemberService {
	
	/**
	 * 개인회원 가입하기. -Id, 이메일 같으면 회원가입 불가. -authority에도 추가
	 * @param member
	 * @throws SignUpMemberFailException
	 */
	void  signUpMember(Member member) throws SignUpMemberFailException;
	
	
	/**
	 * 개인회원정보 조회하기
	 * @param memberId
	 * @return
	 */
	Member inquiryMemberInfo(String memberId);
	
	/**
	 * 개인회원정보 수정하기   -authority에도 수정
	 * @param memberId
	 * @throws ChangeMemberInfoFailException
	 */
	void changeMemberInfo(Member member) throws ChangeMemberInfoFailException;
	
	/**
	 * 개인회원 탈퇴하기  -authority에도 삭제
	 * (관리자)개인회원 강제탈퇴 -authority에도 삭제
	 * @param memberId
	 */
	void deleteMember(String memberId);
		
	/**
	 * 해당 이메일 사용하는 사용자 조회 -중복검사,개인회원 이메일계정으로 아이디/비번 찾기
	 * @param memberEmail
	 * @return
	 */
	Member findMemberByEmail(String memberEmail);
	
	/**
	 * (관리자)전체개인회원정보 조회
	 * @return
	 */
	List<Member> inquiryMemberList();

	
	
}
