package kr.co.turnup_fridger.service;

import java.util.Date;
import java.util.List;

import kr.co.turnup_fridger.vo.MyIrdnt;

public interface MyIrdntService {

	/**
	 * -식재료 생성 
	 * 재료id, 재료이름(사용자편집가능), 보관시작일,(유통기한),보관시작상태,
	 * @param myIrdnt
	 * @throws Exception 
	 */
	void createMyIrdnt(MyIrdnt myIrdnt) throws Exception;
	
	/**
	 * 식재료 수정
	 * @param myIrdnt
	 * @throws Exception 
	 */
	void updateMyIrdnt(MyIrdnt myIrdnt) throws Exception;
	
	/**
	 * 식재료 삭제
	 * @throws Exception 
	 */
	void removeMyIrdnt(int irdntKey) throws Exception;
	
	/**
	 * 냉장고 id로 모든 식재료 불러오기
	 */
	List<MyIrdnt> findAllMyIrdntByFridgerId(int fridgerId);
	
	/**
	 * 재료이름으로 식재료 찾기
	 * @param irdntName
	 * @return
	 */
	List<MyIrdnt> findMyIrdntByIrdntName(String irdntName, int fridgerId);
	
	/**
	 * 식재료의 현재 신선도를 계산해주는 서비스.
	 * 
	 * 유통기한이 있으면 그걸로. 현재 날짜와 비교해서 몇일 이하면 3-2-1로 리턴 
	 * 유통기한이 없으면 보관시작일*보관시작상태를 보관기간과 비교해서 현재날짜와 비교 
	 * @param myirdnt
	 * @return
	 */
	String getFreshLevel(MyIrdnt myirdnt);
	
	/**
	 * 나의 식재료key로 식재료를 찾기.
	 * @param IrdntId
	 * @return
	 */
	MyIrdnt fingMyIrdntBymyIrdntKey(int myIrdntKey);
	
	/**
	 * 보관시작일로 해당하는 식재료들 찾기.
	 * @param startDate
	 * @return
	 */
	List<MyIrdnt> findMyIrdntByStartDate(Date startDate,int fridgerId);
	
	/**
	 * 유통기한으로 해당하는 식재료들 찾기.
	 * @param endDate
	 * @return
	 */
	List<MyIrdnt> findMyIrdntByEndDate(Date endDate,int fridgerId);
	
	/**
	 * 신선도를 입력받아서 해당하는 식재료들 찾기.
	 * @param freshLevel
	 * @return
	 */
	List<MyIrdnt> findMyIrdntByFreshLevel(String freshLevel,int fridgerId);
	
	//추가 
	/**
	 * 신선도와 재료이름을 입력받아서 해당하는 나의 식재료들만 보여주기. 
	 * @param freshLevle
	 * @param irdntName
	 * @return
	 */
	List<MyIrdnt> findMyIrdntByFreshLevelAndIrdntName(String freshLevel, String irdntName,int fridgerId);
	
	
}


