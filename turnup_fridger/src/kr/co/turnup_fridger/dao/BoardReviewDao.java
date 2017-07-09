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
	
	
	//전체리스트
	List<BoardReview> selectBoardReviewList();
	//별점순
	List<BoardReview> selectBoardReviewByStarList();
	//아이디로 조회
	List<BoardReview> selectBoardReviewByMemberIdList(String memberId);
	//레시피 이름으로 조회
	List<BoardReview> selectBoardReviewByRecipeNameList(String recipeName);
	//Id로 조회
	BoardReview selecetBoardReviewByBoardReviewId(int boardReviewId);
	//레시피 이름
	List<RecipeInfo> selectRecipeName(String recipeName);
}
