package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.MemberRecipeRecommand;

public interface BoardShareRecipeService {
	
	void insertBoardShareRecipe(BoardShareRecipe boardShareRecipe);
	
	void increaseHit(int recipeId, HttpSession session) throws Exception;
	
	void deleteBoardShareRecipe(int recipeId);

	public void updateBoardShareRecipe(BoardShareRecipe boardShareRecipe );
	
	Map selectBoardShareRecipeByTitle(String title, int page);
	
	BoardShareRecipe boardRead(int recipeId);
	
	Map<String, Object> selectBoardShareRecipeAll(int page);
	
	void updateBoardRecommand(int recipeId);
	
	void insertRecommandServie(MemberRecipeRecommand memberRecipeRecommand);
	
	MemberRecipeRecommand selectRecommandService(int recipeId, String memberId);
	
	void deleteRecommandService(int recipeId);
	
	Map<String, Object> boardSearchByTitle(int page, String keyword);
	
	Map<String, Object> boardSearchByTxt(int page, String keyword);
	
	Map<String, Object> boardSearchByMemberId(int page, String keyword);
	
	List<BoardShareRecipe> selectBoardTop4();
	
	List<BoardShareRecipe> selectBoardShareRecipeByRecipeIdToIrdnt(int recipeId);
	
	List<String> selectBoardShareRecipeByRecipeIdToImg(int recipeId); 
	
	void insertBoardShareRecipeImg(int recipeId, String boardShareRecipeImgUrl);

	void deleteBoardShareRecipeImgByKey(int boardShareRecipeImgKey);
	
	void deleteBoardShareRecipeImgAll(int recipeId);
	
	List<String> selectBoardShareRecipeImg(int recipeId);


	
	/**
	 * 레시피 공유게시판의 글번호들로 글객체들을 담는 리스트.
	 * @param irdntIds
	 * @param hareIrdntsIds
	 * @return
	 */
	Map findUserRecipeByIds(List<Integer> irdntIds, List<Integer> hateIrdntsIds,int page);
	
	
	
}
