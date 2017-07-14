package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.FridgerGroup;

public interface FridgerGroupService {

	/**
	 * 냉장고그룹 추가
	 * @param fg - 냉장고그룹
	 * @throws Exception
	 */
	void insertFridgerGroup(FridgerGroup fg) throws Exception;
	
	/**
	 * 냉장고그룹 탈퇴
	 * @param groupMemberId
	 * @throws Exception
	 */
	void deleteFridgerGroup(String groupMemberId) throws Exception;
	
	/**
	 * 회원id로 공유멤버 조회
	 * @param groupMemberId
	 * @return
	 */
	List<FridgerGroup> selectFridgerGroupByGroupMemberId(String groupMemberId);
	
	/**
	 * 한 냉장고의 공유멤버리스트 조회
	 * @param fridgerId
	 * @return
	 */
	List<FridgerGroup> selectFridgerGroupByFridgerId(int fridgerId);
	
	/**
	 * 한 냉장고의 공유멤버 수 조회
	 * @param fridgerId
	 * @return
	 */
	int selectFridgerGroupCount(int fridgerId);
	
}
