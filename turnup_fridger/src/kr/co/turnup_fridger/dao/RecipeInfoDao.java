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
	 * 레시피 코드를 통해서 조인된 3개테이블의 정보를 가져옴.(3중조인)
	 * 상세정보페이지에서 보여질것.
	 * @param recipeId
	 * @return
	 */
	RecipeInfo selectThreeOfRecipesById(int recipeId);

	/**
	 * 풀네임으로
	 * @param recipeName
	 * @return
	 */
	RecipeInfo selectRecipeInfoByFullName(String recipeName);
	
	
	/**
	 * 레시피id들로 찾은 레시피들을 모두 담은 리스트.(페이징)
	 * keyword는 정렬키워드 (난이도, 최다조회순, 칼로리순...)
	 * @param recipeId
	 * @return
	 */
	List<RecipeInfo> selectRecipesInfoByIds(List<Integer> recipeIds,String keyword,int startIndex,int endIndex);
	
	
	/**
	 * 재료id를 통해 걸러낸 레시피id들로 찾은 레시피들의 수
	 * @param recipeIds
	 * @return
	 */
	int selectRecipesInfoByIdsCount(List<Integer> recipeIds,String keyword);
	
	
	/**
	 * 레시피 이름을 통하여 레시피들을 가져옴(페이징)
	 * keyword는 정렬키워드 (난이도, 최다조회순, 칼로리순...)
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByName(String recipeName,String keyword,int startIndex,int endIndex);
	
	/**
	 * 레시피 이름으로 검색한 레시피들의 수
	 * @param recipeName
	 * @return
	 */
	int selectRecipeInfoByNameCount(String recipeName,String keyword);
	
	/**
	 * 카테고리들을 받아서 레시피들을 가져옴(페이징)
	 * keyword는 정렬키워드 (난이도, 최다조회순, 칼로리순...)
	 * @param categoryName
	 * @param typeName
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByCategoryAndType(String categoryName,String typeName,String keyword,int startIndex,int endIndex);
	

	/**
	 * 카테고리를 받아서 찾은 레시피들의 수 
	 * @param categoryName
	 * @param typeName
	 * @param keyword
	 * @return
	 */
	int selectRecipeInfoByCategoryAndTypeCount(String categoryName,String typeName,String keyword);
	
	/**
	 * 카테고리 이름을 받아서 음식분류명들을 받아옴
	 * @param categoryName
	 * @return
	 */
	List<String> selectTypeNameByCategoryName(String categoryName);
}
