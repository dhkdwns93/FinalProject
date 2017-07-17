package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.ShareRecipeIrdnt;

public interface ShareRecipeIrdntService {
	/**
	 * 
	 * @param ShareRecipeIrdnt
	 */
	void insertShareRecipeIrdnt(ShareRecipeIrdnt ShareRecipeIrdnt) throws Exception;
	/**
	 * 
	 * @param shareRecipeIrdnt
	 */
	void updateShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt) throws Exception;
	/**
	 * 매개변수로 받은 key로 공유재료 삭제
	 * @param irdntKey
	 */
	void deleteShareRecipeIrdnt(int irdntKey) throws Exception;
	
	/**
	 * 레시피ID로 삭제
	 * @param recipeId
	 */
	void deleteShareRecipeIrdntByRecipeId(int recipeId);
	
	/**
	 * 레시피재료로 삭제
	 * @param irdntId
	 */
	void deleteShareRecipeIrdntByIrdntId(int irdntId);
	
	
	ShareRecipeIrdnt selectShareRecipeByIrdntName(String irdntName);
	/**
	 * 전체조회
	 * @return
	 *//*
	 List<ShareRecipeIrdnt> selectShareRecipeIrdntAll();*/
	/**
	 * recipeId로 상세 조회
	 * @param recipeId
	 * @return
	 */
	List<ShareRecipeIrdnt> selectShareRecipeIrdntByRecipeId(int recipeId);
	
	ShareRecipeIrdnt selectShareRecipeIrdntByRecipeIdNotList(int recipeId);
	/**
	 * irdntKey로 조회
	 * @param irdntKey
	 * @return
	 */
	ShareRecipeIrdnt selectShareRecipeByIrdntKey(int irdntKey);
	
	/**
	 * recipeId와 irdntId로 조회
	 * @param shareRecipeIrdnt
	 * @return
	 */
	ShareRecipeIrdnt selectShareRecipeIrdntByRecipeIdByIrdntId(ShareRecipeIrdnt shareRecipeIrdnt);
	
	
	///////////////////////////////////
	List<ShareRecipeIrdnt> findShareRecipeIrdntByRecipeId(int recipeId);
	
	
}
