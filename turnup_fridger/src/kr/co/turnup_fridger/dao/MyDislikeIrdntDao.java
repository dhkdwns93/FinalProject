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
	 * 회원id로 회원의 기피재료를 모두 불러오기.
	 * @param memberId
	 * @return
	 */
	List<MyDislikeIrdnt> selectMyDislikeIrdntByMemberId(String memberId);
	
	/**
	 * 기피재료의 pk인 key값으로 기피재료한가지를 불러오기.
	 * @param myDislikeIrdntKey
	 * @return
	 */
	MyDislikeIrdnt selectMyDislikeIrdntByMyDislikeIrdntKey(int myDislikeIrdntKey);
	
	
}
