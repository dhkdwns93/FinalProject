/**
 (Service)AuthorityService
작성자 :  김경혜
최초 작성일 170706
변경이력
*/
package kr.co.turnup_fridger.service;

import kr.co.turnup_fridger.vo.Authority;

/**
 * 전체사용자 관련 업무로직 처리
 */
public interface AuthorityService {
	/**
	 * 로그인아이디로 전체사용자 조회하기
	 * @param loginId
	 * @return
	 */
	Authority findAuthority(String loginId);
}
