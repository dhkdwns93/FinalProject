package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardReview;

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
	
	/**
	 * 매개변수로 받은 ID로 저장된 BoardReview 정보를 삭제하는 메소드
	 * @param boardReviewId
	 * 작성자 - 김장규
	 */
	void removeBoardReview(int boardReviewId);
	
	
	List<BoardReview> selectBoardReviewList();
	
	//별점순
	List<BoardReview> selectBoardReviewByStarList();
	//아이디로 조회
	List<BoardReview> selectBoardReviewByMemberIdList(String memberId);
	//레시피 이름으로 조회
	List<BoardReview> selectBoardReviewByRecipeNameList(String recipeName);
}
