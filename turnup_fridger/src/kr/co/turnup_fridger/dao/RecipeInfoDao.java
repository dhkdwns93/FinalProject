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
	
	/**<확인필요>
	 * 레시피코드들을 담은 list를 받아서 그에 해당하는 레시피들을 모두 담은 리스트.
	 * @param recipeId
	 * @return
	 */
	List<RecipeInfo> selectRecipesInfoByIds(List<Integer> recipeId);
	
	/**
	 * 레시피 코드를 통해서 조인된 3개테이블의 정보를 가져옴.(3중조인)
	 * @param recipeId
	 * @return
	 */
	RecipeInfo selectThreeOfRecipesById(int recipeId);
	
	
	/**
	 * 레시피 이름을 통하여 레시피들을 가져옴(페이징)
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByName(String recipeName,int startIndex,int endIndex);
	
	/**
	 * 레시피 이름으로 검색한 레시피들의 수 (페이징할때 필요한것)
	 * @param recipeName
	 * @return
	 */
	int selectRecipeInfoByNameCount(String recipeName);
	
	/**
	 * 카테고리들을 받아서 레시피들을 가져옴(페이징)
	 * @param categoryName
	 * @param typeName
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByCategoryAndType(String categoryName,String typeName);
		
	/**
	 * 유형분류명(한식,중식...)을 통하여 레시피들을 가져옴
	 * @return
	 */
	//List<RecipeInfo> selectRecipeInfoByCategoryName(String categoryName);
	
	/**
	 * 음식분류명(밥,찌개 ...)을 통하여 레시피들을 가져옴
	 * @return
	 */
	//List<RecipeInfo> selectRecipeInfoByTypeName(String typeName);

	
	/**
	 * 난이도를 통하여 레시피들을 가져옴
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByLevel(String recipeLevel);
	
	/**
	 * 조회수를 통하여 레시피들을 가져옴
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoByHits(int recipeHits);
	
	/**
	 * 칼로리정보를 통하여 레시피들을 가져옴
	 * @return
	 */
	List<RecipeInfo> selectRecipeInfoBycalorie(String calorie);

	
	
}
