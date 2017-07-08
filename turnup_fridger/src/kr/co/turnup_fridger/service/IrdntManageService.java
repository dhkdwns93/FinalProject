package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.exception.DuplicateIrdntException;
import kr.co.turnup_fridger.exception.NoneIrdntException;
import kr.co.turnup_fridger.vo.IrdntManage;

public interface IrdntManageService {

	/**
	 * 재료 등력
	 * @param irdnt
	 * @return 
	 * @throws Exception 
	 */
	void createIrdnt(IrdntManage irdnt) throws DuplicateIrdntException;
	
	/**
	 * 재료수정
	 * @param irdnt
	 * @return 
	 * @throws Exception 
	 */
	void updateIrdnt(IrdntManage irdnt) throws NoneIrdntException;
	
	/**
	 * 재료삭제
	 * @param irdntId
	 * @return 
	 * @throws Exception 
	 */
	void removeIrdnt(int irdntId) throws NoneIrdntException;
	
	/**
	 * 모든 재료 불러오기
	 * @return
	 */
	List<IrdntManage> findAllIrdnt();
	
	/**
	 * 재료id로 재료 검색
	 * @param irdntId
	 * @return
	 */
	IrdntManage findIrdntByIrdntId(int irdntId);
	
	/**
	 * 재료명(부분일치)과 카테고리(전체포함 각각)로 재료검색 
	 * @param irdntName
	 * @param irdntCategory
	 * @return
	 */
	List<IrdntManage> findIrdntsByKeyword(String irdntName, String irdntCategory);
	
	/**
	 * 카테고리명들을 불러오는 메서드.
	 * @return
	 */
	List<String> findAllIrdntCategory();
	
	/**
	 * 재료명(부분일치)으로 재료들의 목록을 가져오기.
	 * @param irdntName
	 * @return
	 */
	List<IrdntManage> findIrdntByName(String irdntName);
	
}
