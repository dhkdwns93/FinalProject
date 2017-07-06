package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.exception.DuplicatedFridgerException;
import kr.co.turnup_fridger.exception.FindFridgerFailException;
import kr.co.turnup_fridger.exception.FindMemberFailException;
import kr.co.turnup_fridger.vo.Fridger;

public interface FridgerService {
	
	/**
	 * 냉장고 생성 서비스
	 * @param fridger
	 * @return
	 * @throws Exception 
	 */
	void createFridger(Fridger fridger) throws DuplicatedFridgerException;
	
	/**
	 * 냉장고 정보 수정 서비스
	 * @param fridger
	 * @throws Exception 
	 */
	void updateFridger(Fridger fridger) throws FindFridgerFailException, DuplicatedFridgerException, FindMemberFailException ;
	
	/**
	 * 냉장고 삭제 서비스
	 * @param fridger
	 * @throws Exception 
	 */
	void removeFridger(int fridgerId) throws FindFridgerFailException;
	
	
	/**
	 * 모든 냉장고 목록 보기
	 * @return
	 */
	List<Fridger> findFridgerAll();
	
	/**
	 * 냉장고 ID로 냉장고 조회 서비스
	 * @param fridgerId
	 * @return
	 */
	Fridger findFridgerByFridgerId(int fridgerId);
	
	/**
	 * 냉장고 ID로 냉장고와 냉장고 속 재료들 조회 서비스
	 * @param fridgerId
	 * @return
	 */
	Fridger findFridgerAndIrdntByFridgerId(int fridgerId);
	
	/**
	 * 냉장고  ID로 냉장고와 냉장고 공유하는 멤버 그룹 조회 서비스
	 * @param fridgerId
	 * @return
	 */
	Fridger findFridgerAndFridgerGroupByFridgerId(int fridgerId);
	
	
	/**
	 * 냉장고명으로 냉장고 조회 서비스
	 * @param fridgerId
	 * @return
	 */
	List<Fridger> findFridgerByFridgerName(String fridgerName);
	
	/**
	 * 냉장고명으로 냉장고와 냉장고 속 재료들 조회 서비스
	 * @param fridgerId
	 * @return
	 */
	List<Fridger> findFridgerAndIrdntByFridgerName(String fridgerName);
	
	/**
	 * 냉장고명으로 냉장고와 냉장고 공유하는 멤버 그룹 조회 서비스
	 * @param fridgerId
	 * @return
	 */
	List<Fridger> findFridgerAndFridgerGroupByFridgerName(String fridgerName);
	
	/**
	 *  냉장고 주인회원 ID로 냉장고 찾기 
	 * @param memberId
	 * @return
	 */
	List<Fridger> findFridgerByOwner(String memberId);
	
	/**
	 * 냉장고 주인회원 ID로 냉장고와 냉장고 공유하는 멤버 그룹 조회 서비스
	 * @param memberId
	 * @return
	 */
	List<Fridger> findFridgerAndFridgerGroupByOwnerId(String memberId);
	
	/**
	 *  냉장고 주인회원 ID로  냉장고와 냉장고 속 재료들 조회 서비스
	 * @param memberId
	 * @return
	 */
	List<Fridger> findFridgerAndIrdntByOwnerId(String memberId);
	

}
