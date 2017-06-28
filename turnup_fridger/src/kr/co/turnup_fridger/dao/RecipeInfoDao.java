package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.RecipeInfo;

public interface RecipeInfoDao {

	/**
	 * 레시피 기본정보를 입력
	 * @return
	 */
	int insertRecipeInfo(RecipeInfo recipeInfo);
	
	/**
	 * 레시피 기본정보를 수정
	 * @param recipeInfo
	 * @return
	 */
	int updateRecipeInfo(RecipeInfo recipeInfo);
	
	/**
	 * 레시피 기본정보를 삭제 
	 * @return
	 */
	int deleteRecipeInfo(int recipeId);
	
	/**
	 * 모든 레시피 정보를 가져오기.
	 * @return
	 */
	List<RecipeInfo> selectAllRecipeInfo();
	
	/**
	 * 레시피코드를 통하여 레시피기본정보하나를 가져옴.
	 * @return
	 */
	RecipeInfo selectRecipeInfoById(int recipeId);
	
	/**
	 * 레시피 이름을 통하여 레시피들을 가져옴
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByName(String recipeName);
	
	/**
	 * 난이도를 통하여 레시피들을 가져옴
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByLevel(String recipeLevel);
	
	/**
	 * 조회수를 통하여 레시피들을 가져옴(일정기준을 줄것)
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByHits(int recipeHits);
	
	/**
	 * 칼로리정보를 통하여 레시피들을 가져옴
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoBycalorie(String calorie);
	
	/**
	 * 유형분류명(한식,중식...)을 통하여 레시피들을 가져옴
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByCategoryName(String categoryName);
	
	/**
	 * 음식분류명(밥,찌개 ...)을 통하여 레시피들을 가져옴
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByTypeName(String typeName);
	
	
}
