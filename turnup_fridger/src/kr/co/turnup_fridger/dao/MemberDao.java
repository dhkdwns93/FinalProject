/**
 (Dao)memberDao
작성자 :  김경혜
최초 작성일 170627
변경이력 
*/
package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.Member;

public interface MemberDao {
	/**
	 * (사용자)개인회원 가입하기
	 * @param member
	 * @return
	 */
	int insertMember(Member member);
	
	/**
	 * (사용자)개인회원정보 수정하기
	 * @param member
	 * @return
	 */
	int updateMember(Member member);
	
	/**
	 * (사용자)개인회원 탈퇴하기
	 * (관리자)개인회원 강제탈퇴시키기
	 * @param memberId
	 * @return
	 */
	int deleteMemberById(String memberId);
	
	/**
	 * (관리자)전체개인회원정보 조회하기
	 * @return
	 */
	List<Member> selectMemberList();
	
	/**
	 * memberId를 매개변수로 받아 하나의 회원정보를 조회.
	 * (사용자)개인회원 로그인하기
	 * (사용자)개인회원정보조회하기
	 * @param memberId
	 * @return
	 */
	Member selectMemberById(String memberId);
	
	/**
	 * memberEmail를 매개변수로 받아 하나의 회원정보를조회.
	 * (사용자)개인회원 이메일 계정으로 아이디/비번 찾기
	 * @param email
	 * @return
	 */
	Member selectMemberByEmail(String memberEmail);
}
