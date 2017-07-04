package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import kr.co.turnup_fridger.vo.BoardNotice;

public interface BoardNoticeService 
{
	/**
	 * 한개의 공지사항 정보를 등록 하는 메소드
	 * 작성자 - 김장규
	 * @param boardNotice
	 */
	void addBoardNotice(BoardNotice boardNotice);
	
	/**
	 * 공지사항 정보를 수정 하는 메소드
	 * 작성자 - 김장규
	 * @param boardNotice
	 */
	void updateBoardNotice(BoardNotice boardNotice);
	
	/**
	 * 매개변수로 받은 ID로 저장된 공지사항 삭제하는 메소드
	 * 작성자 - 김장규
	 * @param id
	 */
	void removeBoardNoticeById(int id);
	
	/**
	 * 저장된 공지사항 정보 중 매개변수 ID를 가진 정보 조회하는 메소드
	 * 작성자 - 김장규
	 * @param id
	 * @return
	 */
	BoardNotice findBoardNoticeById(int id);
	
	/**
	 * 저장된 공지사항 정보를  전체 조회 조회하는 메소드
	 * 작성자 - 김장규	
	 * @return
	 */
	Map<String, Object> findBoardNoticeList(int page);
	
	/**
	 * 저장된 공지사항 정보 중 매개변수 ITEMS을 가진 정보 조회하는 메소드
	 * 작성자 - 김장규
	 * @param items
	 * @return
	 */
	Map<String, Object> findBoardNoticeByItmes(String items,int page);
}
