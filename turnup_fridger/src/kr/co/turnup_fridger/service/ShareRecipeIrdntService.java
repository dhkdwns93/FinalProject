package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.ShareRecipeIrdnt;

public interface ShareRecipeIrdntService {
	/**
	 * 등록
	 * @param ShareRecipeIrdnt
	 */
	void insertShareRecipeIrdnt(ShareRecipeIrdnt ShareRecipeIrdnt);
	/**
	 * 수정
	 * @param shareRecipeIrdnt
	 */
	void updateShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt);
	/**
	 * 삭제
	 * @param irdntKey
	 */
	void deleteShareRecipeIrdnt(int irdntKey);
	/**
	 * 전체조회
	 * @return
	 */
	 List<ShareRecipeIrdnt> selectShareRecipeIrdntAll();
	/**
	 * irdntId로 조회
	 * @param irdntId
	 * @return
	 */
	ShareRecipeIrdnt selectShareRecipeIrdntByIrdntId(int irdntId);
	/**
	 * recipeId로 조회
	 * @param recipeId
	 * @return
	 */
	ShareRecipeIrdnt selectShareRecipeIrdntByRecipeId(int recipeId);
}
