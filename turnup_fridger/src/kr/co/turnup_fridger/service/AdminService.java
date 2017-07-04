/**
 (Service)AdminService
작성자 :  김경혜
최초 작성일 170703
변경이력
*/
package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.exception.RegisterAdminFailException;
import kr.co.turnup_fridger.vo.Admin;

/**
 * 관리자 관련 업무로직 처리
 */
public interface AdminService {
	
	/**
	 * 관리자개인정보 조회하기
	 * @param adminId
	 * @return
	 */
	Admin inquiryAdminInfo(String adminId);
	
	/**
	 * 관리자 개인정보 수정하기 -authority테이블에도 수정-권한은 조회만 가능
	 * @return
	 */
	void changeAdminInfo(Admin admin);
	
	/**
	 * 전체관리자등록정보조회
	 * @return
	 */
	List<Admin> inquiryAdminList();
	
	/**
	 * (마스터관리자)관리자 등록하기-authority테이블에도 등록
	 * @param admin
	 * @throws RegisterAdminFailException
	 */
	void registerAdmin(Admin admin) throws RegisterAdminFailException;
	
	/**
	 * (마스터관리자)관리자권한 수정하기-authority테이블도 수정
	 * @param adminId
	 * @param adminAuthority
	 */
	void changeAdminAuthority(String adminId, String adminAuthority);
	
	/**
	 * (마스터관리자)관리자 탈퇴시키기 -authority테이블도 삭제- 마스터계정은 탈퇴 불가(후에 수정)
	 * @param adminId
	 */
	void deleteAdmin(String adminId);
} 
