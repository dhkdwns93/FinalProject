package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.co.turnup_fridger.vo.BoardFree;

public interface BoardFreeService {

	//등록
	void addBoardFree(BoardFree boardFree);
	
	
	//수정
	void updateBoardFree(BoardFree boardFree);
	
	
	//삭제
	void removeBoardFree(int id);
	
	//조회수
	void increasHit(int boardFreeId,HttpSession session) throws Exception;
	
	//전체 리스트
	Map<String, Object>  selectBoardFreeList(int page);
	
	
	//조회수 조회
	Map<String, Object> selectBoardFreeByBoardFreeHits(int page);
	
	
	//아이디 조회
	Map<String, Object> selectBoardFreeByMemberId(String memberId,int page);
	
	//제목 조회
	Map<String, Object> selectBoardFreeByTitle(String boardFreeTitle,int page);
	
	
	
	//상세페이지
	BoardFree selectBoardFreeByboardFreeId(int boardFreeId);
	
	
	
	List<BoardFree> test(String boardFreeTitle);
}
