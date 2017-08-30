package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import kr.co.turnup_fridger.vo.BoardReview;
import kr.co.turnup_fridger.vo.RecipeInfo;

public interface BoardReviewService {

	/*
	 * 후기게시판 등록 - 회원
	 * 작성자 - 김장규
	 */
	void addBoardReview(BoardReview boardReview);
	
	/*
	 * 후기게시판 수정 - 작성자
	 * 작성자 - 김장규
	 */
	void updateBoardReview(BoardReview boardReview);
	
	/*
	 * 후기게시판 삭제 - 관리자, 작성자
	 * 작성자 - 김장규
	 */
	void removeBoardReview(int boardReviewId);
	
	/*
	 * 후기게시판 전체 목록 조회
	 * 작성자 - 김장규
	 */
	Map<String, Object>  selectBoardReviewList(int page);
	
	/*
	 * 후기게시판 별점순 조회
	 * 작성자 - 김장규
	 */
	Map<String, Object> selectBoardReviewByStarList(int page);
	
	/*
	 * 후기게시판 레시피이름으로 조회
	 * 작성자 - 김장규
	 */
	Map<String, Object> selectBoardReviewByRecipeNameList(String recipeName,int page);
	
	/*
	 * 후기게시판 회원 아이디로 목록 조회
	 * 작성자 - 김장규
	 */
	Map<String, Object> selectBoardReviewByMemberIdList(String memberId,int page);

	/*
	 * 후기게시판 해당 글 상세 정보 조회
	 * 작성자 - 김장규
	 */
	BoardReview selecetBoardReviewByBoardReviewId(int boardReviewId);
	
	/*
	 * 후기게시판 레시피 이름으로 조회
	 * 작성자 - 김장규
	 */
	List<RecipeInfo> selectRecipeName(String recipeName);
	
		
	/*
	 * 후기게시판 레시피 아이디로 조회
	 * 작성자 - 김장규
	 */
	Map<String, Object> findBoardReviewByRecipeId(int recipeId,int page);
	
	
}
