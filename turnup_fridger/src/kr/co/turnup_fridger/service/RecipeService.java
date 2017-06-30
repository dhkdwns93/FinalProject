package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.RecipeInfo;

public interface RecipeService {

	/**
	 * 레시피를 등록
	 * @param recipe
	 */
	void createRecipe(RecipeInfo recipe);
	
	/**
	 * 레시피를 수정
	 * @param recipe
	 */
	void updateRecipe(RecipeInfo recipe);
	
	/**
	 * 레시피를 삭제
	 * @param recipeCode
	 */
	void removeRecipe(int recipeCode);
	
	/**
	 * 재료id들로 레시피들을 찾기, (선택재료들 포함, 기피재료 비포함)
	 * recipeInfo, 레시피공유게시판에서 조회해오기.
	 * @return
	 */
	List<RecipeInfo> findRecipeByIrdntId(List<Integer> irdntIds, List<Integer> hateIrdntIds);
	
	
	/**
	 * 레시피 이름으로 레시피들을 찾기
	 * @param recipeName
	 * @return
	 */
	List<RecipeInfo> findRecipeByRecipeName(String recipeName);
	
	/**
	 * 카테고리로 레시피들을 찾기 
	 * @return
	 */
	List<RecipeInfo> findRecipeByCategory(String categoryName, String typeName);
	
	
	/**
	 * 검색된 재료들은 분류키워드를 받아서 정렬하는 작업 
	 * @return
	 */
	List<RecipeInfo> RangeRecipeByKeyword(List<RecipeInfo> Recipes, String keyword);

	
	/**
	 * 레시피 단위변환
	 * @return
	 */
	RecipeInfo changePortion(int portion);
	
	
	
}
