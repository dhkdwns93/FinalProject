package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.IrdntManage;
import kr.co.turnup_fridger.vo.ShareRecipeIrdnt;

public interface ShareRecipeIrdntDao {
	/**
	 * 공유레시피재료 등록
	 * @param shareRecipeIrdnt
	 * @return
	 */
	int insertShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt);
	/**
	 * 공유레시피재료 수정
	 * @param shareRecipeIrdnt
	 * @return
	 */
	int updateShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt);
	/**
	 * irdntKey로 공유레시피재료 삭제
	 * @param irdntKey
	 * @return
	 */
	int deleteShareRecipeIrdnt(int irdntKey);
	/**
	 * irdntId로  공유레시피재료 조회
	 * @param irdntId
	 * @return
	 */
	ShareRecipeIrdnt selectShareRecipeIrdntByIrdntId(int irdntId);
	/**
	 * recipeId로 공유레시피재료 조회
	 * @param recipeId
	 * @return
	 */
	ShareRecipeIrdnt selectShareRecipeIrdntJoinByRecipeId(int recipeId);
	/**
	 * 전체조회
	 * @return
	 */
	List<ShareRecipeIrdnt> selectShareRecipeIrdntAll();
	
}
