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
	 * 나의 식재료 테이블에 입력된 식재료의 재료id와 냉장고id를 받아서 그 재료를 삭제.
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
	 * 식재료 id와 냉장고id를 입력해서 해당하는 식재료의 정보를 가져온다. 
	 * @param irdntId
	 * @param fridgerId
	 * @return
	 */
	MyIrdnt selectMyIrdntById(int irdntId);
	
	/**
	 * 재료명으로 검색하여 해당하는 나의 식재료의 정보를 가져온다.  
	 * @param irdntName
	 * @return
	 */
	List<MyIrdnt> selectMyIrdntByName(String irdntName);
	
	
	/**
	 * 신선도가 나쁜 상태인 음식들만 가져오기
	 * @return
	 */
	List<MyIrdnt> selectMyStaleIrdnt(String freshLevel);
	
	
	/**
	 * 유통기한 임박인 상태의 음식들만 가져오기 
	 * @return
	 */
	List<MyIrdnt> selectSoonExpireMyIrdnt(Date endDate);
	
	
	/**
	 * 보관시작일로 검색하여 음식들을 가져오기
	 * @return
	 */
	List<MyIrdnt> selectMyIrdntByStartDate(Date startDate);
	
	/**
	 * 현재 갖고있는 모든 식재료의 종류 수
	 * @return
	 */
	int selectCountAllMyIrdnts();
	
	
	
	
	
}
