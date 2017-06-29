package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardQnA;

public interface BoardQnAService {

	/**
	 * 한개의 QnA 정보를 등록 하는 메소드
	 * @param boardQnA
	 * 작성자 - 김장규
	 */
	void addBoardQnA(BoardQnA boardQnA);
	
	/**
	 * QnA 정보를 수정하는 메소드
	 * @param boardQnA
	 * 작성자 - 김장규
	 */
	void updateBoardQnA(BoardQnA boardQnA);
	
	/**
	 * 매개변수로 받은 ID로 저장된 QnA 정보를 삭제하는 메소드(댓글 포함)
	 * @param id
	 * 작성자 - 김장규
	 */
	void removeBoardQnA(int id);
	
	/**
	 * 저장된 QnA 정보를  전체 조회 조회하는 메소드
	 * @return
	 * 작성자 - 김장규
	 */
	List<BoardQnA> findBoardQnAList();
	
	/**
	 * 저장된 QnA 정보 중 매개변수 ID를 가진 정보 조회하는 메소드
	 * @param id
	 * @return
	 * 작성자 - 김장규
	 */
	BoardQnA findBoardQnAById(int id);
	
	/**
	 * 저장된 QnA 정보 중 매개변수 MemberID를 가진 정보 조회하는 메소드
	 * @param id
	 * @return
	 * 작성자 - 김장규
	 */
	List<BoardQnA> findBoardQnAByMemberId(String id);
}
