/**
 (Dao)authorityDao
작성자 :  김경혜
최초 작성일 170630
변경이력 
*/
package kr.co.turnup_fridger.dao;

import kr.co.turnup_fridger.vo.Authority;

public interface AuthorityDao {
	/**
	 * authority테이블에 유저 추가
	 * @param authority
	 * @return
	 */
	int insertAuthority(Authority authority);
	
	/**
	 * authority테이블에 유저정보 수정
	 * @param authority
	 * @return
	 */
	int updateAuthority(Authority authority);
	
	/**
	 * authority테이블에 유저 삭제
	 * @param loginId
	 * @return
	 */
	int deleteAuthority(String loginId);
	
	/**
	 * loginId를 매개변수로 받아 하나의 유저 정보를 조회.
	 * @param loginId
	 * @return
	 */
	Authority selectAuthorityById(String loginId);
}