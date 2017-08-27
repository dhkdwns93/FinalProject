package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardReview;
import kr.co.turnup_fridger.vo.RecipeInfo;

public interface BoardReviewDao {

	/*
	 * BoardReview 정보를 insert 하는 메소드 - 회원
	 * 작성자 : 김장규
	 */
	int insertBoardReview(BoardReview boardReview);
	
	/*
	 * BoardReview 정보를 update 하는 메소드 - 작성자
	 * 작성자 : 김장규
	 */
	int updateBoardReview(BoardReview boardReview);
	
	/*
	 * BoardReview 정보를 delete 하는 메소드 - 관리자, 작성자
	 * 작성자 : 김장규
	 */
	int deleteBoardReview(int boardReviewId);
	
	/*
	 * BoardReview 전체 목록 수 반환 메소드
	 * 작성자 : 김장규
	 */
	int selectBoardReviewCount();
	
	/*
	 * BoardReview 전체 목록 조회 메소드
	 * 작성자 : 김장규
	 */
	List<BoardReview> selectBoardReviewList(int startIndex, int endIndex);
	
	/*
	 * BoardReview 별점 수으로 조회 메소드
	 * 작성자 : 김장규
	 */
	List<BoardReview> selectBoardReviewByStarList(int startIndex, int endIndex);
	
	/*
	 * BoardReview레시피 이름 수 반환 메소드
	 * 작성자 : 김장규
	 */
	int selectBoardReviewByRecipeNameCount(String recipeName);
	
	/*
	 * BoardReview 레시피 조회 메소드
	 * 작성자 : 김장규
	 */
	List<BoardReview> selectBoardReviewByRecipeNameList(String recipeName,int startIndex, int endIndex);
	
	/*
	 * BoardReview 조회한 아이디 수 반환 메소드
	 * 작성자 : 김장규
	 */
	int selectBoardReviewByMemberIdCount(String memberId);
	
	/*
	 * BoardReview 아이디 조회  메소드
	 * 작성자 : 김장규
	 */
	List<BoardReview> selectBoardReviewByMemberIdList(String memberId,int startIndex,int endIndex);

	/*
	 * BoardReview 상세정보 조회 메소드
	 * 작성자 : 김장규
	 */
	BoardReview selecetBoardReviewByBoardReviewId(int boardReviewId);
	
	/*
	 * BoardReview 레시피 이름 조회 메소드
	 * 작성자 : 김장규
	 */
	List<RecipeInfo> selectRecipeName(String recipeName);
	
	/*
	 * BoardReview 레시피 아이디 수 반환 메소드
	 * 작성자 : 김장규
	 */
	int selectRecipeIdCount(int recipeId);
	
	/*
	 * BoardReview 레시피 아이디 조회 메소드
	 * 작성자 : 김장규
	 */
	List<BoardReview> selectBoardReviewByRecipeId(int recipeId,int startIndex,int endIndex);

	/*
	 * BoardReview 레시피 아이디 상세 정보 조회 메소드
	 * 작성자 : 김장규
	 */
	BoardReview selectBoardReviewByBoardReviewId(int boardReviewId);
	
	
	
}
