package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.exception.DuplicateFavoriteException;
import kr.co.turnup_fridger.exception.NoneFavoriteException;
import kr.co.turnup_fridger.vo.FavoriteRecipe;

public interface FavoriteRecipeService {

	/**
	 * 레시피를 즐겨찾기에 추가
	 * @param recipe
	 * @throws DuplicateFavoriteException 
	 */
	void createFavoriteRecipe(FavoriteRecipe recipe) throws DuplicateFavoriteException;
	
	/**
	 * 추가된 즐겨찾기정보를 수정
	 * @param recipe
	 * @throws NoneFavoriteException 
	 */
	void updateFavoriteRecipe(FavoriteRecipe recipe) throws NoneFavoriteException;
	
	/**
	 * 추가된 즐겨찾기정보를 삭제
	 * @param favoriteRecipeKey
	 * @throws NoneFavoriteException 
	 */
	void removeFavoriteRecipe(int favoriteRecipeKey) throws NoneFavoriteException;
	
	/**
	 * 전체 레시피 즐겨찾기 목록 불러오기
	 * @return
	 */
	List<FavoriteRecipe> findAllFavoriteRecipe();
	
	/**
	 * 회원별 레시피 즐겨찾기 목록을 조회
	 * @param memberId
	 * @return
	 */
	List<FavoriteRecipe> findFavoriteRecipeByMemberId(String memberId);
	
	/**
	 * 레시피별로 레시피 즐겨찾기 목록을 조회
	 * @param recipeId
	 * @return
	 */
	List<FavoriteRecipe> findFavoriteRecipeByRecipeId(int recipeId);
	
	/**
	 * 회원id와 레시피id로 한행을 추출
	 * @param memberId
	 * @param recipeId
	 * @return
	 */
	FavoriteRecipe findFavoriteRecipeByIds(String memberId, int recipeId);
	
}
