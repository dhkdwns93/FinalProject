package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardFree;

public interface BoardFreeDao {
	
	/*
	 * BoardFree 정보를 insert 하는 메소드  - 회원
	 * 작성자 : 김장규
	 */
	int insertBoardFree(BoardFree boardFree);
	
	/*
	 * BoardFree 정보를 update 하는 메소드 - 작성자
	 * 작성자 : 김장규
	 */
	int updateBoardFree(BoardFree boardFree);
	
	/*
	 * BoardFree 정보를 delete 하는 메소드(댓글과 함께 삭제) - 관리자, 작성자
	 * 작성자 : 김장규
	 */
	int deleteBoardFree(int boardFreeId);
	

	/*
	 * 조회수 증가
	 * 작성자 : 김장규
	 */
	int increaseViewcnt(int boardFreeId);
	
	/*
	 * 모든 BoardFree의 전체수를 반환
	 * 작성자 : 김장규
	 */
	int selectBoardFreeCount();
	
	/*
	 * BoardFree 목록을 보여주는 메소드
	 * 작성자 : 김장규
	 */
	List<BoardFree> selectBoardFreeList(int startIndex, int endIndex);
	

	/*
	 * BoardFree 조회수로 전체 조회
	 * 작성자 : 김장규
	 */
	List<BoardFree> selectBoardFreeByBoardFreeHits(int startIndex, int endIndex);
	
	
	
	/*
	 * BoardFree 아이디 수 반환
	 * 작성자 : 김장규
	 */
	int selectBoardFreeByMemberIdCount(String memberId);
	
	
	/*
	 * BoardFree 아이디로  조회
	 * 작성자 : 김장규
	 */
	List<BoardFree> selectBoardFreeByMemberId(String memberId,int startIndex, int endIndex);
	
	
	/*
	 * BoardFree의 제목 수를 반환
	 * 작성자 : 김장규
	 */
	int selectBoardFreeByTitleCount(String boardFreeTitle);
	
	
	/*
	 * BoardFree 제목으로  조회
	 * 작성자 : 김장규
	 */
	List<BoardFree> selectBoardFreeByTitle(String boardFreeTitle,int startIndex, int endIndex);	
	
	
	/*
	 * BoardFree 상세정보(댓글 상세정보 포함)를 보여주는 메소드
	 * 작성자 : 김장규
	 */
	BoardFree selectBoardFreeByboardFreeId(int boardFreeId);
	
}
