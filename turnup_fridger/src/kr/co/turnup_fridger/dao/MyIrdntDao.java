package kr.co.turnup_fridger.dao;

import java.util.Date;
import java.util.List;

import kr.co.turnup_fridger.vo.MyIrdnt;

public interface MyIrdntDao {

	/**
	 * 나의 식재료 테이블에 식재료를 입력.
	 * @param irdnt
	 * @return
	 */
	int insertMyIrdnt(MyIrdnt irdnt);
	
	/**
	 * 나의 식재료 테이블에 입력된 식재료를 수정.
	 * @param irdnt
	 * @return
	 */
	int updateMyIrdnt(MyIrdnt irdnt);
	
	/**
	 * 나의 식재료 테이블에  식재료의 key를 받아서 그 재료를 삭제.
	 * @param irdntId
	 * @return
	 */
	int deleteMyIrdnt(int irdntKey);

	/**
	 * 모든 식재료들의 정보를 가져온다.
	 * @return
	 */
	List<MyIrdnt> selectAllInfoMyIrdnt();
	
	/**
	 * irdntKey로 해당하는 식재료의 정보를 가져온다. 
	 * @param irdntId
	 * @param fridgerId
	 * @return
	 */
	MyIrdnt selectMyIrdntByKey(int irdntKey);
	
	/**
	 * 재료명으로 검색하여 해당하는 나의 식재료의 정보를 가져온다. (부분일치) 
	 * @param irdntName
	 * @return
	 */
	List<MyIrdnt> selectMyIrdntByName(String irdntName,int fridgerId);
	
	
	/**
	 * 신선도를 입력받아서 해당하는 음식들 가져오기
	 * @return
	 */
	List<MyIrdnt> selectMyStaleIrdnt(String freshLevel,int fridgerId);
	
	
	/**
	 * 유통기한 임박인 상태의 음식들만 가져오기 
	 * @return
	 */
	List<MyIrdnt> selectSoonExpireMyIrdnt(Date endDate,int fridgerId);
	
	
	/**
	 * 보관시작일로 검색하여 음식들을 가져오기
	 * @return
	 */
	List<MyIrdnt> selectMyIrdntByStartDate(Date startDate,int fridgerId);
	
	/**
	 * 현재 갖고있는 모든 식재료의 종류 수
	 * @return
	 */
	int selectCountAllMyIrdnts(int fridgerId);
	
	/**
	 * 냉장고id로 전체 식재료목록 가져오기
	 * @param fridgerId
	 * @return
	 */
	List<MyIrdnt> selectMyIrdntByFridgerId(int fridgerId);
	
	
	/**
	 * 신선도와 재료명으로 검색하여 해당하는 나의 식재료들만 불러오기.
	 * @param freshLevel
	 * @param irdntName
	 * @return
	 */
	List<MyIrdnt> selectMyIrdntByFreshLevelAndIrdntName(String freshLevel, String irdntName,int fridgerId);
	
	/**
	 * 회원이 가진 개인식재료들을 모두 불러오기
	 * @param memberId
	 * @return
	 */
	List<MyIrdnt> selectMyIrdntBymemberId(String memberId);
	
}
