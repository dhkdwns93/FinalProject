package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardQnA;

public interface BoardQnADao {

	/*
	 * BoardQnA 정보를 insert 하는 메소드 - 회원
	 * 작성자 : 김장규
	 */
	int insertBoardQnA(BoardQnA boardQnA);
	
	/*
	 * BoardQnA 정보를 update 하는 메소드 - 해당 글 작성자
	 * 작성자 : 김장규
	 */
	int updateBoardQnA(BoardQnA boardQnA);
	
	/*
	 * BoardQnA 정보를 delete 하는 메소드(댓글과 함께 삭제) - 관리자, 회원
	 * 작성자 : 김장규
	 */
	int deleteBoardQnA(int id);
	
	/*
	 * 모든 QnA의 전체수를 반환
	 * 작성자 : 김장규 
	 */
	int selectBoardQnACount();

	/*
	 * BoardQnA 목록을 보여주는 메소드
	 * 작성자 : 김장규
	 */
	List<BoardQnA> selectBoardQnAList(int startIndex, int endIndex);
	
	/*
	 * 매개변수 memberID을 가진 정보 BoardQnA 목록수를 반환
	 */
	int selectBoardQnAByMemberIdCount(String memberId);
	
	/*
	 * 매개변수 memberID을 가진 정보 BoardQnA 목록 보여주는 메소드
	 * 작성자 : 김장규
	 */
	List<BoardQnA> selectBoardQnAByMemberId(String memberId,int startIndex, int endIndex);

	
	/*
	 * BoardQnA 상세정보(댓글 상세정보 포함)를 보여주는 메소드 - 해당글 작성자, 관리자
	 * 작성자 : 김장규
	 */
	BoardQnA selectBoardQnAById(int id);
}
