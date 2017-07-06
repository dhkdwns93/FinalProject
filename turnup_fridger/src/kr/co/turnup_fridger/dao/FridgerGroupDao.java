package kr.co.turnup_fridger.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.co.turnup_fridger.vo.FridgerGroup;

public interface FridgerGroupDao {

	/**
	 * 한개의 냉장고그룹을 생성하는 메소드
	 * @param fg
	 * @return
	 */
	public int insertFridgerGroup(FridgerGroup fg);
	
	/**
	 * 냉장고 공유멤버 탈퇴
	 * @param groupJoinSeq
	 * @return
	 */
	public int deleteFridgerGroup(String groupMemberId);
	
	/**
	 * 냉장고 삭제로인한 모든 공유 멤버 삭제
	 * @param groupJoinSeq
	 * @return
	 */
	public int deleteFridgerGroupByFridgerId(int groupFridgerId);
	
	/**
	 * 회원id로 공유멤버 조회
	 * @param groupMemberId
	 * @return
	 */
	public FridgerGroup selectFridgerGroupByGroupMemberId(String groupMemberId);

	/**
	 * 한 냉장고의 공유멤버 리스트 조회(가입순서 정렬)
	 * @param fridgerId
	 * @return
	 */
	public List<FridgerGroup> selectFridgerGroupByFridgerId(int fridgerId);
	
	/**
	 * 한 냉장고의 공유멤버 수 조회
	 * @param fridgerId
	 * @return
	 */
	public int selectFridgerGroupCount(int fridgerId);
	
}