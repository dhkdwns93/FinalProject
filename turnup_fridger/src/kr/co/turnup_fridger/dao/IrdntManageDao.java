package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.IrdntManage;

public interface IrdntManageDao {

	/**
	 * 재료입력
	 * @return
	 */
	int insertIrdnt(IrdntManage irdnt);
	
	/**
	 * 재료수정
	 * @return
	 */
	int updateIrdnt(IrdntManage irdnt);
	
	/**
	 * 재료삭제
	 * @return
	 */
	int deleteIrdnt(int irdntId);
	
	/**
	 * 재료 전부 조회
	 * @return
	 */
	List<IrdntManage> selectAllIrdnt(int startIndex,int endIndex);
	
	/**
	 * 페이징안한 재료 전체조회
	 * @return
	 */
	List<IrdntManage> selectAllIrdntNotPaging();
	
	/**
	 * 재료 전부조회한 수.
	 * @return
	 */
	int selectAllIrdntCount();
	
	/**
	 * 재료명으로 검색(완전일치)
	 * @param irdntName
	 * @return
	 */
	List<IrdntManage> selectIrdntByFullName(String irdntName);
	
	
	/**
	 * 재료 id로 재료조회
	 * @return
	 */
	IrdntManage selectIrdntById(int irdntId);
	
	
	/**
	 * 재료명(부분일치)과 카테고리(전체포함)을 받아서 재료명을 검색.
	 * @param irdntName
	 * @param irdntCategory
	 * @return
	 */
	List<IrdntManage> selectIrdntsBykeyword(String irdntName, String irdntCategory,int startIndex,int endIndex);
	
	
	//==============
	/**
	 * 재료명으로 재료들 조회 (부분일치)
	 * @return
	 */
	List<IrdntManage> selectIrdntByName(String irdntName);
	
	/**
	 * 재료분류로 재료들 조회
	 * @return
	 */
	List<IrdntManage> selectIrdntByCategory(String irdntCategory);
	
	/**
	 * 카테고리명들을 불러오는 메서드.
	 * @return
	 */
	List<String> selectAllIrdntCategory();
	
	/**
	 * 재료명과 카테고리로 검색한 것의 총 갯수.
	 * @param irdntName
	 * @param irdntCategory
	 * @return
	 */
	int selectIrdntsBykeywordCount(String irdntName, String irdntCategory);
	
	
}
