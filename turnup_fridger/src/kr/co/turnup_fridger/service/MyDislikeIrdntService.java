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
