package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.co.turnup_fridger.vo.BoardFree;

public interface BoardFreeService {

	/*
	 * BoardFree 등록 - 회원
	 * 작성자 : 김장규
	 */
	void addBoardFree(BoardFree boardFree);
	
	
	/*
	 * BoardFree 정보를 수정 - 작성자
	 * 작성자 : 김장규
	 */
	void updateBoardFree(BoardFree boardFree);
	
	
	/*
	 * BoardFree 삭제 - 관리자, 작성자
	 * 작성자 : 김장규
	 */
	void removeBoardFree(int id);
	
	/*
	 * BoardFree 조회수 증가
	 * 작성자 : 김장규
	 */
	void increasHit(int boardFreeId,HttpSession session) throws Exception;
	
	/*
	 * BoardFree 전체 목록 조회
	 * 작성자 : 김장규
	 */
	Map<String, Object>  selectBoardFreeList(int page);
	
	
	/*
	 * BoardFree 조회수로 조회
	 * 작성자 : 김장규
	 */
	Map<String, Object> selectBoardFreeByBoardFreeHits(int page);
	
	
	/*
	 * BoardFree 아이디 조회
	 * 작성자 : 김장규
	 */
	Map<String, Object> selectBoardFreeByMemberId(String memberId,int page);
	
	/*
	 * BoardFree 제목 조회
	 * 작성자 : 김장규
	 */
	Map<String, Object> selectBoardFreeByTitle(String boardFreeTitle,int page);
	
	
	
	/*
	 * BoardFree 상세 보기
	 * 작성자 : 김장규
	 */
	BoardFree selectBoardFreeByboardFreeId(int boardFreeId);

}
