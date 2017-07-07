/**
 (Service)MyDislikeIrdntService
작성자 :  박연수
최초 작성일 
변경이력 
170706 (경혜) removeMyDislikeIrdntByMemberId 메소드 추가
					removeMyDislikeIrdntByIrdntId 메소드 추가
*/
package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.MyDislikeIrdnt;

public interface MyDislikeIrdntService {

	/**
	 * 기피재료 추가
	 * @param irdnt
	 * @throws Exception 
	 */
	void createMyDislikeIrdnt(MyDislikeIrdnt irdnt) throws Exception;

	/**
	 * 기피재료 수정
	 * @param irdnt
	 * @throws Exception 
	 */
	void updateMyDislikeIrdnt(MyDislikeIrdnt irdnt) throws Exception;
	
	/**
	 * 기피재료 삭제
	 * @param myDislikeIrdntKey
	 * @throws Exception 
	 */
	void removeMyDislikeIrdnt(int myDislikeIrdntKey) throws Exception;
	
	/**
	 * 기피재료 삭제-해당 회원의 기피재료 삭제
	 * @param memberId
	 * @throws Exception
	 */
	void removeMyDislikeIrdntByMemberId(String memberId) ;
	
	/**
	 * 기피재료 삭제 -해당 재료의 기피재료 삭제
	 * @param irdntId
	 * @throws Exception
	 */
	void removeMyDislikeIrdntByIrdntId(int irdntId) throws Exception;
	
	/**
	 * 회원id로 기피재료 모두 불러오기
	 * @param memberId
	 * @return
	 */
	List<MyDislikeIrdnt> findMyDislikeIrdntByMemberId(String memberId);

	/**
	 * 기피재료의 key값으로 기피재료 가져오기 
	 * @param myDislikeIrdntKey
	 * @return
	 */
	MyDislikeIrdnt findMyDislikeIrdntBymyDislikeIrdntKey(int myDislikeIrdntKey);
}
