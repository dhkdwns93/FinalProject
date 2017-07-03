/**
 (Dao)adminDao
작성자 :  김경혜
최초 작성일 170627
변경이력 
*/
package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.Admin;

public interface AdminDao {
	/**
	 * (마스터관리자)관리자 등록하기-authority 테이블에도 등록
	 * @param admin
	 * @return
	 */
	int insertAdmin(Admin admin);
	
	/**
	 * (관리자)관리자개인정보 수정하기-권한제외-authority 테이블에도 수정
	 * @param admin
	 * @return
	 */
	int updateAdmin(Admin admin);
	
	/**
	 * (마스터관리자)관리자권한(관리자,마스터관리자) 수정하기-authority 테이블에도 수정
	 * @param admin
	 * @return
	 */
	int updateAuthority(Admin admin);
	
	/**
	 * (마스터관리자)관리자 탈퇴시키기-authority 테이블에도 삭제
	 * @param adminId
	 * @return
	 */
	int deleteAdminById(String adminId);
	
	/**
	 * (관리자)전체관리자 등록정보 조회하기.
	 * @return
	 */
	List<Admin> selectAdminList();
	
	/**
	 * adminId를 매개변수로 받아 하나의 관리자 정보를 조회.
	 * (관리자)관리자 로그인하기
	 * (관리자)관리자 개인정보 수정하기
	 * @param adminId
	 * @return
	 */
	Admin selectAdminById(String adminId);
}
