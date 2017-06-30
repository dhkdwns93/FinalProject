package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.IrdntManage;

public interface IrdntManageService {

	/**
	 * 재료 등력
	 * @param irdnt
	 * @throws Exception 
	 */
	void createIrdnt(IrdntManage irdnt) throws Exception;
	
	/**
	 * 재료수정
	 * @param irdnt
	 * @throws Exception 
	 */
	void updateIrdnt(IrdntManage irdnt) throws Exception;
	
	/**
	 * 재료삭제
	 * @param irdntId
	 * @throws Exception 
	 */
	void removeIrdnt(int irdntId) throws Exception;
	
	/**
	 * 모든 재료 불러오기
	 * @return
	 */
	List<IrdntManage> findAllIrdnt();
	
	/**
	 * 재료명으로 재료검색 (부분일치)
	 * @param irdntName
	 * @return
	 */
	List<IrdntManage> findIrdntByIrdntName(String irdntName);
 	
	/**
	 * 재료id로 재료 검색
	 * @param irdntId
	 * @return
	 */
	IrdntManage findIrdntByIrdntId(int irdntId);
	
	/**
	 * 카테고리로 재료들 검색
	 * @param irdntCategory
	 * @return
	 */
	List<IrdntManage> fingIrdntByIrdntCategory(String irdntCategory);
	
}
