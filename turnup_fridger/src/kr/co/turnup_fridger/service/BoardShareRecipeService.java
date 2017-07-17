package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.co.turnup_fridger.exception.FindMemberFailException;
import kr.co.turnup_fridger.exception.OverLapException;
import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.MemberRecipeRecommand;

public interface BoardShareRecipeService {
	
	void insertBoardShareRecipe(BoardShareRecipe boardShareRecipe);
	
	
	void increaseHit(int recipeId, HttpSession session) throws Exception;
	
	/**
	 * 사진 수정
	 * @param shareRecipeIrdnt
	 */
	void updateImageNull(BoardShareRecipe boardShareRecipe);
	
	void deleteBoardShareRecipe(int recipeId);

	void updateBoardShareRecipe(BoardShareRecipe boardShareRecipe );
	
	List<BoardShareRecipe> selectBoardShareRecipeByTitle(String title);
	
	BoardShareRecipe boardRead(int recipeId);
	
	Map<String, Object> selectBoardShareRecipeAll(int page);
	/**추천recommand*-************************************************/
	void insertRecommandServie(MemberRecipeRecommand memberRecipeRecommand);
	void updateBoardRecommand(int recipeId);	
	void deleteRecommandService(int recipeId);
	List<MemberRecipeRecommand> selectRecommandByRecipeId(int recipeId);
	MemberRecipeRecommand selectRecommandService(int recipeId, String memberId) throws OverLapException, FindMemberFailException;
	/**
	 * recipeId로 수정시 조회
	 * @param recipeId
	 * @return
	 */
	MemberRecipeRecommand selectRecommandOne(int recipeId);
	/***************************검색기능******************************************/
	Map<String, Object> boardSearchByTitle(int page, String keyword);
	
	Map<String, Object> boardSearchByTxt(int page, String keyword);
	
	Map<String, Object> boardSearchByMemberId(int page, String keyword);
	
	List<BoardShareRecipe> selectBoardTop4();
	
	/**
	 * 2개 조인
	 * recipeId로 상세 조회
	 * @param recipeId
	 * @return
	 */
	BoardShareRecipe selectBoardByShareIrdnt(int recipeId);

	/**
	 * 레시피 공유게시판의 글번호들로 글객체들을 담는 리스트.
	 * @param irdntIds
	 * @param hareIrdntsIds
	 * @return
	 */
	Map findUserRecipeByIds(List<Integer> irdntIds, List<Integer> hateIrdntsIds);
	
	
	
}
