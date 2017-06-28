package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.RecipeCrse;

public interface RecipeCrseService {

	/**
	 * 레시피 과정정보 등록
	 * @param recipeCrse
	 */
	void createRecipeCrse(RecipeCrse recipeCrse);
	
	/**
	 * 레시피 과정정보 수정
	 * @param recipeCrse
	 */
	void updateRecipeCrse(RecipeCrse recipeCrse);
	
	/**
	 * 레시피 과정정보 삭제
	 * @param recipeId
	 * @param cookingNo
	 */
	void deleteRecipeCrse(int recipeId,int cookingNo);
	
	/**
	 * 모든 레시피 과정정보 불러오기
	 * @return
	 */
	List<RecipeCrse> findAllRecipeCrse();
	
	/**
	 * 레시피코드로 레시피 과정정보들 불러오기
	 * @param recipeId
	 * @return
	 */
	List<RecipeCrse> findRecipeCrseByrecipeId(int recipeId);
	
	/**
	 * 레시피코드와 요리설명순서로 과정정보들 불러오기
	 * @param recipeId
	 * @param cookingNo
	 * @return
	 */
	RecipeCrse findRecipeCrseByIdandNo(int recipeId,int cookingNo);
	
	/**
	 * 요리 과정정보들 단위변환(인분변환)
	 * @param cookingDc
	 * @param recipeId
	 * @param cookingNo
	 * @return
	 */
	String changePortion(String cookingDc,int recipeId,int cookingNo);
	
}
