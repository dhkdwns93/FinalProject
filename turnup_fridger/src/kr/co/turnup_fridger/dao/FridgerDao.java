package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.Fridger;

public interface FridgerDao {
	
	/**
	 * 냉장고 생성하기
	 * @param fridger
	 * @return
	 */
	int insertFridger(Fridger fridger);
	
	/**
	 * 냉장고 애칭, 주인 수정하기
	 * @param fridger
	 * @return
	 */
	int updateFridger(Fridger fridger);
	
	/**
	 * 냉장고 번호로 삭제하기
	 * @param fridgerId
	 * @return
	 */
	int deleteFridger(int fridgerId);
	
	
//	select
	
	List<Fridger> selectFridgerAll();
	
	/**
	 * 냉장고 ID로 냉장고 조회
	 * @param fridgerId
	 * @return
	 */
	Fridger selectFridgerByFridgerId(int fridgerId);
	
	/**
	 * 냉장고ID로 냉장고와 냉장고 속 재료 조회
	 * @param fridgerId
	 * @return
	 */
	Fridger selectFridgerAndIrdntByFridgerId(int fridgerId);
	
	/**
	 * 냉장고ID로 냉장고와 냉장고 공유하는 멤버 조회
	 * @param fridgerId
	 * @return
	 */
	Fridger selectFridgerAndFridgerGroupByFridgerId(int fridgerId);
	
	
	/**
	 * 냉장고명으로 조회 
	 * @param FridgerName
	 * @return
	 */
	Fridger selectFridgerByFridgerFullName(String fridgerName);
	
	/**
	 * 냉장고명으로 조회 (부분검색)
	 * @param FridgerName
	 * @return
	 */
	List<Fridger> selectFridgerByFridgerName(String fridgerName);
	
	/**
	 * 냉장고명으로 냉장고와 냉장고 속 재료 조회 
	 * @param FridgerName
	 * @return
	 */
	List<Fridger> selectFridgerAndIrdntByFridgerName(String fridgerName);
	
	/**
	 * 냉장고명으로 냉장고와 냉장고 공유하는 멤버 조회
	 * @param FridgerName
	 * @return
	 */
	List<Fridger> selectFridgerAndFridgerGroupByFridgerName(String fridgerName);
	
	/**
	 * 냉장고 주인회원으로 조회
	 * @param memberId
	 * @return
	 */
	List<Fridger> selectFridgerByOwnerId(String memberId);

	/**
	 * 냉장고 주인회원으로 냉장고와 냉장고 공유하는 멤버 조회
	 * @param memberId
	 * @return
	 */
	List<Fridger> selectFridgerAndFridgerGroupByOwnerId(String memberId);
	
	/**
	 * 냉장고 주인회원으로 냉장고와 냉장고 속 재료 조회 
	 * @param memberId
	 * @return
	 */
	List<Fridger> selectFridgerAndIrdntByOwnerId(String memberId);

	
	/**************************페이지 처리*************************/
	
	List<Fridger> selectFridgerByFridgerNamePaging(String fridgerName, int startIndex,int endIndex);
	
	List<Fridger> selectFridgerByOwnerIdPaging(String memberId, int startIndex,int endIndex);

	int selectCountFridgerByFridgerName(String fridgerName);
	
	int selectCountFridgerByOwnerId(String memberId);
	
	
}

