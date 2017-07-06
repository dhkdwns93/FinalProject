package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardQnA;

public interface BoardQnADao {

	/**
	 * BoardQnA 정보를 insert 하는 메소드
	 * @param boardQnA
	 * @return
	 * 작성자 : 김장규
	 */
	int insertBoardQnA(BoardQnA boardQnA);
	
	/**
	 * BoardQnA 정보를 update 하는 메소드
	 * @param boardQnA
	 * @return
	 * 작성자 : 김장규
	 */
	int updateBoardQnA(BoardQnA boardQnA);
	
	/**
	 * BoardQnA 정보를 delete 하는 메소드(댓글과 함께 삭제)
	 * @param id
	 * @return
	 * 작성자 : 김장규
	 */
	int deleteBoardQnA(int id);
	
	/**
	 * 모든 QnA의 전체수를 반환
	 * @param session
	 * @return
	 */
	int selectBoardQnACount();

	/**
	 * BoardQnA 목록을 보여주는 메소드
	 * @return
	 * 작성자 : 김장규
	 */
	List<BoardQnA> selectBoardQnAList(int startIndex, int endIndex);
	
	
	
	/**
	 * BoardQnA 상세정보(댓글 상세정보 포함)를 보여주는 메소드
	 * @param id
	 * @return
	 * 작성자 : 김장규
	 */
	BoardQnA selectBoardQnAById(int id);
	
	
	/**
	 * MEMBER QnA의 전체수를 반환
	 * @param session
	 * @return
	 */
	int selectBoardQnAByMemberIdCount(String memberId);
	
	
	/**
	 * memberID로 BoardQnA 목록 보여주는 메소드 
	 * @param id
	 * @return
	 * 작성자 : 김장규
	 */
	List<BoardQnA> selectBoardQnAByMemberId(String memberId,int startIndex, int endIndex);
}
