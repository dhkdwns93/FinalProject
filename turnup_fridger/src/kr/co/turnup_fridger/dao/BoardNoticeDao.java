package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardNotice;

public interface BoardNoticeDao 
{
	
	/**
	 * BoardNotice 정보를  insert 하는 메소드 - 관리자
	 * @param boardNotice
	 * @return
	 * 작성자 : 김장규
	 */
	int insertBoardNotice(BoardNotice boardNotice);
	
	/**
	 * BoardNotice 정보를 update 하는 메소드 - 관리자
	 * @param id
	 * @return
	 * 작성자 : 김장규
	 */
	int updateBoardNotice(BoardNotice boardNotice);
	
	/**
	 * BoardNotice 정보를 delete 하는 메소드 - 관리자
	 * @param id
	 * @return
	 * 작성자 : 김장규
	 */
	int deleteBoardNoticeByid(int id);
	
	/**
	 * BoardNotice 목록을 보여주는 메소드
	 * @return
	 * 작성자 : 김장규
	 */
	List<BoardNotice> selectBoardNoticeList();
	
	/**
	 * BoardNotice 상세정보를 보여주는 메소드 
	 * @param id
	 * @return
	 * 작성자 : 김장규
	 */
	BoardNotice selectBoardNoticeById(int id);

	/**
	 * ITEMS로 BoardNotice 목록 정렬해주는 메소드
	 * @param items
	 * @return
	 * 작성자 : 김장규
	 */
	List<BoardNotice> selectBoardNoticeByItems(String items);
}