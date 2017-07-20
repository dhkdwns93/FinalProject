package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardReview;
import kr.co.turnup_fridger.vo.RecipeInfo;

public interface BoardReviewDao {

	/**
	 * BoardReview 정보를 insert 하는 메소드
	 * @param BoardReview
	 * @return
	 * 작성자 : 김장규
	 */
	int insertBoardReview(BoardReview boardReview);
	
	/**
	 * BoardReview 정보를 update 하는 메소드
	 * @param boardQnA
	 * @return
	 * 작성자 : 김장규
	 */
	int updateBoardReview(BoardReview boardReview);
	
	
	//이미지 삭제
	int updateImageNull(BoardReview boardReview);
	
	/**
	 * BoardReview 정보를 delete 하는 메소드
	 * @param id
	 * @return
	 * 작성자 : 김장규
	 */
	int deleteBoardReview(int boardReviewId);
	
	
	//전체 카운트
	int selectBoardReviewCount();
	//전체리스트
	List<BoardReview> selectBoardReviewList(int startIndex, int endIndex);
	//별점순
	List<BoardReview> selectBoardReviewByStarList(int startIndex, int endIndex);
	
	//레시피 이름 카운트
	int selectBoardReviewByRecipeNameCount(String recipeName);
	//레시피 이름으로 조회
	List<BoardReview> selectBoardReviewByRecipeNameList(String recipeName,int startIndex, int endIndex);
	
	//아이디 카운트
	int selectBoardReviewByMemberIdCount(String memberId);
	//아이디로 조회
	List<BoardReview> selectBoardReviewByMemberIdList(String memberId,int startIndex,int endIndex);

	//리뷰Id로 상세 정보 조회
	BoardReview selecetBoardReviewByBoardReviewId(int boardReviewId);
	
	//레시피 이름 검색 
	List<RecipeInfo> selectRecipeName(String recipeName);
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//아이디 카운트
	int selectRecipeIdCount(int recipeId);
	//레시피 아이디로 리스트 조회
	List<BoardReview> selectBoardReviewByRecipeId(int recipeId,int startIndex,int endIndex);
	
	/**
	 * id 넣어서 게시글 객체 하나를 반환하는 메서드.
	 * @param boardReviewId
	 * @return
	 */
	BoardReview selectBoardReviewByBoardReviewId(int boardReviewId);
	
	
	
}
