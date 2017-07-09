package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardFree;

public interface BoardFreeDao {
	
	/**
	 * BoardFree 정보를 insert 하는 메소드
	 * @param boardFree
	 * @return
	 * 작성자 : 김장규
	 */
	int insertBoardFree(BoardFree boardFree);
	/**
	 * BoardFree 정보를 insert 하는 메소드
	 * @param boardFree
	 * @return
	 * 작성자 : 김장규
	 */
	int updateBoardFree(BoardFree boardFree);
	
	/**
	 * BoardFree 정보를 delete 하는 메소드(댓글과 함께 삭제)
	 * @param id
	 * @return
	 */
	int deleteBoardFree(int boardFreeId);
	

	/**
	 * 조회수 증가
	 * @param boardFreeHits
	 */
	int increaseViewcnt(int boardFreeId);
	
	/**
	 * 모든 BoardFree의 전체수를 반환
	 * @param session
	 * @return
	 */
	int selectBoardFreeCount();
	
	/**
	 * BoardFree 목록을 보여주는 메소드
	 * @return
	 */
	List<BoardFree> selectBoardFreeList(int startIndex, int endIndex);
	

	/**
	 * BoardFree 조회수로 전체 조회
	 * @param boardFreeHits
	 * @return
	 */
	List<BoardFree> selectBoardFreeByBoardFreeHits(int startIndex, int endIndex);
	
	
	
	/**
	 * 모든 BoardFree의 아이디 수를 반환
	 * @param session
	 * @return
	 */
	int selectBoardFreeByMemberIdCount(String memberId);
	
	
	/**
	 * BoardFree 아이디로  조회
	 * @param boardFreeHits
	 * @return
	 */
	List<BoardFree> selectBoardFreeByMemberId(String memberId,int startIndex, int endIndex);
	
	
	/**
	 * 모든 BoardFree의 제목 수를 반환
	 * @param session
	 * @return
	 */
	int selectBoardFreeByTitleCount(String boardFreeTitle);
	
	
	/**
	 * BoardFree 제목으로  조회
	 * @param boardFreeHits
	 * @return
	 */
	List<BoardFree> selectBoardFreeByTitle(String boardFreeTitle,int startIndex, int endIndex);	
	
	
	/**
	 * BoardFree 상세정보(댓글 상세정보 포함)를 보여주는 메소드
	 * @param id
	 * @return
	 */
	BoardFree selectBoardFreeByboardFreeId(int boardFreeId);
	
	List<BoardFree> test(String boardFreeTitle);
	
	
	

	
}
