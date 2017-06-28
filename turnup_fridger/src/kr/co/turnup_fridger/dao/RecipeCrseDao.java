package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.RecipeCrse;

public interface RecipeCrseDao {

	/**
	 * 과정정보를 입력
	 * @return
	 */
	int insertRecipeCrse(RecipeCrse recipeCrse);
	
	/**
	 * 과정정보를 수정
	 * @return
	 */
	int updateRecipeCrse(RecipeCrse recipeCrse);
	
	/**
	 * 과정정보를 삭제 (레시피코드와 요리설명순서가 복합키)
	 * @return
	 */
	int deleteRecipeCrse(int recipeId, int cookingNo);
	
	/**
	 * 모든 과정정보들을 리턴
	 * @return
	 */
	List<RecipeCrse> selectAllRecipeCrse();
	
	/**
	 * 레시피코드를 통해 과정정보들을 리턴
	 * @return
	 */
	List<RecipeCrse> selectRecipeCrseById(int recipeId);
	
	/**
	 * 레시피코드와 요리설명순서를 복합키로 하여 한개의 과정정보를 가져옴.
	 * @return
	 */
	RecipeCrse selectRecipeCrseByIdAndNo(int recipeId, int cookingNo);
}
