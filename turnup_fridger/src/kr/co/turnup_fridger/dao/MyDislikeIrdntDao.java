/**
 (DAO)MyDislikeIrdntDao
작성자 :  박연수
최초 작성일 
변경이력 
170706 (경혜) deleteMyDislikeIrdntByMemberId 메소드 추가
					deleteMyDislikeIrdntByIrdntId 메소드 추가
					selectMyDislikeIRdntByMemberIdAndIrdntId 메소드 추가
*/
package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.MyDislikeIrdnt;

public interface MyDislikeIrdntDao {

	/**
	 * 기피재료 입력
	 * @param irdnt
	 * @return
	 */
	int insertMyDislikeIrdnt(MyDislikeIrdnt irdnt);
	
	/**
	 * 기피재료 수정
	 * @param irdnt
	 * @return
	 */
	int updateMyDislikeIrdnt(MyDislikeIrdnt irdnt);
	
	/**
	 * 기피재료 삭제
	 * @param myDislikeIrdntKey
	 * @return
	 */
	int deleteMyDislikeIrdnt(int myDislikeIrdntKey);
	
	/**
	 * 기피재료 삭제 - memberId로 삭제
	 * @param memberId
	 * @return
	 */
	int deleteMyDislikeIrdntByMemberId(String memberId);
	
	/**
	 * 기피재료 삭제 - irdntId로 삭제
	 * @param irdntId
	 * @return
	 */
	int deleteMyDislikeIrdntByIrdntId(int irdntId);
	
	/**
	 * 회원id로 회원의 기피재료를 모두 불러오기.
	 * @param memberId
	 * @return
	 */
	List<MyDislikeIrdnt> selectMyDislikeIrdntByMemberId(String memberId);
	
	/**
	 * 회원 ID와 재료 ID로 기피재료 불러오기.
	 * @param mydislikeIrdnt
	 * @return
	 */
	MyDislikeIrdnt selectMyDislikeIRdntByMemberIdAndIrdntId(MyDislikeIrdnt myDislikeIrdnt);
	
	/**
	 * 기피재료의 pk인 key값으로 기피재료한가지를 불러오기.
	 * @param myDislikeIrdntKey
	 * @return
	 */
	MyDislikeIrdnt selectMyDislikeIrdntByMyDislikeIrdntKey(int myDislikeIrdntKey);
	
	
}
