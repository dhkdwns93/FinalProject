package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import kr.co.turnup_fridger.exception.DuplicateRecipeException;
import kr.co.turnup_fridger.exception.NoneRecipeException;
import kr.co.turnup_fridger.vo.RecipeInfo;

public interface RecipeService {

	/**
	 * 레시피를 등록
	 * @param recipe
	 * @throws Exception 
	 */
	void createRecipe(RecipeInfo recipe) throws DuplicateRecipeException;
	
	/**
	 * 레시피를 수정
	 * @param recipe
	 * @throws Exception 
	 */
	void updateRecipe(RecipeInfo recipe) throws NoneRecipeException;
	
	/**
	 * 레시피를 삭제
	 * @param recipeCode
	 * @throws Exception d
	 */
	void removeRecipe(int recipeId) throws NoneRecipeException;
	
	/**
	 * 재료id들로 레시피들을 찾기, (선택재료들 포함, 기피재료 비포함)
	 * recipeInfo, 레시피공유게시판 둘다 조회
	 * 1. irdntId들을 가지고, recipeIrdnt테이블에서 recipeId들을 걸러낸다.
	 * 2. recipeId들의 리스트를 가지고 recipeInfo만 가져오는걸 한다.(페이징) 
	 * @return
	 */
	//Map<String,Object> findRecipeByIrdntId(List<Integer> irdntIds, List<Integer> hateIrdntIds,String keyword,int page);
	
	List<RecipeInfo> findRecipeByIrdntId(List<Integer> irdntIds, List<Integer> hateIrdntIds,String keyword);
	
	/**
	 * 레시피 이름으로 레시피들을 찾기(페이징)
	 * @param recipeName
	 * @return
	 */
	//Map<String, Object> findRecipeByRecipeName(String recipeName,String keyword,int page);
	
	List<RecipeInfo> findRecipeByRecipeName(String recipeName,String keyword);
	
	/**
	 * 카테고리로 레시피들을 찾기 (페이징)
	 * @return
	 */
	//Map<String,Object> findRecipeByCategory(String categoryName, String typeName,String keyword,int page);

	List<RecipeInfo> findRecipeByCategory(String categoryName, String typeName,String keyword);
	
	/**
	 * 목록에서 클릭했을때 recipeId값이 넘어가서 그걸로 검색하여 보여줄 상세페이지 (조인)
	 * @param recipeId
	 * @return
	 */
	RecipeInfo showDetailOfRecipe(int recipeId);
	
	
	/**
	 * 레시피 단위변환
	 * @return
	 */
	RecipeInfo changePortion(int portion);

	/**
	 * 전체 레시피들 가져오는것.
	 * @return
	 */
	List<RecipeInfo> allRecipeList();
	
}
