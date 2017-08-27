package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardNotice;

public interface BoardNoticeDao 
{
	
	/*
	 * BoardNotice 정보를  insert 하는 메소드 - 관리자
	 * 작성자 : 김장규
	 */
	int insertBoardNotice(BoardNotice boardNotice);
	
	/*
	 * BoardNotice 정보를 update 하는 메소드 - 관리자
	 * 작성자 : 김장규
	 */
	int updateBoardNotice(BoardNotice boardNotice);
	
	/*
	 * BoardNotice 정보를 delete 하는 메소드 - 관리자
	 * 작성자 : 김장규
	 */
	int deleteBoardNoticeByid(int id);
	
	
	/*
	 * 모든 공자사항의 전체수를 반환
	 * 작성자 : 김장규 
	 */
	int selectBoardNoticeCount();
	
	/*
	 * BoardNotice 목록을 보여주는 메소드
	 * 작성자 : 김장규
	 */
	List<BoardNotice> selectBoardNoticeList(int startIndex, int endIndex);
	
	
	/*
	 * BoardNotice 상세정보를 보여주는 메소드 
	 * 작성자 : 김장규
	 */
	BoardNotice selectBoardNoticeById(int id);

	/*
	 * 매개변수 ITEMS을 가진 정보 BoardNotice 목록 수를 반환
	 * 작성자 : 김장규 
	 */	
	
	int selectBoardNoticeByItmesCount(String items);
	
	/*
	 * 매개변수 ITEMS을 가진 정보 BoardNotice 목록 보여주는 메소드
	 * 작성자 : 김장규
	 */
	List<BoardNotice> selectBoardNoticeByItems(String items, int startIndex, int endIndex);
}
