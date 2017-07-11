package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import kr.co.turnup_fridger.vo.BoardReview;
import kr.co.turnup_fridger.vo.RecipeInfo;

public interface BoardReviewService {

	/**
	 * 한개의 BoardReview 정보를 등록 하는 메소드
	 * @param BoardReview
	 * 작성자 - 김장규
	 */
	void addBoardReview(BoardReview boardReview);
	
	/**
	 * BoardReview 정보를 수정하는 메소드
	 * @param BoardReview
	 * 작성자 - 김장규
	 */
	void updateBoardReview(BoardReview boardReview);
	
	
	//이미지 삭제
	void updateImageNull(BoardReview boardReview);
	
	
	/**
	 * 매개변수로 받은 ID로 저장된 BoardReview 정보를 삭제하는 메소드
	 * @param boardReviewId
	 * 작성자 - 김장규
	 */
	void removeBoardReview(int boardReviewId);
	
	//전체 조회
	Map<String, Object>  selectBoardReviewList(int page);
	
	//별점순 조회
	Map<String, Object> selectBoardReviewByStarList(int page);
	
	//레시피 이름으로 조회
	Map<String, Object> selectBoardReviewByRecipeNameList(String recipeName,int page);
	
	//아이디로 조회
	Map<String, Object> selectBoardReviewByMemberIdList(String memberId,int page);

	//상세정보
	BoardReview selecetBoardReviewByBoardReviewId(int boardReviewId);
	//레시피이름조회
	List<RecipeInfo> selectRecipeName(String recipeName);
}
