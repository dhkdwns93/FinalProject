package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.FavoriteRecipe;

public interface FavoriteRecipeDao {

	/**
	 * 레시피 즐겨찾기에 추가
	 * @param recipe
	 * @return
	 */
	int insertFavoriteRecipe(FavoriteRecipe recipe);
	
	/**
	 * 등록된 즐겨찾기를 수정
	 * @param recipe
	 * @return
	 */
	int updateFavoriteRecipe(FavoriteRecipe recipe);
	
	/**
	 * 등록된 즐겨찾기를 삭제 
	 * @param favoriteRecipeKey
	 * @return
	 */
	int deleteFavoriteRecipe(int favoriteRecipeKey);
	
	/**
	 * 등록된 모든 즐겨찾기 정보들을 조회
	 * @return
	 */
	List<FavoriteRecipe> selectAllFavoriteRecipe();
	
	/**
	 * 사용자id로 즐겨찾기 목록들을 조회
	 * @param memberId
	 * @return
	 */
	List<FavoriteRecipe> selectFavoriteRecipeByMemberId(String memberId);
	
	/**
	 * 레시피코드로 즐겨찾기 목록들을 조회
	 * @param recipeId
	 * @return
	 */
	List<FavoriteRecipe> selectFavoriteRecipeByRecipeId(int recipeId);
	
	/**
	 * 해당회원이 이미 즐겨찾기에 있는지 조회해보려는 것.
	 * @param memberId
	 * @param recipeId
	 * @return
	 */
	FavoriteRecipe selectFavoriteRecipeByIds(String memberId, int recipeId);
	
	/**
	 * 시퀀스pk값으로 한행추출
	 * @param favoriteRecipeKey
	 * @return
	 */
	FavoriteRecipe selectFavoriteRecipeByKey(int favoriteRecipeKey);
	
}
