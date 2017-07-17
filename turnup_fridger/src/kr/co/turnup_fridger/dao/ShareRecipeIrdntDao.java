package kr.co.turnup_fridger.dao;

import java.util.List;
import java.util.Map;

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
	
	int deleteShareRecipeIrdntByRecipeId(int recipeId);
	
	
	int deleteShareRecipeIrdntByIrdntId(int irdntId);
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
	List<ShareRecipeIrdnt> selectShareRecipeIrdntByRecipeId(int recipeId);
	
	ShareRecipeIrdnt selectShareRecipeByIrdntKey(int irdntKey);
	
	
	/**
	 * irdntName으로  조회
	 * @param irdntName
	 * @return
	 */
	ShareRecipeIrdnt selectShareRecipeByIrdntName(String irdntName);
	
	ShareRecipeIrdnt selectShareRecipeIrdntByRecipeIdByIrdntId(ShareRecipeIrdnt shareRecipeIrdnt);
	
	ShareRecipeIrdnt selectShareRecipeIrdntByRecipeIdNotList(int recipeId);
	/**
	 * 입력받은 재료id들로 해당 레시피공유게시판글id들만 골라내는 작업. 
	 * @param irdntIds
	 * @param hateIrdntIds
	 * @return
	 */
	List<Integer> getRecipeBoardIdByIrdntIds(List<Integer> irdntIds, List<Integer> hateIrdntIds);
	
	
	
	//상세보기 페이지2
	List<ShareRecipeIrdnt> findShareRecipeIrdntByRecipeId(int recipeId);

	
}
